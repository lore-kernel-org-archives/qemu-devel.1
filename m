Received: from eggs.gnu.org ([2001:4830:134:3::10]:47942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLn9O-0007SC-49
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLn9K-0000T9-T5
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:02:42 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dLn9K-0000Sw-Lc
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:02:38 -0400
Received: by mail-wm0-x241.google.com with SMTP id d64so3739697wmf.2
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 02:02:38 -0700 (PDT)
Date: Fri, 16 Jun 2017 10:02:35 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170616090235.GB31462@stefanha-x1.localdomain>
References: <201706131924483092713@zte.com.cn>
	<d62e03ee-f3ab-303e-011d-8b995530b6ab@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <d62e03ee-f3ab-303e-011d-8b995530b6ab@redhat.com>
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTog562U5aSNOiBSZTogW1BBVENI?=
 =?utf-8?q?v2_02/04=5D_colo-compare=3A_Process_pactkets_in_the_IOThread_of?=
 =?utf-8?q?the_primary?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: wang.yong155@zte.com.cn, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, wang.guang55@zte.com.cn, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 12:23:27PM +0800, Jason Wang wrote:
> Paolo, Marc and Stefan:
>=20
> We want let chardev front-end run in colo comparing IOThread. This looks =
not
> supported by current chardev frontend API. Any idea/suggestion on how to
> achieve this?

I'm not very familiar with chardev but a quick look suggests that the
subsystem uses the glib event loop (GMainContext) APIs.

IOThread uses QEMU's AioContext event loop and does not run a
GMainContext.

main-loop.c has an AioContext but also a GMainContext.  It runs the
GMainContext event loop and integrates AioContext into that event loop.

Today chardev and IOThread cannot work together.  chardev only works in
the main loop because the implicit NULL GMainContext is used by the
code.

It may be possible to unify main-loop.c and AioContext so that every
AioContext also has a GMainContext.  I don't know how difficult that
will be.

Unification must not decrease AioContext performance.  Benchmarks would
be necessary.

Stefan

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQ56rAAoJEJykq7OBq3PI2BIIALrNijrnIcqzzorDzwL1tyFp
i2fdAHPhFsfqa7ET4DwSnKXeZjs13oXazoOfLKBHft62laKShNO0mLjCXj9kdgL1
GCX2L9CIhdDQji//RqpjWqlp0eJ/JPnDnPAJNbxT13BghZD3a3P/RR+PFMpXSjAs
AJH9+muM5L3rjh+Aih2fRggPb1dYeYkMSiQ5VAtjHt/OcZTY/dC+RWMhBOj5yegZ
LRsUU/hzrNhq9KXOoCZiOUYga5RPYoDHWxJK78IHdbThbCL8TXQbvnQ3sT8+yyuv
QbI2dDRRlEGDWuw924nJQqkIy99fLW2886KtV/IKkPOuytw/cYMcLvv+nd+8DS8=
=scns
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
