Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3475FC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED4120870
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="HGH8myxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED4120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9e5-00022s-VT
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jU9TM-00019i-7g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jU9Qb-0008Ej-NV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:43:27 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:56242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jU9N8-0001RR-1D; Thu, 30 Apr 2020 09:37:02 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 856AF2E148F;
 Thu, 30 Apr 2020 16:36:58 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 7i37znqff2-atAa7PnK; Thu, 30 Apr 2020 16:36:58 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1588253818; bh=B7N/2dA22AZAvZEuIRWbfaStgxBZh00/dxecx4k5Xoo=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=HGH8myxN3Y/63O9Kv/epJ9XSlQxTpgYIikgVtdc4m8IsGLb6RskZSa/DqTlBHc4kL
 7UslRRq+pS0Cnp4VFDOe76Ufs6eX4HgQE+05moAk/7iFfchULsHMjuhOEEvapytVou
 z0OEBCfcKyWl1qCY2H4Hz7yOhSOvDM370odm/Z4E=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7108::1:9])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 tZ29y7t6r8-atWKEcqN; Thu, 30 Apr 2020 16:36:55 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] char-socket: return -1 in case of disconnect during
 tcp_chr_write
Date: Thu, 30 Apr 2020 16:36:16 +0300
Message-Id: <2f783e19d2bfe75946ec677ddd5e979f9a3683d2.1588252862.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1588252861.git.dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1588252861.git.dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:36:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 5.45.199.163
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
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, arei.gonglei@huawei.com,
 fengli@smartx.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, raphael.norwitz@nutanix.com
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
---
 chardev/char-socket.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38..c128cca 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -175,14 +175,16 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
         if (ret < 0 && errno != EAGAIN) {
             if (tcp_chr_read_poll(chr) <= 0) {
                 tcp_chr_disconnect_locked(chr);
-                return len;
+                /* Return an error since we made a disconnect. */
+                return ret;
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


