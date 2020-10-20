Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E02EC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697DF22242
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLOlv/Sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697DF22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuiA-0004iw-CX
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUuP5-0005Zb-2o
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUuP1-0007Ay-Vn
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603210941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JcM4j/FPegasVk/W/u7CO0eXiTsAR3utx4rXmn1cH1Q=;
 b=GLOlv/Shl/0GWTSvhEJzuq6+kBUV+N74S3yRYcRQlbOijQbv+xFuYYaoNZA2Jz3Rl+XoHk
 tTvv290AuQQH9oj4Ldz/X1n4gB4rpprMDkyps9RfDi89ga2cUaDj2QjIx4Wxw6uQu4Zj2c
 61/lDPSsMBkh3NM4B0N+MsZMR16t7LI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-5yvAsaWxO2qH8ia5dOsK_A-1; Tue, 20 Oct 2020 12:22:18 -0400
X-MC-Unique: 5yvAsaWxO2qH8ia5dOsK_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B81B11074656
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 16:22:17 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-206.ams2.redhat.com
 [10.36.114.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B2D96EF59;
 Tue, 20 Oct 2020 16:22:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] os: deprecate the -enable-fips option and QEMU's FIPS
 enforcement
Date: Tue, 20 Oct 2020 17:22:11 +0100
Message-Id: <20201020162211.401204-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The -enable-fips option was added a long time ago to prevent the use of
single DES when VNC when FIPS mode is enabled. It should never have been
added, because apps are supposed to unconditionally honour FIPS mode
based on the '/proc/sys/crypto/fips_enabled' file contents.

In addition there is more to achieving FIPS compliance than merely
blocking use of certain algorithms. Those algorithms which are used
need to perform self-tests at runtime.

QEMU's built-in cryptography provider has no support for self-tests,
and neither does the nettle library.

If QEMU is required to be used in a FIPS enabled host, then it must be
built with the libgcrypt library enabled, which will unconditionally
enforce FIPS compliance in any algorithm usage.

Thus there is no need to keep either the -enable-fips option in QEMU, or
QEMU's internal FIPS checking methods.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/deprecated.rst | 11 +++++++++++
 os-posix.c                 |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 905628f3a0..faa2bc49b1 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -158,6 +158,17 @@ devices.  It is possible to use drives the board doesn't pick up with
 -device.  This usage is now deprecated.  Use ``if=none`` instead.
 
 
+``--enable-fips`` (since 5.2)
+
+This option restricts usage of certain cryptographic algorithms when
+the host is operating in FIPS mode.
+
+If FIPS compliance is required, QEMU should be built with the ``libgcrypt``
+library enabled as a cryptography provider.
+
+Neither the ``nettle`` library, or the built-in cryptography provider are
+supported on FIPS enabled hosts.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/os-posix.c b/os-posix.c
index 1de2839554..a6846f51c1 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -153,6 +153,9 @@ int os_parse_cmd_args(int index, const char *optarg)
         break;
 #if defined(CONFIG_LINUX)
     case QEMU_OPTION_enablefips:
+        warn_report("-enable-fips is deprecated, please build QEMU with "
+                    "the `libgcrypt` library as the cryptography provider "
+                    "to enable FIPS compliance");
         fips_set_state(true);
         break;
 #endif
-- 
2.26.2


