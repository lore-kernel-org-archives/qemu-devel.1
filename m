Received: from eggs.gnu.org ([209.51.188.92]:44729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goyhX-00021W-PT
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goyhW-0001H6-Bb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:51:23 -0500
References: <1548700805-1016533-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<00c8b4b9-77ca-159e-4554-3311695fe3db@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <131316a6-463d-ad1a-1b57-20f5dd0af62d@redhat.com>
Date: Wed, 30 Jan 2019 17:51:14 -0500
MIME-Version: 1.0
In-Reply-To: <00c8b4b9-77ca-159e-4554-3311695fe3db@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 0/2] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com



On 1/29/19 11:01 PM, Eric Blake wrote:
> On 1/28/19 12:40 PM, Andrey Shinkevich wrote:
>> Here is the update for the bitmap extension of the qcow2 specific
>> information as the output of the 'qemu-img info' command.
>> The version #7 was in email with the message ID:
>> <1544698788-52893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
>>
>> v8:
>> The output benchmark files for the qemu-iotests, namely 060, 065 082, 198
>> and 206, were modified to show the bitmap extension for the qemu specific
>> information. A new test file 239 was added to the test set that checks the
>> output for the fields of the bitmap section.
>> The backward compatibility of the output for images of the version 2
>> of qcow2 was added.
> 
> So, I'm trying to test this, and I've discovered something rather
> annoying about persistent snapshots: they DON'T get written to disk
> until the qemu process exits.  In other words, even after creating a

Technically, they get written out on qcow2_inactivate -- so there is the
opportunity to write them out at key sync points if you want.

However, like Vladimir says, this data is going to be necessarily wrong
while the image is in-use, so there may not be great value in it. There
may be a lot of anti-value if users learn to use or rely on that data.

I suppose the debugging case you want to assist here is one of trust for
users -- if a user wants to take a quick poke at the image and see if
the persistent bitmap tracking really got enabled before trusting it for
the next week of operations.

> persistent bitmap via QMP (I'm trying to debug my libvirt API for
> incremental snapshots, so I did this via 'virsh snapshot-create-as $dom
> name', but it boils down to a QMP transaction with
> 'block-dirty-bitmap-add' as one of the commands), running:
> 
> $ qemu-img info -U Active1.qcow2
> 
> shows
>     bitmaps:
>     refcount bits: 16
> 
> for as long as the qemu process is running. What does it take to force a
> qcow2 image to write out its current set of known bitmaps to disk, even
> if they are known to be potentially dirty? Should it happen any time we
> flush L1/L2/refcount tables?  On a periodic but slow timer (say once
> every 5 minutes)? Other ideas?  I know we don't want to be flushing the
> full bitmap contents on every change to the in-memory internal bitmap,
> but meta-changes (such as adding a bitmap) seem like the sort of thing
> where it's worth flushing the qcow2 file; particularly when adding the
> bitmap via QMP 'transaction' which goes to the bother of flushing all
> pending I/O in order to properly roll back on failure (which means on
> success, it would be nice for the new bitmap name to show up in the
> qcow2 header, even if the contents of the bitmap are not up-to-date).
> 
