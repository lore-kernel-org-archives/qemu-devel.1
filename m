Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC1BC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714F220757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcX1g7Rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714F220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7x3-0004HY-IS
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7ji-0003Jo-PH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jf-0000Qz-GC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:37987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jf-0000QU-1h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id x17so6513399wrt.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ldO2tE9PLYd0GigcvjlBiYXaMzZxcyyWw/7hDoBADyU=;
 b=UcX1g7Rt05VLqU4ftMVwz9UUz3Oa382gumesSBYqw8HiIBBzVghDmDtNaFIw+JE+m8
 nFg5Nhgrs/jztpuydoSxZ7jICyip9n0OE14uqLobP1txm20phWl7uUT3GWdeIEZdBq8l
 3PYQOV5BxMvrxg/dSK3zYGRz1fvQRzrIep5WR4vkYZc+1I31UzF73oC8X0qbsXAc0O3G
 CNSFal+72paOIYjwLrNmA0hpCVQhjL8ftsDMRmKAZMqJR8+wdZ0vfYBYg1ZkHQlfM5iE
 3rAQ+ZRTcfuO2odwdTtE6TIA7eDrL8e2i7nF2ER4B/4bg9CrOyLNkO4zl2gl6bsaD3ub
 Xx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ldO2tE9PLYd0GigcvjlBiYXaMzZxcyyWw/7hDoBADyU=;
 b=l45Kw7tB5bRDcdcRJ5ZM0MQj3TvZ4igkq2n7aP4BWkDgP4e3WqLVsH0uUfN2uDNIdn
 2ea1ZJR4TwyUbnBBTtVsMB8YtXMF4u4oUOUnvHlroiC2+EsQM9Y3hC4NMdvNl/noEh2L
 z6fFcBWCggs+RNXqy6NFTYCK63UsWcvMi3F0H7C/+mtFUTc49fpA535/i4qHOqbJCzro
 qJwDCUKGlPpRwXTim2iO2q0KFqYFvfBI7bAxyrR95nV180Mwqgx8RZLLQXxzSAvjtYBw
 uGjbJ1MdQghQDWQF3Wrwhk1z6RTOejq5ZGYcbi5xjassqIubILWDgDrwwuVQQFvXnZIv
 mvAg==
X-Gm-Message-State: AGi0PuYri1rKpjNaPjKIJ1Psp7+zDHBmrFLDe+mf3fmuj61VJa2SpGyZ
 QA7/2ukNfWjxs9T6aaZz6KSnZloW0Q1HNw==
X-Google-Smtp-Source: APiQypItvsTYYdro7NGrJL4ADdQn2ej2D0OLF689DaApILcOjeCepuyfanCgPVt0LL722Or8cUpPjw==
X-Received: by 2002:adf:e944:: with SMTP id m4mr3452365wrn.366.1588247529322; 
 Thu, 30 Apr 2020 04:52:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/31] hw/arm/virt: dt: move creation of /secure-chosen to
 create_fdt()
Date: Thu, 30 Apr 2020 12:51:33 +0100
Message-Id: <20200430115142.13430-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jerome Forissier <jerome@forissier.org>

The /secure-chosen node is currently used only by create_uart(), but
this will change. Therefore move the creation of this node to
create_fdt().

Signed-off-by: Jerome Forissier <jerome@forissier.org>
Message-id: 20200420121807.8204-2-jerome@forissier.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cca53162563..0d92674f32b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -234,6 +234,10 @@ static void create_fdt(VirtMachineState *vms)
     /* /chosen must exist for load_dtb to fill in necessary properties later */
     qemu_fdt_add_subnode(fdt, "/chosen");
 
+    if (vms->secure) {
+        qemu_fdt_add_subnode(fdt, "/secure-chosen");
+    }
+
     /* Clock node, for the benefit of the UART. The kernel device tree
      * binding documentation claims the PL011 node clock properties are
      * optional but in practice if you omit them the kernel refuses to
@@ -761,7 +765,6 @@ static void create_uart(const VirtMachineState *vms, int uart,
         qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
         qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
 
-        qemu_fdt_add_subnode(vms->fdt, "/secure-chosen");
         qemu_fdt_setprop_string(vms->fdt, "/secure-chosen", "stdout-path",
                                 nodename);
     }
-- 
2.20.1


