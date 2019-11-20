Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EDBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1330520885
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXcEitlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1330520885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTBN-0008TD-VQ
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iXTAQ-0007MQ-Cp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iXTAP-0003xU-0Q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:49:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iXTAO-0003xH-SX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574268560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Dpc1BgQpMogJAbxDLdkCUn1kyxxuliFoIC8+1a85qY=;
 b=QXcEitlFeLLm2rkZ+b9YfjpOMFY+E0R91YZ09wmCj6JhUjLnXsDgMNjxo2bDfGHfUYcFLS
 G7gwDjGwhUdl7f28lBMlKTNaE3goX07rawBIvL/ULEOmPzKbZR2lWXF2ne8vZUgbABfHqe
 /P7aif+Sw0PWrUdtmhyORljCXUqDpTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-i4u_zttCP1uoIaLgIIIn3g-1; Wed, 20 Nov 2019 11:49:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C746593CE;
 Wed, 20 Nov 2019 16:49:16 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB0A76BF98;
 Wed, 20 Nov 2019 16:49:15 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-4.2 1/2] i386: Add new versions of
 Skylake/Cascadelake/Icelake without TSX
Date: Wed, 20 Nov 2019 13:49:11 -0300
Message-Id: <20191120164912.32384-2-ehabkost@redhat.com>
In-Reply-To: <20191120164912.32384-1-ehabkost@redhat.com>
References: <20191120164912.32384-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: i4u_zttCP1uoIaLgIIIn3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

One of the mitigation methods for TAA[1] is to disable TSX
support on the host system.  Linux added a mechanism to disable
TSX globally through the kernel command line, and many Linux
distributions now default to tsx=3Doff.  This makes existing CPU
models that have HLE and RTM enabled not usable anymore.

Add new versions of all CPU models that have the HLE and RTM
features enabled, that can be used when TSX is disabled in the
host system.

References:

[1] TAA, TSX asynchronous Abort:
    https://software.intel.com/security-software-guidance/insights/deep-div=
e-intel-transactional-synchronization-extensions-intel-tsx-asynchronous-abo=
rt
    https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_ab=
ort.html

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 296b491607..0267e08612 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2474,6 +2474,14 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
                     { /* end of list */ }
                 }
             },
+            {
+                .version =3D 3,
+                .props =3D (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -2541,6 +2549,14 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
                     { /* end of list */ }
                 }
             },
+            {
+                .version =3D 3,
+                .props =3D (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { /* end of list */ }
+                }
+            },
             { /* end of list */ }
         }
     },
@@ -2608,6 +2624,13 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
                   { /* end of list */ }
               },
             },
+            { .version =3D 3,
+              .props =3D (PropValue[]) {
+                  { "hle", "off" },
+                  { "rtm", "off" },
+                  { /* end of list */ }
+              },
+            },
             { /* end of list */ }
         }
     },
@@ -2665,6 +2688,18 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Icelake)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                .props =3D (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "Icelake-Server",
@@ -2723,6 +2758,18 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Xeon Processor (Icelake)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                .props =3D (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { /* end of list */ }
+                },
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "Denverton",
--=20
2.21.0


