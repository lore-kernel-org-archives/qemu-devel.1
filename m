Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989DFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF7E2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWhjMC7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF7E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY3GY-0006y2-0u
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 04:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kY3Fs-0006WI-Vt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:25:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kY3Fr-0006Kq-BQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 04:25:56 -0400
Received: by mail-pf1-x444.google.com with SMTP id a200so1714186pfa.10
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=rrn9aCMVRSxzTuJaEZz6SG2CMI3jFx8x8T8nf/uYOSo=;
 b=tWhjMC7l8ci1uWX6YtzghjDzJ9hp4G1vo7yRPMlZgZBIcMaA9/wOrFlUoDS3XaVEgF
 DoAEoOpQgvAXZwcIceNBtUBkdicv1o92/cXsVJ64J++ZH2X8nAC3+bP0pflJpvzk1p2e
 iHqry7VEOSheOTDGnODUSCr+NjPGSiFZ9jpRq3MwOnLLxMXIPU+iJzIr48hHdwh+2S7j
 p5X1AkZPpd1kEp8Mm7aQDmIhpqR/On1Y7QtgmokjxRLER+giQPXBfRWK49P1ra5f+AxZ
 3QDfLJNWEeUT/kgOot4CFjnK2Tat4XS6Tv5qDAJHSNl2LlFrvSK6mHf7wFqx/PaWlR6E
 oLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=rrn9aCMVRSxzTuJaEZz6SG2CMI3jFx8x8T8nf/uYOSo=;
 b=lGGIN3X18fZ2U3O+1rDgocxUnFItBVQiKSIw8wOv10xZqWWAgsd9NMcwmAZdW2GPXu
 BZVThPNpAFzB3dhxzs6DEtSPRZ7Yv5PqkrX3SbgWjSxVfuFOkjakhVQvxPlvaRUw96t/
 7kVweZLlA/wpo2FFGRrtLIabH9CIKW6UK+wnF1Y/Zn99rL4C3TmzJnYEkVZKX6fFwEiH
 v7NqqC5U+RI1uK6gSuBfYS8O9NsfStFNX/x00RaHd9PkWNncfgubZZpvEMXomn2u0YKm
 2K8fIZZP66MnSJ9WhlYLM5KgRpjnmbGEJJol4wtTIBWlyhqgw50uDvRW6uk4bMdcuWTx
 SIQg==
X-Gm-Message-State: AOAM5327speG58dOJAinlh123J2QHYT++TbSwGX1ZUHN8vBkabbS7ojl
 8K0XnNPztcgyCScHvireC9Q=
X-Google-Smtp-Source: ABdhPJw0jwCBlf1mZ7FVJCkFdGvx1Rz2wR8g/OmEXVCqmPdsWNjMz7xPQ5scq/Q02Ivwj+1dgkJQ7w==
X-Received: by 2002:a63:af1c:: with SMTP id w28mr3152517pge.453.1603959953572; 
 Thu, 29 Oct 2020 01:25:53 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id ca5sm2194478pjb.27.2020.10.29.01.25.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2020 01:25:53 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] hw/9pfs: virtio-9p: Ensure config space is a multiple of 4
 bytes
Date: Thu, 29 Oct 2020 16:25:41 +0800
Message-Id: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the virtio device config space access is handled by the
virtio_config_readX() and virtio_config_writeX() APIs. They perform
a sanity check on the result of address plus size against the config
space size before the access occurs.

For unaligned access, the last converted naturally aligned access
will fail the sanity check on 9pfs. For example, with a mount_tag
`p9fs`, if guest software tries to read the mount_tag via a 4 byte
read at the mount_tag offset which is not 4 byte aligned, the read
result will be `p9\377\377`, which is wrong.

This changes the size of device config space to be a multiple of 4
bytes so that correct result can be returned in all circumstances.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/9pfs/virtio-9p-device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 14371a7..e6a1432 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -201,6 +201,7 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
     V9fsVirtioState *v = VIRTIO_9P(dev);
     V9fsState *s = &v->state;
     FsDriverEntry *fse = get_fsdev_fsentry(s->fsconf.fsdev_id);
+    size_t config_size;
 
     if (qtest_enabled() && fse) {
         fse->export_flags |= V9FS_NO_PERF_WARN;
@@ -211,7 +212,8 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
     }
 
     v->config_size = sizeof(struct virtio_9p_config) + strlen(s->fsconf.tag);
-    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, v->config_size);
+    config_size = ROUND_UP(v->config_size, 4);
+    virtio_init(vdev, "virtio-9p", VIRTIO_ID_9P, config_size);
     v->vq = virtio_add_queue(vdev, MAX_REQ, handle_9p_output);
 }
 
-- 
2.7.4


