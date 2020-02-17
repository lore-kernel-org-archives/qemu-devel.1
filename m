Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA7C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136F520725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5PZZmzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136F520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kMU-0001qf-6H
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kIa-0000vL-Tp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kIZ-0001dP-Lg
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22676
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kIZ-0001d5-Hl
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B6QuhLUUdajcwFl5aoo5HJCiteCeqU1tdmAw3L7A8gg=;
 b=N5PZZmzSZAE+FWRsUU1lHlm+OH3fe65SBjcr40evkn+9eRiEpYTqTwTNL5uzD1SbztakRq
 zXpVEWMMzEcDVefw4IobXaLMpyFo+ql55Zz4LRGlIq6nhlYBpuClp/o3hltqT627KLSshJ
 nslrdNvTGbwGcuXqR861Z7oX8r++rvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-L8HmyUzEMdmQ8Bhuk756IA-1; Mon, 17 Feb 2020 12:35:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F50E1005513;
 Mon, 17 Feb 2020 17:35:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4515F90508;
 Mon, 17 Feb 2020 17:35:07 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/79] vl.c: move -m parsing after memory backends has been
 processed
Date: Mon, 17 Feb 2020 12:33:39 -0500
Message-Id: <20200217173452.15243-7-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: L8HmyUzEMdmQ8Bhuk756IA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pasic@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It will be possible for main RAM to come from memory-backend
and we should check that size specified in -m matches the size
of the backend and [MachineState::]ram_size also matches
backend's size.

However -m parsing (set_memory_options()) happens before backends
are intialized (object_create_delayed()) which complicates it.
Consolidate set_memory_options() and assigning parsed results to
current_machine after backends are initialized, so it would be
possible access the initialized backend instance to compare
sizes.

This patch only consolidates scattered places touching ram_size
within vl.c. And follow up patch will integrate backend handling
to set_memory_options().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: pasic@linux.ibm.com
CC: pbonzini@redhat.com
---
 vl.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/vl.c b/vl.c
index 2103804c52..72ffc06f2f 100644
--- a/vl.c
+++ b/vl.c
@@ -2655,6 +2655,14 @@ static void set_memory_options(uint64_t *ram_slots, =
ram_addr_t *maxram_size,
         exit(EXIT_FAILURE);
     }
=20
+    if (!xen_enabled()) {
+        /* On 32-bit hosts, QEMU is limited by virtual address space */
+        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
+            error_report("at most 2047 MB RAM can be simulated");
+            exit(1);
+        }
+    }
+
     loc_pop(&loc);
 }
=20
@@ -3819,8 +3827,6 @@ int main(int argc, char **argv, char **envp)
     machine_class =3D select_machine();
     object_set_machine_compat_props(machine_class->compat_props);
=20
-    set_memory_options(&ram_slots, &maxram_size, machine_class);
-
     os_daemonize();
     rcu_disable_atfork();
=20
@@ -4122,9 +4128,6 @@ int main(int argc, char **argv, char **envp)
     machine_opts =3D qemu_get_machine_opts();
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
                      &error_fatal);
-    current_machine->ram_size =3D ram_size;
-    current_machine->maxram_size =3D maxram_size;
-    current_machine->ram_slots =3D ram_slots;
=20
     /*
      * Note: uses machine properties such as kernel-irqchip, must run
@@ -4235,14 +4238,6 @@ int main(int argc, char **argv, char **envp)
=20
     tpm_init();
=20
-    if (!xen_enabled()) {
-        /* On 32-bit hosts, QEMU is limited by virtual address space */
-        if (ram_size > (2047 << 20) && HOST_LONG_BITS =3D=3D 32) {
-            error_report("at most 2047 MB RAM can be simulated");
-            exit(1);
-        }
-    }
-
     blk_mig_init();
     ram_mig_init();
     dirty_bitmap_mig_init();
@@ -4287,6 +4282,12 @@ int main(int argc, char **argv, char **envp)
     if (cpu_option) {
         current_machine->cpu_type =3D parse_cpu_option(cpu_option);
     }
+
+    set_memory_options(&ram_slots, &maxram_size, machine_class);
+    current_machine->ram_size =3D ram_size;
+    current_machine->maxram_size =3D maxram_size;
+    current_machine->ram_slots =3D ram_slots;
+
     parse_numa_opts(current_machine);
=20
     if (machine_class->default_ram_id && current_machine->ram_size &&
--=20
2.18.1


