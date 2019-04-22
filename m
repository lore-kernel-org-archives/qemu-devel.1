Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B278C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 23:58:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC5020665
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 23:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC5020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIipV-0007SH-7C
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 19:58:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIimn-00058J-35
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIif4-0005hY-Q5
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIif4-0005gt-L2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA8F33093404;
	Mon, 22 Apr 2019 23:47:44 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5452C19C77;
	Mon, 22 Apr 2019 23:47:44 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 20:47:40 -0300
Message-Id: <20190422234742.15780-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 22 Apr 2019 23:47:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] i386: "unavailable-features" QOM property
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
	Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422234740.BqmeoBGuwkeIJtCcgolH677onKxl5YHyRTbVYLXbLbc@z>

Currently, libvirt uses the "filtered-features" QOM property at
runtime to ensure no feature was accidentally disabled on VCPUs
because it's not available on the host.

However, the code for "feature-words" assumes that all missing
features have a corresponding CPUID bit, which is not true for
MSR-based features like the ones at FEAT_ARCH_CAPABILITIES.

We could extend X86CPUFeatureWordInfo to include information
about MSR features, but it's impossible to do that while keeping
compatibility with clients that (reasonably) expect all elements
of "filtered-features" to have the cpuid-* fields.

We have a field in "query-cpu-definitions" that already describes
all features that are missing on a CPU, including MSR features:
CpuDefinitionInfo.unavailable-features.  The existing code for
building the unavailable-features array even uses
X86CPU::filtered_features to build the feature list.

This series adds a "unavailable-features" QOM property to X86CPU
objects that have the same semantics of "unavailable-features" on
query-cpu-definitions.  The new property has the same goal of
"filtered-features", but is generic enough to let any kind of CPU
feature to be listed there without relying on low level details
like CPUID leaves or MSR numbers.

Eduardo Habkost (2):
  i386: x86_cpu_list_feature_names() function
  i386: "unavailable-features" QOM property

 target/i386/cpu.c | 55 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140


