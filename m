Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F36C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F2A206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 07:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Mfrh0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F2A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsMhd-0003p5-Fj
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 03:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43014)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hsMhA-0003FI-5g
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hsMh9-0003xu-Ae
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 03:37:16 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hsMh9-0003xf-4X; Tue, 30 Jul 2019 03:37:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id g67so51549195wme.1;
 Tue, 30 Jul 2019 00:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dQIpnV4LZvhQ3lloX/9JJb/lLJErDsCRTvTUZeMluCo=;
 b=J2Mfrh0yhTxo1WtlBKc0vjLDbGitCu8TrXyKX4tCd09KjzESR7x8KfsuwVeZo3IggD
 6TDEthZdnFitDhPSuwGuadhCT4ih3bAZzWcIAHsGGAvpvbT0VHakJOmedLokluOaLtLu
 qFvxhtHp+d788rYR0JyETprGgKOER8mx1+dgW8kYKfpGHdzl/OIcM1zW/Jc393C6Hnvn
 ZX56ltJBzgyNN+Diq/lntJofHhPZGUETDJM7PYttwURs86LXhqIz+QKiUhsS7OrzAuIC
 iMgGKFeCOs/9UMFxkgHo23D9tETvweYISZ5eGc/mH7HkfJoPfk57cAFStPB6EX21h2SA
 cRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dQIpnV4LZvhQ3lloX/9JJb/lLJErDsCRTvTUZeMluCo=;
 b=gyi7SFatAExgc+Xf62hlP/RoFGdpTDA7wIPYcfGX+B0t5Fs5QQYDBQeQsuujsr7jRq
 fSIU4lSMokJsBdiCZpRmtnEJPDZcy37VgpFI06zDDO4t42eFduuiAQvLJ8awyNLNdI0z
 ytOMobyjgglOizgOV9U6x+5+kJ5HPxkEnp7jbQcsRpwCvcie5P79YcuG+vPFJZH6CIq7
 WlZPthygF+w3ETYSvJJqUSdeXnDzMZ3+F6Aq0oeq5zr97dkdgAdZD8yHJ4AGGUqv4mzY
 pJ1DmSxF00DvIhd+yQv5w66mkeRlTtLq0LTch5Pi9ADFBc4HrgS2GjcIBd55wZIwC+6O
 AuUw==
X-Gm-Message-State: APjAAAWX8BReoL7MVoQe1Y9HdDiiLXeh7egaCGmdz9dl72mSNePpS7iO
 2ovg514oMYJGNy6x9q07bwQ=
X-Google-Smtp-Source: APXvYqwYX0aGOqHlaPV+iuyR8UOSJ2LItwa88XCSFM2IN52COpod+hRwmnkqOz8s8sh5FMyK35UlQw==
X-Received: by 2002:a1c:cfc5:: with SMTP id f188mr95004124wmg.24.1564472233788; 
 Tue, 30 Jul 2019 00:37:13 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n9sm107629364wrp.54.2019.07.30.00.37.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 00:37:13 -0700 (PDT)
Date: Tue, 30 Jul 2019 08:37:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190730073712.GD30213@stefanha-x1.localdomain>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
 <20190729151651.21306-13-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <20190729151651.21306-13-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v7 12/15] qemu-img: adds
 option to use aio engine for benchmarking
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2019 at 08:46:48PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  qemu-img.c    | 10 +++++++++-
>  qemu-img.texi |  5 ++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 79983772de..3fc8dac0b1 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4192,7 +4192,8 @@ static int img_bench(int argc, char **argv)
>              {"force-share", no_argument, 0, 'U'},
>              {0, 0, 0, 0}
>          };
> -        c =3D getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:wU", long_optio=
ns, NULL);
> +        c =3D getopt_long(argc, argv, ":hc:d:f:ni:o:qs:S:t:wU", long_opt=
ions,
> +                        NULL);

Please update help() with documentation for -i.

>          if (c =3D=3D -1) {
>              break;
>          }
> @@ -4234,6 +4235,13 @@ static int img_bench(int argc, char **argv)
>              break;
>          case 'n':
>              flags |=3D BDRV_O_NATIVE_AIO;

Missing break statement.

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0/86cACgkQnKSrs4Gr
c8iqRQf+Ox/Hn09ZbsqUzV3/uwXf2+7TMMQkpG/ETXt2v5CCYMaOM1EETqO5LcLo
YFK2pQRBovJbAnf2sazdfK63GM5LtZLkd1yk+HnM5BuR7pKLIGG30KHtGT8yUUKs
82iQExX2eerbJ1Mz6rplLROlb0t4/GbLMKbLp5n7zaEZ6RSWSCeKFeJPJF/gb73/
36BNJ8bkngvmT3ZuEq/vMKN3xEmjAQVp058A4CW6hXNgRZvyTaJTK59RJv/wCoYu
3cWGQZCalt2YhoOnBhYxqIV6koDuE+okX63FpbeQSunAX/6FYJ/i9NWnpDx3Xa4l
uabpz+vBxc4Dd7y7k+16NLOm8InRNA==
=+gS5
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--

