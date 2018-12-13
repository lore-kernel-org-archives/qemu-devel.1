Received: from eggs.gnu.org ([2001:4830:134:3::10]:57227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYmT-0003MO-VX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXYmK-0004dw-9J
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:44:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gXYmA-0003Ev-Ui
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 16:44:14 -0500
References: <20181130144404.GA32091@mswork1>
	<faae3e4a-bce7-849a-b510-1c94ffb03413@redhat.com>
	<20181213183253.GE10456@mswork1>
From: Eric Blake <eblake@redhat.com>
Message-ID: <93edfff5-9cc2-8b19-b5a5-48ee4c7c0007@redhat.com>
Date: Thu, 13 Dec 2018 15:43:52 -0600
MIME-Version: 1.0
In-Reply-To: <20181213183253.GE10456@mswork1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Loading snapshot with readonly qcow2 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Spradling <michael@os.amperecomputing.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 12/13/18 12:33 PM, Michael Spradling wrote:

>>> My question is has anyone looked into loading snapshots from a backing
>>> file?  I have attempted to look through the code and this looks to be
>>> difficult.  If I attempt to add support for this is there any general
>>> advice to follow?  Any other ideas?
>>
>> 'qemu-nbd -l' can serve snapshots from a qcow2 file; perhaps that can be
>> used to cobble together something that works for your needs?
>>

> 
> I looked at "qemu-nbd -l" and this seems to only export a readonly
> interface.  Really, what I need is a writable temp file that can load a
> snapshot snapshot.

Can you combine -s (create a writable temp file) with -l to get what you 
want?

/me tries:

$ qemu-img create -f qcow2 a 1M
Formatting 'a', fmt=qcow2 size=1048576 cluster_size=65536 
lazy_refcounts=off refcount_bits=16
$ qemu-io -c 'w -P 1 0 512' a
wrote 512/512 bytes at offset 0
512 bytes, 1 ops; 0.0487 sec (10.257 KiB/sec and 20.5137 ops/sec)
$ qemu-img snapshot -c snap a
$ qemu-io -c 'w -P 2 0 512' a
wrote 512/512 bytes at offset 0
512 bytes, 1 ops; 0.0752 sec (6.645 KiB/sec and 13.2903 ops/sec)
$ qemu-nbd -l snap -s a
Failed to load snapshot: Can't find snapshot

I can confirm that 'qemu-nbd -s a' lets me write data that is discarded 
on disconnect (lsof says a temp file in /var/tmp/vl.XXXXXX was created); 
and that 'qemu-nbd -l snap a' lets me read the snapshot data. But mixing 
the two fails, and it would be a nice bug to fix.

> 
> Please excuse and correct me if I get some of the terminology of the
> sections below wrong.
> 
> I went down the path of hacking up some of the qemu qcow2 file system
> code to see if I can achieve the ability to restore a snapshot from a
> backing file to the temporarily created "-snapshot" qcow2 image.  The
> backing file has been marked readonly by the filesystem and the active
> image file was created with the "-snapshot" option.  I spend some time
> reading the qcow2 documentation and it seems I have to copy the l1 and
> l2 table values(are these actual host clusters) from the backing file
> snapshot to the active images l1 and l2 tables.  Is there anything else
> that may need updated that I have not yet stumbled upon?

Mucking with the l1 and l2 tables implies that you are directly 
manipulating qcow2 contents.  It's much nicer if you can come up with a 
solution where qemu-img does all the qcow2 work for you, and you just 
worry about guest-visible data.  Or are you actually patching the code 
compiled into qemu-img?

> 
> I still don't have this working yet and I believe my area of problems is
> qcow2_update_snapshot_refcount.  Can anyone explain what this does
> exactly.  It seems the function does three different things based on the
> value of addend, either -1, 0, 1, but its somewhat unclear.

Every cluster of qcow2 is reference-counted, to track which portions of 
the file are (supposed to be) in use according to following the metadata 
trails.  When internal snapshots are used, this is implemented by 
incrementing the refcount for each cluster that is reachable both from 
the snapshot and from the current L1 table (update_snapshot_refcount 
+1), then when writing to the cluster we break the reference count by 
writing the new data to a new allocation and decrementing the reference 
count of the old cluster. When trimming clusters, we decrement the 
refcount, and if it goes to 0 the cluster can be reused for something else.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
