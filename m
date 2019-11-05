Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD615C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07F3214B2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugoobrko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07F3214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1KJ-0000BW-EM
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS1J5-0007Gt-HT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS1J3-0006Yn-EN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:03:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iS1J1-0006VC-52
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:03:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id 11so21640869wmk.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=h13MMGIfcEC+tOTP/IjhVRAx2XvVmahMoKLnf8sIt8M=;
 b=ugoobrko262wGgHAMggkgfUKbiYQmcyrpqNHD7/dojq+oNwfZRTLqIyXasw8kcUvzs
 xbSkGHbVjEtv7iFR6pDoRGOIq/9BZ/0Qw7ajSe5hmvXMZt80eDNV6mpQkcBjPE8m95XW
 dD3aVLWWbF5kP0oEliTYbKFzTalpXMqNKinROK/EmIudrtR6jhZzccDfzvRTDlCkUp/L
 mhz4M9noB1OfBtzq8vTTzQ7dusuiqTDUSnDhR6z+YfQLnvVrgIsAnpyyWsaqxl5BYdf1
 WPIkxjcctuajmt058um/cIyOl/+aJDz3lwbNhunRRkIq4HeAmntJprscs2Dw0SQ+Fpjp
 hxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=h13MMGIfcEC+tOTP/IjhVRAx2XvVmahMoKLnf8sIt8M=;
 b=DbPp6QKGSI4uqR+uwMemdpXOrprX4rshdEAjgOtEo39x5XGwUtAFop/juWCptgWRaQ
 RM+lGkpkMxuf60bCPA9YORn5zU5QDN5S3KTBvwIX73GFYr0WDFTgCcw2CcC/CN2Lduph
 TtHfen8n6gY4aCe1Tu+FYIfCa4Eh5SQRcpR06wXZr1P3ZiKOQSJ7Vn+MXhbcxzOoD2MP
 OoIV1VaNyZnsccA/NYji5nyCY00TxVDttklU/UmyNy9wBy/IpM1PFOJRP2f8DBAt/Le4
 VVruMkls24o5eVjROuZMGxdSfrcC/q24Xo/zAmstp2xuS6PKUJnFQ5R6UQnwY27gNQBA
 hMSg==
X-Gm-Message-State: APjAAAWSnEAoeJLCeNF68qW8JhnhuIjHBT/lFQwUfliRJaAVJ9W/cvRk
 mVgSgvY39Rjt8R/YFOk24YA=
X-Google-Smtp-Source: APXvYqyLCwNQyTJbcQrcVRY94nbVj+WWUEAHYw07wtte3ddaewM3n6NrsS6z44pLQmsaEVLni2+dvw==
X-Received: by 2002:a1c:39c2:: with SMTP id g185mr2663271wma.88.1572969818181; 
 Tue, 05 Nov 2019 08:03:38 -0800 (PST)
Received: from localhost (91.141.1.3.wireless.dyn.drei.com. [91.141.1.3])
 by smtp.gmail.com with ESMTPSA id d11sm17284202wrn.28.2019.11.05.08.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 08:03:37 -0800 (PST)
Date: Tue, 5 Nov 2019 17:03:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] iothread: document -object iothread on man page
Message-ID: <20191105160336.GG166646@stefanha-x1.localdomain>
References: <20191025122236.29815-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
In-Reply-To: <20191025122236.29815-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Zhenyu Ye <yezhenyu2@huawei.com>, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, dgilbert@redhat.com,
 jiangyiwen <jiangyiwen@huawei.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2019 at 02:22:36PM +0200, Stefan Hajnoczi wrote:
> Add -object iothread documentation to the man page, including references
> to the query-iothread QMP command and qom-set syntax for adjusting
> adaptive polling parameters at run-time.
>=20
> Reported-by: Zhenyu Ye <yezhenyu2@huawei.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-options.hx | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Thanks, applied to my block-next tree for QEMU 4.3:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BnVcACgkQnKSrs4Gr
c8h0UAgAqs+TMGLDYZuEbMgNI2PIL8BEiRxXztl+arZ8+8IvXaD9xuh5IyqUeHes
DLUT3p+1qyI4jafwFCZwcwxG0Wrh97PxpuA87dzqgmo6ywO2A+zELUYX7zFqLjA6
en7/iPqCAxJlOHQEgIrYyFH/qTfbXWd+I7zCqEij/aLHafzYWbs62Ei2XcDFos3c
0dCY2pqBRwAm1gmcvw5Th8cHaAtbHgRA6IhQAH2P5LtAh1TE3IjyDvLt120adNTs
RdP8qr82fXFx6OYtuhd+G2PDYTWuw6IRfEtatfnN9qcmIMQxCfOoO72WiYAXMfZ9
IdCYmPnHa3Wf3JKxQuQgWkwADnbz6Q==
=NOqd
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--

