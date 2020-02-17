Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CFAC34026
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462212064C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 20:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htgKQjUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462212064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mg2-0001kR-Eq
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 15:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j3mfU-0001Gx-FY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j3mfS-0007CL-Oq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:06:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j3mfS-0007By-Kw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 15:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581970017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8KMNKQdexsfFba+bz6f+nuDxakbPyp4CA2QwJ1Z2Bw=;
 b=htgKQjUWAOwp7UO5rZ8xxgFzftZP8fcs0cDHCcnbDr+5dIu4JcqTVaEwieQGt3YNS6f8lW
 k0sUIlKKFLc0QZXRGwR1EvD5GadG1zswRYv3Sfvg5HVFqcyJHBzCsKWY+KIMYvR7/icbiR
 mwqLds8VI7YbGToH6U7Ula+Ex4aP2yk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-7C4ekrZ-Mx6b9vTkt4RjSA-1; Mon, 17 Feb 2020 15:06:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1317118CA240
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 20:06:55 +0000 (UTC)
Received: from work-vm (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FF685D9E2;
 Mon, 17 Feb 2020 20:06:48 +0000 (UTC)
Date: Mon, 17 Feb 2020 20:06:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 3/3] tools/virtiofsd/fuse_lowlevel: Fix
 fuse_out_header::error value
Message-ID: <20200217200645.GF3434@work-vm>
References: <20200217094240.9927-1-philmd@redhat.com>
 <20200217094240.9927-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200217094240.9927-4-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7C4ekrZ-Mx6b9vTkt4RjSA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> Fix warning reported by Clang static code analyzer:
>=20
>     CC      tools/virtiofsd/fuse_lowlevel.o
>   tools/virtiofsd/fuse_lowlevel.c:195:9: warning: Value stored to 'error'=
 is never read
>           error =3D -ERANGE;
>           ^       ~~~~~~~
>=20
> Fixes: 2de121f01e
> Reported-by: Clang Static Analyzer
> Reviewed-by: J=E1n Tomko <jtomko@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Nice, this actually fixes 3db2876

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> RFC because untested
> ---
>  tools/virtiofsd/fuse_lowlevel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index 704c0369b2..2dd36ec03b 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -192,7 +192,7 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int er=
ror, struct iovec *iov,
> =20
>      if (error <=3D -1000 || error > 0) {
>          fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n", error);
> -        error =3D -ERANGE;
> +        out.error =3D -ERANGE;
>      }
> =20
>      iov[0].iov_base =3D &out;
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


