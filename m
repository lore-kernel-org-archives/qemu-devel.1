Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659ADC54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE93206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="A7qdHfAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE93206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4i2-0001pE-Bt
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jY4hI-0000mb-HD; Mon, 11 May 2020 05:26:04 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:47948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jY4hE-0005Ds-OS; Mon, 11 May 2020 05:26:02 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 954962E14F7;
 Mon, 11 May 2020 12:25:54 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 ZXmsrMc4VS-PpAKws1Z; Mon, 11 May 2020 12:25:54 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589189154; bh=pX2lP3obviLVGwwzxt6isdkDCUTdKcep+W4ykUgk8Bc=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=A7qdHfAMhdBkhwzjmS9T82czLznH3pdmVH5X9uUKObaBBTvUfJVM8kv7dyEAjOfM/
 N6COta3R8oLM1/ny4qycoWXBUxbIe/TgqXJRfMs8VAtobotC4QcnOLTCFRCpNs55tg
 Lthh6FGrkGbNpZdKcYO7H8yMWINPY4lEACQWEtIQ=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7214::1:7])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 E3CEgGVtP9-PpWulvLv; Mon, 11 May 2020 12:25:51 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Mon, 11 May 2020 12:25:49 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
Message-ID: <20200511092541.GA27558@dimastep-nix>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed805147-d87d-5ac2-3196-367981b0679c@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 04:55:47
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
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, arei.gonglei@huawei.com, raphael.norwitz@nutanix.com,
 fengli@smartx.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 11, 2020 at 11:15:53AM +0800, Jason Wang wrote:
> 
> On 2020/4/30 下午9:36, Dima Stepanov wrote:
> >If vhost-user daemon is used as a backend for the vhost device, then we
> >should consider a possibility of disconnect at any moment. If such
> >disconnect happened in the vhost_migration_log() routine the vhost
> >device structure will be clean up.
> >At the start of the vhost_migration_log() function there is a check:
> >   if (!dev->started) {
> >       dev->log_enabled = enable;
> >       return 0;
> >   }
> >To be consistent with this check add the same check after calling the
> >vhost_dev_set_log() routine. This in general help not to break a
> >migration due the assert() message. But it looks like that this code
> >should be revised to handle these errors more carefully.
> >
> >In case of vhost-user device backend the fail paths should consider the
> >state of the device. In this case we should skip some function calls
> >during rollback on the error paths, so not to get the NULL dereference
> >errors.
> >
> >Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> >---
> >  hw/virtio/vhost.c | 39 +++++++++++++++++++++++++++++++++++----
> >  1 file changed, 35 insertions(+), 4 deletions(-)
> >
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index 3ee50c4..d5ab96d 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -787,6 +787,17 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
> >  static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> >  {
> >      int r, i, idx;
> >+
> >+    if (!dev->started) {
> >+        /*
> >+         * If vhost-user daemon is used as a backend for the
> >+         * device and the connection is broken, then the vhost_dev
> >+         * structure will be reset all its values to 0.
> >+         * Add additional check for the device state.
> >+         */
> >+        return -1;
> >+    }
> >+
> >      r = vhost_dev_set_features(dev, enable_log);
> >      if (r < 0) {
> >          goto err_features;
> >@@ -801,12 +812,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
> >      }
> >      return 0;
> >  err_vq:
> >-    for (; i >= 0; --i) {
> >+    /*
> >+     * Disconnect with the vhost-user daemon can lead to the
> >+     * vhost_dev_cleanup() call which will clean up vhost_dev
> >+     * structure.
> >+     */
> >+    for (; dev->started && (i >= 0); --i) {
> >          idx = dev->vhost_ops->vhost_get_vq_index(
> 
> 
> Why need the check of dev->started here, can started be modified outside
> mainloop? If yes, I don't get the check of !dev->started in the beginning of
> this function.
> 
No dev->started can't change outside the mainloop. The main problem is
only for the vhost_user_blk daemon. Consider the case when we
successfully pass the dev->started check at the beginning of the
function, but after it we hit the disconnect on the next call on the
second or third iteration:
     r = vhost_virtqueue_set_addr(dev, dev->vqs + i, idx, enable_log);
The unix socket backend device will call the disconnect routine for this
device and reset the structure. So the structure will be reset (and
dev->started set to false) inside this set_addr() call. So
we shouldn't call the clean up calls because this virtqueues were clean
up in the disconnect call. But we should protect these calls somehow, so
it will not hit SIGSEGV and we will be able to pass migration.

Just to summarize it:
For the vhost-user-blk devices we ca hit clean up calls twice in case of
vhost disconnect:
1. The first time during the disconnect process. The clean up is called
inside it.
2. The second time during roll back clean up.
So if it is the case we should skip p2.

> 
> >dev, dev->vq_index + i);
> >          vhost_virtqueue_set_addr(dev, dev->vqs + i, idx,
> >                                   dev->log_enabled);
> >      }
> >-    vhost_dev_set_features(dev, dev->log_enabled);
> >+    if (dev->started) {
> >+        vhost_dev_set_features(dev, dev->log_enabled);
> >+    }
> >  err_features:
> >      return r;
> >  }
> >@@ -832,7 +850,15 @@ static int vhost_migration_log(MemoryListener *listener, int enable)
> >      } else {
> >          vhost_dev_log_resize(dev, vhost_get_log_size(dev));
> >          r = vhost_dev_set_log(dev, true);
> >-        if (r < 0) {
> >+        /*
> >+         * The dev log resize can fail, because of disconnect
> >+         * with the vhost-user-blk daemon. Check the device
> >+         * state before calling the vhost_dev_set_log()
> >+         * function.
> >+         * Don't return error if device isn't started to be
> >+         * consistent with the check above.
> >+         */
> >+        if (dev->started && r < 0) {
> >              return r;
> >          }
> >      }
> >@@ -1739,7 +1765,12 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> >  fail_log:
> >      vhost_log_put(hdev, false);
> >  fail_vq:
> >-    while (--i >= 0) {
> >+    /*
> >+     * Disconnect with the vhost-user daemon can lead to the
> >+     * vhost_dev_cleanup() call which will clean up vhost_dev
> >+     * structure.
> >+     */
> >+    while ((--i >= 0) && (hdev->started)) {
> >          vhost_virtqueue_stop(hdev,
> >                               vdev,
> >                               hdev->vqs + i,
> 
> 
> This should be a separate patch.
Do you mean i should split this patch to two patches?

Thanks.

> 
> Thanks
> 

