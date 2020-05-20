Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C337EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F97120671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="wWYalFkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F97120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbR5u-0005Nw-PH
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jbR2h-00081f-QJ; Wed, 20 May 2020 11:54:03 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:46292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jbR2g-0001HB-3F; Wed, 20 May 2020 11:54:03 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 019122E15A0;
 Wed, 20 May 2020 18:53:57 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 MrD3iOv6lW-rsdmkE4h; Wed, 20 May 2020 18:53:56 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589990036; bh=SEun7ESiWH3czDdIa+sUhnBLSFJMVA81918bgD9tv/k=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=wWYalFkDnGKFSNHDbV0koQbtahnLTPDzIrNAwSkY+nS7DPh7xkAFOmk4S0BrpTd1Z
 U7KF28kZaZL/oAyt1LaR/pR6rzUHds+qfEvtDPeDNZRkCw/HPMxz/uKI1x8cFkT1SH
 lQzM1jX/OMcsXQB4/95Mexgl8nUpTwiXOfqos3t8=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1221::1:11])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 wLIWnjIOwO-rsXeYWgN; Wed, 20 May 2020 18:53:54 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] char-socket: return -1 in case of disconnect during
 tcp_chr_write
Date: Wed, 20 May 2020 18:53:12 +0300
Message-Id: <aeb7806bfc945faadf09f64dcfa30f59de3ac053.1589989075.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1589989075.git.dimastep@yandex-team.ru>
References: <cover.1589989075.git.dimastep@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <cover.1589989075.git.dimastep@yandex-team.ru>
References: <cover.1589989075.git.dimastep@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 11:53:57
X-ACL-Warn: Detected OS   = ???
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


