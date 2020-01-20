Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E5A20684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDGfpfq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E5A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itU9i-0007d2-C2
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1itU84-0005tM-Js
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1itU83-0006NE-Kk
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:17:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60168
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1itU83-0006N2-Fz
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579515475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i2shoQrsYn2LlJuPT9Aj1vIJumQ4aGZU1Po3F/hNNys=;
 b=TDGfpfq5x0iDaI+AdGH3lTa1SJjmOocJo3zljIcSilrCrC1+/renjyc90bj08bZVdBHnXP
 ZJK5oiweno9JZM6BpmS6OSJ94T3vC6tEzFg9jV3S68E5apMHwXZ61bKoqE75baG0vo3ygH
 HPvrM43dZbmew+dpjfepJudoxjcKzu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-pzLqA3W4PNq5_uy8G7Bdgg-1; Mon, 20 Jan 2020 05:17:53 -0500
X-MC-Unique: pzLqA3W4PNq5_uy8G7Bdgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72D8E10054E3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 10:17:52 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 937E960BF7;
 Mon, 20 Jan 2020 10:17:48 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-73-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 072/104] virtiofsd: passthrough_ll: fix refcounting on
 remove/rename
In-reply-to: <20191212163904.159893-73-dgilbert@redhat.com>
Date: Mon, 20 Jan 2020 11:17:42 +0100
Message-ID: <875zh68m9l.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

> From: Miklos Szeredi <mszeredi@redhat.com>
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 50 +++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)

This one is missing a commit message, and I think the patch isn't
trivial enough to give it a pass without it.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4lfkYACgkQ9GknjS8M
AjUbCA/+IfX3uD++I/hzZeg6/H3dQ07jf3SHiDEwdrvhYv9NGGLOT5I0qWQga0Vc
erfNtPhKJS3Ab3jhRI+o7jWmVlCdORF62O/pqHeUKTGS0MoZcvqnbn7b9vHCVDi9
xCLIJtTUmAjYUNWgklCL6YydfDKb8HsGiT7786/DYVsewvx2LjoWFY10hNEMitc0
8ZOYCLb/Uk0P29PAqYtyLo227NRFF+aVF6PfS1tCF0WQSIrEwdjdKatHoAICmc6Q
bJhlj95515T3cHjcxHhrGg4+RAjwFbbRTgjwykDBAJDHoI7m6TwqlYPiA5WJRKpY
fM4aVfE2jK1b2ia3UKx3ceKV3oSgIQhd0RkNGhPBZ5wLnrRdqzHdlDRkMNtjcG8F
Vozr6FpGQrMpVd4A95nHbrO49+6bRBlD+BQFVYy6ad0/Dv8cWy3bLQVPpRDCGs/L
gTAGKRXoqn6vvCsziQDVkjpDmmRDVV363/oQEgSQM0J4Ei6+oPVImVAphROo1Qqc
rS2tOSyQ/O5EcHluJ2++YNh91WZSmTVlqAW0VzYf6abTVwOExUpHFAdWT5LpiGHp
Fa0zXreJCgcn5xYlUKS4TNEpsNsax8Xg612z7289BrUg7H1Tkb8nbR85l0BDgxu/
pqsPXB4Bqi95tyx2gNF+sxguggXGZle7UZfML1Mv0f/JZUMZekQ=
=+RVy
-----END PGP SIGNATURE-----
--=-=-=--


