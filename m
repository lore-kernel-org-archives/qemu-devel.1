Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D1C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE6920818
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE6920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXeC-0007K9-Cn
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 03:51:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXY4-0002z4-7U
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXY3-0002Qa-8X
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:45:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRXY3-0002Q6-3b
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 768B281DE6
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 07:44:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E6AE17142;
	Fri, 17 May 2019 07:44:57 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 09:45:19 +0200
Message-Id: <1558079119-320634-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
References: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 17 May 2019 07:44:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 6/6] numa: deprecate implict memory
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
adhoc memory mapping of initial RAM.
---
 v3:
   - update deprecation doc, s/4.0/4.1/
   - mention that legacy 'mem' option could also be used to
     provide explicit memory distribution for old machine types

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
index 995a96c..546f722 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -88,6 +88,14 @@ In future new machine versions will not accept the option but it will keep
 working with old machine types. User can inspect read-only machine property
 'numa-mem-supported' to check if specific machine type (not) supports the option.
 
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


