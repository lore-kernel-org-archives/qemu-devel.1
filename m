Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDFDC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FA820882
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMi1aZJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FA820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrMO-0004Yy-4q
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:06:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itrKT-0002dC-J5
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:04:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itrKN-0002BD-W3
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:04:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itrKN-0002Ar-Sv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579604651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JD10Fq/9poMDjb/HbghiEve7pBcjeVe8ewjzArfNZpI=;
 b=GMi1aZJ8ocT95pd7S0Ght7E66CaX7MamohKfqmHSsng/KI4w4bDeOe+N+QjKBSyCKqdjOL
 BumFT+2zob1QZVrhtPG5sepCwX+sQK19jZMmim2S9bN9u5Qq1eK46Mj0b3yeluqDJwRSoR
 LIIZV3ZmR2h3TVvVmkZnPZUp5gqT1PM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-9ZRUMiBDNYe81rm4na-EVw-1; Tue, 21 Jan 2020 06:04:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0003DBA3;
 Tue, 21 Jan 2020 11:04:04 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-38.brq.redhat.com [10.40.205.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D8C683860;
 Tue, 21 Jan 2020 11:03:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/10] Cleanups around the 'current_machine' global variable
Date: Tue, 21 Jan 2020 12:03:39 +0100
Message-Id: <20200121110349.25842-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9ZRUMiBDNYe81rm4na-EVw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1 was "Replace current_machine by qdev_get_machine()":
https://www.mail-archive.com/qemu-devel@nongnu.org/msg669611.html

But Markus objected, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg670122.html
and older discussion:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg611338.html

This series salvage patches from v1, and add other trivial cleanups.

Can the ARM/PPC/S390 patches could go via their own tree, and the
rest via Paolo's 'misc' tree?

Supersedes: <20200109152133.23649-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (10):
  hw/ppc/spapr_rtas: Use local MachineState variable
  hw/ppc/spapr_rtas: Access MachineState via SpaprMachineState argument
  hw/ppc/spapr_rtas: Remove local variable
  target/arm/kvm: Use CPUState::kvm_state in kvm_arm_pmu_supported()
  target/s390x: Remove duplicated ifdef macro
  qom/object: Display more helpful message when a parent is missing
  qdev: Abort if the root machine container is missing
  accel: Introduce the current_accel() wrapper
  accel: Replace current_machine->accelerator by current_accel() wrapper
  accel/tcg: Sanitize include path

 include/sysemu/accel.h     | 2 ++
 accel/accel.c              | 5 +++++
 accel/kvm/kvm-all.c        | 4 ++--
 accel/tcg/tcg-all.c        | 8 ++++----
 hw/core/qdev.c             | 1 +
 hw/ppc/spapr_rtas.c        | 9 ++++-----
 memory.c                   | 2 +-
 qom/object.c               | 6 +++++-
 target/arm/kvm.c           | 4 +---
 target/arm/kvm64.c         | 5 ++---
 target/i386/kvm.c          | 2 +-
 target/ppc/kvm.c           | 2 +-
 target/s390x/excp_helper.c | 7 +++----
 vl.c                       | 2 +-
 14 files changed, 33 insertions(+), 26 deletions(-)

--=20
2.21.1


