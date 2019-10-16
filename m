Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90168FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 18:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60669218DE
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 18:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmuxAIIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60669218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKoIy-0001kS-Gs
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 14:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iKoI4-00018W-8u
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 14:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iKoI3-0005oi-5a
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 14:44:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iKoI2-0005oB-TJ
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 14:44:55 -0400
Received: by mail-wr1-x444.google.com with SMTP id r3so29271923wrj.6
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 11:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xMXXNS5avxy69xRg1DGFF/riCwTTYHJMnGimGq68Sl0=;
 b=JmuxAIINvi13NbnxAW5ft8QY7D+hdUclFGbQJX6MyyNxYc0L8kIm1Q6sacZ2I9fNCA
 6MecOXPQssxNcuxW/xZJ3iMmckw1KrtkRBXyuFa9r9lmkIj0ftoLekjWf8+fJRcNU94b
 vH/FCAQvT+pBKtV2hGwPovQ6C6JCWwDTXObvs7lwF3AVp+yNKfR8Q5pM0JmUbTGVN1o/
 Yn7jvmbcjm/Npj3C3lftDY92yefKX5xyVozU2bGmVYV8kjETiPQYIX/mqz7KSjxd2iZa
 Gd8F5eL7wvQr+sTV/kHTScbiN68gMaXVzuWz1x0+iDrxO3p/B+fesE4eOsS+myvJXytK
 Pn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xMXXNS5avxy69xRg1DGFF/riCwTTYHJMnGimGq68Sl0=;
 b=jSjI04vPyflv8t5IagU1dCoxLoyneQcmh9CShe+HmFMyqfiUE9QkoFmN58VlX9VaTj
 azLL44x4N53lky2R/7UGMUBm6k1BTGBoCgQtdGyq8V5IDcd8DZXYnh0USD/VbM6HWgq5
 hmY1BNhIwY+/uAp58xeSIG/ObNRKNPWwlLYpuRt6IGDFVRQTa7F9ml7wqnJKz2KTC7n8
 fQmxp1GzxzwxI/YEYhRPXf6RxfGv3vsCxOrz53F+IIPUNSYUEDXilhTMTdFxMyhBs4hQ
 Yk92qFFXRFkMJz1p0LswVe2SpTWbm86bFdPkEBWaXLHtd8HSiaszkI7Zmfe7yafVOWKT
 VURw==
X-Gm-Message-State: APjAAAXKD4SDn0UbU3+9bRscS6VJjZ2G7YnYBS1lOnwDe0ckDT5C9H16
 wRoZWttEIrLXrx2HGC5KqDk=
X-Google-Smtp-Source: APXvYqznD5UronV9BZEbXh7bmzngn8z3xevGEKeaOtfvGbqRv9ilsdSAXJLvkbGqa9z19sZRZ6Ma3A==
X-Received: by 2002:adf:aacc:: with SMTP id i12mr3949008wrc.15.1571251493413; 
 Wed, 16 Oct 2019 11:44:53 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y186sm5103761wmd.26.2019.10.16.11.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 11:44:51 -0700 (PDT)
Date: Wed, 16 Oct 2019 19:44:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] virito: Use auto rcu_read macros
Message-ID: <20191016184450.GA15027@stefanha-x1.localdomain>
References: <20191014175440.152609-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20191014175440.152609-1-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 06:54:40PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Use RCU_READ_LOCK_GUARD and WITH_RCU_READ_LOCK_GUARD
> to replace the manual rcu_read_(un)lock calls.
>=20
> I think the only change is virtio_load which was missing unlocks
> in error paths; those end up being fatal errors so it's not
> that important anyway.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/virtio/virtio.c | 46 ++++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2nZSEACgkQnKSrs4Gr
c8ilfggAxZJ8UG+TgvE9DZr5SJ8+82NgAg1ZPnSYys65m3EcQGj1S4CDxjKR3icC
KK4R6WoydLdxZH2PcuakoSc32iLbo+23aAhbLrOnn4b4dmUXIw3phttAqbuMsf7p
kn2Z9C0SuaoVwA+6KGScTaV/2fsSxhcke4on9LGUmH1InDp56/RllAgvJ3mscdr9
G2QHubgXV3JKqX7hR+0pIid5rTKVnRp6Js3rd1R2dJW/ZRc/AeDamLKdbHXdULjA
NWDUNPGlY01C5vtzz03CRfYurq3ZNW3jpmtomq80mdqVsuJbS3APVywDkLUjWfig
VCV3b0DY7Dz4SsiPzqDzQzs2izLY1A==
=NIIz
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

