Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3396BC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009E0207D4
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0ISBmmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009E0207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juJ42-0004Lk-Ab
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIya-0003df-10
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyY-0006iJ-FF
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id o11so8994954wrv.9
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x+AzDxkpTb7rSHxhkwf/D/VC9fOGKV8MMi1S7eP7yLg=;
 b=b0ISBmmwSLHrsPPL8Pgxic/FKa1pjNeLJAiyx9UMIUumR40K1+hRk+mDCTI02YdqUP
 BvwmQAVyLV/hGU5A9vnC/QcdpO+QDPDXgjWXCy6Fesi7BIJzSyL2CPNe/k6PTjYj299U
 PFOuu9fWX7bk7y0cDGVcw/Uy4ksxD9FmpTTpPgPsEsDbABAnxnW3719DUTtpXAPTwout
 oDIXee6bDZQjasYdC11N/XUNhIiF3cqj/lEKsihhWWhFbh2I88zxZ/bAQmeVP2k1sT0f
 uP/FiMeiUB0rHriAYeXz9kVfWDTQRIlj6kqHP20oTBrYHRWE1vWhFrL3oGS94U+tqOKT
 bv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x+AzDxkpTb7rSHxhkwf/D/VC9fOGKV8MMi1S7eP7yLg=;
 b=SdX2NRNXr8ZhRn6TA/9gjoBNkLpKokib0MTKHqrCv/1+VwBHhzO3ADsOO6C9fxz6vQ
 JfRiTh98J0G52f8ADj7mUhJCRH6SoTTWXvz1lBIl9g+xemPqEibTIhwCpes9gk0UjKmD
 tkvgJyqYZ3U7ed+EmXku9UXIgcUD6xUVvqC6ZpgLqgyKLhkMxxqoI9HHNF+avcO2SlXs
 RLbFqQh+pjl9r8ObwLS1ei7PEkrFrMoTNefW2GUWAnOeG1LjfzrFmmYvkekXpCA/tYPr
 VD72svGBqf0vBXmkfr/HZDOxG9U5XRE3rIKrTV0UokyVYX4/FPAp80py2NwCUMpBgO8z
 5SGg==
X-Gm-Message-State: AOAM531wf030wcUNOLTEgGvIABfFa4eHzBQGGr3ldIVwPRlwTMcjw00Z
 Pq9kbZkkU+MRFhsTqUQ9BuBZlg==
X-Google-Smtp-Source: ABdhPJwcHPSK2wPPhxlxNV7hnLOEWJmLE8eoUE2mEeeTO1TBrvnm/0Qz3sM+9r9m0AmFOR84S/2coA==
X-Received: by 2002:a5d:60c7:: with SMTP id x7mr68124856wrt.138.1594487265195; 
 Sat, 11 Jul 2020 10:07:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i6sm3838854wrp.92.2020.07.11.10.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:07:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA7AA1FF98;
 Sat, 11 Jul 2020 18:07:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 49/50] Revert "vga: build virtio-gpu as module"
Date: Sat, 11 Jul 2020 18:07:31 +0100
Message-Id: <20200711170732.26213-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711170732.26213-1-alex.bennee@linaro.org>
References: <20200711170732.26213-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

This reverts commit 8d5a24c83dba90b08ef163bbf166d6dfbad9019b.

Compiling all virtio-gpu objects into a single module isn't a good plan
because the individual objects have different CONFIG_* dependencies.
Leads to module load failures on s390x due to vga support being
disabled, which in turn breaks '-device virtio-gpu-device' (flagged by
travis ci).

So back to the drawing board for modular virtio-gpu ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200710203652.9708-3-kraxel@redhat.com>

diff --git a/util/module.c b/util/module.c
index 32b0547b82..90e9bd42c6 100644
--- a/util/module.c
+++ b/util/module.c
@@ -266,12 +266,6 @@ static struct {
     { "usb-redir",             "hw-", "usb-redirect"          },
     { "qxl-vga",               "hw-", "display-qxl"           },
     { "qxl",                   "hw-", "display-qxl"           },
-    { "virtio-gpu-device",     "hw-", "display-virtio-gpu"    },
-    { "virtio-gpu-pci",        "hw-", "display-virtio-gpu"    },
-    { "virtio-vga",            "hw-", "display-virtio-gpu"    },
-    { "vhost-user-gpu-device", "hw-", "display-virtio-gpu"    },
-    { "vhost-user-gpu-pci",    "hw-", "display-virtio-gpu"    },
-    { "vhost-user-vga",        "hw-", "display-virtio-gpu"    },
     { "chardev-braille",       "chardev-", "baum"             },
 };
 
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index e907f3182b..d619594ad4 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -49,19 +49,16 @@ common-obj-m += qxl.mo
 qxl.mo-objs = qxl.o qxl-logger.o qxl-render.o
 endif
 
-ifeq ($(CONFIG_VIRTIO_GPU),y)
-common-obj-m += virtio-gpu.mo
-virtio-gpu-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
-virtio-gpu-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
-virtio-gpu-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
-virtio-gpu-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
-virtio-gpu-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
-virtio-gpu-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
-virtio-gpu.mo-objs := $(virtio-gpu-obj-y)
-virtio-gpu.mo-cflags := $(VIRGL_CFLAGS)
-virtio-gpu.mo-libs := $(VIRGL_LIBS)
-endif
-
+common-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
+common-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
+common-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
+common-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
+common-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
+common-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
+virtio-gpu.o-cflags := $(VIRGL_CFLAGS)
+virtio-gpu.o-libs += $(VIRGL_LIBS)
+virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
+virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
 common-obj-$(CONFIG_DPCD) += dpcd.o
 common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
 
-- 
2.20.1


