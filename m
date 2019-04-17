Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1892CC10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD17C21773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD17C21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGarB-0004xL-QX
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 23:03:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGanm-0002nd-6O
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGanl-0007lq-CC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hGank-0007kX-5S; Tue, 16 Apr 2019 22:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88D0A307D910;
	Wed, 17 Apr 2019 02:59:54 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 166E85D707;
	Wed, 17 Apr 2019 02:59:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 23:59:42 -0300
Message-Id: <20190417025944.16154-4-ehabkost@redhat.com>
In-Reply-To: <20190417025944.16154-1-ehabkost@redhat.com>
References: <20190417025944.16154-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 17 Apr 2019 02:59:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/5] linux-user: Use lookup_cpu_class()
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
Message-ID: <20190417025942.7yX-eftdvYzz644nHO83a7271D6-tzMUqtp0A4xsIdg@z>

The return value of cpu_get_model() is just a CPU model name and
never includes extra options.  We don't need to call
parse_cpu_option().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 linux-user/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 20e0f51cfa..d74108e05c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -592,6 +592,7 @@ int main(int argc, char **argv, char **envp)
     TaskState *ts;
     CPUArchState *env;
     CPUState *cpu;
+    CPUClass *cc;
     int optind;
     char **target_environ, **wrk;
     char **target_argv;
@@ -660,7 +661,8 @@ int main(int argc, char **argv, char **envp)
     if (cpu_model == NULL) {
         cpu_model = cpu_get_model(get_elf_eflags(execfd));
     }
-    cpu_type = parse_cpu_option(cpu_model);
+    cc = lookup_cpu_class(cpu_model, &error_fatal);
+    cpu_type = object_class_get_name(OBJECT_CLASS(cc));
 
     /* init tcg before creating CPUs and to get qemu_host_page_size */
     tcg_exec_init(0);
-- 
2.18.0.rc1.1.g3f1ff2140


