Received: from eggs.gnu.org ([2001:4830:134:3::10]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePDLk-0002xd-2e
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePDLh-0003AE-AN
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:09:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePDLg-00039M-Ua
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:09:49 -0500
Date: Wed, 13 Dec 2017 20:09:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213200938.GG8317@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-17-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-17-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 16/26] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:50PM +0800, Peter Xu wrote:
> @@ -3956,12 +3968,122 @@ static void handle_qmp_command(JSONMessageParser=
 *parser, GQueue *tokens,
>          }
>      }
> =20
> -err_out:
> -    monitor_qmp_respond(mon, rsp, err, id);
> +    /* Respond if necessary */
> +    monitor_qmp_respond(mon, rsp, NULL, id);
> +
> +    /* This pairs with the monitor_suspend() in handle_qmp_command(). */
> +    if (!qmp_oob_enabled(mon)) {
> +        monitor_resume(mon);

monitor_resume() does not work between threads: if the event loop is
currently blocked in poll() it won't notice that the monitor fd should
be watched again.

Please add aio_notify() to monitor_resume() and monitor_suspend().  That
way the event loop is forced to check can_read() again.

> +    }
> =20
>      qobject_decref(req);
>  }
> =20
> +/*
> + * Pop one QMP request from monitor queues, return NULL if not found.
> + * We are using round-robin fasion to pop the request, to avoid
> + * processing command only on a very busy monitor.  To achieve that,
> + * when we processed one request on specific monitor, we put that
> + * monitor to the end of mon_list queue.
> + */
> +static QMPRequest *monitor_qmp_requests_pop_one(void)
> +{
> +    QMPRequest *req_obj =3D NULL;
> +    Monitor *mon;
> +
> +    qemu_mutex_lock(&monitor_lock);
> +
> +    QTAILQ_FOREACH(mon, &mon_list, entry) {
> +        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);

Please add a doc comment about the monitor_lock < qmp_queue_lock lock
ordering in the qmp_queue_lock field declaration so that deadlocks can
be prevented.

> +        req_obj =3D g_queue_pop_head(mon->qmp.qmp_requests);
> +        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +        if (req_obj) {
> +            break;
> +        }
> +    }
> +
> +    if (req_obj) {
> +        /*
> +         * We found one request on the monitor. Degrade this monitor's
> +         * priority to lowest by re-inserting it to end of queue.
> +         */
> +        QTAILQ_REMOVE(&mon_list, mon, entry);
> +        QTAILQ_INSERT_TAIL(&mon_list, mon, entry);
> +    }
> +
> +    qemu_mutex_unlock(&monitor_lock);
> +
> +    return req_obj;
> +}
> +
> +static void monitor_qmp_bh_dispatcher(void *data)
> +{
> +    QMPRequest *req_obj;
> +
> +    while (true) {

Previously QEMU could only dispatch 1 QMP command per main loop
iteration.  Now multiple requests can be processed in a single main loop
iteration.

If a producer enqueues requests faster than the dispatcher can dequeue
them then this is infinite loop will prevent the caller (i.e.  QEMU main
loop) from making progress.

The following keeps 1 QMP command per main loop iteration and avoids the
infinite loop:

  static void monitor_qmp_bh_dispatcher(void *data)
  {
      QMPRequest *req_obj =3D monitor_qmp_requests_pop_one();

      if (req_obj) {
          monitor_qmp_dispatch_one(req_obj);

	  /* Reschedule instead of looping so the main loop stays responsive */
          qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
      }
  }

> +    /*
> +     * Put the request to the end of queue so that requests will be
> +     * handled in time order.  Ownership for req_obj, req, id,
> +     * etc. will be delivered to the handler side.
> +     */
> +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +    g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
> +    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +
> +    /* Kick the dispatcher routine */
> +    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> +
> +    /*
> +     * If OOB is not enabled on current monitor, we'll emulate the old
> +     * behavior that we won't process current monitor any more until
> +     * it is responded.  This helps make sure that as long as OOB is
> +     * not enabled, the server will never drop any command.
> +     */
> +    if (!qmp_oob_enabled(mon)) {
> +        monitor_suspend(mon);
> +    }

monitor_suspend() must be called before g_queue_push_tail().  Otherwise
the other thread might complete the request and call monitor_resume()
before we call monitor_suspend().

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMYkCAAoJEJykq7OBq3PI23cH/RSgkNz3AEmtThoLalE6mGJP
4y5i8g/q2XWNgHCghs5m8Qez1pyX5n7r616wreWoKqwkkptzv4ayfwKAHWvF6YV3
CTutONB6xsn7ER8olFlW+qZ2Gge3KTrIVybVd4+cbn5ikF1pgaJHx0TAru6XZIXV
OGl8kN3ucnTiSBdEnTEkFLJ4CH8fWt5SrfYBV0nr4bRrx/gOAxVzzWrXV9SFhF+e
KoS/2czUoTYb0dC/+jS2YmFKWqSvg/RdczZ0LIyvlHeraoy1vftyFpIkiSkEFIJM
jOqkjTU5tiB44hV2M46ogT80/oa04BpPNXSjudUTdL3tp+GTOGkdjGDRx9t4+Tk=
=23MO
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--
