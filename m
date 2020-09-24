Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4274C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1AE2388A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8rfklcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1AE2388A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNoJ-0005Kg-4Y
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTn-00013L-1r
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTk-00063k-By
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDz7rvUfqEw9N2lF4clALKh5sIsbFpsUABaYQ29sh/A=;
 b=W8rfklcfJNlU6lPR1wS8q9qwxX8JAu4YH64wcgXsuIEoM5B0DoPsEcuDPvUcCH2Lj4GRVo
 4Mum8V9wEZ3u0WBogeIPRZypwEPH/KLs7n9jgfxhwSuN7oMO2hKM+PfLNZ+iWH5pPLlMuc
 5m3VtMCOcc8K27qnvNbZ5aTSw3xf9NU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-22RBhs4KNPqMKEIPbmVfHA-1; Thu, 24 Sep 2020 05:23:49 -0400
X-MC-Unique: 22RBhs4KNPqMKEIPbmVfHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500EC800471
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0299755764;
 Thu, 24 Sep 2020 09:23:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/92] meson: report accelerator support
Date: Thu, 24 Sep 2020 05:22:20 -0400
Message-Id: <20200924092314.1722645-39-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
index 6abb8bbcb1..fedf44ed79 100644
--- a/meson.build
+++ b/meson.build
@@ -583,6 +583,7 @@ endforeach
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
 minikconf = find_program('scripts/minikconf.py')
+config_all = {}
 config_all_devices = {}
 config_all_disas = {}
 config_devices_mak_list = []
@@ -638,6 +639,14 @@ kconfig_external_symbols = [
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
 
@@ -666,6 +675,11 @@ foreach target : target_dirs
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
 
@@ -710,7 +724,7 @@ endforeach
 # targets that are not built for this compilation.  The CONFIG_ALL
 # pseudo symbol replaces it.
 
-config_all = config_all_devices
+config_all += config_all_devices
 config_all += config_host
 config_all += config_all_disas
 config_all += {
@@ -1537,16 +1551,15 @@ summary_info += {'Linux AIO support': config_host.has_key('CONFIG_LINUX_AIO')}
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



