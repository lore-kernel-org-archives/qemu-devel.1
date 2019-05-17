Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282BBC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D4420818
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D4420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXcc-0006PC-3c
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 03:49:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXY2-0002xn-Qh
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXY1-0002PP-QH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRXY1-0002Of-IU
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCBF13DBC5
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 07:44:56 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 936595D6A9;
	Fri, 17 May 2019 07:44:55 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 09:45:18 +0200
Message-Id: <1558079119-320634-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
References: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 17 May 2019 07:44:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 5/6] numa: deprecate 'mem' parameter of
 '-numa node' option
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

The parameter allows to configure fake NUMA topology where guest
VM simulates NUMA topology but not actually getting a performance
benefits from it. The same or better results could be achieved
using 'memdev' parameter. In light of that any VM that uses NUMA
to get its benefits should use 'memdev'. To allow transition
initial RAM to device based model, deprecate 'mem' parameter as
its ad-hoc partitioning of initial RAM MemoryRegion can't be
translated to memdev based backend transparently to users and in
compatible manner (migration wise).

That will also allow to clean up a bit our numa code, leaving only
'memdev' impl. in place and several boards that use node_mem
to generate FDT/ACPI description from it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
 * mention "numa-mem-supported" machine property in deprecation
   documentation.
---
 numa.c               |  2 ++
 qemu-deprecated.texi | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/numa.c b/numa.c
index 3875e1e..2205773 100644
--- a/numa.c
+++ b/numa.c
@@ -121,6 +121,8 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
 
     if (node->has_mem) {
         numa_info[nodenr].node_mem = node->mem;
+        warn_report("Parameter -numa node,mem is deprecated,"
+                    " use -numa node,memdev instead");
     }
     if (node->has_memdev) {
         Object *o;
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 842e71b..995a96c 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -72,6 +72,22 @@ backend settings instead of environment variables.  To ease migration to
 the new format, the ``-audiodev-help'' option can be used to convert
 the current values of the environment variables to ``-audiodev'' options.
 
+@subsection -numa node,mem=@var{size} (since 4.1)
+
+The parameter @option{mem} of @option{-numa node} is used to assign a part of
+guest RAM to a NUMA node. But when using it, it's impossible to manage specified
+size on the host side (like bind it to a host node, setting bind policy, ...),
+so guest end-ups with the fake NUMA configuration with suboptiomal performance.
+However since 2014 there is an alternative way to assign RAM to a NUMA node
+using parameter @option{memdev}, which does the same as @option{mem} and provides
+means to actualy manage node RAM on the host side. Use parameter @option{memdev}
+with @var{memory-backend-ram} backend as an replacement for parameter @option{mem}
+to achieve the same fake NUMA effect or a properly configured
+@var{memory-backend-file} backend to actually benefit from NUMA configuration.
+In future new machine versions will not accept the option but it will keep
+working with old machine types. User can inspect read-only machine property
+'numa-mem-supported' to check if specific machine type (not) supports the option.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
-- 
2.7.4


