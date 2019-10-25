Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9DDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788D321928
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBXRTcF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788D321928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNpKB-0004C5-8h
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIh-00022O-7L
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIg-0007YV-4w
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNpIg-0007YF-1k
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571970361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4eZCQ4DtIKc5OyXVLekec+UhUjUI8Xusz0XAGuqf8E=;
 b=dBXRTcF2JtgOICr7tPoiIuz/E6Xg3YKGECCVNVBp4Xd0c7vz8eHdaZODIR8BwNFAepFhD9
 G9KYohIEck/nnYXw/d5lcq+1KKL80/3TaoqnrPDPXlIzMEzc1+C/DfcQMjve15WDUQRJ+3
 1IQIkqFnQ35Tk1Rr3bZ65gHwpY3m/lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-ZTIH5A0IOdWh1JVzspZWtQ-1; Thu, 24 Oct 2019 22:25:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741271800DC7;
 Fri, 25 Oct 2019 02:25:57 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0734A1001B20;
 Fri, 25 Oct 2019 02:25:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] i386: Use g_autofree at x86_cpu_list_entry()
Date: Thu, 24 Oct 2019 23:25:47 -0300
Message-Id: <20191025022553.25298-2-ehabkost@redhat.com>
In-Reply-To: <20191025022553.25298-1-ehabkost@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZTIH5A0IOdWh1JVzspZWtQ-1
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

Make the code shorter and simpler.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0de8a22e1e..5b7c5b1177 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3976,9 +3976,9 @@ static void x86_cpu_list_entry(gpointer data, gpointe=
r user_data)
 {
     ObjectClass *oc =3D data;
     X86CPUClass *cc =3D X86_CPU_CLASS(oc);
-    char *name =3D x86_cpu_class_get_model_name(cc);
-    char *desc =3D g_strdup(cc->model_description);
-    char *alias_of =3D x86_cpu_class_get_alias_of(cc);
+    g_autofree char *name =3D x86_cpu_class_get_model_name(cc);
+    g_autofree char *desc =3D g_strdup(cc->model_description);
+    g_autofree char *alias_of =3D x86_cpu_class_get_alias_of(cc);
=20
     if (!desc && alias_of) {
         if (cc->model && cc->model->version =3D=3D CPU_VERSION_AUTO) {
@@ -3992,9 +3992,6 @@ static void x86_cpu_list_entry(gpointer data, gpointe=
r user_data)
     }
=20
     qemu_printf("x86 %-20s  %-48s\n", name, desc);
-    g_free(name);
-    g_free(desc);
-    g_free(alias_of);
 }
=20
 /* list available CPU models and flags */
--=20
2.21.0


