Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAAFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C72F22B4D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 06:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eO/5vYes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C72F22B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBBh7-0006YL-Cs
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 02:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBBgV-00066l-Qn
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:46:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38450
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kBBgT-0001Ce-AC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 02:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598510811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kJlznFq6vxh1OBE29iALNUMP+it7Bix+4YNxmkdBaLY=;
 b=eO/5vYes8iBnxgbX3t4O0b8FEDB9xDSDAIoKBwVtGKHj+FIZSAKnTWByD5JSrFqN1JFJnu
 vFss5T9MV2mEmHNdjVsbh5SbfjqHMn35Q+f1Idhv6vb40KV8zHYtdpqROpD22NEOlpPZI6
 bAHANBJ051NEZF4CcsWrIFnymYDjNh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-j6lrIf8TMeqL6wXjfwh3rA-1; Thu, 27 Aug 2020 02:46:48 -0400
X-MC-Unique: j6lrIf8TMeqL6wXjfwh3rA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 607DD85C733
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:46:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CE0E1972A;
 Thu, 27 Aug 2020 06:46:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 40ECE942; Thu, 27 Aug 2020 08:46:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: fix qxl module build
Date: Thu, 27 Aug 2020 08:46:29 +0200
Message-Id: <20200827064629.23080-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:42:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop qxl object from softmmu source set, it is built as module.

Also drop CONFIG_QXL condition from qxl_ss.add.  First because it is
pointless, the whole thing is wrapped into "has_key('CONFIG_QXL')".
Second because it doesn't work for some reason.  Looks like the source
files are not added to the set for some reason and we end up with an
empty hw-display-qxl.so.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/meson.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/display/meson.build b/hw/display/meson.build
index 78adaf9db463..becbedd24c23 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -41,12 +41,10 @@ specific_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 
 if config_all_devices.has_key('CONFIG_QXL')
   qxl_ss = ss.source_set()
-  qxl_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
+  qxl_ss.add(files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
   hw_display_modules += {'qxl': qxl_ss}
 endif
 
-softmmu_ss.add(when: 'CONFIG_QXL', if_true: files('qxl.c', 'qxl-logger.c', 'qxl-render.c'))
-
 softmmu_ss.add(when: 'CONFIG_DPCD', if_true: files('dpcd.c'))
 softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx_dp.c'))
 
-- 
2.27.0


