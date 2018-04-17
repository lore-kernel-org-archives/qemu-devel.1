Received: from eggs.gnu.org ([2001:4830:134:3::10]:44248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Vcg-0001YH-2e
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Vcb-00052g-Ul
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:46:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8Vcb-000526-Mg
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:46:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 804DD4023150
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 18:46:25 +0000 (UTC)
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <22b1c176-a6c2-951e-09ec-aa41b6b0576d@redhat.com>
Date: Tue, 17 Apr 2018 13:46:20 -0500
MIME-Version: 1.0
In-Reply-To: <20180417133602.23832-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eeixQoej7hyI2V76mgWil1m1fcA3UPBOQ"
Subject: Re: [Qemu-devel] [PATCH v5 3/5] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eeixQoej7hyI2V76mgWil1m1fcA3UPBOQ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <22b1c176-a6c2-951e-09ec-aa41b6b0576d@redhat.com>
Subject: Re: [PATCH v5 3/5] qobject: replace qobject_incref/QINCREF
 qobject_decref/QDECREF
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
 <20180417133602.23832-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180417133602.23832-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2018 08:36 AM, Marc-Andr=C3=A9 Lureau wrote:
> Now that we can safely call QOBJECT() on QObject * as well as its
> subtypes, we can have macros qobject_ref() / qobject_unref() that work
> everywhere instead of having to use QINCREF() / QDECREF() for QObject
> and qobject_incref() / qobject_decref() for its subtypes.
>=20
> Note that the new macros evaluate their argument exactly once, thus no
> need to shout them.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/monitor.c

> @@ -346,7 +346,7 @@ static void monitor_qmp_cleanup_req_queue_locked(Mo=
nitor *mon)
>  static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
>  {
>      while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
> -        qobject_decref(g_queue_pop_head(mon->qmp.qmp_responses));
> +        qobject_unref((QObject *)g_queue_pop_head(mon->qmp.qmp_respons=
es));

Interesting that you have to add a cast here.  That is, the new macro is
more type-safe than the old version (since g_queue_pop_head() returns
void*); a quick audit of monitor.c shows we only ever pushed QObject*
onto the queue in the first place...

> @@ -494,9 +494,9 @@ static void monitor_json_emitter(Monitor *mon, QObj=
ect *data)
>           * caller won't free the data (which will be finally freed in
>           * responder thread).
>           */
> -        qobject_incref(data);
> +        qobject_ref(data);
>          qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> -        g_queue_push_tail(mon->qmp.qmp_responses, (void *)data);
> +        g_queue_push_tail(mon->qmp.qmp_responses, data);

=2E..but you did manage to get rid of the pointless cast to void* in the
process.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eeixQoej7hyI2V76mgWil1m1fcA3UPBOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWQPwACgkQp6FrSiUn
Q2qIQwgAn6YA09N09F5MQLAkuf4D2Ze4tC83AnEznXuW8zBLbU9U2GSqhgh9DZCz
fC9u3ea7mPC2LU4UWmb1D/st7pAgf2f90KQkQmA56iWDZF7q6TjBHnEmZzycRd6I
H0D1N+THYqWTnkKPWggfPD7dMNE2WREH+p1af9hRs75xIUxAS3eVtnbLpYQtEYHu
RuduGjmCT1j9iHWota4p6lG7b9b4nxyNZ21VmMVOSigRbCeSaMo0gciznTnVQlYi
qQOftOMolJjMO00aBsOu4oW9rMJC8jfGJoJd99EtqLFnMKoWU8shw2x7mqslSQTf
LuXya2n7+Xag18j2ZF20Aow70bq8yA==
=6ZYq
-----END PGP SIGNATURE-----

--eeixQoej7hyI2V76mgWil1m1fcA3UPBOQ--
