Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2679C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9B020733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFoBK1sF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9B020733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17WB-0004mo-RD
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j17Ux-0004Ep-O5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j17Uw-0007Ux-KN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:45:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j17Uw-0007UV-Em
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581335105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8owv4ytH+R7TdQNFwR1yQkycDps4UJsUWQlxY/wgQxo=;
 b=fFoBK1sF3lPD4JZjnCFivSFNzercPET5smjXMsnewXrh99Fx0X6WFj8UxPT1Gd8/8pPAB9
 SyLJQSJ5MAecO0Emn3UyJ9golAVHZR8VxTF4z9zGtNkuVT5yopBVRttyEEovGRY5FXkpB6
 PO002vYzVY/qHzxyUhSGxEmI9Ea61n4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-oCL2j8haOTOIY6Adf6oUuQ-1; Mon, 10 Feb 2020 06:44:57 -0500
Received: by mail-qv1-f71.google.com with SMTP id r9so4759853qvs.19
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 03:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xB01AmvIMP2zlBp52cydjafDP6p81GAeFrzC/ZqXhLM=;
 b=HCrozoyN+t5mKICBT19DmSYwRwHQvYphJDitQFGc6kBJDTv+WveKMLtUlJJLKmLGVA
 u48sjz28G0/ikD+XrwfrnTB9bS0gX4ZlkJ3xmct+hSmV89AgZZ0e+T7yMNbEdwzreR52
 6PW0iejxVRe3rh+FcadP8OoT/3FGobi/DiMUkwBhSPVBN4teN791KZNKI4wnL55LAAL8
 rOtlbtSfQx8YXhSmMqlr2Zg/c2J+70eMfhYL2yaPfryAAfMQ5vDH8sK6MiBEtzy75agE
 SDr1UZCmZMtlauQaqMly1R258c+m6lS92gmT5J9qE0RF755beIFT8VZgPxk3d0Ld5FlL
 uG7Q==
X-Gm-Message-State: APjAAAUo+vi4ne9NZdGeGWjy2rx66k6diw4vKYiFbWfv/VBxMgdM/+CQ
 VhEALxlt/L2l+B634nSqRsqjKaijYFkC0KcuUlyEsWSL5dnk+HJB7vw/fGonhAg+ciWex9U9cev
 fXWZfpMLvDlVlidI=
X-Received: by 2002:ac8:163c:: with SMTP id p57mr9672536qtj.106.1581335096825; 
 Mon, 10 Feb 2020 03:44:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqzo8F+ijddyWNCzlSRkdjCazFKYIFluf/ruZv69nOCH6erG+yjXCdvK7xLg46qRCeaKu8pXbA==
X-Received: by 2002:ac8:163c:: with SMTP id p57mr9672524qtj.106.1581335096584; 
 Mon, 10 Feb 2020 03:44:56 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id 12sm12808qkv.29.2020.02.10.03.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 03:44:55 -0800 (PST)
Date: Mon, 10 Feb 2020 06:44:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zha Bin <zhabin@linux.alibaba.com>
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Message-ID: <20200210062938-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <cover.1581305609.git.zhabin@linux.alibaba.com>
X-MC-Unique: oCL2j8haOTOIY6Adf6oUuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, jasowang@redhat.com,
 jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 05:05:16PM +0800, Zha Bin wrote:
> We have compared the number of files and the lines of code between
> virtio-mmio and virio-pci.
>=20
> =09=09=09=09Virtio-PCI=09    Virtio-MMIO=09
> =09number of files(Linux)=09    161=09=09=091
> =09lines of code(Linux)=09    78237=09=09538



Something's very wrong here. virtio PCI is 161 files?
Are you counting the whole PCI subsystem?
Sure enough:

$ find drivers/pci -name '*c' |wc -l
150

That's not reasonable, this includes a bunch of drivers that
never run on a typical hypervisor.

MMIO is also not as small as you are trying to show:

$ cloc drivers/virtio/virtio_mmio.c include/uapi/linux/virtio_mmio.h
       2 text files.
       2 unique files.                             =20
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=3D0.01 s (230.7 files/s, 106126.5 lines/=
s)
---------------------------------------------------------------------------=
----
Language                     files          blank        comment           =
code
---------------------------------------------------------------------------=
----
C                                1            144            100           =
 535
C/C++ Header                     1             39             66           =
  36
---------------------------------------------------------------------------=
----
SUM:                             2            183            166           =
 571
---------------------------------------------------------------------------=
----


I don't doubt MMIO is smaller than PCI. Of course that's because it has
no features to speak of - just this patch already doubles it's size. If
we keep doing that because we want the features then they will reach
the same size in about 4 iterations.


--=20
MST


