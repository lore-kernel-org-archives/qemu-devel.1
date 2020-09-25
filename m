Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2893BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FCC20878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UH4Zm0md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FCC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjN2-0005GI-6G
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLjM9-0004l0-Q1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLjM7-0004cZ-TL
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:45:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601023526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3LHJiy8weVYxlFI8NtJls1pPZFILxQrGjeO4fr+5XmE=;
 b=UH4Zm0mdlT7zSKJQS4GYJyGyLHepHKL3i/uX8qBm4YFGOeNUspKUSI/r8kfybsLf3JDVey
 6jxQDQ5YURe7L22qJWfmtxB2thD/Wp5GedW7Hz+heEC3N+4SxX3vz8A/g6tAz6YTmpXAwU
 mo6DpH8aDBl9M+0oFpb2OKBVk07LXxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-p6hnfKS8OeuQ7mmKfFPcDQ-1; Fri, 25 Sep 2020 04:45:22 -0400
X-MC-Unique: p6hnfKS8OeuQ7mmKfFPcDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E128718BA284;
 Fri, 25 Sep 2020 08:45:21 +0000 (UTC)
Received: from localhost (ovpn-113-240.ams2.redhat.com [10.36.113.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 862539CBA;
 Fri, 25 Sep 2020 08:45:21 +0000 (UTC)
Date: Fri, 25 Sep 2020 09:45:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/31] block/export: Add infrastructure and QAPI for
 block exports
Message-ID: <20200925084520.GC33068@stefanha-x1.localdomain>
References: <20200924152717.287415-1-kwolf@redhat.com>
 <160096811541.10265.13762738300010781996@66eaa9a8a123>
MIME-Version: 1.0
In-Reply-To: <160096811541.10265.13762738300010781996@66eaa9a8a123>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 24, 2020 at 10:21:56AM -0700, no-reply@patchew.org wrote:
> ERROR: "(foo*)" should be "(foo *)"
> #156: FILE: blockdev-nbd.c:224:
> +    return (BlockExport*) exp;
[...]
> ERROR: "(foo*)" should be "(foo *)"
> #49: FILE: blockdev-nbd.c:239:
> +    blk_exp_unref((BlockExport*) exp);

These can be fixed when merging the patches.

Stefan

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9triAACgkQnKSrs4Gr
c8gdSgf/X8kQ254qRZSSUfiQsDWirPW0GgvOLXhzxroGzJ6F8QopC6wawDaCHs3m
J2sq1TTdt7DzVf3xaO5MbTJvWT4327aY5dRx/N0BtEtnBzRvXNcMBjkJ8du+VdpN
uoioPgVpH/duivaBgyv7Kjn4yoP/cmyPPVGnqJGNdr5tkBX319+eR8qQ8M2krgrV
jvBTFNHMWn5SSJsXyWu04kWEq6N1TlpRll5TusAkinuy/Nl5QQ0NpgkTthEI+TZ3
EVjMx4xPhQz39WyTlj+yawcLYYkaHaNoHqX2IulK3lCaWjGyla3X33eETiLUhIt4
x5SlZgHK4HTfNA7+ZaZfTR9EiEKlvA==
=6Dvw
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--


