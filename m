Received: from eggs.gnu.org ([2001:4830:134:3::10]:50664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duIj2-0001Rf-PZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duIj0-00064n-5M
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:38:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duIiz-00063Y-SG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:38:06 -0400
References: <1505328054-23805-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f09b7bd0-2055-9f1c-4bb8-ab5f2bbf6837@redhat.com>
Date: Tue, 19 Sep 2017 08:38:00 -0500
MIME-Version: 1.0
In-Reply-To: <1505328054-23805-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wsPmd1JGBUxUqqrheXgjVdvWURWNPHJxT"
Subject: Re: [Qemu-devel] [PATCH v2] tests: Introduce generic device
 hot-plug/hot-unplug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wsPmd1JGBUxUqqrheXgjVdvWURWNPHJxT
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <f09b7bd0-2055-9f1c-4bb8-ab5f2bbf6837@redhat.com>
Subject: Re: [PATCH v2] tests: Introduce generic device hot-plug/hot-unplug
 functions
References: <1505328054-23805-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1505328054-23805-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 01:40 PM, Thomas Huth wrote:
> A lot of tests provide code for adding and removing a device via the
> device_add and device_del QMP commands. Maintaining this code in so man=
y
> places is cumbersome and error-prone (some of the code parts check the
> responses for device deletion in an incorrect way, for example, we've g=
ot
> to deal with both, error code and DEVICE_DEL event here). So let's prov=
ide
> some proper generic functions for adding and removing a device instead.=

>=20
> The code for correctly unplugging a device has been taken from a patch
> from Peter Xu.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

> + */
> +void qtest_qmp_device_del(const char *id)
> +{
> +    QDict *response1, *response2, *event =3D NULL;
> +    char *cmd;
> +
> +    cmd =3D g_strdup_printf("{'execute': 'device_del',"
> +                          " 'arguments': { 'id': '%s' }}", id);
> +    response1 =3D qmp(cmd);
> +    g_free(cmd);
> +    g_assert(response1);
> +    g_assert(!qdict_haskey(response1, "error"));
> +
> +    response2 =3D qmp("");

Hmm, this new use of qmp("") means I get to rebase the efforts to remove
the empty qmp command usage from the testsuite efforts.  We really want
to have two low-level functions (one to send, one to receive), and then
have qmp() be the combination of both in a row; we have qmp_async() for
the send, and only qtest_receive() for the receive, so I'll have to
revive my work on unifying things...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wsPmd1JGBUxUqqrheXgjVdvWURWNPHJxT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBHbgACgkQp6FrSiUn
Q2pjQggAnKdlZPIP401y2Hu/7kjm5jE1A9iFfGTANnkHsYpKm/s2E8NDn3IqmrXA
c5O9KQ3DiQNsO0YumRWKYIF9unJB1yBewje1HWbySIT2heEVHKxdvKeN7IUwHiC+
s8Rx4Y2ufxgGZIS0QoCymftAIqXRzteKwkgBAnQrhfIKdUc4gU6iTEr8M1ZtfxZ8
rj10MqOYR2livSL0sTaTWf7fMgQXmIqtnv3xa0f0sqFtvT2mk3gq3uNYyQLiA3CV
4xtyArdf8LBARf1qyToVM2FsICgmRVa1bMxWFZsWYPW+EXsFxXG3g7y3zPzeVldT
FBNMHYhz+8woZVopCjLmfiOEakf8Uw==
=oV7G
-----END PGP SIGNATURE-----

--wsPmd1JGBUxUqqrheXgjVdvWURWNPHJxT--
