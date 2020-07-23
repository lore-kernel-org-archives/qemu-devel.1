Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F97C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418CD207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7JrLfWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418CD207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfKF-0007CQ-Ek
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfJA-0005T3-UE
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:47:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51598
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jyfJ6-0004CX-VR
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595526420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hDiABnSVTJmwW4/l6/BO7SmKArZXogC39VD0mu6opk=;
 b=Y7JrLfWxtPTqWH9DrkTQEty8y/iV9r5tl624jxeLn5nTaq3H22jRl881BQg8nqFa2tn0At
 /4pISEzZZ1PZqMGxFCO6PyabvbFljLXBuEoLqqxRm8nSPOlTyIwuNaUa7M4GAO6Psl6mDx
 HezHfx7wDjzg/dtEXxZ8Sssl8dxLp4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-6J5YDb7lNaGUX6z4QPcitw-1; Thu, 23 Jul 2020 13:46:56 -0400
X-MC-Unique: 6J5YDb7lNaGUX6z4QPcitw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D84A100AA51;
 Thu, 23 Jul 2020 17:46:55 +0000 (UTC)
Received: from turbo.com (ovpn-113-141.ams2.redhat.com [10.36.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9FA469316;
 Thu, 23 Jul 2020 17:46:52 +0000 (UTC)
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org,
	kraxel@redhat.com
Subject: [PATCH 4/7] spice: Make spice a module configuration
Date: Thu, 23 Jul 2020 19:46:12 +0200
Message-Id: <20200723174615.2370096-5-dinechin@redhat.com>
In-Reply-To: <20200723174615.2370096-1-dinechin@redhat.com>
References: <20200723174615.2370096-1-dinechin@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit changes the spice configuration 'm' by default, and moves
the spice components to obj-m variables. It is sufficient to build
without modules enable, but does not link correctly yet, since no
shims have been created for the missing functions yet.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
---
 chardev/Makefile.objs | 3 ++-
 configure             | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 3783dadc4c..7cf05c9541 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -26,4 +26,5 @@ baum.o-cflags := $(SDL_CFLAGS)
 baum.o-libs := $(BRLAPI_LIBS)
 endif
 
-common-obj-$(CONFIG_SPICE) += spice.o
+common-obj-$(CONFIG_SPICE) += spice.mo
+spice.mo-objs := spice.o
diff --git a/configure b/configure
index 4bd80ed507..054aab31be 100755
--- a/configure
+++ b/configure
@@ -7534,7 +7534,7 @@ if test "$posix_memalign" = "yes" ; then
 fi
 
 if test "$spice" = "yes" ; then
-  echo "CONFIG_SPICE=y" >> $config_host_mak
+  echo "CONFIG_SPICE=m" >> $config_host_mak
 fi
 
 if test "$smartcard" = "yes" ; then
-- 
2.26.2


