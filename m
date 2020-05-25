Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A32C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 475E92068D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="c040eo1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 475E92068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8Tp-0006fG-EN
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jd8Sn-00053y-GI; Mon, 25 May 2020 04:28:01 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:58280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jd8Si-0003Tb-Kk; Mon, 25 May 2020 04:27:58 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 8FB002E148D;
 Mon, 25 May 2020 11:27:50 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net
 (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 FxQuT7vOaJ-Rl2aBwer; Mon, 25 May 2020 11:27:50 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590395270; bh=gMhfxGcFdwdMevrhHzJ8BX4KCxU/0rt3FHhjZoSjczs=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=c040eo1BrBQQzbNHqdLjjygiFqZfOYReON+woDWLgNh3dSFX89EPkqcVTb8Kbm+re
 1RGlSzuhKfRixCX1YLyPA77e/RX5u9fLH52fHSW3gDdJZFX4TCqHkRxxSRuEAgaWHn
 xetcmmPngbyNtGQk4qvoOnBNk/ELBzrjsrx8BpXw=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:105::1:6])
 by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 n1l1kfpX9v-RkWKceGS; Mon, 25 May 2020 11:27:47 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Mon, 25 May 2020 11:27:45 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/2] vhost-user-blk: delay vhost_user_blk_disconnect
Message-ID: <20200525082745.GA7303@dimastep-nix>
References: <cover.1589989075.git.dimastep@yandex-team.ru>
 <0dfb37f8728aba26c8d6c117018332a5b7dc9b56.1589989075.git.dimastep@yandex-team.ru>
 <6621f54b-45c1-c4da-04ef-42379a4f33c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6621f54b-45c1-c4da-04ef-42379a4f33c0@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=5.45.199.163;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 04:27:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_PASS=-0.001,
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
 qemu-devel@nongnu.org, mreitz@redhat.com, fengli@smartx.com,
 yc-core@yandex-team.ru, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 raphael.norwitz@nutanix.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 11:31:16AM +0800, Jason Wang wrote:
> 
> On 2020/5/20 下午11:53, Dima Stepanov wrote:
> >A socket write during vhost-user communication may trigger a disconnect
> >event, calling vhost_user_blk_disconnect() and clearing all the
> >vhost_dev structures holding data that vhost-user functions expect to
> >remain valid to roll back initialization correctly. Delay the cleanup to
> >keep vhost_dev structure valid.
> >There are two possible states to handle:
> >1. RUN_STATE_PRELAUNCH: skip bh oneshot call and perform disconnect in
> >the caller routine.
> >2. RUN_STATE_RUNNING: delay by using bh
> >
> >BH changes are based on the similar changes for the vhost-user-net
> >device:
> >   commit e7c83a885f865128ae3cf1946f8cb538b63cbfba
> >   "vhost-user: delay vhost_user_stop"
> 
> 
> It's better to explain why we don't need to deal with case 1 in the
> vhost-user-net case.
In general i believe we should have similar change for all the
vhost-user devices. But i don't have a tests for it right now. So as we
discussed in v2 e-mail thread, i decided to stick only with the
vhost-user-blk changes. Also it seems to me that the problem is a little
bit wider, we have the changes like:
 - only vhost-user-net: e7c83a885f865128ae3cf1946f8cb538b63cbfba
   "vhost-user: delay vhost_user_stop"
 - only vhost-user-blk: 9d283f85d755285bf1b1bfcb1ab275239dbf2c7b
   "fix vhost_user_blk_watch crash"
 - only vhost-user-blk: my change
At least what i knew (maybe more, because i can miss smth). So maybe
this "vhost_user_event()" routine should be generic for all vhost-user
devices with the internal method calls to specific devices. I want to
try making a rework for this, but don't want to do it in this patch set.
Because it will require more investigation and testing, since more
devices will be touched during refactoring.

> 
> And do we still need patch 1 if we had this patch??
Yes, we still need it. The first patch is about getting an error from
the low level to the upper initialization error. So for example when we
call smth like get_config() and failed because of disconnect, we will stop
initialization. Without patch 1 we will try to call next initialization
function and such behaviour looks incorrect.

Thanks, Dima.

No other comments mixed in below.

> 
> Thanks
> 
> 
> >
> >Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> >---
> >  hw/block/vhost-user-blk.c | 49 +++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 43 insertions(+), 6 deletions(-)
> >
> >diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> >index 9d8c0b3..447fc9c 100644
> >--- a/hw/block/vhost-user-blk.c
> >+++ b/hw/block/vhost-user-blk.c
> >@@ -337,11 +337,6 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >      VHostUserBlk *s = VHOST_USER_BLK(vdev);
> >-    if (!s->connected) {
> >-        return;
> >-    }
> >-    s->connected = false;
> >-
> >      if (s->dev.started) {
> >          vhost_user_blk_stop(vdev);
> >      }
> >@@ -349,6 +344,19 @@ static void vhost_user_blk_disconnect(DeviceState *dev)
> >      vhost_dev_cleanup(&s->dev);
> >  }
> >+static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
> >+
> >+static void vhost_user_blk_chr_closed_bh(void *opaque)
> >+{
> >+    DeviceState *dev = opaque;
> >+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >+    VHostUserBlk *s = VHOST_USER_BLK(vdev);
> >+
> >+    vhost_user_blk_disconnect(dev);
> >+    qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, vhost_user_blk_event,
> >+            NULL, opaque, NULL, true);
> >+}
> >+
> >  static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
> >  {
> >      DeviceState *dev = opaque;
> >@@ -363,7 +371,28 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
> >          }
> >          break;
> >      case CHR_EVENT_CLOSED:
> >-        vhost_user_blk_disconnect(dev);
> >+        /*
> >+         * A close event may happen during a read/write, but vhost
> >+         * code assumes the vhost_dev remains setup, so delay the
> >+         * stop & clear. There are two possible paths to hit this
> >+         * disconnect event:
> >+         * 1. When VM is in the RUN_STATE_PRELAUNCH state. The
> >+         * vhost_user_blk_device_realize() is a caller.
> >+         * 2. In tha main loop phase after VM start.
> >+         *
> >+         * For p2 the disconnect event will be delayed. We can't
> >+         * do the same for p1, because we are not running the loop
> >+         * at this moment. So just skip this step and perform
> >+         * disconnect in the caller function.
> >+         */
> >+        if (s->connected && runstate_is_running()) {
> >+            AioContext *ctx = qemu_get_current_aio_context();
> >+
> >+            qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, NULL, NULL,
> >+                    NULL, NULL, false);
> >+            aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque);
> >+        }
> >+        s->connected = false;
> >          break;
> >      case CHR_EVENT_BREAK:
> >      case CHR_EVENT_MUX_IN:
> >@@ -428,6 +457,14 @@ reconnect:
> >      ret = vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
> >                                 sizeof(struct virtio_blk_config));
> >+    if (!s->connected) {
> >+        /*
> >+         * Perform disconnect before making reconnect. More detailed
> >+         * comment why it was delayed is in the vhost_user_blk_event()
> >+         * routine.
> >+         */
> >+        vhost_user_blk_disconnect(dev);
> >+    }
> >      if (ret < 0) {
> >          error_report("vhost-user-blk: get block config failed");
> >          goto reconnect;
> 

