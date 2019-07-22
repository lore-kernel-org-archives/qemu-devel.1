Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448CCC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120C521955
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUfFs+wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120C521955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpb0S-0006xQ-CR
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hpazl-0004di-7u
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hpazj-0006P6-TY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:17:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hpazj-0006Ni-MH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:16:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id r1so40042676wrl.7
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sfTY8XQYwydUBik6pz+sOsPpf+J/3/G7lA07pOd4fqU=;
 b=fUfFs+wfU88pwlAac2ZSQcbJ3+3yBnxY16nFTAO3XTNH/xfKDc4/wqFu1XIkl4ZdJT
 3y/Ms1kPohW2l+zHIeyhppAUHGzXmFNJBv02YnEB0PysD/cSF+BLENO1mt/B7VEBGr8J
 vmAIMuu2HlWvMI8WmjdZFN3YYwGgw/d5M8wXLzsITv5ef4lG3s7dFfA52JhgOPskytF1
 I2YShBIBjKi9yapeu3x2DSeqFvEUpJSA/Y/YKAaVF3P0RVDWpcl2aNKk6dSdnl6dzFNO
 TxNQmKugZor/VDegrZe2WRNYZW/RRn4rHlkdQTASW0QcuQ559oECfJ//jyKaLm/qLGHf
 BZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sfTY8XQYwydUBik6pz+sOsPpf+J/3/G7lA07pOd4fqU=;
 b=Igy5NjBysmuMp4XJtp23twB+GprghJ67EYr7Yyk4Jd8wTtqYT/E4RhSqwFICcfm8bW
 84PaSBEiOJRzBAEesTWJQKcrNEM3D/wTwLcz+iYzXMq60ev0C75u7015syRvWSL2Kjwi
 NA3VzJvoIP4g6urUqXxqA8mwh/tfY3v0k0fQKb+9ijmjWoXejb5GBKxj+1v+P1ZlljYO
 lIBYLnZUM9XxBxLp0iDvZpvKrmhuXaBjya3plIBfHs2XPnNTXmC8wBaVPKbjwwBRidEZ
 o1Wo/B8GRcBMK/nycrwzYrlsMoxT4NmqQfFY2jruEZAvwMwv6PXEqz2xgZ786BoDU2+P
 vkQQ==
X-Gm-Message-State: APjAAAX0C2QZ9xvofNNCZHa/LDu9rWqsLGQXi1CBZY4kWXTXbi2Khw8v
 CTP08NJxlS71Udgfmh34/z+aA+FBZBg=
X-Google-Smtp-Source: APXvYqyoJqCDcBN+GuXPu4/ITHhUNzEq3QjbfVuZ5aYlXp+RxkAhxR1MXz4Dtx8DGY7Hnv6IDeUV+w==
X-Received: by 2002:a05:6000:11c6:: with SMTP id
 i6mr69385575wrx.193.1563812218361; 
 Mon, 22 Jul 2019 09:16:58 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id o6sm77717501wra.27.2019.07.22.09.16.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 09:16:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 18:16:56 +0200
Message-Id: <20190722161657.8188-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722161657.8188-1-pbonzini@redhat.com>
References: <20190722161657.8188-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 1/2] virtio-scsi: fixed virtio_scsi_ctx_check
 failed when detaching scsi disk
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
Cc: Zhengui li <lizhengui@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhengui li <lizhengui@huawei.com>

commit a6f230c move blockbackend back to main AioContext on unplug. It set the AioContext of
SCSIDevice to the main AioContex, but s->ctx is still the iothread AioContexï¼ˆif the scsi controller
is configure with iothreadï¼‰. So if there are having in-flight requests during unplug, a failing assertion
happend. The bt is below:
(gdb) bt
#0  0x0000ffff86aacbd0 in raise () from /lib64/libc.so.6
#1  0x0000ffff86aadf7c in abort () from /lib64/libc.so.6
#2  0x0000ffff86aa6124 in __assert_fail_base () from /lib64/libc.so.6
#3  0x0000ffff86aa61a4 in __assert_fail () from /lib64/libc.so.6
#4  0x0000000000529118 in virtio_scsi_ctx_check (d=<optimized out>, s=<optimized out>, s=<optimized out>) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:246
#5  0x0000000000529ec4 in virtio_scsi_handle_cmd_req_prepare (s=0x2779ec00, req=0xffff740397d0) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:559
#6  0x000000000052a228 in virtio_scsi_handle_cmd_vq (s=0x2779ec00, vq=0xffff7c6d7110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:603
#7  0x000000000052afa8 in virtio_scsi_data_plane_handle_cmd (vdev=<optimized out>, vq=0xffff7c6d7110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi-dataplane.c:59
#8  0x000000000054d94c in virtio_queue_host_notifier_aio_poll (opaque=<optimized out>) at /home/qemu-4.0.0/hw/virtio/virtio.c:2452

assert(blk_get_aio_context(d->conf.blk) == s->ctx) failed.

To avoid assertion failed,  moving the "if" after qdev_simple_device_unplug_cb.

In addition, to avoid another qemu crash below, add aio_disable_external before
qdev_simple_device_unplug_cb, which disable the further processing of external clients
when doing qdev_simple_device_unplug_cb.
(gdb) bt
#0  scsi_req_unref (req=0xffff6802c6f0) at hw/scsi/scsi-bus.c:1283
#1  0x00000000005294a4 in virtio_scsi_handle_cmd_req_submit (req=<optimized out>,
    s=<optimized out>) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:589
#2  0x000000000052a2a8 in virtio_scsi_handle_cmd_vq (s=s@entry=0x9c90e90,
    vq=vq@entry=0xffff7c05f110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi.c:625
#3  0x000000000052afd8 in virtio_scsi_data_plane_handle_cmd (vdev=<optimized out>,
    vq=0xffff7c05f110) at /home/qemu-4.0.0/hw/scsi/virtio-scsi-dataplane.c:60
#4  0x000000000054d97c in virtio_queue_host_notifier_aio_poll (opaque=<optimized out>)
    at /home/qemu-4.0.0/hw/virtio/virtio.c:2447
#5  0x00000000009b204c in run_poll_handlers_once (ctx=ctx@entry=0x6efea40,
    timeout=timeout@entry=0xffff7d7f7308) at util/aio-posix.c:521
#6  0x00000000009b2b64 in run_poll_handlers (ctx=ctx@entry=0x6efea40,
    max_ns=max_ns@entry=4000, timeout=timeout@entry=0xffff7d7f7308) at util/aio-posix.c:559
#7  0x00000000009b2ca0 in try_poll_mode (ctx=ctx@entry=0x6efea40, timeout=0xffff7d7f7308,
    timeout@entry=0xffff7d7f7348) at util/aio-posix.c:594
#8  0x00000000009b31b8 in aio_poll (ctx=0x6efea40, blocking=blocking@entry=true)
    at util/aio-posix.c:636
#9  0x00000000006973cc in iothread_run (opaque=0x6ebd800) at iothread.c:75
#10 0x00000000009b592c in qemu_thread_start (args=0x6efef60) at util/qemu-thread-posix.c:502
#11 0x0000ffff8057f8bc in start_thread () from /lib64/libpthread.so.0
#12 0x0000ffff804e5f8c in thread_start () from /lib64/libc.so.6
(gdb) p bus
$1 = (SCSIBus *) 0x0

Signed-off-by: Zhengui li <lizhengui@huawei.com>
Message-Id: <1563696502-7972-1-git-send-email-lizhengui@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/virtio-scsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index d0bdbff090..aa33819d59 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -841,14 +841,16 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         virtio_scsi_release(s);
     }
 
+    aio_disable_external(s->ctx);
+    qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
+    aio_enable_external(s->ctx);
+
     if (s->ctx) {
         virtio_scsi_acquire(s);
         /* If other users keep the BlockBackend in the iothread, that's ok */
         blk_set_aio_context(sd->conf.blk, qemu_get_aio_context(), NULL);
         virtio_scsi_release(s);
     }
-
-    qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
 }
 
 static struct SCSIBusInfo virtio_scsi_scsi_info = {
-- 
2.21.0



