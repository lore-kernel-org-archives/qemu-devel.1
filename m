Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE811C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70AAC22209
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fushdf6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AAC22209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVwA-0008TL-CW
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVug-0006eM-H7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33648)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVue-00087f-5u
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FSe9+N7Ey81R37g/nLUGGPJ15xAAJ5ghXf96mBoZyc=;
 b=fushdf6irO1IC/Yqmc9Zmq7kligV/O2WMIqkEIfZmeuf0q7E8YY//Me+GqCtS1bre9eJl/
 H5fViKG4Gy0K7TiIfnj6zK/e5byLLOMQ2GR6ijoiOGXFfgDiODovvD/FiPOnSTFitgSrj4
 BBnH5wpYwBkAxoZMsOjiVXacFypgwGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-r5sHGWLcN0uUJEv7Kokiww-1; Wed, 16 Sep 2020 07:47:45 -0400
X-MC-Unique: r5sHGWLcN0uUJEv7Kokiww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 697B780EF84;
 Wed, 16 Sep 2020 11:47:44 +0000 (UTC)
Received: from thuth.com (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 282FB5DE4A;
 Wed, 16 Sep 2020 11:47:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/24] qga/commands-win32: Fix problem with redundant protype
 declaration
Date: Wed, 16 Sep 2020 13:47:13 +0200
Message-Id: <20200916114731.102080-7-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-1-thuth@redhat.com>
References: <20200916114731.102080-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When compiling QEMU with MSYS2 on Windows, there is currently the
following error:

../qga/commands-win32.c:62:24: error: redundant redeclaration of
 'CM_Get_DevNode_PropertyW' [-Werror=redundant-decls]
   62 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../qga/commands-win32.c:26:
C:/tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26: note:
 previous declaration of 'CM_Get_DevNode_PropertyW' was here
  840 |   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst,
   const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE PropertyBuffer,
   PULONG PropertyBufferSize, ULONG ulFlags);

Seems like this protype is sometimes available in the cfgmgr32.h
header, and sometimes not. Let's silence the compiler warning here
to let the build pass with -Werror, too.

Message-Id: <20200915114757.55635-1-thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qga/commands-win32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 48d8bbe649..0c3c05484f 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -57,8 +57,10 @@ DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverDate, 0xa8b865dd, 0x2e3d,
 DEFINE_DEVPROPKEY(qga_DEVPKEY_Device_DriverVersion, 0xa8b865dd, 0x2e3d,
     0x4094, 0xad, 0x97, 0xe5, 0x93, 0xa7, 0xc, 0x75, 0xd6, 3);
     /* DEVPROP_TYPE_STRING */
-/* The following shoud be in cfgmgr32.h, but it isn't */
+/* The CM_Get_DevNode_PropertyW prototype is only sometimes in cfgmgr32.h */
 #ifndef CM_Get_DevNode_Property
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wredundant-decls"
 CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
     DEVINST          dnDevInst,
     CONST DEVPROPKEY * PropertyKey,
@@ -68,6 +70,7 @@ CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
     ULONG            ulFlags
 );
 #define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
+#pragma GCC diagnostic pop
 #endif
 
 #ifndef SHTDN_REASON_FLAG_PLANNED
-- 
2.18.2


