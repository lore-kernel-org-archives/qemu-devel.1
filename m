Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36F5C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9116B21773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9116B21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGasi-0006Ci-Rq
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 23:05:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGano-0002pP-0V
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 23:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGanm-0007me-Rd
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hGanm-0007lT-4k; Tue, 16 Apr 2019 22:59:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CFA43DE10;
	Wed, 17 Apr 2019 02:59:56 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 09EB519C67;
	Wed, 17 Apr 2019 02:59:55 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 23:59:43 -0300
Message-Id: <20190417025944.16154-5-ehabkost@redhat.com>
In-Reply-To: <20190417025944.16154-1-ehabkost@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 17 Apr 2019 02:59:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/5] bsd-user: Use lookup_cpu_class()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417025943.EglxuYzlvARPRdlZbuCnyEvVgEev2isJkK-huzxP6Eo@z>

The hardcoded CPU models in the code are just CPU models and
don't include any extra options.  We don't need to call
parse_cpu_options().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 bsd-user/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index a6c055f5fb..d2915a9951 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -732,6 +732,7 @@ int main(int argc, char **argv)
     TaskState ts1, *ts = &ts1;
     CPUArchState *env;
     CPUState *cpu;
+    CPUClass *cc;
     int optind;
     const char *r;
     int gdbstub_port = 0;
@@ -903,7 +904,8 @@ int main(int argc, char **argv)
     /* init tcg before creating CPUs and to get qemu_host_page_size */
     tcg_exec_init(0);
 
-    cpu_type = parse_cpu_option(cpu_model);
+    cc = lookup_cpu_class(cpu_model, &error_fatal);
+    cpu_type = object_class_get_name(OBJECT_CLASS(cc));
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
 #if defined(TARGET_SPARC) || defined(TARGET_PPC)
-- 
2.18.0.rc1.1.g3f1ff2140


