Received: from eggs.gnu.org ([2001:4830:134:3::10]:57572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXu4i-0001yn-Tt
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gXu4f-0005Wi-Kr
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:28:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gXu4f-0005UL-C6
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 15:28:41 -0500
References: <20181130144404.GA32091@mswork1>
	<faae3e4a-bce7-849a-b510-1c94ffb03413@redhat.com>
	<20181213183253.GE10456@mswork1>
	<93edfff5-9cc2-8b19-b5a5-48ee4c7c0007@redhat.com>
	<20181214160328.GB20905@mswork1>
From: Eric Blake <eblake@redhat.com>
Message-ID: <264e8cab-431e-68c6-96ca-711131481a14@redhat.com>
Date: Fri, 14 Dec 2018 14:28:37 -0600
MIME-Version: 1.0
In-Reply-To: <20181214160328.GB20905@mswork1>
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

On 12/14/18 10:03 AM, Michael Spradling wrote:

>> Can you combine -s (create a writable temp file) with -l to get what you
>> want?
>>
>> /me tries:

>>
>> I can confirm that 'qemu-nbd -s a' lets me write data that is discarded on
>> disconnect (lsof says a temp file in /var/tmp/vl.XXXXXX was created); and
>> that 'qemu-nbd -l snap a' lets me read the snapshot data. But mixing the two
>> fails, and it would be a nice bug to fix.
> 
> I briefly looked at the code and is seams to be using the same base
> functions as qemu does.  So, if I get this working for the model it
> might also start working for qemu-nbd.

>>
> Ideally, I want to not modify old images or create new images with
> qemu-img, so I have been not modifing qemu-img, but qemu directly
> itself.  My use case will have several snapshots in an image.(say
> 100).  I will then later resume each of these snapshots in a qemu
> session in parallel.  This is why I have gone done the route of modifying
> the temp snapshots file /var/tmp/vl.XXXXX L1 and l2 tables.  My
> understanding is if these are updated and the cluster doesn't exists in
> the temp file the code will then look for it in the backing file.  Still
> researching this area.

Right now, the only thing that qemu reads from a backing file is a guest 
cluster. L1/L2 clusters have to be local to the file that they are 
describing (there is no way to make an L2 table fall back to the 
contents of a different cluster in the backing file).  It boils down to:

Reads:
Does the active layer have an L2 mapping for the current cluster being 
read?  Yes - read that cluster. No - ask the backing layer to provide 
the contents of that cluster (and if copy-on-read is enabled, also write 
those contents in a fresh allocation so that the current layer no longer 
has to defer to the backing).

Writes:
Does the active layer have an L2 mapping for the current cluster 
containing the data being written? Yes - modify that cluster in place. 
No - allocate an new cluster, and if the write was for less than a full 
cluster, also ask the backing layer to provide the contents of the rest 
of the cluster for a copy-on-write action. After the write, the current 
layer no longer has to defer to the backing.

Creating an arbitrary qcow2 file on top of any arbitrary read-only 
backing layer (including 'qemu-nbd -l snap image) should be doable, even 
if verbose (since the "backing file" of a qcow2 BDS node can be any 
other BDS).  Providing some shorter command lines, like making 'qemu-nbd 
-s -l snap image' work so that you don't have to provide your own manual 
overlay, is thus not a high priority.

> 
>>>
>>> I still don't have this working yet and I believe my area of problems is
>>> qcow2_update_snapshot_refcount.  Can anyone explain what this does
>>> exactly.  It seems the function does three different things based on the
>>> value of addend, either -1, 0, 1, but its somewhat unclear.
>>
>> Every cluster of qcow2 is reference-counted, to track which portions of the
>> file are (supposed to be) in use according to following the metadata trails.
>> When internal snapshots are used, this is implemented by incrementing the
>> refcount for each cluster that is reachable both from the snapshot and from
>> the current L1 table (update_snapshot_refcount +1), then when writing to the
>> cluster we break the reference count by writing the new data to a new
>> allocation and decrementing the reference count of the old cluster. When
>> trimming clusters, we decrement the refcount, and if it goes to 0 the
>> cluster can be reused for something else.
> 
> I think I understand this.  That would satifys addend being a -1 or 1.
> I am still unclear why you would call the fuction with addend being 0.

An addend of 0 allows a couple of callers to temporarily have an 
inconsistent image for the sake of optimizing a bulk allocation/freeing, 
followed by informing the refcount table to match, with fewer changes to 
the cluster containing the refcounts than if the algorithm had to 
accurately use -1/+1 on a per-cluster basis.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
