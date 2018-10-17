Received: from eggs.gnu.org ([2001:4830:134:3::10]:56289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCsRY-0004tH-Qw
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCsRX-0007kz-0t
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 16:29:24 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
	<b5b13c24-1510-6d85-cfc4-f9a4fc3bbbc4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00fa8e73-dd23-f2aa-7cd3-b15595642463@redhat.com>
Date: Wed, 17 Oct 2018 15:29:08 -0500
MIME-Version: 1.0
In-Reply-To: <b5b13c24-1510-6d85-cfc4-f9a4fc3bbbc4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/6] dirty-bitmaps: fix QMP command
 permissions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com

On 10/2/18 6:08 PM, John Snow wrote:

>> John Snow (6):
>>    block/dirty-bitmaps: add user_locked status checker
>>    block/dirty-bitmaps: fix merge permissions
>>    block/dirty-bitmaps: allow clear on disabled bitmaps
>>    block/dirty-bitmaps: prohibit enable/disable on locked/frozen bitmaps
>>    block/backup: prohibit backup from using in use bitmaps
>>    nbd: forbid use of frozen bitmaps
>>

> 
> Planning on submitting tests for 3.1, but with the merge queue opened up
> again I'm pretty keen on getting some stable commit IDs for these so far.

Food for thought when writing tests:
I've just noticed with my progress on libvirt code that for 
error-recovery purposes, if we decide to make 
x-block-dirty-bitmap-disable fail on a disabled bitmap (or enable on an 
enabled map) that it would be nice to have a distinct error code; or 
even better to just be a silent no-op.  That's because when libvirt has 
the situation:

bitmap1 (disabled), bitmap2 (enabled)

and wants to delete the point in time between those two, it will call:

enable bitmap1
merge bitmap2 into bitmap1
remove bitmap2

Removing a bitmap is not part of 'transaction', and there is no pressing 
reason for it to be (other than convenience) - which means this is at 
least 2 commands (if the first two are a transaction) or 3 (if all are 
done independently).

But because it is not a transaction, libvirt can conceivably succeed at 
reenabling bitmap1 but then fail because the guest shut down before 
merging bitmap2 into 1.  When the guest is restarted, there is no real 
data loss (bitmap1 and 2 are now both active, which is a little bit less 
efficient for guest writes than having just one active), so the user can 
attempt to have libvirt retry the deletion sequence.  If asking for 
bitmap1 to be enabled fails (because it is already enabled), then 
libvirt will have to add workaround code (either to detect that the 
error iss different than other failures, or to pre-probe whether the 
bitmap is already enabled); whereas if the request is a no-op, things 
are easier from libvirt's point of view.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
