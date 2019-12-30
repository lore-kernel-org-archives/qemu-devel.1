Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083F6C2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 09:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBCD2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 09:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afanjB2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBCD2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilr4e-0007Qf-JC
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 04:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilr3N-0006HZ-UE
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 04:09:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilr3L-0008OB-P1
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 04:09:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22550
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilr3L-0008NZ-Cy
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 04:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577696970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YdbmsnBhJ0g5NW+3S/cmQT+u1hJcl4/8moRbY7Q0gaI=;
 b=afanjB2UWoyNZbQW8WdxO054KPeD7UARQXyuEg1ma9weKO1SJPaRiN1L/Y2llU5GQTZ00/
 Lv+79pfWhv4R4+iJjDPiaQ2ZeLkEHDShjDFwKIxs7iJPg4HPa10zlWiGOkAjMTXrKztgi0
 lH+2+plioH5tt3eeNmxBvcqLHA4cbqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-kj3syISaMd2KuTUr17DQFA-1; Mon, 30 Dec 2019 04:09:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7DC3800EBF;
 Mon, 30 Dec 2019 09:09:22 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 537D21036D1B;
 Mon, 30 Dec 2019 09:09:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/2] tcg: Include tcg files using tcg/ dirname,
 reduce cpp search path list
Date: Mon, 30 Dec 2019 10:08:58 +0100
Message-Id: <20191230090900.446-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: kj3syISaMd2KuTUr17DQFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Noticed we could clean this while reviewing Richard patch last night:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg667606.html

Philippe Mathieu-Daud=C3=A9 (2):
  tcg: Search includes from the project root source directory
  configure: Remove tcg/ from the preprocessor include search list

 configure                     | 1 -
 include/exec/cpu_ldst.h       | 2 +-
 tcg/i386/tcg-target.h         | 2 +-
 tcg/tcg-op.h                  | 2 +-
 tcg/tcg.h                     | 4 ++--
 accel/tcg/cpu-exec.c          | 2 +-
 accel/tcg/tcg-runtime-gvec.c  | 2 +-
 accel/tcg/translate-all.c     | 2 +-
 accel/tcg/user-exec.c         | 2 +-
 bsd-user/main.c               | 2 +-
 cpus.c                        | 2 +-
 exec.c                        | 2 +-
 linux-user/main.c             | 2 +-
 target/alpha/translate.c      | 2 +-
 target/arm/helper-a64.c       | 2 +-
 target/arm/translate-a64.c    | 4 ++--
 target/arm/translate-sve.c    | 6 +++---
 target/arm/translate.c        | 4 ++--
 target/cris/translate.c       | 2 +-
 target/hppa/translate.c       | 2 +-
 target/i386/mem_helper.c      | 2 +-
 target/i386/translate.c       | 2 +-
 target/lm32/translate.c       | 2 +-
 target/m68k/translate.c       | 2 +-
 target/microblaze/translate.c | 2 +-
 target/mips/translate.c       | 2 +-
 target/moxie/translate.c      | 2 +-
 target/nios2/translate.c      | 2 +-
 target/openrisc/translate.c   | 2 +-
 target/ppc/mem_helper.c       | 2 +-
 target/ppc/translate.c        | 4 ++--
 target/riscv/cpu_helper.c     | 2 +-
 target/riscv/translate.c      | 2 +-
 target/s390x/translate.c      | 4 ++--
 target/sh4/translate.c        | 2 +-
 target/sparc/ldst_helper.c    | 2 +-
 target/sparc/translate.c      | 2 +-
 target/tilegx/translate.c     | 2 +-
 target/tricore/translate.c    | 2 +-
 target/unicore32/translate.c  | 2 +-
 target/xtensa/translate.c     | 2 +-
 tcg/aarch64/tcg-target.inc.c  | 4 ++--
 tcg/arm/tcg-target.inc.c      | 4 ++--
 tcg/i386/tcg-target.inc.c     | 4 ++--
 tcg/mips/tcg-target.inc.c     | 2 +-
 tcg/optimize.c                | 2 +-
 tcg/ppc/tcg-target.inc.c      | 4 ++--
 tcg/riscv/tcg-target.inc.c    | 4 ++--
 tcg/s390/tcg-target.inc.c     | 4 ++--
 tcg/sparc/tcg-target.inc.c    | 2 +-
 tcg/tcg-common.c              | 2 +-
 tcg/tcg-op-gvec.c             | 8 ++++----
 tcg/tcg-op-vec.c              | 6 +++---
 tcg/tcg-op.c                  | 6 +++---
 tcg/tcg.c                     | 2 +-
 tcg/tci.c                     | 2 +-
 56 files changed, 75 insertions(+), 76 deletions(-)

--=20
2.21.0


