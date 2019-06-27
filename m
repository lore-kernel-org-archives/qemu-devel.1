Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36B0C004E6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51F920665
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51F920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgb3T-0003tZ-MQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgazt-0000sU-Ty
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgazk-0007EY-TZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24195)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgazf-00077s-Bn; Thu, 27 Jun 2019 16:27:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E1CED3082A9C;
 Thu, 27 Jun 2019 20:27:35 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F18C7600CC;
 Thu, 27 Jun 2019 20:27:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:26:51 +0200
Message-Id: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 27 Jun 2019 20:27:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 00/28] block/pflash_cfi02: Implement missing
 AMD pflash functionality
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is based on Stephen Checkoway work (v4):
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04595.html

Stephen work is a great improvement of the actual code, however
while reviewing his patches, I found them quite dense, so I started
to split each logical change to be able to digest his series.

Sfephen implemented the 'interleaving' feature in way I am not yet
confident it is in the project best interest. The relevant thread
started here:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05395.html

However meanwhile we will discuss his interleaving implementation,
I don't want to block the rest of his work, so I took that patch
of (and rebased his work).

I'm spamming all the maintainers of the boards using
pflash_cfi02_register(). This series is not 'block' related, it is
a classical 'device' model series.
Help reviewing is appreciated :)

I am still looking for real-world code stressing this flash model.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (20):
  hw/block/pflash: Simplify trace_pflash_io_read/write()
  hw/block/pflash: Simplify trace_pflash_data_read/write()
  hw/block/pflash_cfi02: Fix debug format string
  hw/block/pflash_cfi02: Add an enum to define the write cycles
  hw/block/pflash_cfi02: Add helpers to manipulate the status bits
  hw/block/pflash_cfi02: Simplify a statement using fall through
  hw/block/pflash_cfi02: Use the ldst API in pflash_write()
  hw/block/pflash_cfi02: Use the ldst API in pflash_read()
  hw/block/pflash_cfi02: Extract the pflash_data_read() function
  hw/block/pflash_cfi02: Unify the MemoryRegionOps
  tests/pflash-cfi02: Refactor to support testing multiple
    configurations
  hw/block/pflash_cfi02: Remove pointless local variable
  hw/block/pflash_cfi02: Document the current CFI values
  hw/block/pflash_cfi02: Hold the PRI table offset in a variable
  hw/block/pflash_cfi02: Document 'Page Mode' operations are not
    supported
  hw/block/pflash_cfi02: Extract pflash_regions_count()
  hw/block/pflash_cfi02: Split if() condition
  hw/block/pflash_cfi02: Reduce single byte/word write delay
  hw/block/pflash_cfi02: Document commands
  hw/block/pflash_cfi02: Reduce I/O accesses to 16-bit

Stephen Checkoway (8):
  tests/pflash-cfi02: Add test for supported CFI commands
  hw/block/pflash_cfi02: Fix command address comparison
  hw/block/pflash_cfi02: Implement nonuniform sector sizes
  hw/block/pflash_cfi02: Fix CFI in autoselect mode
  hw/block/pflash_cfi02: Fix reset command not ignored during erase
  hw/block/pflash_cfi02: Implement multi-sector erase
  hw/block/pflash_cfi02: Implement erase suspend/resume
  hw/block/pflash_cfi02: Use chip erase time specified in the CFI table

 hw/block/pflash_cfi01.c   |  11 +-
 hw/block/pflash_cfi02.c   | 703 ++++++++++++++++++++++++++------------
 hw/block/trace-events     |  10 +-
 tests/Makefile.include    |   2 +
 tests/pflash-cfi02-test.c | 681 ++++++++++++++++++++++++++++++++++++
 5 files changed, 1173 insertions(+), 234 deletions(-)
 create mode 100644 tests/pflash-cfi02-test.c

--=20
2.20.1


