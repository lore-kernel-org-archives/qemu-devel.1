Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B063C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 22:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5AC206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 22:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5AC206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53410 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he5WZ-0006MF-9z
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 18:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1he5UD-0005T2-7I
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 18:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1he5U5-00051A-WE
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 18:24:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>)
 id 1he5Tl-0004Wx-QL; Thu, 20 Jun 2019 18:24:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D40A45D5E6;
 Thu, 20 Jun 2019 22:23:18 +0000 (UTC)
Received: from hp-moonshot-03-c05.lab.eng.rdu2.redhat.com
 (hp-moonshot-03-c05.lab.eng.rdu2.redhat.com [10.8.2.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE406090E;
 Thu, 20 Jun 2019 22:23:16 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 18:23:14 -0400
Message-Id: <20190620222314.2670-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 20 Jun 2019 22:23:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v2 PATCH] hw/arm/virt: makes virt a default
 machine type
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
Cc: qemu-arm@nongnu.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter, Cleber,

Re-sending this email because I forgot to copy the mailing listing.
Sorry. Original message below.

==
Hi Peter et al.,

I came across this when running the acceptance tests in an aarch64 host.
The arch-independent tests fail because, in general, they don't set a
machine type. In order to avoid treating arm targets as special cases
on avocado_qemu framework I prefered to attempt to promote virt as
default for ARM emulation. Moreover since it represents a generic hardware
and its used is broaden advised [1], I found it the right choice.

Maybe that topic was discussed already but I didn't find any reference on
either the mailing list and git logs. It is also true
that I am an ignorant on ARM platform, thus I might be missing
something. Those explain why I send this patch as RFC.

[1] https://wiki.qemu.org/Documentation/Platforms/ARM

Thanks,

Wainer
-- >8 --
Currently none arm target has a default machine type, unlike
others as x86_64 and ppc64. The 'virt' (alias) type represents a
generic ARM hardware, so let's specify it the default machine for
ARM emulation.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 431e2900fd..2f8aa2bfb7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -74,6 +74,7 @@
         mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
         if (latest) { \
             mc->alias = "virt"; \
+            mc->is_default = 1; \
         } \
     } \
     static const TypeInfo machvirt_##major##_##minor##_info = { \
-- 
2.18.1


