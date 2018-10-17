Received: from eggs.gnu.org ([2001:4830:134:3::10]:49168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCqUx-0002Mc-Ie
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCqUw-00005t-JN
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:24:47 -0400
References: <20181002230218.13949-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2f93b39-107c-ba70-5915-0b24c25cf58d@redhat.com>
Date: Wed, 17 Oct 2018 13:24:13 -0500
MIME-Version: 1.0
In-Reply-To: <20181002230218.13949-1-jsnow@redhat.com>
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
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 10/2/18 6:02 PM, John Snow wrote:
> based on: jsnow/bitmaps staging branch
> 
> This series builds on a previous standalone patch and adjusts
> the permission for all (or most) of the QMP bitmap commands.
> 
> V4:
>   - Replace "in-use" with "in use"
>   - Replace "user_modifiable" version with "user_locked"
>   - Remove more usages of frozen-and-or-locked in NBD.
> 
> John Snow (6):
>    block/dirty-bitmaps: add user_locked status checker
>    block/dirty-bitmaps: fix merge permissions
>    block/dirty-bitmaps: allow clear on disabled bitmaps
>    block/dirty-bitmaps: prohibit enable/disable on locked/frozen bitmaps
>    block/backup: prohibit backup from using in use bitmaps
>    nbd: forbid use of frozen bitmaps

Just now noticing that our docs are slightly out of sync with these changes:

# @DirtyBitmapStatus:
#
# An enumeration of possible states that a dirty bitmap can report to 
the user.
#
# @frozen: The bitmap is currently in-use by a backup operation or block 
job,
#          and is immutable.
#
# @disabled: The bitmap is currently in-use by an internal operation and is
#            read-only. It can still be deleted.

This state is also reachable when using x-block-dirty-bitmap-disable, 
which is not an internal operation.  We probably also ought to document 
that this state is a prereq to x-nbd-server-add-bitmap, since...

#
# @active: The bitmap is actively monitoring for new writes, and can be 
cleared,
#          deleted, or used for backup operations.

...active is not valid for that usage.

#
# @locked: The bitmap is currently in-use by some operation and can not be
#          cleared, deleted, or used for backup operations. (Since 2.12)


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
