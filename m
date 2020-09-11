Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D01C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F6D22275
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnKNgb86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F6D22275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjAl-0004uQ-8O
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kGjA5-0004UR-7e
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kGjA1-0001Ik-QA
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599831135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Hft9ljPN8fzBYHbXFry5QtXQ89rMCsuUCfXuUh6TXJE=;
 b=bnKNgb86uTa9Y3RH3KRm7LH92hMXoDgNp8vgvr8Z1ROjAAe7Gs3XIKsa/A169Ku2v+RFXu
 dnM/7qvGsIdP2wpO0u1WfKfq5BQV/WVpowAzFJqWoYBLkph9xlfOSLQW74j7OVRce7FXXp
 ecYdi6H6/K3jT+4OugQ9Gpyt0J7hLnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-FCrf6WdlMzC8npIjPaLgag-1; Fri, 11 Sep 2020 09:32:13 -0400
X-MC-Unique: FCrf6WdlMzC8npIjPaLgag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE4D2801AAF;
 Fri, 11 Sep 2020 13:32:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEFDD10023A7;
 Fri, 11 Sep 2020 13:32:04 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] smp: drop support for deprecated (invalid topologies)
Date: Fri, 11 Sep 2020 09:32:02 -0400
Message-Id: <20200911133202.938754-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, mst@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

it's was deprecated since 3.1

Support for invalid topologies is removed, the user must ensure
that topologies described with -smp include all possible cpus,
i.e. (sockets * cores * threads) == maxcpus or QEMU will
exit with error.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 docs/system/deprecated.rst | 26 +++++++++++++-------------
 hw/core/machine.c          | 16 ++++------------
 hw/i386/pc.c               | 16 ++++------------
 3 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 122717cfee..d737728fab 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -47,19 +47,6 @@ The 'file' driver for drives is no longer appropriate for character or host
 devices and will only accept regular files (S_IFREG). The correct driver
 for these file types is 'host_cdrom' or 'host_device' as appropriate.
 
-``-smp`` (invalid topologies) (since 3.1)
-'''''''''''''''''''''''''''''''''''''''''
-
-CPU topology properties should describe whole machine topology including
-possible CPUs.
-
-However, historically it was possible to start QEMU with an incorrect topology
-where *n* <= *sockets* * *cores* * *threads* < *maxcpus*,
-which could lead to an incorrect topology enumeration by the guest.
-Support for invalid topologies will be removed, the user must ensure
-topologies described with -smp include all possible cpus, i.e.
-*sockets* * *cores* * *threads* = *maxcpus*.
-
 ``-vnc acl`` (since 4.0.0)
 ''''''''''''''''''''''''''
 
@@ -618,6 +605,19 @@ New machine versions (since 5.1) will not accept the option but it will still
 work with old machine types. User can check the QAPI schema to see if the legacy
 option is supported by looking at MachineInfo::numa-mem-supported property.
 
+``-smp`` (invalid topologies) (removed 5.2)
+'''''''''''''''''''''''''''''''''''''''''''
+
+CPU topology properties should describe whole machine topology including
+possible CPUs.
+
+However, historically it was possible to start QEMU with an incorrect topology
+where *n* <= *sockets* * *cores* * *threads* < *maxcpus*,
+which could lead to an incorrect topology enumeration by the guest.
+Support for invalid topologies is removed, the user must ensure
+topologies described with -smp include all possible cpus, i.e.
+*sockets* * *cores* * *threads* = *maxcpus*.
+
 Block devices
 -------------
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ea26d61237..09aee4ea52 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -754,23 +754,15 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
             exit(1);
         }
 
-        if (sockets * cores * threads > ms->smp.max_cpus) {
-            error_report("cpu topology: "
-                         "sockets (%u) * cores (%u) * threads (%u) > "
-                         "maxcpus (%u)",
+        if (sockets * cores * threads != ms->smp.max_cpus) {
+            error_report("Invalid CPU topology: "
+                         "sockets (%u) * cores (%u) * threads (%u) "
+                         "!= maxcpus (%u)",
                          sockets, cores, threads,
                          ms->smp.max_cpus);
             exit(1);
         }
 
-        if (sockets * cores * threads != ms->smp.max_cpus) {
-            warn_report("Invalid CPU topology deprecated: "
-                        "sockets (%u) * cores (%u) * threads (%u) "
-                        "!= maxcpus (%u)",
-                        sockets, cores, threads,
-                        ms->smp.max_cpus);
-        }
-
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d071da787b..fbde6b04e6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -746,23 +746,15 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
             exit(1);
         }
 
-        if (sockets * dies * cores * threads > ms->smp.max_cpus) {
-            error_report("cpu topology: "
-                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) > "
-                         "maxcpus (%u)",
+        if (sockets * dies * cores * threads != ms->smp.max_cpus) {
+            error_report("Invalid CPU topology deprecated: "
+                         "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
+                         "!= maxcpus (%u)",
                          sockets, dies, cores, threads,
                          ms->smp.max_cpus);
             exit(1);
         }
 
-        if (sockets * dies * cores * threads != ms->smp.max_cpus) {
-            warn_report("Invalid CPU topology deprecated: "
-                        "sockets (%u) * dies (%u) * cores (%u) * threads (%u) "
-                        "!= maxcpus (%u)",
-                        sockets, dies, cores, threads,
-                        ms->smp.max_cpus);
-        }
-
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
-- 
2.27.0


