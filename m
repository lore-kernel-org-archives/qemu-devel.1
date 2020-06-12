Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0142C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 11:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33B320792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 11:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33B320792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjhmW-0004MR-MF
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 07:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjhjs-0002O7-LK
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 07:20:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:33356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjhjq-0006VO-0D
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 07:20:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jjhjn-0005tW-Ev
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 11:20:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 659792E810B
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 11:20:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2020 11:13:31 -0000
From: Gerd Hoffmann <1882851@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: diego-viola kraxel-redhat
X-Launchpad-Bug-Reporter: Diego Viola (diego-viola)
X-Launchpad-Bug-Modifier: Gerd Hoffmann (kraxel-redhat)
References: <159174217343.32241.17743917589333297614.malonedeb@gac.canonical.com>
Message-Id: <20200612111331.6982-1-kraxel@redhat.com>
Subject: [Bug 1882851] [PATCH] drm/virtio: fix unblank
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6e6744b19599cba0e51eba848d9dc0ec2ab09c0c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:25:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1882851 <1882851@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When going through a disable/enable cycle without changing the framebuffer
the optimization added by commit 3954ff10e06e causes the screen stay
blank.  Add a bool to force an update to fix that.

Cc: 1882851@bugs.launchpad.net
Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't ch=
ange")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 +
 drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
 drivers/gpu/drm/virtio/virtgpu_plane.c   | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/=
virtgpu_drv.h
index 7879ff58236f..6d5410d5dd84 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -138,6 +138,7 @@ struct virtio_gpu_output {
 	int cur_x;
 	int cur_y;
 	bool enabled;
+	bool need_update;
 };
 #define drm_crtc_to_virtio_gpu_output(x) \
 	container_of(x, struct virtio_gpu_output, crtc)
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/vir=
tio/virtgpu_display.c
index 2b7e6ae65546..44e9c7b874f5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -99,6 +99,7 @@ static void virtio_gpu_crtc_atomic_enable(struct drm_crtc=
 *crtc,
 	struct virtio_gpu_output *output =3D drm_crtc_to_virtio_gpu_output(crtc);
 =

 	output->enabled =3D true;
+	output->need_update =3D true;
 }
 =

 static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virti=
o/virtgpu_plane.c
index 52d24179bcec..5948031a9ce8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -163,7 +163,8 @@ static void virtio_gpu_primary_plane_update(struct drm_=
plane *plane,
 	    plane->state->src_w !=3D old_state->src_w ||
 	    plane->state->src_h !=3D old_state->src_h ||
 	    plane->state->src_x !=3D old_state->src_x ||
-	    plane->state->src_y !=3D old_state->src_y) {
+	    plane->state->src_y !=3D old_state->src_y ||
+	    output->need_update) {
 		DRM_DEBUG("handle 0x%x, crtc %dx%d+%d+%d, src %dx%d+%d+%d\n",
 			  bo->hw_res_handle,
 			  plane->state->crtc_w, plane->state->crtc_h,
@@ -178,6 +179,7 @@ static void virtio_gpu_primary_plane_update(struct drm_=
plane *plane,
 					   plane->state->src_h >> 16,
 					   plane->state->src_x >> 16,
 					   plane->state->src_y >> 16);
+		output->need_update =3D false;
 	}
 =

 	virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle,
-- =

2.18.4

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882851

Title:
  QEMU video freezes with "Guest disabled display" (virtio driver)

Status in QEMU:
  New

Bug description:
  I am using Arch Linux as my Guest and Host OS, after starting qemu
  with the following command:

    $ qemu-system-x86_64 -enable-kvm -hda arch-zoom.qcow2 -m 4G -vga
  virtio

  and waiting for a screen blank, I get this message:

    Guest disabled display

  And nothing happens after that, I can move the mouse or hit any key,
  and the message is still there.

  I can still reboot the VM but that's not optimal.

  I can reproduce this with the latest QEMU release (5.0.0) or git master, =

  I also tried this with older releases (4.0.0, 3.0.0) and the issue is sti=
ll there.

  I can't reproduce this with other video drivers (std, qxl).

  With std/qxl the screen will blank a bit and then continue as normal.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882851/+subscriptions

