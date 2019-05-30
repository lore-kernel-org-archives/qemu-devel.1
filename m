Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85D6C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29822511A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29822511A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49247 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWGXQ-0004Ms-32
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 04:35:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWGUw-0002wg-7d
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hWGUv-0006gf-7a
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hWGUv-0006HA-1M
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:33:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A207300502A
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 08:32:52 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F87C1001E86;
	Thu, 30 May 2019 08:32:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 10:33:19 +0200
Message-Id: <1559205199-233510-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1559205199-233510-1-git-send-email-imammedo@redhat.com>
References: <1559205199-233510-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 30 May 2019 08:32:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 3/3] numa: deprecate implict memory
 distribution between nodes
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
	ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implicit RAM distribution between nodes has exactly the same issues as:
  "numa: deprecate 'mem' parameter of '-numa node' option"
only with QEMU being the user that's 'adding' 'mem' parameter.

Deprecate it, to get it out of the way so that we could consolidate
guest RAM allocation using memory backends making it consistent and
possibly later on transition to using memory devices instead of
adhoc memory mapping for the initial RAM.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 numa.c               | 3 +++
 qemu-deprecated.texi | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/numa.c b/numa.c
index 2205773..6d45a1f 100644
--- a/numa.c
+++ b/numa.c
@@ -409,6 +409,9 @@ void numa_complete_configuration(MachineState *ms)
         if (i == nb_numa_nodes) {
             assert(mc->numa_auto_assign_ram);
             mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
+            warn_report("Default splitting of RAM between nodes is deprecated,"
+                        " Use '-numa node,memdev' to explictly define RAM"
+                        " allocation per node");
         }
 
         numa_total = 0;
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index eb347f5..c744ba9 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -98,6 +98,14 @@ In future new machine versions will not accept the option but it will still
 work with old machine types. User can check QAPI schema to see if the legacy
 option is supported by looking at MachineInfo::numa-mem-supported property.
 
+@subsection -numa node (without memory specified) (since 4.1)
+
+Splitting RAM by default between NUMA nodes has the same issues as @option{mem}
+parameter described above with the difference that the role of the user plays
+QEMU using implicit generic or board specific splitting rule.
+Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} (if
+it's supported by used machine type) to define mapping explictly instead.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
-- 
2.7.4


