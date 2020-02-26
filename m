Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E45C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420232084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5M244Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420232084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6shi-0002dG-F0
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sf8-0005er-Eg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sf7-0000RN-C6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21125
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sf7-0000Qn-5g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qy9/687s6ZY1i4Ce3m2ls24YlJZNFW8NDWw91xMGiXM=;
 b=L5M244Y0s+TGnbipt7kKQ0v7TLiCAFpfuKSTPdXWzYnDx9iWjyqKB9S45xsJvNKL9IjGtP
 yqp1D/wqBMoCkoyZCnKBxZ5aOPue1TW/+mM5xHQB9qdnt5WR0D/UZhxJ7NKun10objhtG9
 07FTWJZ9JDGojFmYdwJTS2KkEttzgms=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Z2EcyetMNmyVo-mN20zsOQ-1; Wed, 26 Feb 2020 04:07:22 -0500
X-MC-Unique: Z2EcyetMNmyVo-mN20zsOQ-1
Received: by mail-wr1-f71.google.com with SMTP id p8so1189148wrw.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=66uA6nm0t2SlG2qj7xxlmLCKVkLyYwtKAF+OGhXadUo=;
 b=PFwCUOTaDUgqPjOxaqesJEBcatNiMG2qMBpuNcIknzWZNJYZi55GAWB76c2rzZdbWU
 TJ22J8Qd3AuBvtFw3rE7P6zHYdX9FakeXmIl7NFC+58hrMx9u2rV0exj3xpdblXIsY0G
 M3EwbncpBWd4P6UmGYs3Gp5vAiWAeBr56nFass78XzzbX7gSwzEO+EOJMts3S1/k3rq3
 m1HYtz2a3wVBqMkT+/0P2SBmWZwryT/97Zsag5F3/hrAcGzE1HRqqEuc/6y5yCfykD9V
 5vOYXPf3tWCeazf3mWQnp+Ni4AU1BSFNYfQt0sMRtD/6251q7gn+4FTnbPRGIOygHdVl
 31zQ==
X-Gm-Message-State: APjAAAXAKGkreS3yv2l5pEmVBOWYc3baxk32zOm3kJdeXNTG+YdO0ALl
 zot+mKQA5KsVketyZ+m00W0/D/AAsyyjKeEirtsYQOJkm94pbelvmH2ntWGeQOUKBKexmtpRgy7
 fOpK/2p/xyd2c65o=
X-Received: by 2002:adf:de85:: with SMTP id w5mr4033415wrl.323.1582708041124; 
 Wed, 26 Feb 2020 01:07:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAZZInhrvhe4EF8VhwBSbl63Y9WrwIFTiutZBLHlbgnV8okdijIvQp4FMHAMIhj3S0RQQLjg==
X-Received: by 2002:adf:de85:: with SMTP id w5mr4033382wrl.323.1582708040840; 
 Wed, 26 Feb 2020 01:07:20 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 q6sm2353885wrf.67.2020.02.26.01.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:20 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 21/30] MAINTAINERS: add virtio-iommu related files
Message-ID: <20200226090010.708934-22-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Add a new "virtio-iommu" section with the new files
related to this device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20200214132745.23392-11-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 195dd58cac..ff06934bb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1631,6 +1631,12 @@ F: hw/input/virtio-input*.c
 F: include/hw/virtio/virtio-input.h
 F: contrib/vhost-user-input/*
=20
+virtio-iommu
+M: Eric Auger <eric.auger@redhat.com>
+S: Maintained
+F: hw/virtio/virtio-iommu*.c
+F: include/hw/virtio/virtio-iommu.h
+
 virtio-serial
 M: Laurent Vivier <lvivier@redhat.com>
 R: Amit Shah <amit@kernel.org>
--=20
MST


