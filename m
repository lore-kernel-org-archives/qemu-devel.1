Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86FC2073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SF8wokuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86FC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUJ2-0007qD-SS
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1itUI5-0006u8-Ea
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1itUI1-0006R5-3l
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:28:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1itUI0-0006Qm-Vc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uCY1Ukrbv/Ec7W1QzeMSc2kBob//COVMLsRObrANmIs=;
 b=SF8wokuBOTf8NaqyHaYKXBrv8lHugRbkLj9IYJu8Wqg1wcU3jFbDp1T6XRusrGJOzyL1On
 anjykckyffY1ublncsfDlF4F4qCaVpFLdtW1B8TnYwF7tj6Zx2ea5zd0ZJBy8XM7wuUReT
 2fmyTJX7pK0mZKVgtajFhqWOgdBbPeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-D0BV_xxlMSelFuXEC8uvkg-1; Mon, 20 Jan 2020 05:28:08 -0500
X-MC-Unique: D0BV_xxlMSelFuXEC8uvkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E607DB60
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 10:28:07 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F14B060BF7;
 Mon, 20 Jan 2020 10:28:02 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-94-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 093/104] virtiofsd: introduce inode refcount to prevent
 use-after-free
In-reply-to: <20191212163904.159893-94-dgilbert@redhat.com>
Date: Mon, 20 Jan 2020 11:28:00 +0100
Message-ID: <8736ca8lsf.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> If thread A is using an inode it must not be deleted by thread B when
> processing a FUSE_FORGET request.
>
> The FUSE protocol itself already has a counter called nlookup that is
> used in FUSE_FORGET messages.  We cannot trust this counter since the
> untrusted client can manipulate it via FUSE_FORGET messages.
>
> Introduce a new refcount to keep inodes alive for the required lifespan.
> lo_inode_put() must be called to release a reference.  FUSE's nlookup
> counter holds exactly one reference so that the inode stays alive as
> long as the client still wants to remember it.
>
> Note that the lo_inode->is_symlink field is moved to avoid creating a
> hole in the struct due to struct field alignment.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 168 ++++++++++++++++++++++++++-----
>  1 file changed, 145 insertions(+), 23 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4lgLAACgkQ9GknjS8M
AjWSfw//f51RWDVlvQ/cu9wmsi07+fRee8h4BJ2tWxGJ8YE+MES16Ho8CiBT1K9g
LtIsMpA4OeJlhM9IHYbROeUmMKJ4a6p9GOkxP+Rlm59Z/i5h/qgvmWRnbU/gat+b
0DBJnxweS4F/WbvO0SC7ESIlXtLBJGG4GYac/vpgc6PALrZna3FkTRJdDWRSYjCs
WOD9XDuY0kbrXKZ9kH3y478LoHIvnFqqE1rHS1J1uCk0fV74rSlCIakzPN8pEx80
i34ZyCSS0Ociig4dS5uKVZOD1MsdtizoupQLS+l3wNHY/XmklXMEdWIzy1kBkMKT
lArer6nJpesBeXKlvafzJJ1A+h/2VgbuDMHM1FS4UfSDR5ctX2MYNoFwktB0VTgf
WKwri0jrIxsa6XotxwKJSo1e09fn7IC2lygtdBQOSj1mwyaz78Irn3sXSjIYYo5J
80fsEFWrbcBCjas7iq0p2GOPyjWSItIZ4PhAkgvlQ+JF9taRKBacAHxS8u8hGvX2
N5s6UHimq+QVE/hjPeDoXy/dA9lw2qROD9rgAPBF7s9T+5wKS2cAVCWXRYmfA18o
3E+nC/RrHyNJL9oHs3grf/THSmbixAANyxi5uvT1rAMz3IibMr9sullXIHDex7wM
TyxwYBdpcTDZCKvE4b97mElkELLJ/1iNytCjUKe9DTJnrIpkjGQ=
=PJYF
-----END PGP SIGNATURE-----
--=-=-=--


