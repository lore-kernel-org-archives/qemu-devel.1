Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2283C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DE320818
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 07:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DE320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43895 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRXcW-0006LU-VB
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 03:49:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXXv-0002tc-SN
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRXXu-0002K1-BG
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRXXu-0002JY-3s
	for qemu-devel@nongnu.org; Fri, 17 May 2019 03:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED3347FDC9
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 07:44:48 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91D645D6A9;
	Fri, 17 May 2019 07:44:45 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 09:45:13 +0200
Message-Id: <1558079119-320634-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 17 May 2019 07:44:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/6] numa: deprecate '-numa node,
 mem' and default memory distribution
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

Changes since v2:
  - taking in account previous review, implement a way for mgmt to intospect if
    '-numa node,mem' is supported by machine type as suggested by Daniel at
             https://www.mail-archive.com/qemu-devel@nongnu.org/msg601220.html
      * ammend "qom-list-properties" to show property values
      * add "numa-mem-supported" machine property to reflect if '-numa node,mem=SZ'
        is supported. It culd be used with '-machine none' or at runtime with
        --preconfig before numa memory mapping are configured
  * minor fixes to deprecation documentation mentioning "numa-mem-supported" property

 1) "I'm considering to deprecating -mem-path/prealloc CLI options and replacing
them with a single memdev Machine property to allow interested users to pick
used backend for initial RAM (fixes mixed -mem-path+hostmem backends issues)
and as a transition step to modeling initial RAM as a Device instead of
(ab)using MemoryRegion APIs."
(for more details see: https://www.mail-archive.com/qemu-devel@nongnu.org/msg596314.html)

However there is a couple of roadblocks on the way (s390x and numa memory handling).
I think I finally thought out a way to hack s390x in migration compatible manner,
but I don't see any way to do it for -numa node,mem and default RAM assignement
to nodes. Considering both numa usecases aren't meaningfully using NUMA (aside
guest side testing) and could be replaced with explicitly used memdev parameter,
I'd like to propose removing these fake NUMA friends on new machine types,
hence this deprecation. And once the last machie type that supported the option
is removed we would be able to remove option altogether.

As result of removing deprecated options and replacing initial RAM allocation
with 'memdev's (1), QEMU will allocate guest RAM in consistent way, fixing mixed
use-case and allowing boards to move towards modelling initial RAM as Device(s).
Which in its own turn should allow to cleanup NUMA/HMP/memory accounting code
more by dropping ad-hoc node_mem tracking and reusing memory device enumeration
instead.

Reference to previous versions:
 * [PATCH 0/2] numa: deprecate -numa node, mem and default memory distribution
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg600706.html
 * [PATCH] numa: warn if numa 'mem' option or default RAM splitting between nodes is used.
    https://www.mail-archive.com/qemu-devel@nongnu.org/msg602136.html
 * [PATCH v2] numa: warn if numa 'mem' option or default RAM splitting between nodes is used.
    https://www.spinics.net/linux/fedora/libvir/msg180917.html

CC: libvir-list@redhat.com
CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
CC: berrange@redhat.com
CC: armbru@redhat.com

Igor Mammedov (6):
  pc: fix possible NULL pointer dereference in
    pc_machine_get_device_memory_region_size()
  qmp: make "qom-list-properties" show initial property values
  qmp: qmp_qom_list_properties(): ignore empty string options
  numa: introduce "numa-mem-supported" machine property
  numa: deprecate 'mem' parameter of '-numa node' option
  numa: deprecate implict memory distribution between nodes

 include/hw/boards.h  |  1 +
 hw/arm/virt.c        |  1 +
 hw/core/machine.c    | 12 ++++++++++++
 hw/i386/pc.c         |  7 ++++++-
 hw/ppc/spapr.c       |  1 +
 numa.c               |  5 +++++
 qapi/misc.json       |  5 ++++-
 qemu-deprecated.texi | 24 ++++++++++++++++++++++++
 qmp.c                | 15 +++++++++++++++
 9 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.7.4


