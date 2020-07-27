Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2329C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3A02070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hkqi0qXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3A02070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03ak-00067f-R5
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vz-0005rE-RA
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:50:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Vx-0001yc-Sr
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595857801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXITvKmBNRuCK1oQcQxl+D6gdJLR2Jn4LOvKMTH1JwU=;
 b=Hkqi0qXgfpMZkSq1LUvlj+sAbgaauIzSKSJ8XjdvQcP4R9txDe0Idl34wJ4zVyDjPvhrYe
 6S6QjOeeUlUukPHGYijZB/AOIUhZ6E3k8uM3ldlLprwkpNP+WwR+qRXd5/qAvppxT6dC4s
 zjTqEnImNa7fE75TxhvYVrbTFoo4ToI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-k4u030l8NA2e93fexBbHCA-1; Mon, 27 Jul 2020 09:49:59 -0400
X-MC-Unique: k4u030l8NA2e93fexBbHCA-1
Received: by mail-wm1-f71.google.com with SMTP id b13so7845706wme.9
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uXITvKmBNRuCK1oQcQxl+D6gdJLR2Jn4LOvKMTH1JwU=;
 b=AZRsOxdAaMTH5RfIO84Jchpk8TVjTb4iqnyioL01Md6Zt7LcuBpAua+DcXElMHmbdp
 Y6070Q7bcS5mtR/WL0NnThDHYD1l59fQMlNoIeP+MIOXe0U8hHvJn2wsUcDtFIjSfIgY
 AEQKwwZXyk3DnP1nyTuU/CGEIVdsTKl97YctsU5Ozgvkt69tRmdJzxrKg4HNOVysuQew
 19lkpCQMFMxSVjxRZJTYME9d9kdB2LNPBkIKAKpgZhZE9djoOl1Kn+aIhhuU3JUsn59b
 2c0b76nlKo+eMuHMz6tAxlE9A7aNY6AYAZueA78y7ePElVbPCijTLrl9+7khU2wjVIFo
 M6lw==
X-Gm-Message-State: AOAM532oOSpBx95nOIXCuajEFKqXbGtdfEzUTIt7SXb89q8p/tTUs+jV
 KFFNd0f5HrDeRj6OJwRXPeWxxUk2rJXjFdp1+HfEvnR/N44FRhSDViPeKJ79E5b5oIKuDXlWTmk
 kj8NQtFAv6XcuZlc=
X-Received: by 2002:a5d:4144:: with SMTP id c4mr20279497wrq.200.1595857797764; 
 Mon, 27 Jul 2020 06:49:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU5AsL6E7y4503fSx98Jssxl30XSXuHZ4FBywFGLzvPAcpIE4TRpOcuLGe+/JF3G0t6M9mwg==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr20279473wrq.200.1595857797601; 
 Mon, 27 Jul 2020 06:49:57 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id 111sm6980416wrc.53.2020.07.27.06.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:49:56 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:49:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] MAINTAINERS: Cover the firmware JSON schema
Message-ID: <20200727134614.96376-8-mst@redhat.com>
References: <20200727134614.96376-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727134614.96376-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add an entry to cover firmware.json (see commit 3a0adfc9bf:
schema that describes the different uses and properties of
virtual machine firmware).

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200703183450.32398-1-philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3395abd4e1..0886eb3d2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2667,6 +2667,14 @@ F: include/hw/i2c/smbus_master.h
 F: include/hw/i2c/smbus_slave.h
 F: include/hw/i2c/smbus_eeprom.h
 
+Firmware schema specifications
+M: Laszlo Ersek <lersek@redhat.com>
+M: Philippe Mathieu-Daudé <philmd@redhat.com>
+R: Daniel P. Berrange <berrange@redhat.com>
+R: Kashyap Chamarthy <kchamart@redhat.com>
+S: Maintained
+F: docs/interop/firmware.json
+
 EDK2 Firmware
 M: Laszlo Ersek <lersek@redhat.com>
 M: Philippe Mathieu-Daudé <philmd@redhat.com>
-- 
MST


