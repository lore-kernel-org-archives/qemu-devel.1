Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E201C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570AF207FA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUilFn+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570AF207FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSOQc-0001th-Gr
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSOPg-0000yT-EU
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSOPf-0007mv-8a
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:44:08 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSOPf-0007mK-23
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:44:07 -0500
Received: by mail-wm1-x344.google.com with SMTP id q70so4367018wme.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 08:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NyC4YhDqBGVzKpMdPw4ZFmmAjIsIidtjmxF0U/8C+5U=;
 b=YUilFn+TVqVvQmB99D0cptUFdS5VHH8DBpiwOJROEE5RgmrBaJW9eRHni90nz2x3S7
 RtFIbjQ29k2Zlc0ShqtOF2kEln2VqdnrxOlLMLJv7XH/h1SSh03UTF6SZIZg5c8ydoS/
 H0lwitOOIqoY06lZZsMMy7fxvJBJC9xzeCg9qBcS5i6eTWCFQ2Jau94jH7X+oJ3H8F47
 GrjSzHQh5/FAf2HFfAWQgMIBrHxW0OJpA7eXc92fe3C5Rz8o6kwazydq5nh47xxAcsR3
 VuARtRaT9d7jcsOm4vDWywTqF0xz2KAnHAuGIAhv6LtqZFC6fJ+hYbjSv6MpUC/fjxGj
 RvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NyC4YhDqBGVzKpMdPw4ZFmmAjIsIidtjmxF0U/8C+5U=;
 b=bwYR5fly9nMCyHga46F0957b6IIuw6GJxlB1pex9M2pGxccISqu6fB7eXj9jBs/EqM
 gDvLbbUIIEtsJaLJlTm0FnTL9YKau0UyBsY3oln4NxqKbFXTXAACfn5/xrjp6joO/kWB
 MsQ3Xt5TO/Apzj6ICe2lxjfXxrHYyynhlbBcNPwNHw3u+btvh36bC7lgavnAqgkllSMW
 RJGGKLxwfDkde03QscJoJ2W6WMYZ0nQjpTC/grVxXx+1ZxQ4TnujyJhfS0x/L06Z50k0
 zqjlF2yIvy/2Dxmd9hQym6E4W5ZGr8FX+JzFNHxPUsYGRuF75whRkZhBKmiH1m5fodM6
 SmDg==
X-Gm-Message-State: APjAAAU0HedmTWVRKd69gHiSdx/0tygDGeJPyLgI2BwFCsduNPMDV3i0
 zQZEUbKgCllo8IUPO+plKfk=
X-Google-Smtp-Source: APXvYqwJNYFiy0j+wnxA80TY1vzPfOAtZ9aWRY9ip9ZmxnysTep+mJEdATdL//8FO+rTz8ZcAzxOSw==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr3315774wmj.140.1573058645656; 
 Wed, 06 Nov 2019 08:44:05 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id y16sm14993742wro.25.2019.11.06.08.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 08:44:04 -0800 (PST)
Date: Wed, 6 Nov 2019 17:44:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 11/20] libqtest: make qtest_bufwrite send "atomic"
Message-ID: <20191106164403.GJ340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-12-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/qIPZgKzMPM+y5U5"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-12-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/qIPZgKzMPM+y5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 02:49:57PM +0000, Oleinik, Alexander wrote:
> From: Alexander Oleinik <alxndr@bu.edu>
>=20
> When using qtest "in-process" communication, qtest_sendf directly calls
> a function in the server (qtest.c). Combining the contents of the
> subsequent socket_sends into the qtest_sendf, makes it so the server can
> immediately handle the command, without building a local buffer and
> waiting for a newline.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/libqtest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 822bfe208b..ff3153daf2 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -1083,8 +1083,8 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, c=
onst void *data, size_t size)
> =20
>      bdata =3D g_base64_encode(data, size);
>      qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
> -    socket_send(s->fd, bdata, strlen(bdata));
> -    socket_send(s->fd, "\n", 1);
> +    s->ops.send(s, bdata, strlen(bdata));
> +    s->ops.send(s, "\n", 1);
>      qtest_rsp(s, 0);
>      g_free(bdata);
>  }

Please update the commit message and description - they no longer seem
to match what the patch is doing.  The qtest_sendf() is not atomic, it
is still split into 3 send operations.

Stefan

--/qIPZgKzMPM+y5U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C+FIACgkQnKSrs4Gr
c8iPjwf/dOoufUX79aqT+n/aZkt0x/A+mnMeFuGZmf82N1qBIpM3sJBr/zKJ/0he
KZcjwoM35T2+debWJ8YVGAtF09gFjiermG/1BckCGXEFHi6QbCMU/4QKfecphRwH
IZxtz0JPdDH0kWlPhTloFhN+/gUJNaKu229HFIkMAh6gxczRYrl57N9gqpI6PmKm
jpyWZQL5i4pWHZatXgL1k0XgyXb1hkKmGBCwDj71a5GUiDz8/byCZ3G3yYY8AmIt
jhBNA/Bne5M91R0MQnwOkpDmJD/8Kb7G06hVXItFAqCkMJ6ezyrtcYx4zBVjSWMY
msgKzN7Yg2NFVhUZ/yi+oIiNePuBeQ==
=hKKj
-----END PGP SIGNATURE-----

--/qIPZgKzMPM+y5U5--

