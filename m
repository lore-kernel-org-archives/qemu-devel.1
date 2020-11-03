Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9ECC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C49E20757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyG55BLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C49E20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxfz-0001jF-QF
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOd-0004TV-0d
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOa-0006Sl-QS
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTkwT/HJ1lj3VKT9unaRe9zAEsq3t6jIEnXFjz8fDHg=;
 b=KyG55BLjo1TMDH5VtfFwR2c6vIe9nofLO1VcgBlV9DfdvL9zGwvWQIlksFmeSit8Z/u8Ir
 5/pLOTTpJoh4GjqcRZcfs7O/dMmyFe7O7Eyo3jYLvuTTG5ZHRK2Lmj/oGsr/6ZaF9QzYeg
 J/IdYyjC2m1aiOp+KPCIpxh4dZY6qzc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-qtVob46sPLmeEzZ8RICBpw-1; Tue, 03 Nov 2020 09:34:37 -0500
X-MC-Unique: qtVob46sPLmeEzZ8RICBpw-1
Received: by mail-wm1-f72.google.com with SMTP id c10so3821438wmh.6
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QTkwT/HJ1lj3VKT9unaRe9zAEsq3t6jIEnXFjz8fDHg=;
 b=loRJN05eF6u8TkOH4in0ZOmdFrDzGkoLpXwEink+k3TzoSpp7SK0eiP7FDFR+b0BiA
 qyz8HSz7vxZ1PGDd9CJJTuAeR0pHrfxNj00AdFyymbpj1NpNas/J4HiD409Hxp+1YTnb
 0Upc+DZ8AYW57mNb60+ERRvWA7E/hvfCUsg2c6m8/U8Vdje6nBYSgDMqVoqQUBKt8g45
 KgoChDQP9nvI5DRhBJmTTLTIgIZjxYmB0CEb3deMkh1ifmN8SFLZ5bq+mj4iU+kA0MNF
 e/wLwVHwUq+7jbY73Mx+WeUqRC19vv9ecXXuT+zub2kGJE/uia6mKbPMWszUky5p+nVA
 Z4Vw==
X-Gm-Message-State: AOAM533mwzFGa+hiWcg6nQKVmth2R9cTsqQnF51xmB3pFStFH5y0O2Zs
 5R5VAQCipCpGBaA0018ivmu9V8EEO49YR0C3tWw5dEDL003KxZlRwZypRCn2GgCqTGWHMGtluLI
 NxY7dgnp4m3TAaK4=
X-Received: by 2002:a5d:4581:: with SMTP id p1mr26440926wrq.353.1604414075528; 
 Tue, 03 Nov 2020 06:34:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9L697Du0dzc7wR99MIjOGGMPL/JcEtGEA5Jy7QuBJZt71LCvFWOcFPrTWK4x6fpc6FhZK5Q==
X-Received: by 2002:a5d:4581:: with SMTP id p1mr26440911wrq.353.1604414075382; 
 Tue, 03 Nov 2020 06:34:35 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id u3sm24771383wro.33.2020.11.03.06.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:34 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/38] hw/smbios: Fix leaked fd in save_opt_one() error path
Message-ID: <20201103142306.71782-13-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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


