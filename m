Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0509AC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C3B208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM+HO+TC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C3B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfZz-0004Hl-OV
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHX-0005cj-Iy
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHH-0007RZ-0B
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JOd2bsZPbfbEwnQisBt2RsFYgrrwD7abZfi5rOVHUc=;
 b=CM+HO+TC1v7wTrjDGzrFMTUXOf0tC/ASuOsyJlAaeV9d/NnIgxg8p4EBjSqNZCPfa9kvTm
 wRZw5y4u8C7OJ8tv98ExdoBhvuJMOEt8utE8dWpAMcZXe9IVjUXH+YJASForwd4DtwWSSu
 utFbyAKf2Bb0POksW2K4z9iUxhm/SqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-M-7LMJvxM0qEXU46A2HyCA-1; Sat, 19 Sep 2020 11:59:49 -0400
X-MC-Unique: M-7LMJvxM0qEXU46A2HyCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8E5110066FC
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 782085576A;
 Sat, 19 Sep 2020 15:59:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/57] meson: report accelerator support
Date: Sat, 19 Sep 2020 11:58:59 -0400
Message-Id: <20200919155916.1046398-41-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:41:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Andrew Jones <drjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note that the "real" support is reported.  A configuration like
--disable-system --enable-kvm will report "no" for "KVM support" because
no KVM-supported target is being compiled.

Reported-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index f5c9c04e40..d5ab4bde2b 100644
--- a/meson.build
+++ b/meson.build
@@ -589,6 +589,7 @@ endforeach
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
 minikconf = find_program('scripts/minikconf.py')
+config_all = {}
 config_all_devices = {}
 config_all_disas = {}
 config_devices_mak_list = []
@@ -644,6 +645,14 @@ kconfig_external_symbols = [
 ]
 ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
 
+accel_symbols = [
+  'CONFIG_KVM',
+  'CONFIG_HAX',
+  'CONFIG_HVF',
+  'CONFIG_TCG',
+  'CONFIG_WHPX'
+]
+
 foreach target : target_dirs
   config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
 
@@ -672,6 +681,11 @@ foreach target : target_dirs
       config_target_data.set(k, v)
     endif
   endforeach
+  foreach sym: accel_symbols
+    if config_target.has_key(sym)
+      config_all += { sym: 'y' }
+    endif
+  endforeach
   config_target_h += {target: configure_file(output: target + '-config-target.h',
                                                configuration: config_target_data)}
 
@@ -716,7 +730,7 @@ endforeach
 # targets that are not built for this compilation.  The CONFIG_ALL
 # pseudo symbol replaces it.
 
-config_all = config_all_devices
+config_all += config_all_devices
 config_all += config_host
 config_all += config_all_disas
 config_all += {
@@ -1543,16 +1557,15 @@ summary_info += {'Linux AIO support': config_host.has_key('CONFIG_LINUX_AIO')}
 summary_info += {'Linux io_uring support': config_host.has_key('CONFIG_LINUX_IO_URING')}
 summary_info += {'ATTR/XATTR support': config_host.has_key('CONFIG_ATTR')}
 summary_info += {'Install blobs':     config_host.has_key('INSTALL_BLOBS')}
-# TODO: add back KVM/HAX/HVF/WHPX/TCG
-#summary_info += {'KVM support':       have_kvm'}
-#summary_info += {'HAX support':       have_hax'}
-#summary_info += {'HVF support':       have_hvf'}
-#summary_info += {'WHPX support':      have_whpx'}
-#summary_info += {'TCG support':       have_tcg'}
-#if get_option('tcg')
-#  summary_info += {'TCG debug enabled': config_host.has_key('CONFIG_DEBUG_TCG')}
-#  summary_info += {'TCG interpreter':   config_host.has_key('CONFIG_TCG_INTERPRETER')}
-#endif
+summary_info += {'KVM support':       config_all.has_key('CONFIG_KVM')}
+summary_info += {'HAX support':       config_all.has_key('CONFIG_HAX')}
+summary_info += {'HVF support':       config_all.has_key('CONFIG_HVF')}
+summary_info += {'WHPX support':      config_all.has_key('CONFIG_WHPX')}
+summary_info += {'TCG support':       config_all.has_key('CONFIG_TCG')}
+if config_all.has_key('CONFIG_TCG')
+  summary_info += {'TCG debug enabled': config_host.has_key('CONFIG_DEBUG_TCG')}
+  summary_info += {'TCG interpreter':   config_host.has_key('CONFIG_TCG_INTERPRETER')}
+endif
 summary_info += {'malloc trim support': has_malloc_trim}
 summary_info += {'RDMA support':      config_host.has_key('CONFIG_RDMA')}
 summary_info += {'PVRDMA support':    config_host.has_key('CONFIG_PVRDMA')}
-- 
2.26.2



