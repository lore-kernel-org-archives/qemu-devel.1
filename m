Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B051C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E7E207D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFC/daYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E7E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSef-0001Fi-26
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMb-0006Th-5Y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMX-0007Am-Ev
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uj8Or6jqCWjgsWo+tDf5DueNDzUwY/MwozhU6V0+JXk=;
 b=KFC/daYZDxfoTQH28tuS7XtRhLQ3vatKo2LB7vJtJT0KM8mrLxorA/X76i/9ir16ojHMkj
 SeQJ6Q12mVpUmiDuNTfAwODZZgGR0B0BkrMbLsL4rs9YhXpSrai7Ze782BQeJcaXFXjWXm
 pMDvlSH2ZhoV3g2lMWxgg9cLZ7NzVYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-317Vn0TCNlCS1UiO5d_aZQ-1; Wed, 02 Sep 2020 08:59:38 -0400
X-MC-Unique: 317Vn0TCNlCS1UiO5d_aZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E73910ABDC3
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:34 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C72E5D9CC
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/39] configure: remove unnecessary libm test
Date: Wed,  2 Sep 2020 08:59:12 -0400
Message-Id: <20200902125917.26021-35-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The same test is already performed by meson.build.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/configure b/configure
index 033eb43428..adb5abe0c0 100755
--- a/configure
+++ b/configure
@@ -4968,20 +4968,6 @@ if test "$libiscsi" != "no" ; then
   fi
 fi
 
-##########################################
-# Do we need libm
-cat > $TMPC << EOF
-#include <math.h>
-int main(int argc, char **argv) { return isnan(sin((double)argc)); }
-EOF
-if compile_prog "" "" ; then
-  :
-elif compile_prog "" "-lm" ; then
-  LIBS="-lm $LIBS"
-else
-  error_exit "libm check failed"
-fi
-
 ##########################################
 # Do we need librt
 # uClibc provides 2 versions of clock_gettime(), one with realtime
-- 
2.26.2



