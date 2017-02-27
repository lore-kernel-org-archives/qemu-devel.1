Received: from eggs.gnu.org ([2001:4830:134:3::10]:35007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ciInW-0007ga-Gg
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ciInV-0007B7-JQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:44:54 -0500
Date: Mon, 27 Feb 2017 10:44:39 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170227104439.GC2350@work-vm>
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
	<20170225193155.447462-5-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170225193155.447462-5-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] migration: fix use-after-free of
 to_dst_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> hmp_savevm calls qemu_savevm_state(f), which sets to_dst_file=f in
> global migration state. Then hmp_savevm closes f (g_free called).
> 
> Next access to to_dst_file in migration state (for example,
> qmp_migrate_set_speed) will use it after it was freed.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 75e56d2d07..fcb8fd8acd 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1276,6 +1276,11 @@ done:
>          status = MIGRATION_STATUS_COMPLETED;
>      }
>      migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status);
> +
> +    /* f is outer parameter, it should not stay in global migration state after
> +     * this function finished */
> +    ms->to_dst_file = NULL;
> +
>      return ret;
>  }
>  
> -- 
> 2.11.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
