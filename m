Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26267C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE242084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE242084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKgI-0003qP-UI
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1hyKdX-0000f4-Cm
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hyKdU-0000a2-Qq
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:38:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hyKdU-0000Yz-Kv
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:38:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D729D3C917;
 Thu, 15 Aug 2019 18:38:07 +0000 (UTC)
Received: from localhost (ovpn-116-32.gru2.redhat.com [10.97.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDC8510016EB;
 Thu, 15 Aug 2019 18:38:04 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 15:38:00 -0300
Message-Id: <20190815183803.13346-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 15 Aug 2019 18:38:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] pc: Fix die-id validation and
 compatibility with libvirt
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
Cc: Peter Krempa <pkrempa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Like Xu <like.xu@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, if die-id is omitted on -device for CPUs, we get a
very confusing error message:

  $ qemu-system-x86_64 -smp 1,sockets=3D6,maxcpus=3D6 \
    -device qemu64-x86_64-cpu,socket-id=3D1,core-id=3D0,thread-id=3D0
  qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=3D1,core-id=3D0=
,thread-id=3D0: \
    Invalid CPU die-id: 4294967295 must be in range 0:5

This has 3 problems

1) The actual range for die-id is 0:0.
   This is fixed by patch 1/3.
2) The user didn't specify die-id=3D4294967295.
   This is fixed by patch 2/3.
3) It breaks compatibility with libvirt because die-id was not
   mandatory before.
   This is addressed by patch 3/3.

Issues #1 and #2 were reported at:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1741151

Issue #3 was reported at:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1741451

Cc: Like Xu <like.xu@linux.intel.com>
Cc: Peter Krempa <pkrempa@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>

Eduardo Habkost (3):
  pc: Fix error message on die-id validation
  pc: Improve error message when die-id is omitted
  pc: Don't make CPU properties mandatory unless necessary

 hw/i386/pc.c                             | 23 ++++++++-
 tests/acceptance/pc_cpu_hotplug_props.py | 59 ++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 tests/acceptance/pc_cpu_hotplug_props.py

--=20
2.21.0


