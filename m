Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A683C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4AE217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 06:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4AE217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51986 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHMww-00058L-0G
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 02:24:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnB-0005bz-DO
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnA-0004yA-Br
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMnA-0004xa-6V
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7806A3008CDC;
	Fri, 19 Apr 2019 06:14:31 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 100E35C21F;
	Fri, 19 Apr 2019 06:14:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 03:14:22 -0300
Message-Id: <20190419061429.17695-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 19 Apr 2019 06:14:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/7] Delete 16 *_cpu_class_by_name() functions
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419061422.Q-TbGueZETvzab9p9QEFOiJWjh10CiZhaRJoq4C-QdU@z>

This series adds a new CPUClass::class_name_format field, which
allows us to delete 16 of the 21 *_cpu_class_by_name() functions
that exist today.

Eduardo Habkost (7):
  cpu: Change return type of cpu_class_by_name() to CPUClass
  riscv: Don't split CPU model string
  arm: Don't split CPU model string
  arm: Remove special case for "any" CPU model
  cpu: Let architectures set CPU class name format
  cpu: Set class name format for some architectures
  cpu: Set fixed class name on some architectures

 include/qom/cpu.h         | 14 +++++++++++++-
 target/s390x/internal.h   |  1 -
 exec.c                    |  8 +++-----
 qom/cpu.c                 | 20 +++++++++++++++++---
 target/arm/cpu.c          | 30 +-----------------------------
 target/hppa/cpu.c         |  8 ++------
 target/i386/cpu.c         | 11 +----------
 target/lm32/cpu.c         | 17 +----------------
 target/m68k/cpu.c         | 17 +----------------
 target/microblaze/cpu.c   |  8 ++------
 target/mips/cpu.c         | 13 +------------
 target/moxie/cpu.c        | 17 +----------------
 target/nios2/cpu.c        |  8 ++------
 target/openrisc/cpu.c     | 17 +----------------
 target/riscv/cpu.c        | 20 +-------------------
 target/s390x/cpu.c        |  2 +-
 target/s390x/cpu_models.c | 20 +++++---------------
 target/tilegx/cpu.c       |  8 ++------
 target/tricore/cpu.c      | 17 +----------------
 target/unicore32/cpu.c    | 17 +----------------
 target/xtensa/cpu.c       | 17 +----------------
 21 files changed, 58 insertions(+), 232 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140


