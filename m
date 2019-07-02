Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D7C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0897E2082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0897E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLiV-0008Au-Og
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiKqb-0000zm-Ii
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiKqY-00072n-Je
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:37:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiKqY-0006v1-7s
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:37:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42D253082B6D;
 Tue,  2 Jul 2019 15:37:22 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C848D1001B3A;
 Tue,  2 Jul 2019 15:37:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Tue,  2 Jul 2019 12:35:29 -0300
Message-Id: <20190702153535.9851-37-ehabkost@redhat.com>
In-Reply-To: <20190702153535.9851-1-ehabkost@redhat.com>
References: <20190702153535.9851-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 02 Jul 2019 15:37:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v3 36/42] i386: Define -IBRS, -noTSX,
 -IBRS versions of CPU models
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

Add versions of CPU models that are equivalent to their -IBRS,
-noTSX and -IBRS variants.

The separate variants will eventually be removed and become
aliases for these CPU versions.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190628002844.24894-6-ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a611c6eae2..99ab6104f4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1851,6 +1851,20 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_EXT3_LAHF_LM,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core i7 9xx (Nehalem Class Core i7)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                /* Equivalent to Nehalem-IBRS */
+                .props =3D (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core i7 9xx (Nehalem Core i7, IBRS update)"=
 },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "Nehalem-IBRS",
@@ -1907,6 +1921,20 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Westmere E56xx/L56xx/X56xx (Nehalem-C)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                /* Equivalent to Westmere-IBRS */
+                .props =3D (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Westmere E56xx/L56xx/X56xx (IBRS update)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "Westmere-IBRS",
@@ -1971,6 +1999,20 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Xeon E312xx (Sandy Bridge)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                /* Equivalent to SandyBridge-IBRS */
+                .props =3D (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Xeon E312xx (Sandy Bridge, IBRS update)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "SandyBridge-IBRS",
@@ -2043,6 +2085,20 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Xeon E3-12xx v2 (Ivy Bridge)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                /* Equivalent to IvyBridge-IBRS */
+                .props =3D (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Xeon E3-12xx v2 (Ivy Bridge, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "IvyBridge-IBRS",
@@ -2205,6 +2261,52 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Haswell)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                /* Equivalent to Haswell-noTSX */
+                .props =3D (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { "stepping", "1" },
+                    { "model-id", "Intel Core Processor (Haswell, no TSX=
)", },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version =3D 3,
+                /* Equivalent to Haswell-IBRS */
+                .props =3D (PropValue[]) {
+                    /* Restore TSX features removed by -v2 above */
+                    { "hle", "on" },
+                    { "rtm", "on" },
+                    /*
+                     * Haswell and Haswell-IBRS had stepping=3D4 in
+                     * QEMU 4.0 and older
+                     */
+                    { "stepping", "4" },
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core Processor (Haswell, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version =3D 4,
+                /* Equivalent to Haswell-noTSX-IBRS */
+                .props =3D (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    /* spec-ctrl was already enabled by -v3 above */
+                    { "stepping", "1" },
+                    { "model-id",
+                      "Intel Core Processor (Haswell, no TSX, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "Haswell-IBRS",
@@ -2375,6 +2477,45 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Broadwell)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                /* Equivalent to Broadwell-noTSX */
+                .props =3D (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    { "model-id", "Intel Core Processor (Broadwell, no T=
SX)", },
+                    { /* end of list */ }
+                },
+            },
+            {
+                .version =3D 3,
+                /* Equivalent to Broadwell-IBRS */
+                .props =3D (PropValue[]) {
+                    /* Restore TSX features removed by -v2 above */
+                    { "hle", "on" },
+                    { "rtm", "on" },
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core Processor (Broadwell, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            {
+                .version =3D 4,
+                /* Equivalent to Broadwell-noTSX-IBRS */
+                .props =3D (PropValue[]) {
+                    { "hle", "off" },
+                    { "rtm", "off" },
+                    /* spec-ctrl was already enabled by -v3 above */
+                    { "model-id",
+                      "Intel Core Processor (Broadwell, no TSX, IBRS)" }=
,
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "Broadwell-IBRS",
@@ -2465,6 +2606,20 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Core Processor (Skylake)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                /* Equivalent to Skylake-Client-IBRS */
+                .props =3D (PropValue[]) {
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Core Processor (Skylake, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "Skylake-Client-IBRS",
@@ -2567,6 +2722,23 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
             CPUID_6_EAX_ARAT,
         .xlevel =3D 0x80000008,
         .model_id =3D "Intel Xeon Processor (Skylake)",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                /* Equivalent to Skylake-Server-IBRS */
+                .props =3D (PropValue[]) {
+                    /* clflushopt was not added to Skylake-Server-IBRS *=
/
+                    /* TODO: add -v3 including clflushopt */
+                    { "clflushopt", "off" },
+                    { "spec-ctrl", "on" },
+                    { "model-id",
+                      "Intel Xeon Processor (Skylake, IBRS)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "Skylake-Server-IBRS",
@@ -3082,6 +3254,20 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
         .xlevel =3D 0x8000001E,
         .model_id =3D "AMD EPYC Processor",
         .cache_info =3D &epyc_cache_info,
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                /* Equivalent to EPYC-IBPB */
+                .props =3D (PropValue[]) {
+                    { "ibpb", "on" },
+                    { "model-id",
+                      "AMD EPYC Processor (with IBPB)" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
     {
         .name =3D "EPYC-IBPB",
--=20
2.18.0.rc1.1.g3f1ff2140


