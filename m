Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00180CA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0ED21928
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddwpmMMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0ED21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNpK5-00046o-Cq
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIh-00022N-7F
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIf-0007YJ-S7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24687
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNpIf-0007Y9-Oo
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571970361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SggPprj3sPvFJNcYTUZ3yZnnkOxjb9MiYD6fAe1K0TI=;
 b=ddwpmMMY5FOHf4nBV9WR7vJwoTumwUWoh+1y0hlE1hlO4C50M9BoZ/zH8Aj937g+HCwJ0W
 5NSJoeCnChRrO9a1y5aMH3e5IwTkRy6bTsFBVbKz2aX8HaHpUskltbn88RQ8J7dMGQSQOW
 XdKgfl16V5ZbcDtwOr6Bp37UOWDAAO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-CC1qr9k-PNuU2g2AOFgQPw-1; Thu, 24 Oct 2019 22:25:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C261801E5F;
 Fri, 25 Oct 2019 02:25:55 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9E5E600C6;
 Fri, 25 Oct 2019 02:25:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] i386: Add `machine` parameter to query-cpu-definitions
Date: Thu, 24 Oct 2019 23:25:46 -0300
Message-Id: <20191025022553.25298-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: CC1qr9k-PNuU2g2AOFgQPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We had introduced versioned CPU models in QEMU 4.1, including a
method for querying for CPU model versions using
query-cpu-definitions.  This only has one problem: fetching CPU
alias information for multiple machine types required restarting
QEMU for each machine being queried.

This series adds a new `machine` parameter to
query-cpu-definitions, that can be used to query CPU model alias
information for multiple machines without restarting QEMU.

Eduardo Habkost (7):
  i386: Use g_autofree at x86_cpu_list_entry()
  i386: Add default_version parameter to CPU version functions
  i386: Don't use default_cpu_version at "-cpu help"
  machine: machine_find_class() function
  i386: Remove x86_cpu_set_default_version() function
  i386: Don't use default_cpu_version() inside query-cpu-definitions
  cpu: Add `machine` parameter to query-cpu-definitions

 qapi/machine-target.json                   | 14 +++-
 include/hw/boards.h                        |  1 +
 include/hw/i386/pc.h                       |  5 +-
 target/i386/cpu.h                          |  6 --
 hw/core/machine.c                          | 16 ++++
 hw/i386/pc.c                               |  3 -
 target/arm/helper.c                        |  4 +-
 target/i386/cpu.c                          | 93 +++++++++++++++-------
 target/mips/helper.c                       |  4 +-
 target/ppc/translate_init.inc.c            |  4 +-
 target/s390x/cpu_models.c                  |  4 +-
 vl.c                                       | 17 +---
 tests/acceptance/x86_cpu_model_versions.py | 42 ++++++++++
 13 files changed, 154 insertions(+), 59 deletions(-)

--=20
2.21.0


