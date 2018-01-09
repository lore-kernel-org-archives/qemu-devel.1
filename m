Received: from eggs.gnu.org ([2001:4830:134:3::10]:55719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYuAb-0004xw-GF
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYuAW-0001an-Kt
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:42:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYuAW-0001aM-E2
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:42:20 -0500
Date: Tue, 9 Jan 2018 13:42:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180109134208.GD31400@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-19-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-19-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 18/27] monitor: send event when command
 queue full
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


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:48PM +0800, Peter Xu wrote:
> @@ -4071,6 +4073,9 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
>      req_obj->req =3D req;
>      req_obj->need_resume =3D false;
> =20
> +    /* Protect qmp_requests and fetching its length. */
> +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +
>      /*
>       * If OOB is not enabled on current monitor, we'll emulate the old
>       * behavior that we won't process current monitor any more until
> @@ -4080,6 +4085,17 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>      if (!qmp_oob_enabled(mon)) {
>          monitor_suspend(mon);
>          req_obj->need_resume =3D true;
> +    } else {
> +        /* Drop the request if queue is full. */
> +        if (mon->qmp.qmp_requests->length >=3D QMP_REQ_QUEUE_LEN_MAX) {
> +            qapi_event_send_command_dropped(id,
> +                                            COMMAND_DROP_REASON_QUEUE_FU=
LL,
> +                                            NULL);
> +            qobject_decref(id);
> +            qobject_decref(req);
> +            g_free(req_obj);
> +            return;

qmp_queue_lock is still locked!  I suggest releasing the lock before
calling qapi_event_send_command_dropped().

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVMawAAoJEJykq7OBq3PIeugIALAtxZFqCmwJaWui6k68Pein
o0jbIcX+TkAKwlQjUmiiuJ9XNPPos8sm38kOrozHpHy07f7sW1E8zwUOzRuIFpxv
QkmNxM5C/QL9Ph9fVvndHXZ382DuePljliC/BGQViD8VsEBdtxPqHNbyq1LgCv85
vFmgieRrIR2dSlt8h6wom0Ept24j2wEltxCS4Qv60IcE2Ape7TTbeADCDkNuel/s
A18VG000Cr8TSbZzLrh9Z7DEl+HABLhOkY85sd/npDPOBUjY/JZ0AKdvOptqKjdT
ihswrHCAIjc6MJdUknzBnO8q7Xn2v2oiHZloiXR4uuyCMDAzGpMhJFNToH4a6NU=
=M9P8
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
