Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0299C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B76E2171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="td9RMTXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B76E2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1U4-000407-HO
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52513)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hw1Td-0003aH-H3
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hw1Tc-0001wR-IW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:46:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hw1Tc-0001w1-Br
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:46:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id p74so5052039wme.4
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0/LzhshBg+Gd0OI+uQ1Z5T8gXCVGKmZJGXugHby8sRc=;
 b=td9RMTXPudr6Tiixn/Lg4h9l1XQqMF5C59f4ekRCECiOMY8VwfWZQoT68k550QdGr8
 hOtBmVsjbQ80b513IrkMkbtW4k+Dwd2z9JF70u9U7TCnv+LggdpMhJY8N9H7paheHsk1
 8pWaEVKRRJktmT3e8jB5xDiGQn7CyK/9FZIQQRt3BPrzu30iQHkuTdNqlAZYyNGYNhZ8
 AW5AwsyUz6lx3QZHNdDJCGGvMx7DLR/hCVu3NEGOmK4RzoGXiRL30GndvTCO1W1DvD22
 A+1gYuj1i+VlU61du8FXXFHjJ2Yw7nNc4klPzeVYfFNWqFwVYqRS1KtNETeWwGYVvAND
 Wkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0/LzhshBg+Gd0OI+uQ1Z5T8gXCVGKmZJGXugHby8sRc=;
 b=adNpcidYrHrWEZZVt62+KtgEFYLrBso8i9L+So6BG/g/LR4kGS6wvRHK6hOVYP+HkP
 ZIekNs/nTn9jma+Y/OrWivSSDB+tRYh2YU69Iei7KgfNy0iYVvSEDK8aJR2blpl+p5n/
 CpgtyHVDnjLo+qzC13oNukLWlIRbmgEnU/LAMOLgfrXbZj7OeRqsR+1tXxEwtDLEncN5
 qAremqW+MQfupvwaNPdZ+e0UwGQPRkjg7wBSk2Q0We9U3/jPxsqs0mCyUayxdgFYxuzM
 Vp1VfCnZh0W6zaYx0gbw6pg3XnikRd6Y2n2osFqTVZIKNPaexo1xi+d3o2kLhcdJIJNh
 7PJA==
X-Gm-Message-State: APjAAAV8MU2kMpvmKIY8maHft74al7jDkwVzy2tG/hlS9Uli3G1KOtjQ
 XdUvIDNb+zsoqccwHhQX/yA=
X-Google-Smtp-Source: APXvYqw8wrGMg+nOqym6zaqYfA6WdTq3Hso99RIWYkdlNdVz+0RAH6Qlu2OzMee51o3pojQljNuQdg==
X-Received: by 2002:a1c:f913:: with SMTP id x19mr9802596wmh.139.1565343983192; 
 Fri, 09 Aug 2019 02:46:23 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d17sm5273637wrm.52.2019.08.09.02.46.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 02:46:22 -0700 (PDT)
Date: Fri, 9 Aug 2019 10:46:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190809094621.GM25286@stefanha-x1.localdomain>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-15-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Content-Disposition: inline
In-Reply-To: <20190805071038.32146-15-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RFC PATCH v2 14/17] fuzz: Add forking support to
 the fuzzer
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


--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2019 at 07:11:15AM +0000, Oleinik, Alexander wrote:
> +void *counter_shm;
> +size_t feature_shm_len;
> +uintptr_t feature_shm;
> +size_t offset;
> +
> +typedef struct CoverageRegion {
> +    uint8_t *start;
> +    size_t length;
> +    bool store; /* Set this if it needs to be copied to the forked process */
> +} CoverageRegion;
> +
> +CoverageRegion regions[10];
> +int region_index;
> +

The global variable names in this file are likely to cause naming
collisions.  Do they need to be global?  If yes, please prefix with
"fuzz_".

--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NQOwACgkQnKSrs4Gr
c8gvhwf+IZFZu1y08AmOJo4SXjRCd98FTE1ztmpps1xUnkgl3iw+cFt9qE0Ksi8F
7X0Znz7hXxmmqwNwdyEDK+IVZo7Vv5Ztiievv/7gp122GoXvqFvMwIj6wJSR3MbC
HiIENTcOI/t6JO7m9Ldzft0f4R6oR4SNkoBTTcCOiwklujo+bc76W1QiNrE0I3pR
ZWWU+Tq0uyzgXH0j4rWfFHsCYUa8IIhtzWV7XFrbJRUgu+/I65z0cMYmnTci3Cb7
++ABsEOPrCJHAR1pQNRXhO6J8qRYYOm1MBlx4bCAoJwlQS/eMlPUmpO+u9+LNmmF
1mTo4BdNYvA0D/aZpdDoEQ5lOOhCuA==
=NBBu
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--

