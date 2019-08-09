Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4780C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCB52173E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oW1Rpm5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCB52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw0sG-0007aD-LO
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hw0rs-00079M-Mv
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hw0rr-0000uT-SG
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:07:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hw0rr-0000tV-KD
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:07:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id q12so7274526wrj.12
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=myhIy+9F/f7dkasTn952IAcaiHsFZ+flJcN0JpViv54=;
 b=oW1Rpm5kp+iXjoN1zBtTEpR8RMIaZEHqm56gj0W2jdsTF08WvJbV7nzLjfF8jxw8zP
 vBqU50NoNIngEwOdInwGnZzozLPoADWxEvBBWu+NjqRbIp+Rg+BFKyCdQ0ZYzVKoVzi/
 fNhdugeZ8N0rQBenHFg2m/LYYGvP3PYdQcUA0o4a2AXXwDGCjxfVgfr6oeuT01cm9xMW
 86RULScGslnIFfky36f8gm0k6H4qdIqhVlbYozCyBpgaEp+KoJw8WP8d+UpwYB+Gw3Ot
 eW1caN1wxEKGcjO7rvDcTcsCboaspi3PsxNpTo0soVLHwGBoACII6KTs8uiAMLn0YIfD
 wc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=myhIy+9F/f7dkasTn952IAcaiHsFZ+flJcN0JpViv54=;
 b=HUsdkTr6o9i1YWdBSysUUJMMzOWixWLrr2PGXIMIvYzcgHYKQZVQSNmAsWis/WDt1J
 PuCZ/LBBM6gzzVHuhvwZ8G1GwXcpUY4PxXJUkgjKyfkVg2VayTpWkElwuDZk9/SJ69rj
 yGa60Eeq58AqH0h1XaCIU0/1o4pdlAI4wBFzAz3wTLvfRNrp+jWGIlNK9jhSPf8Uu958
 1rOk9yXOWz6zwqkmee2n4kdgKB6FCGqK5GQb3XtERPnFVbF5XlcBRT3JB1AW55MBTDrB
 5aC0ioOII048PPKTaXkDP27FXlZY2g2yDZdvkG0FhilI7XXOcmVwQNy3nACGiksmG3zz
 upFw==
X-Gm-Message-State: APjAAAWoXwuulZ4IoPmYChro+yaWI5jCepq0A/q7uvOgNADn0OnUfNiQ
 3SQjpqvoJPznTxtwrYiCImI=
X-Google-Smtp-Source: APXvYqzQq+zN0qdeXEfTW/u25N9e8eKU/5Fk1wSAuJRDrkUHgf+GBwdjy06/ybpw72V615eoruperw==
X-Received: by 2002:adf:e94e:: with SMTP id m14mr20237496wrn.230.1565341642535; 
 Fri, 09 Aug 2019 02:07:22 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id i66sm7160883wmg.2.2019.08.09.02.07.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:07:21 -0700 (PDT)
Date: Fri, 9 Aug 2019 10:07:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190809090720.GH25286@stefanha-x1.localdomain>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-7-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Content-Disposition: inline
In-Reply-To: <20190805071038.32146-7-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [RFC PATCH v2 06/17] fuzz: Add FUZZ_TARGET module
 type
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ISKrrfpKsPiF35CV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2019 at 07:11:07AM +0000, Oleinik, Alexander wrote:
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  include/qemu/module.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NN8gACgkQnKSrs4Gr
c8igNwf/SHJwu9PPVmwTYNQl4jfM7G1SQAwCTQFqJwNykwM/j472+cjwDbASKzWx
G5x3Yqo42oo4rSu4Z6aNNvHXgb2cNq991SmglLvvrmgEWt2PU+pb3pS400l26ZKe
InJ8qz/ARzBZsGPNNV4orJdXGDWMrQWcbz8VLyYJC5acrQlgj0kE2mgu+aHYRPmy
OopuQwWCjAp10kRw4+EOUIUl6uQ5qfTw6mrCNNK88GEnTGnaeDtdrbbQ35RuOGsN
FrsjKcCVhh7VjhwoC+BsLAZcEKr8KF2lNm1zvgoqVc/rkMkmvPxerptFCLHh8cC4
HHEmirdEpL/+pB/hBGVUdT7HqbsLVQ==
=nJey
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--

