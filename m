Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9E9C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EEF2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpFqYVIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EEF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS0sG-0000h7-V0
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS0rW-0008NJ-Oj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS0rV-00034b-HP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:35:18 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iS0rV-00033V-AC; Tue, 05 Nov 2019 10:35:17 -0500
Received: by mail-wr1-x444.google.com with SMTP id n1so21916699wra.10;
 Tue, 05 Nov 2019 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G1uhc1qPRBDchuU7SGQrcYi/mlbr+3TLPq+5vHZjJj0=;
 b=gpFqYVIe4UlwLSJn+e93PTE8f2gqVWwZwXWRGFczk3lVYGu4AFZGZ8XWxlWp1q6u+Y
 s6Mg0kpLrsn2rgQApCXhUwCJVo+LTwM7wuyovWCZ6CU7+yQ0uDvX9LE/c9mOHsyb+1PQ
 0xHF1A9Ysc/RB4WkX6wIqaCfX/KWREElCUcLFtNj6ukNRNRLbnVFIiHPrGrRu8ARbDSi
 fsn5KQOLMtbfXxnvNsPjSbjh4YNYnTcHQ1wfVrpwv11eAXYdpJGzESLoy5YRdBfWDbLy
 7Oyg/OYQ4Oxgt6etuL4pJIUt6ec+9d3J2VBGFKsjT4HokGde2b/SoKUTkPKSXjWp4nG4
 Qm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=G1uhc1qPRBDchuU7SGQrcYi/mlbr+3TLPq+5vHZjJj0=;
 b=eX+JOyrnVWBAwZwkhO/cAxRQWgi154ddlqH7Kh8zyV2+g9WnSEr82xGGNez0X4oHBK
 6n4cbWE4wJUrnMZHkpArHpDJ/vLhsWD6YMIrOyYlcOFN3jXS1HxX5plHLxV4ieBojPIX
 2afWkEA63r0hhwI3MUPpkaf/bq75V41wngxr0h2l5ZUJxmtMUvD41OHUfB1LTgoyfaPa
 2S8JIvDpWomcNONIvt0Nl4pGiBsWiHs/E1ac8rN2BG7hqNgN03ubOUVLtQUrTB6dfORO
 esM+YtDUipwMlKtem/bQIm74W+N2XTz3lBnXUcGsl8Jq3X61gxnSMzzr2nEmy5YprmNP
 J32w==
X-Gm-Message-State: APjAAAW1wJENFCWRrq3QkN2F6KjWGvp1lR7P467ZZDqumJQy9PX1/R//
 E3W9f+pbSwSm4jf7ggywZJI=
X-Google-Smtp-Source: APXvYqx/Nnb6nRV2sCDPVeK9E16K2tGqkpzyMB++nT8ZezFLTxe4B5qFTMfP2XH4+vfPe3yhLjIoHw==
X-Received: by 2002:adf:d083:: with SMTP id y3mr27156821wrh.53.1572968116148; 
 Tue, 05 Nov 2019 07:35:16 -0800 (PST)
Received: from localhost (91.141.1.3.wireless.dyn.drei.com. [91.141.1.3])
 by smtp.gmail.com with ESMTPSA id u21sm25390014wmu.27.2019.11.05.07.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 07:35:15 -0800 (PST)
Date: Tue, 5 Nov 2019 16:35:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 00/10] image-fuzzer: Port to Python 3
Message-ID: <20191105153513.GC166646@stefanha-x1.localdomain>
References: <20191016192430.25098-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20191016192430.25098-1-ehabkost@redhat.com>
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 04:24:20PM -0300, Eduardo Habkost wrote:
> This series ports image-fuzzer to Python 3.
>=20
> Eduardo Habkost (10):
>   image-fuzzer: Open image files in binary mode
>   image-fuzzer: Write bytes instead of string to image file
>   image-fuzzer: Explicitly use integer division operator
>   image-fuzzer: Use io.StringIO
>   image-fuzzer: Use %r for all fiels at Field.__repr__()
>   image-fuzzer: Return bytes objects on string fuzzing functions
>   image-fuzzer: Use bytes constant for field values
>   image-fuzzer: Encode file name and file format to bytes
>   image-fuzzer: Run using python3
>   image-fuzzer: Use errors parameter of subprocess.Popen()
>=20
>  tests/image-fuzzer/qcow2/__init__.py |  1 -
>  tests/image-fuzzer/qcow2/fuzz.py     | 54 +++++++++++++-------------
>  tests/image-fuzzer/qcow2/layout.py   | 57 ++++++++++++++--------------
>  tests/image-fuzzer/runner.py         | 12 +++---
>  4 files changed, 61 insertions(+), 63 deletions(-)
>=20
> --=20
> 2.21.0
>=20
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BlrEACgkQnKSrs4Gr
c8hzDQf/bbjXacnEoIjEgpROWO4wNTPNmjGHMNySEYRrkMiYcB4AqhOGQO9+wHsg
sOCgkTtuSxB/1KrQKWl3JjihEN/MFkREgxQaL+/zX6aE3k7ZjpKOWhyvw/m3X8mx
9/3Z7nIbe7cJCYhIBIsJAV2u3m1y/46PsuorgnGRtigIz9V+AQ4X1tbXsELfNKUY
GqVyBHFtpAUPO6OOxHxcNayTkhqEiVs5GD8wml+zypQUCb2wzTdxF68tFi6SpORD
ELTKCS/TddXrRUAa3gIBhQ/snwBSnn1e32Ucq18ergloPLdWcppAgnCFNr8IpBiN
9kWZEMB6Tn3E7sE0ndghnbMADatuGQ==
=o9EL
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

