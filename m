Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EF9C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F92D20855
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOoxAM7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F92D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXldw-0000Ww-Db
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXlcn-0008Vy-1w
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXlcl-0008Ua-9X
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:31:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXlcj-0008Qk-1A
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:31:51 -0500
Received: by mail-wm1-x341.google.com with SMTP id y5so3484523wmi.5
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DQPXUdy3Y9CjRr+/JWcqif4qOWuzh/BDRfKjkBmxxOA=;
 b=QOoxAM7gVjhhMoxrPkeuRhcuOka7ZMQf8StAzbDPZAQGK+LqtTfsAJ+kSMbaPTLt70
 jOiBfRULCeDrnOeFDW4JE+DzXB1M7MMTThFrL14hW931NPSrasVc8qHwDvP55l9XL+VQ
 63j6ljuoFMvGqiEQfzqQ0z6tiR/p3oGvPBUwT+iSsZbOtQebz2D8xRw5lA5RWgWAwL69
 yO14vIsJeB2L4UleO1l8IpRJ/Uiklp1sFiWVzP+WTx7pGKTNRYwDGQygtoofiZjYvkIE
 PwMIFXb1TnAJOYbnJLrswrJTXNpXFYvWozSvM3tdr8mcL/IsAlH2opE6FeKak9Zev7kT
 yLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DQPXUdy3Y9CjRr+/JWcqif4qOWuzh/BDRfKjkBmxxOA=;
 b=EU3bKEa28Rdm5JaOfDs0SaGBdxkWge9KIGyYh+XX9px8t20nvNczTz0IQ40+VtWIiQ
 YEbAVTN8B3zuvAkYwtSUzr/FNrlP7/wrDQLvy+0nLkXvypYtjmL+ydRwWPHLUdm3ZYR4
 ZW5/nzwLgZVO/t81PgKfy3naQ6h2wN76/K62WTEVAggNP66lHXeogGJToEs9n2zMzWox
 LgV7e3Q8EdgiRQfpASEZ+t0R4aKUbNW2iYb2+/kUXE4AYBWoWJfTMi6OTIFYbo+Dv7aS
 Hq43z4Hi3kTaau52qnZEGQqHG3vg2UboLgQsgRhmjPSNjj+B2wRPjenJ1sOGHbgeX3Nt
 qOwg==
X-Gm-Message-State: APjAAAUxhqrDuTDDMzvetSUEcalPeYOHQVc9kB/IB+g6exMEiyn9aHiX
 y8GhAV9DOKTssD79fclAk6Q=
X-Google-Smtp-Source: APXvYqxEzxbRo/WPcZ24qxdwBm+d1qaFQFbJYH69B2YGrjHVdiJCfPPLx3DcbQz4be/RLbRSVgNAYA==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr9075325wmi.4.1574339504681;
 Thu, 21 Nov 2019 04:31:44 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b10sm3180762wrw.53.2019.11.21.04.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 04:31:43 -0800 (PST)
Date: Thu, 21 Nov 2019 12:31:42 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 32/49] multi-process: Use separate MMIO
 communication channel
Message-ID: <20191121123142.GQ439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <b2594fdefb278f890762d12639524c4db7667393.1571905346.git.jag.raman@oracle.com>
 <20191111162132.GI402228@stefanha-x1.localdomain>
 <4a528246-f414-49af-170b-98306b9a0c96@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cxMSjUqMQBJIqbX5"
Content-Disposition: inline
In-Reply-To: <4a528246-f414-49af-170b-98306b9a0c96@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cxMSjUqMQBJIqbX5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2019 at 11:14:50AM -0500, Jag Raman wrote:
> On 11/11/2019 11:21 AM, Stefan Hajnoczi wrote:
> > On Thu, Oct 24, 2019 at 05:09:13AM -0400, Jagannathan Raman wrote:
> > > Using a separate communication channel for MMIO helps
> > > with improving Performance
> >=20
> > Why?
>=20
> Typical initiation of IO operations involves multiple MMIO accesses per
> IO operation. In some legacy devices like LSI, the completion of the IO
> operations is also accomplished by polling on MMIO registers. Therefore,
> MMIO traffic can be hefty in some cases and contribute to Performance.
>=20
> Having a dedicated channel for MMIO ensures that it doesn't have to
> compete with other messages to the remote process, especially when there
> are multiple devices emulated by a single remote process.

A vCPU doing a polling read on an MMIO register will cause a BAR_READ
message to be sent to the remote process.  The vCPU thread waits for the
response to this message.

When there are multiple remote devices each has its own socket, so
communication with different remote processes does not interfere.

The only scenarios I can think of are:
1. Interference within a single device between vCPUs and/or the QEMU
   monitor.
2. A single process serving multiple devices that is implemented in a
   way such that different devices interfere with each other.

It sounds like you are saying the problem is #2, but this is still
unclear to me.  If the remote process can be implemented in a way such
that there is no interference when each device has a special MMIO
socket, then why can't it be implemented in a way such that there is no
interference when each device's main socket is used (each device has
it's own!).

Maybe I've missed the point.  It would be good if you could explain in
more detail.

Stefan

--cxMSjUqMQBJIqbX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Wg64ACgkQnKSrs4Gr
c8g/wwgAm8ZPdiHzPfkL0hR+lc9vVSSrG4+7I+VCFVzXql47Q2RdtA2VE+eLjqrZ
+VsnR7coRWzp7uv/CRPG2GUvCnRP34j5B+LzIRc8jPQYMa07ihuIxYdzsuzlsTkX
8LPR8xr+bcMZBGi5zTvAk54mC5khanzn+kvpEofTW9oDzAGYej2fGRxTa0O8/aPS
79lyE/HJErc7880n3Fm49wYeiHYCcP/J5uWU0ATzcINu53Bx7L0Z4jOLtMiM3ZE2
n8zqJMuCtacUFunyZhLt0FHm0l8Vcx9FgpDpkm0kxQ1Q/paOfs6+B3zZZh9/H1GW
APwN/87JvPO70u5Qvu/9/inPcCHqqw==
=rAm4
-----END PGP SIGNATURE-----

--cxMSjUqMQBJIqbX5--

