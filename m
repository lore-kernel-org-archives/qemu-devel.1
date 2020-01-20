Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4776C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE332073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dL7HtlGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE332073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itU0x-0005CX-R4
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1itU07-0003k9-Ay
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1itU03-0002e6-Fc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:09:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1itU03-0002dt-Bh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579514978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OvxaASTnEDVoOy4BuywGzJWaRCAFcZRsmppABLAXrBs=;
 b=dL7HtlGbkEaBOprXn0T7nuRKa/15/t6HZ/QX7s1o5SbA+cpHquuDTJu9Evm1ARtJDMsVkz
 yaFMjyIp5n0gg7CWRLNYOwjHix0MbapH6FKWZ9AOqOONe2VmTie12Tn5GO2CdAqHpwI4Jo
 fWkzDOtI8ajueESi/4uMo+1oYIJzV4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-1-0ZH54eN6Ozyf05bqCI4w-1; Mon, 20 Jan 2020 05:09:37 -0500
X-MC-Unique: 1-0ZH54eN6Ozyf05bqCI4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE6D7107ACC4
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 10:09:35 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8094910013A7;
 Mon, 20 Jan 2020 10:09:31 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-72-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 071/104] virtiofsd: extract root inode init into
 setup_root()
In-reply-to: <20191212163904.159893-72-dgilbert@redhat.com>
Date: Mon, 20 Jan 2020 11:09:29 +0100
Message-ID: <877e1m8mna.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: vgoyal@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Miklos Szeredi <mszeredi@redhat.com>
>
> Inititialize the root inode in a single place.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4lfFkACgkQ9GknjS8M
AjVsoA//ffvizKlkrEaAb4ynkHrIGDw9AJ/VQK07SawmgdOdM1hFG+3EK1aYqeJM
k2z0nB2khUVfSs+p8KPOhxDgm5ZmE3VNKwhnym2cyvklwGpGiyZWQ0CvJbcEnABX
udkI2Xlvy4AQCIAMulIo2urJUinDxCWrbCt/kxnC/quGxSLGZimm7synOEF/WBf9
l1u8ok4trFhs5DuDDwVyVFlgidKWDcXgxbcoFOEu86xyyf1XgenPkaKCIgTPnUfi
/R10duedJcKQD1S76f0Lq/8UpkxOG2hmy3QYbFdafOmu/QIQfKCvEL4lroBr8UNU
2Z2HAUGX6obqtSHtJSHGSBTxYv6I1kUEMfIBc1qDXLOpwCMSA9pkz47GmQyU43VP
b9t4St3hbcGT9WyVi++u6YP4Pan3gQW/XEx32wxr3/LLfPs1efWH5a8Ng6hLystO
ixOwou1a2TSOzV0jDGreSvF6eIPJt3dKDlVGX21Oi2L8aBrw1df5q2zpVIIunxPo
mM5zeIbYDdFmERnug3tdT1R5hlCQlw5a6McAm7p6dS+WCtVEInYKUR0X0di7R1Px
HrcQnmb7eGan+F/0kCW7EoA+oLqGqAuun5wUllPs6j+V9K73qR1nplPYbBIrwnEy
Wk7cfqaqGTMorak7GVZj2wvSlitmFPDzS8tGBHji9sDEfGE/5oU=
=b48v
-----END PGP SIGNATURE-----
--=-=-=--


