Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6E1C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4371B2190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfqGXLFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4371B2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1wN-0001VL-Ew
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS1v1-0000Q1-Oq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS1uz-0000Jd-I0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:42:59 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iS1uz-0000JU-C2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:42:57 -0500
Received: by mail-wr1-x443.google.com with SMTP id j15so1548283wrw.5
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 08:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0KSuQWzHthTr7opfSzgzm77sWIkDeA3MptAsdOCfTsk=;
 b=SfqGXLFr/JlRrsennXL4jLpYL+7DQUgZ9rWs2mog4INMK9hTp9tAYSR169coBsvibo
 Xdtfj+klGJ449n20IlYN9P2yl/wSo2RIaADhDHdz89HeAsserJ/fhNyluuAIwLsTLRIw
 y9VwDC7+ivVppzkmRaZiAxTVKoLeRlEaXCvUNtVWxfpp8Bz/TQHSCgY7Oo0tRcpfWECI
 wMGGAuQKUPak9rcZpZhcHh94DezGDCH9UZJ1QPqkyclXUW/Mu5yhsX3MGHfiK5nKQG/r
 eA1oiImLKoRQXqgoJG6KBw+hw4yxNIxB7IQXg3J9YydGIZ3cVhuEyy7F6Ee3zDUQogUN
 aNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0KSuQWzHthTr7opfSzgzm77sWIkDeA3MptAsdOCfTsk=;
 b=g7g2Vn88ZqRu5LCpw+funCoZMi3AVIN2B+qZ96LOmtssA8yCSI+2hfNBEZ6TNqcu9L
 SnwIzekntPaEvoifSar11w3oqm0PYjQ/Or4ntoOSBavtabQZ8LJyP7D+v1oowM6NeJT4
 Opm3A8YLkTf7vunVdUqIAlAAhuQJO0RtJ4A8P08Pm02+KBFBPlhYPJKHVga2/wpY8zML
 pg8m7+SqwP2iROsvBLtDf/w+u3eklc0yDRtg/QaUnxtgki6nu+sGlx64q33YwLZCbQGE
 TRxhAn+bWep56WsfRhd+iyum3HNUyt/q3Rfhl9n1weLFKyB5RJ0Z2jMRUT4+6LWo2vd7
 Yb3Q==
X-Gm-Message-State: APjAAAXF5n1lIvkPfIo2SZcoGZTRjB7tOfY4eD237fqNOPYGSQFL3o+L
 wXtm+H8fkYBVxZsmXYXWmIU=
X-Google-Smtp-Source: APXvYqymtU7Me7hcICKvdt+6xt/0s9+5KWaeu2INwlo0luCYTixEL+bjttMBQ0eB3f1A7KEgCzZ+tg==
X-Received: by 2002:a5d:6390:: with SMTP id p16mr22187385wru.55.1572972176396; 
 Tue, 05 Nov 2019 08:42:56 -0800 (PST)
Received: from localhost (91.141.1.3.wireless.dyn.drei.com. [91.141.1.3])
 by smtp.gmail.com with ESMTPSA id u4sm11581873wrq.22.2019.11.05.08.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 08:42:55 -0800 (PST)
Date: Tue, 5 Nov 2019 17:42:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Hanson, Seth" <shanson@sandia.gov>
Subject: Re: Adding New, Unsupported ISA to Qemu
Message-ID: <20191105164253.GJ166646@stefanha-x1.localdomain>
References: <1572911399018.17766@sandia.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Content-Disposition: inline
In-Reply-To: <1572911399018.17766@sandia.gov>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 11:50:11PM +0000, Hanson, Seth via wrote:
> I'm looking for in-depth documentation pertaining to how an unsupported 1=
6 bit RISC ISA can be emulated in Qemu.
>=20
> I've referenced this:
>=20
> https://wiki.qemu.org/Documentation/TCG
>=20
> and have been hoping there's additional, related documentation that I've =
overlooked.

The general advice I've seen is:

1. Look at existing TCG targets to learn how to implement aspects of
   your ISA.

2. If you are unfamiliar with emulation, CPU ISA, or just-in-time
   compiler concepts, try to read up on them and then look back at the
   QEMU code.  Things will be clearer.

You're welcome to join #qemu IRC on irc.oftc.net to ask questions.

Good luck!

Stefan

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Bpo0ACgkQnKSrs4Gr
c8hJpQf7BOsRH/UIreqTgNnDxbCjhBumNYx+BdhnPe38Lmc10ubndo9A1O3wGsvW
/Fw3XKYtbIjl5NERK9zYUgNxxVCmSS0KZf4NCf6bxiK9TrhpxjzrtSaSJbEzppuY
DhGLeoRTfX31N6ruM2kJGnkoibv3HW7VacwGrYwS9ajUUSqoTUNODhs7ScrBdp2Y
ILQK86bVRCl5BB/NUie994Q2UuYFSh8P4fUZHYcbmEDUOIJNWL+TePHLKpoh8wfP
qeDli7g8NvYSx3dQ+RW9/atr0lGA7Wv4ymxwKDa7m8mrDD+1JeGmhXNxIg3lJjVQ
svB6h/vGpnOD+Vk0d9ECzAmnheN9gQ==
=zq5F
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--

