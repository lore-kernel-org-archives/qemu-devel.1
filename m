Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D87C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5280208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="R+N4+vv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5280208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEbD-0006y6-3R
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jeEZv-0005KR-Jb; Thu, 28 May 2020 05:11:55 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:60160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jeEZt-0000q9-HJ; Thu, 28 May 2020 05:11:54 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 2D7D82E15FA;
 Thu, 28 May 2020 12:11:50 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net
 (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Zm8XHZgTdt-BlImbGlA; Thu, 28 May 2020 12:11:50 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590657110; bh=SEun7ESiWH3czDdIa+sUhnBLSFJMVA81918bgD9tv/k=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=R+N4+vv2FuVVA2RjSEIKkaWn9Q6L+EfKGyJYYyCSfOZtBdDS30o1RbLmnkjW+A+UX
 G5Dk8TvBNHMBXbP/lTkmJHq26ABmW6CWg0RgcMT4sFbP32hsf8xM2Lxii9QAFl4HEh
 olV2DOvR4oOO8P+PZCpLL6A+iioT/2tiXBjVgMZ8=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8219::1:5])
 by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 YZCPcdHrH5-BlWq7nl8; Thu, 28 May 2020 12:11:47 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] char-socket: return -1 in case of disconnect during
 tcp_chr_write
Date: Thu, 28 May 2020 12:11:18 +0300
Message-Id: <aeb7806bfc945faadf09f64dcfa30f59de3ac053.1590396396.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1590396396.git.dimastep@yandex-team.ru>
References: <cover.1590396396.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1590396396.git.dimastep@yandex-team.ru>
References: <cover.1590396396.git.dimastep@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, fengli@smartx.com,
 yc-core@yandex-team.ru, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During testing of the vhost-user-blk reconnect functionality the qemu
SIGSEGV was triggered:
 start qemu as:
 x86_64-softmmu/qemu-system-x86_64 -m 1024M -M q35 \
   -object memory-backend-file,id=ram-node0,size=1024M,mem-path=/dev/shm/qemu,share=on \
   -numa node,cpus=0,memdev=ram-node0 \
   -chardev socket,id=chardev0,path=./vhost.sock,noserver,reconnect=1 \
   -device vhost-user-blk-pci,chardev=chardev0,num-queues=4 --enable-kvm
 start vhost-user-blk daemon:
 ./vhost-user-blk -s ./vhost.sock -b test-img.raw

If vhost-user-blk will be killed during the vhost initialization
process, for instance after getting VHOST_SET_VRING_CALL command, then
QEMU will fail with the following backtrace:

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x00005555559272bb in vhost_user_read (dev=0x7fffef2d53e0, msg=0x7fffffffd5b0)
    at ./hw/virtio/vhost-user.c:260
260         CharBackend *chr = u->user->chr;

 #0  0x00005555559272bb in vhost_user_read (dev=0x7fffef2d53e0, msg=0x7fffffffd5b0)
    at ./hw/virtio/vhost-user.c:260
 #1  0x000055555592acb8 in vhost_user_get_config (dev=0x7fffef2d53e0, config=0x7fffef2d5394 "", config_len=60)
    at ./hw/virtio/vhost-user.c:1645
 #2  0x0000555555925525 in vhost_dev_get_config (hdev=0x7fffef2d53e0, config=0x7fffef2d5394 "", config_len=60)
    at ./hw/virtio/vhost.c:1490
 #3  0x00005555558cc46b in vhost_user_blk_device_realize (dev=0x7fffef2d51a0, errp=0x7fffffffd8f0)
    at ./hw/block/vhost-user-blk.c:429
 #4  0x0000555555920090 in virtio_device_realize (dev=0x7fffef2d51a0, errp=0x7fffffffd948)
    at ./hw/virtio/virtio.c:3615
 #5  0x0000555555a9779c in device_set_realized (obj=0x7fffef2d51a0, value=true, errp=0x7fffffffdb88)
    at ./hw/core/qdev.c:891
 ...

The problem is that vhost_user_write doesn't get an error after
disconnect and try to call vhost_user_read(). The tcp_chr_write()
routine should return -1 in case of disconnect. Indicate the EIO error
if this routine is called in the disconnected state.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-socket.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 232e0a8..c2462e0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -174,15 +174,16 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
         if (ret < 0 && errno != EAGAIN) {
             if (tcp_chr_read_poll(chr) <= 0) {
+                /* Perform disconnect and return error. */
                 tcp_chr_disconnect_locked(chr);
-                return len;
             } /* else let the read handler finish it properly */
         }
 
         return ret;
     } else {
-        /* XXX: indicate an error ? */
-        return len;
+        /* Indicate an error. */
+        errno = EIO;
+        return -1;
     }
 }
 
-- 
2.7.4


