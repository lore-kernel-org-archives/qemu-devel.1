Received: from eggs.gnu.org ([209.51.188.92]:45927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxeZp-0003ZI-CJ
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gxeZn-0002uY-C9
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 16:11:17 -0500
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <79dad9b4-17ad-b218-d0f0-d5ec03aeb838@redhat.com>
Date: Sat, 23 Feb 2019 15:10:36 -0600
MIME-Version: 1.0
In-Reply-To: <20190223000614.13894-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/10] block/dirty-bitmaps: rename
 frozen predicate helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

On 2/22/19 6:06 PM, John Snow wrote:
> "Frozen" was a good description a long time ago, but it isn't adequate now.
> Rename the frozen predicate to has_successor to make the semantics of the
> predicate more clear to outside callers.
> 
> In the process, remove some calls to frozen() that no longer semantically
> make sense. For bdrv_enable_dirty_bitmap_locked and
> bdrv_disable_dirty_bitmap_locked, it doesn't make sense to prohibit QEMU
> internals from performing this action when we only wished to prohibit QMP
> users from issuing these commands. All of the QMP API commands for bitmap
> manipulation already check against user_locked() to prohibit these actions.
> 
> Several other assertions really want to check that the bitmap isn't in-use
> by another operation -- use the bitmap_user_locked function for this instead,
> which presently also checks for has_successor. This leaves some redundant
> checks of has_sucessor through different helpers that are addressed in

successor (maintainer can fix, if we don't need v4)

> forthcoming patches.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c           | 32 +++++++++++++++++---------------
>  include/block/dirty-bitmap.h   |  2 +-
>  migration/block-dirty-bitmap.c |  2 +-
>  3 files changed, 19 insertions(+), 17 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
