Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A2C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED4021881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED4021881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijtn-0001fh-GW
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56563)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hijfx-0004XW-4G
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hijfv-0000Vn-Ow
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hijfv-0000V7-HA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:08:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D03E5C05566B;
 Wed,  3 Jul 2019 18:08:10 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 614CF17F37;
 Wed,  3 Jul 2019 18:08:10 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Wed,  3 Jul 2019 15:07:00 -0300
Message-Id: <20190703180726.31267-18-ehabkost@redhat.com>
In-Reply-To: <20190703180726.31267-1-ehabkost@redhat.com>
References: <20190703180726.31267-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 03 Jul 2019 18:08:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v4 17/43] numa: deprecate 'mem' parameter of
 '-numa node' option
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

The parameter allows to configure fake NUMA topology where guest
VM simulates NUMA topology but not actually getting performance
benefits from it. The same or better results could be achieved
using 'memdev' parameter.
Beside of unpredictable performance, '-numa node.mem' option has
other issues when it's used with combination of -mem-path +
+ -mem-prealloc + memdev backends (pc-dimm), breaking binding of
memdev backends since mem-path/mem-prealloc are global and affect
the most of RAM allocations.

It's possible to make memdevs and global -mem-path/mem-prealloc
to play nicely together but that will just complicate already
complicated code and add unobious ways it could break on 2
different memmory allocation pathes and their combinations.

Instead of it, consolidate all guest RAM allocation over memdev
which still allows to create fake NUMA configurations if desired
and leaves one simplifyed code path to consider when it comes
to guest RAM allocation.

To achieve desired simplification deprecate 'mem' parameter as its
ad-hoc partitioning of initial RAM MemoryRegion can't be translated
to memdev based backend transparently to users and in compatible
manner (migration wise).

Later down the road that will allow to consolidate means of how
guest RAM is allocated and would permit us to clean up quite
a bit memory allocations and numa code, leaving only 'memdev'
implementation in place.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1559205199-233510-3-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 numa.c               |  2 ++
 qemu-deprecated.texi | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/numa.c b/numa.c
index 7594eb5a7e..7d449c7e95 100644
--- a/numa.c
+++ b/numa.c
@@ -122,6 +122,8 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
 
     if (node->has_mem) {
         numa_info[nodenr].node_mem = node->mem;
+        warn_report("Parameter -numa node,mem is deprecated,"
+                    " use -numa node,memdev instead");
     }
     if (node->has_memdev) {
         Object *o;
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index df04f2840b..44c9a95966 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -88,6 +88,22 @@ The @code{-realtime mlock=on|off} argument has been replaced by the
 The ``-virtfs_synth'' argument is now deprecated. Please use ``-fsdev synth''
 and ``-device virtio-9p-...'' instead.
 
+@subsection -numa node,mem=@var{size} (since 4.1)
+
+The parameter @option{mem} of @option{-numa node} is used to assign a part of
+guest RAM to a NUMA node. But when using it, it's impossible to manage specified
+RAM chunk on the host side (like bind it to a host node, setting bind policy, ...),
+so guest end-ups with the fake NUMA configuration with suboptiomal performance.
+However since 2014 there is an alternative way to assign RAM to a NUMA node
+using parameter @option{memdev}, which does the same as @option{mem} and adds
+means to actualy manage node RAM on the host side. Use parameter @option{memdev}
+with @var{memory-backend-ram} backend as an replacement for parameter @option{mem}
+to achieve the same fake NUMA effect or a properly configured
+@var{memory-backend-file} backend to actually benefit from NUMA configuration.
+In future new machine versions will not accept the option but it will still
+work with old machine types. User can check QAPI schema to see if the legacy
+option is supported by looking at MachineInfo::numa-mem-supported property.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
-- 
2.18.0.rc1.1.g3f1ff2140


