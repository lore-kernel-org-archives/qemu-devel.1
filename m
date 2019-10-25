Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E29DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A73D21928
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdSuUrdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A73D21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNpKG-0004MZ-3o
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIk-00024i-Nd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIj-0007ZP-O9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46229
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNpIj-0007ZG-L6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571970365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oXiQ9VZ+z74ls5xgndM1WghFumLiYi+xPQ8+MWj6qls=;
 b=IdSuUrdZdBCjiHIXnwOOV4zlbv5UmXa+LM7rERPVVv0/Ql8ZqHYg3c2+utvXslBJcFBrcq
 kcxuj7F8Qa2iZYub0/ce3Fc2QPHc16RiPwST/Qp/xf1R5jjHkoYgbhagCsF6YDRV6vrS7j
 3FMMTTUSGpwzjgTfMC2iloYnO6IIMw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-5asOPNm8NGW8_G9muFsRPw-1; Thu, 24 Oct 2019 22:26:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 467431800DC7;
 Fri, 25 Oct 2019 02:26:01 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C685C5D712;
 Fri, 25 Oct 2019 02:26:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] i386: Don't use default_cpu_version at "-cpu help"
Date: Thu, 24 Oct 2019 23:25:49 -0300
Message-Id: <20191025022553.25298-4-ehabkost@redhat.com>
In-Reply-To: <20191025022553.25298-1-ehabkost@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5asOPNm8NGW8_G9muFsRPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The output of "-cpu help" doesn't change depending on the machine
type, already.  We can remove usage of default_cpu_version and
keep output exactly the same.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 843f8c4b68..8cecc669b3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3980,10 +3980,11 @@ static void x86_cpu_list_entry(gpointer data, gpoin=
ter user_data)
     X86CPUClass *cc =3D X86_CPU_CLASS(oc);
     g_autofree char *name =3D x86_cpu_class_get_model_name(cc);
     g_autofree char *desc =3D g_strdup(cc->model_description);
-    g_autofree char *alias_of =3D x86_cpu_class_get_alias_of(cc, default_c=
pu_version);
=20
-    if (!desc && alias_of) {
-        if (cc->model && cc->model->version =3D=3D CPU_VERSION_AUTO) {
+    if (!desc && cc->model && cc->model->is_alias) {
+        g_autofree char *alias_of =3D
+            x86_cpu_class_get_alias_of(cc, CPU_VERSION_AUTO);
+        if (!alias_of) {
             desc =3D g_strdup("(alias configured by machine type)");
         } else {
             desc =3D g_strdup_printf("(alias of %s)", alias_of);
--=20
2.21.0


