Received: from eggs.gnu.org ([2001:4830:134:3::10]:35262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxEs-00055R-64
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:18:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxEr-0002yA-Aj
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:18:06 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1479837270-79005-5-git-send-email-vsementsov@virtuozzo.com>
	(Vladimir Sementsov-Ogievskiy's message of "Tue, 22 Nov 2016 20:54:17
	+0300")
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-5-git-send-email-vsementsov@virtuozzo.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jan 2017 10:17:55 +0100
Message-ID: <87y3y0akak.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 04/17] migration: introduce postcopy-only
 pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> There would be savevm states (dirty-bitmap) which can migrate only in
> postcopy stage. The corresponding pending is introduced here.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/migration/vmstate.h |  5 +++--
>  include/sysemu/sysemu.h     |  5 +++--
>  migration/block.c           |  7 ++++---
>  migration/migration.c       | 15 ++++++++-------
>  migration/ram.c             |  9 +++++----
>  migration/savevm.c          | 14 ++++++++------
>  migration/trace-events      |  2 +-
>  7 files changed, 32 insertions(+), 25 deletions(-)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 5c30ef7..dc656be 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -58,8 +58,9 @@ typedef struct SaveVMHandlers {
>      /* This runs outside the iothread lock!  */
>      int (*save_live_setup)(QEMUFile *f, void *opaque);
>      void (*save_live_pending)(QEMUFile *f, void *opaque, uint64_t max_size,
> -                              uint64_t *non_postcopiable_pending,
> -                              uint64_t *postcopiable_pending);
> +                              uint64_t *res_precopy_only,
> +                              uint64_t *res_compatible,
> +                              uint64_t *res_postcopy_only);

ok, this got just out of control, this paramenters need to move to one
struct, but as the code was already ugly, I will not put the burden on
you O:-)

But you need to document what means each of the new fields, please O:-)

I really think that doing the rename of the fields in one patch, and
then add the res_compat in a differnt one will make  things easier to
review.


Reviewed-by: Juan Quintela <quintela@redhat.com>

If you have to send a new review, just add documentation to the variable
names, otherwise, send an additional patch when this is merged.
