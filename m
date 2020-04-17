Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1418CC352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1AE7208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="YyGTOnWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AE7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPO4f-0001Mz-Na
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jPO34-0000Cx-Mj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jPO32-0000WE-Cs
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:16:38 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jPO32-0000Ut-6f
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:16:36 -0400
Received: by mail-pg1-x542.google.com with SMTP id 2so884869pgp.11
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:to:cc:subject:date:message-id
 :content-transfer-encoding;
 bh=j2LhT5uQ0fJJClfhlcXSfO9u/S+aep09+Z3mpktX+PU=;
 b=YyGTOnWrudM/DAUdCRUiKOVq1yRU0Ch5DJc4ykJAxLORRqcz/xOkhBYKu0jPBS8Mvl
 pYmopghSeA/60aq9uXRJwBYS0pcB6CIWjOzxfqJNnAoU1zhDyDYQAwMIH6CCixsyPQbt
 nVRCpmjzwk7f72XD/Y56cM/5ZxKvaKbyayewwMGZCKcMIhYslQihbnrnYpn2n98bMDAs
 9u43hdkv5WdMibAI0kLD6l8bXgUrMvX841l7ny4gYRi5QMwtZSO2hW6yUggUxGFlG78E
 XCIWj4m3k3AMJq83oneHog2BVD0mDqAubwB/E6AFDSvXVTlpxkk6hfcag8UWgBomt5y5
 dsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :content-transfer-encoding;
 bh=j2LhT5uQ0fJJClfhlcXSfO9u/S+aep09+Z3mpktX+PU=;
 b=GLR41YGgOxGFIUZtlAPr0iufq8styAAdaJcGBDRjbFxTttaWaxjk6kOTfukMjZymrt
 MPiRPzo64h6jCOv3WO0+8Ut33Xwn9zPBKURMBeAfcTljNq/rEpwcns5w9NP15Munwv9f
 +rmuvd4bhtb/hc0oFoBsmFfo0nkz7yvvq0q/KaAaskHwwRXxabfSt2cZyOAJoDpdtQMi
 J2opmBD9t41OqwDzy6MUp4v7zK9lNlUviFKq1OEslQq3drUYQ+DcM+rB7Qi7gSSiVCKi
 erQg6iJPO4iJMtLo+uVs3xL0OWpqroXNdtwgArhiCB80zcSrepRSmXEn+54+SdGmi3tK
 pJhQ==
MIME-Version: 1.0
X-Gm-Message-State: AGi0PuZ1QVMawBjSk4b6OzREsQxqFqpIhjNUOB57T5PvoMEWaAbpEKhk
 Rdy0pCyWhT6d5B8dbqyhJz67228CVk9C+q6B1KDQbggEqsEGCadapNlKPg88+q3qJOHl1RfNHU6
 6c2Qx35Ot
X-Google-Smtp-Source: APiQypIiD4mavCyOYKSUvR0fIXuASHr+hE2OddnsIHLSckBxO1eAfmLuZkRKThc80310+zvrGIgwbw==
X-Received: by 2002:a63:4646:: with SMTP id v6mr2412977pgk.426.1587118594438; 
 Fri, 17 Apr 2020 03:16:34 -0700 (PDT)
Received: from 31_216.localdomain ([47.89.19.149])
 by smtp.gmail.com with ESMTPSA id k12sm18952074pfk.46.2020.04.17.03.16.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Apr 2020 03:16:33 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] vhost-user-blk: fix invalid memory access
Date: Fri, 17 Apr 2020 18:17:07 +0800
Message-Id: <20200417101707.14467-1-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: lifeng1519@gmail.com, Li Feng <fengli@smartx.com>, fanyang@smartx.com,
 kyle@smartx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

when s->inflight is freed, vhost_dev_free_inflight may try to access
s->inflight->addr, it will retrigger the following issue.

=3D=3D7309=3D=3DERROR: AddressSanitizer: heap-use-after-free on address 0x6=
04001020d18 at pc 0x555555ce948a bp 0x7fffffffb170 sp 0x7fffffffb160
READ of size 8 at 0x604001020d18 thread T0
    #0 0x555555ce9489 in vhost_dev_free_inflight /root/smartx/qemu-el7/qemu=
-test/hw/virtio/vhost.c:1473
    #1 0x555555cd86eb in virtio_reset /root/smartx/qemu-el7/qemu-test/hw/vi=
rtio/virtio.c:1214
    #2 0x5555560d3eff in virtio_pci_reset hw/virtio/virtio-pci.c:1859
    #3 0x555555f2ac53 in device_set_realized hw/core/qdev.c:893
    #4 0x5555561d572c in property_set_bool qom/object.c:1925
    #5 0x5555561de8de in object_property_set_qobject qom/qom-qobject.c:27
    #6 0x5555561d99f4 in object_property_set_bool qom/object.c:1188
    #7 0x555555e50ae7 in qdev_device_add /root/smartx/qemu-el7/qemu-test/qd=
ev-monitor.c:626
    #8 0x555555e51213 in qmp_device_add /root/smartx/qemu-el7/qemu-test/qde=
v-monitor.c:806
    #9 0x555555e8ff40 in hmp_device_add /root/smartx/qemu-el7/qemu-test/hmp=
.c:1951
    #10 0x555555be889a in handle_hmp_command /root/smartx/qemu-el7/qemu-tes=
t/monitor.c:3404
    #11 0x555555beac8b in monitor_command_cb /root/smartx/qemu-el7/qemu-tes=
t/monitor.c:4296
    #12 0x555556433eb7 in readline_handle_byte util/readline.c:393
    #13 0x555555be89ec in monitor_read /root/smartx/qemu-el7/qemu-test/moni=
tor.c:4279
    #14 0x5555563285cc in tcp_chr_read chardev/char-socket.c:470
    #15 0x7ffff670b968 in g_main_context_dispatch (/lib64/libglib-2.0.so.0+=
0x4a968)
    #16 0x55555640727c in glib_pollfds_poll util/main-loop.c:215
    #17 0x55555640727c in os_host_main_loop_wait util/main-loop.c:238
    #18 0x55555640727c in main_loop_wait util/main-loop.c:497
    #19 0x555555b2d0bf in main_loop /root/smartx/qemu-el7/qemu-test/vl.c:20=
13
    #20 0x555555b2d0bf in main /root/smartx/qemu-el7/qemu-test/vl.c:4776
    #21 0x7fffdd2eb444 in __libc_start_main (/lib64/libc.so.6+0x22444)
    #22 0x555555b3767a  (/root/smartx/qemu-el7/qemu-test/x86_64-softmmu/qem=
u-system-x86_64+0x5e367a)

0x604001020d18 is located 8 bytes inside of 40-byte region [0x604001020d10,=
0x604001020d38)
freed by thread T0 here:
    #0 0x7ffff6f00508 in __interceptor_free (/lib64/libasan.so.4+0xde508)
    #1 0x7ffff671107d in g_free (/lib64/libglib-2.0.so.0+0x5007d)

previously allocated by thread T0 here:
    #0 0x7ffff6f00a88 in __interceptor_calloc (/lib64/libasan.so.4+0xdea88)
    #1 0x7ffff6710fc5 in g_malloc0 (/lib64/libglib-2.0.so.0+0x4ffc5)

SUMMARY: AddressSanitizer: heap-use-after-free /root/smartx/qemu-el7/qemu-t=
est/hw/virtio/vhost.c:1473 in vhost_dev_free_inflight
Shadow bytes around the buggy address:
  0x0c08801fc150: fa fa 00 00 00 00 04 fa fa fa fd fd fd fd fd fa
  0x0c08801fc160: fa fa fd fd fd fd fd fd fa fa 00 00 00 00 04 fa
  0x0c08801fc170: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 04 fa
  0x0c08801fc180: fa fa 00 00 00 00 00 01 fa fa 00 00 00 00 00 01
  0x0c08801fc190: fa fa 00 00 00 00 00 fa fa fa 00 00 00 00 04 fa
=3D>0x0c08801fc1a0: fa fa fd[fd]fd fd fd fa fa fa fd fd fd fd fd fa
  0x0c08801fc1b0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
  0x0c08801fc1c0: fa fa 00 00 00 00 00 fa fa fa fd fd fd fd fd fd
  0x0c08801fc1d0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
  0x0c08801fc1e0: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fd
  0x0c08801fc1f0: fa fa 00 00 00 00 00 01 fa fa fd fd fd fd fd fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D7309=3D=3DABORTING

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/block/vhost-user-blk.c | 4 ++++
 hw/virtio/vhost.c         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 776b9af3eb..19e79b96e4 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -463,7 +463,9 @@ reconnect:
=20
 virtio_err:
     g_free(s->vhost_vqs);
+    s->vhost_vqs =3D NULL;
     g_free(s->inflight);
+    s->inflight =3D NULL;
     for (i =3D 0; i < s->num_queues; i++) {
         virtio_delete_queue(s->virtqs[i]);
     }
@@ -484,7 +486,9 @@ static void vhost_user_blk_device_unrealize(DeviceState=
 *dev, Error **errp)
     vhost_dev_cleanup(&s->dev);
     vhost_dev_free_inflight(s->inflight);
     g_free(s->vhost_vqs);
+    s->vhost_vqs =3D NULL;
     g_free(s->inflight);
+    s->inflight =3D NULL;
=20
     for (i =3D 0; i < s->num_queues; i++) {
         virtio_delete_queue(s->virtqs[i]);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 01ebe12f28..aff98a0ede 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1514,7 +1514,7 @@ void vhost_dev_set_config_notifier(struct vhost_dev *=
hdev,
=20
 void vhost_dev_free_inflight(struct vhost_inflight *inflight)
 {
-    if (inflight->addr) {
+    if (inflight && inflight->addr) {
         qemu_memfd_free(inflight->addr, inflight->size, inflight->fd);
         inflight->addr =3D NULL;
         inflight->fd =3D -1;
--=20
2.11.0


--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=B1=BE=D3=CA=CF=E4=CE=AA=B1=B1=BE=A9=D6=BE=C1=E8=BA=A3=C4=C9=BF=C6=BC=BC=D3=
=D0=CF=DE=B9=AB=CB=BE=A3=A8SmartX=A3=A9=B9=A4=D7=F7=D3=CA=CF=E4. =C8=E7=B1=
=BE=D3=CA=CF=E4=B7=A2=B3=F6=B5=C4=D3=CA=BC=FE=D3=EB=B9=A4=D7=F7=CE=DE=B9=D8=
,=B8=C3=D3=CA=BC=FE=CE=B4=B5=C3=B5=BD=B1=BE=B9=AB=CB=BE=C8=CE=BA=CE=B5=C4=
=C3=F7=CA=BE=BB=F2=C4=AC=CA=BE=B5=C4=CA=DA=C8=A8.



