Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4F3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4ED2087D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8tZFxyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4ED2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNuE-0002UK-3l
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjM-0000wU-4F
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjK-00020a-Az
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTkwT/HJ1lj3VKT9unaRe9zAEsq3t6jIEnXFjz8fDHg=;
 b=R8tZFxyCgwj9VbBQSeTQi7E7yxR1t39mEAvYv09OSIp+R4EtnDfxTCjWIRu3oklhRi8iXI
 lFjZUCgzchgWpmT1IUtY515WzleC2ACArl5QdeNQzb0OxmiLynxGq8ZEe4n0AVb8A60oI7
 mrqOBeJWtbeJn2PiZFR33VmYQo3u8NY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-jCDQI1k2MeS7ZPbyRftYug-1; Wed, 04 Nov 2020 13:41:55 -0500
X-MC-Unique: jCDQI1k2MeS7ZPbyRftYug-1
Received: by mail-wr1-f69.google.com with SMTP id y6so333920wrt.22
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QTkwT/HJ1lj3VKT9unaRe9zAEsq3t6jIEnXFjz8fDHg=;
 b=Jh4Xgct+b8iM+LI/9D+FA5pw/5wQu2rQdoVtHA0CXa2ZfqNzeZBStnlsIw2YU/+PNR
 8AYwfVo1cP/29K//t/zv2ju3OFSpbXOBwosctltvGD2FgBTmTxfAf0RQ9TPv8gPr+XRp
 8+HSfvYlGhuHckVevyXh1Jp1VJYFra7LajllNQD0xPbMSqfkJrjXQ/C2ybN07BsBfYvV
 J1ae9J+2VkbYPGGlS5yKhc2Bt7XlGNb3ZWZZOAjdSss8Xpg9gFuE93LeX/BeKI+NspB6
 fA6hoUmjqymhjC+lk39E7EOP1GKDtGdsKHulZrZZlkldgErCf7lpr2SI5NqsBhjLWgoG
 Xi5Q==
X-Gm-Message-State: AOAM530573cH5BiN7o4NvSTQHBr6Dmgc57eBus9s4lo8SNugMJFoKj+U
 h4jiF17WC1SrUBUPiSnYa1QIiSR/IQ2H821x2X70nHPALbRqEoNVEBpNPpfHorvp5be87B17Y1U
 Kwr8KhOfUBWd+iPw=
X-Received: by 2002:a7b:c94d:: with SMTP id i13mr6019966wml.130.1604515314002; 
 Wed, 04 Nov 2020 10:41:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFR7fPeQqqsaG9WxompWLgjuhwXhyM5RHygM2F5QD4TQDWTWvj/J4JhM76QDAdioSNR0HahA==
X-Received: by 2002:a7b:c94d:: with SMTP id i13mr6019955wml.130.1604515313871; 
 Wed, 04 Nov 2020 10:41:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id n9sm3311248wmd.4.2020.11.04.10.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:41:53 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 12/31] hw/smbios: Fix leaked fd in save_opt_one() error path
Message-ID: <20201104184040.285057-13-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix the following Coverity issue (RESOURCE_LEAK):

  CID 1432879: Resource leak

    Handle variable fd going out of scope leaks the handle.

Replace a close() call by qemu_close() since the handle is
opened with qemu_open().

Fixes: bb99f4772f5 ("hw/smbios: support loading OEM strings values from a file")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201030152742.1553968-1-philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 8b30906e50..6a3d39793b 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -988,16 +988,18 @@ static int save_opt_one(void *opaque,
             if (ret < 0) {
                 error_setg(errp, "Unable to read from %s: %s",
                            value, strerror(errno));
+                qemu_close(fd);
                 return -1;
             }
             if (memchr(buf, '\0', ret)) {
                 error_setg(errp, "NUL in OEM strings value in %s", value);
+                qemu_close(fd);
                 return -1;
             }
             g_byte_array_append(data, (guint8 *)buf, ret);
         }
 
-        close(fd);
+        qemu_close(fd);
 
         *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);
         (*opt->dest)[*opt->ndest] = (char *)g_byte_array_free(data,  FALSE);
-- 
MST


