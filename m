Received: from eggs.gnu.org ([2001:4830:134:3::10]:43303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxi3-00054D-VB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cVxi3-0003nv-4X
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:48:16 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1479837270-79005-12-git-send-email-vsementsov@virtuozzo.com>
	(Vladimir Sementsov-Ogievskiy's message of "Tue, 22 Nov 2016 20:54:24
	+0300")
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-12-git-send-email-vsementsov@virtuozzo.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jan 2017 10:48:04 +0100
Message-ID: <8760l4aiwb.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 11/17] migration: add is_active_iterate
 handler
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
> Only-postcopy savevm states (dirty-bitmap) don't need live iteration, so
> to disable them and stop transporting empty sections there is a new
> savevm handler.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/migration/vmstate.h | 1 +
>  migration/savevm.c          | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index dc656be..2c53d0b 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -47,6 +47,7 @@ typedef struct SaveVMHandlers {
>      /* This runs both outside and inside the iothread lock.  */
>      bool (*is_active)(void *opaque);
>      bool (*has_postcopy)(void *opaque);
> +    bool (*is_active_iterate)(void *opaque);
>  
>      /* This runs outside the iothread lock in the migration case, and
>       * within the lock in the savevm case.  The callback had better only
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c58b9f9..4eb1640 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -988,6 +988,11 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>                  continue;
>              }
>          }
> +        if (se->ops && se->ops->is_active_iterate) {
> +            if (!se->ops->is_active_iterate(se->opaque)) {
> +                continue;
> +            }
> +        }
>          /*
>           * In the postcopy phase, any device that doesn't know how to
>           * do postcopy should have saved it's state in the _complete

Reviewed-by: Juan Quintela <quintela@redhat.com>

I still don't see cleary why you can't "reuse" the is_active(), but
well, it will have to add magic there, so ....

BTW, in hindsight, this "is_active" functions are used mainly to check
if the thing is "not active" O:-)
