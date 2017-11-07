Received: from eggs.gnu.org ([2001:4830:134:3::10]:54369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eByFi-0007OY-Ft
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eByFd-0003q9-IQ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:24:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eByFd-0003q1-9b
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 02:24:49 -0500
Date: Tue, 7 Nov 2017 15:24:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171107072436.GP16355@lemon>
References: <20171106094643.14881-1-peterx@redhat.com>
	<20171106094643.14881-16-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106094643.14881-16-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 15/27] monitor: introduce
 monitor_qmp_respond()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, 11/06 17:46, Peter Xu wrote:
> A tiny refactoring, preparing to split the QMP dispatcher away.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 48 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 442d711d5d..1e87de87f8 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3877,6 +3877,36 @@ static int monitor_can_read(void *opaque)
>      return (mon->suspend_cnt == 0) ? 1 : 0;
>  }
>  
> +/*
> + * When rsp/err/id is passed in, the function will be responsible for
> + * the cleanup.
> + */
> +static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
> +                                Error *err, QObject *id)
> +{
> +    QDict *qdict = NULL;
> +
> +    if (err) {
> +        qdict = qdict_new();
> +        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
> +        error_free(err);
> +        rsp = QOBJECT(qdict);
> +    }
> +
> +    if (rsp) {
> +        if (id) {
> +            /* This is for the qdict below. */
> +            qobject_incref(id);

A small change from the old code (that does no incref, and sets id to NULL
afterwards to the final qobject_decref(id) is no-op), but looks correct.

Reviewed-by: Fam Zheng <famz@redhat.com>

> +            qdict_put_obj(qobject_to_qdict(rsp), "id", id);
> +        }
> +
> +        monitor_json_emitter(mon, rsp);
> +    }
> +
> +    qobject_decref(id);
> +    qobject_decref(rsp);
> +}
> +
>  static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
>                                 void *opaque)
>  {
> @@ -3927,24 +3957,8 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
>      }
>  
>  err_out:
> -    if (err) {
> -        qdict = qdict_new();
> -        qdict_put_obj(qdict, "error", qmp_build_error_object(err));
> -        error_free(err);
> -        rsp = QOBJECT(qdict);
> -    }
> +    monitor_qmp_respond(mon, rsp, err, id);
>  
> -    if (rsp) {
> -        if (id) {
> -            qdict_put_obj(qobject_to_qdict(rsp), "id", id);
> -            id = NULL;
> -        }
> -
> -        monitor_json_emitter(mon, rsp);
> -    }
> -
> -    qobject_decref(id);
> -    qobject_decref(rsp);
>      qobject_decref(req);
>  }
>  
> -- 
> 2.13.5
> 
