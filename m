Received: from eggs.gnu.org ([209.51.188.92]:46320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1o0-0008QW-DE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1dW-0000Fd-5W
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:23:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm1dV-0000Dw-Ql
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:23:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9365E7971A
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 16:53:01 +0000 (UTC)
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-2-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c563bdda-601d-c362-049b-b8e3a933291b@redhat.com>
Date: Tue, 22 Jan 2019 10:52:46 -0600
MIME-Version: 1.0
In-Reply-To: <20181219120904.17643-2-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B7ASzrbM8aoQPnqrdPlLd7K6w6h46VNni"
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/7] kbd-state: add keyboard state
 tracker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B7ASzrbM8aoQPnqrdPlLd7K6w6h46VNni
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c563bdda-601d-c362-049b-b8e3a933291b@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/7] kbd-state: add keyboard state
 tracker
References: <20181219120904.17643-1-kraxel@redhat.com>
 <20181219120904.17643-2-kraxel@redhat.com>
In-Reply-To: <20181219120904.17643-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/18 6:08 AM, Gerd Hoffmann wrote:
> Now that most user interfaces are using QKeyCodes it is easier to have
> common keyboard code useable by all user interfaces.
>=20
> This patch adds helper code to track the state of all keyboard keys,
> using a bitmap indexed by QKeyCode.  Modifier state is tracked too,
> as separate bitmap.  That makes checking modifier state easier.
> Likewise we can easily apply special handling for capslock & numlock
> (toggles on keypress) and ctrl + shift (we have two keys for that).
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/kbd-state.h |  32 +++++++++++++
>  ui/kbd-state.c         | 125 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  ui/Makefile.objs       |   2 +-
>  3 files changed, 158 insertions(+), 1 deletion(-)
>  create mode 100644 include/ui/kbd-state.h
>  create mode 100644 ui/kbd-state.c
>=20

> +
> +void kbd_state_key_event(KbdState *kbd, QKeyCode qcode, bool down)
> +{
> +    bool state =3D test_bit(qcode, kbd->keys);
> +
> +    if (state =3D=3D down) {
> +        /*
> +         * Filter out events which don't change the keyboard state.
> +         *
> +         * Most notably this allows to simply send along all key-up
> +         * events, and this function will filter out everything where
> +         * the corresponding key-down event wasn't send to the guest,

s/send/sent/

> +         * for example due to being a host hotkey.
> +         */
> +        return;

> +void kbd_state_lift_all_keys(KbdState *kbd)
> +{
> +    int qcode;
> +
> +    for (qcode =3D 0; qcode < Q_KEY_CODE__MAX; qcode++) {
> +        if (test_bit(qcode, kbd->keys)) {
> +            kbd_state_key_event(kbd, qcode, false);

Is there a more efficient iteration through the bitmap when looking for
the next set bit, or is the map small enough that it doesn't matter?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--B7ASzrbM8aoQPnqrdPlLd7K6w6h46VNni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHSl4ACgkQp6FrSiUn
Q2oBvAf+LUY8ZdoIGRVIfNZsuDUQ8HBLGB0YIAxB6m/ZaJieYm3m1mzNfo7qlnnZ
eCq1hGLvEb08Y7wFlogdjEtQ/Gct16En8bJIOmr/LvuwqyZfkjgRCOxSY5cdtNyW
WZra75wjiPlVjjiFUpBT59tw6UcCo00ju07WZKScY8wHBKAPM2AzIcR/qurOkhfL
h2RQ/cWRmW2MhI6dvo8LOHYywDFa1QJ49vcesWq/V9Yv/ATY3mtvp3Lzv3GZ9dIp
NhyL7z13Po1/VMYpzh+XazMLNqqGAUX9CwY1GO91mE1QJVAjpVw0Mw4QIJPqQIZ6
B6X0I5MVwojDCPRiB8ekYGWcqCI1Ew==
=jyYU
-----END PGP SIGNATURE-----

--B7ASzrbM8aoQPnqrdPlLd7K6w6h46VNni--
