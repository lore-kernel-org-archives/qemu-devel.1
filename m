Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6EFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692D020BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AilTWkv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692D020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB4c-0001F3-HN
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmN-0007Bi-1H
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmL-0004qL-9o
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTkwT/HJ1lj3VKT9unaRe9zAEsq3t6jIEnXFjz8fDHg=;
 b=AilTWkv2F+GCR21M0H9WidNTxewPkgV1OIf2lVqY1h0H8t8FDd6gtKok716lQ1ruZosJ3m
 kQoWCRBOxLbmtUzBcY72aWOTmxJpyg6LEsm/2DftX1eRixI2VhVapDZkztomHBREIor8El
 kBPwv1Vth3Yapwf8M80Z4MuRRBpAE4k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-st653kjrMb-laG9vRXT0ag-1; Tue, 03 Nov 2020 23:51:19 -0500
X-MC-Unique: st653kjrMb-laG9vRXT0ag-1
Received: by mail-wr1-f69.google.com with SMTP id h8so8752030wrt.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QTkwT/HJ1lj3VKT9unaRe9zAEsq3t6jIEnXFjz8fDHg=;
 b=CXeTKNLj+q/tC6Cw6DDqm2AosywDZaiDwgJVdZcEkBWaIzb/gi3DKPaJGslCORAcs8
 RJxBOQSNBYVMG5hfwLj40Z+aPfNlL2wgBpK4M293DBAhBiphK43Fj+5UCHrc2oNq4eCS
 4NykhNgAT2H0/CMLHmuVVDScK6wPMyNdeMwLhMfxGRAFTj7+O/C/+HR82NSFHT59VJV8
 t9kiofITob/u/3fcRhRsPxcff/BP1DbM2vOS+6lB7DRnUkhKgVJP42PFI9+QKKFGnDMf
 zemV+S30ZpJLC+0Q5Mvn58cWxCOWBAV7rOx1G7/JRJcxktJSYSJz2pFfbNA0gp//pFnq
 S32A==
X-Gm-Message-State: AOAM530liCVAYj09s53JfP2x/LWebEwmbZ4cn1ZgshvZT3ImAizWYriP
 D9XAyKubIVhRlDWmHdypVET7CTqu0+50WLoUjKI8l9d/N2UiS7tyN2cCbNiolUoyoFJVRXvyhVO
 a6DpAvRtmntT+CA0=
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr31535049wrv.172.1604465477640; 
 Tue, 03 Nov 2020 20:51:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUgsPaveUdfW8VUaAKa0QnpyrEuLakxvhVemX2FGAfbSC5w1+S79jiFtRprGeBjDFfnqL8OQ==
X-Received: by 2002:a5d:54c1:: with SMTP id x1mr31535034wrv.172.1604465477476; 
 Tue, 03 Nov 2020 20:51:17 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id o7sm879237wrp.23.2020.11.03.20.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:16 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/38] hw/smbios: Fix leaked fd in save_opt_one() error path
Message-ID: <20201104044937.226370-13-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
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


