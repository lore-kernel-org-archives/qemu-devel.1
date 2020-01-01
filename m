Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1835C32764
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBDF20842
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8Lo72LO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBDF20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imc82-0003xj-Qs
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 06:25:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imc68-0002Fx-My
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imc66-0006rv-FU
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:23:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imc66-0006nw-94
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 06:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577877809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wNRLLNt73F5NE0cl/xsszva96k63W92F8fbKgXIt8fA=;
 b=f8Lo72LO5z7wGbJUWRApKU3JBphGJ8xGWGdRd8IkXZqCXwAPV2h9RcaDIAicZE765VvQXn
 UDU5BKgoNmN2P8qllVxEQtYvdajJFxJr6RixvcxKsdYzwjvcEpNX/9EPgyB3ygNNJFCvok
 e2A/ZkCUSsRM7GzvHD7Spep1wzORa8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-DDHZJOfAOa2PS59k7M8Ifw-1; Wed, 01 Jan 2020 06:23:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94D69182B7AA;
 Wed,  1 Jan 2020 11:23:23 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B3735D9E2;
 Wed,  1 Jan 2020 11:23:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] tcg: Include tcg files using tcg/ dirname,
 reduce cpp search path list
Date: Wed,  1 Jan 2020 12:22:59 +0100
Message-Id: <20200101112303.20724-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DDHZJOfAOa2PS59k7M8Ifw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Claudio Fontana <claudio.fontana@huawei.com>,
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

Since v1:
- moved headers to include/tcg/ (Paolo)
- include in .inc.c relative to parent (Stefan)

v1: https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05356.html

Philippe Mathieu-Daud=C3=A9 (4):
  tcg: Search includes from the project root source directory
  tcg: Search includes in the parent source directory
  tcg: Move TCG headers to include/tcg/
  configure: Remove tcg/ from the preprocessor include search list

 configure                            | 1 -
 include/exec/cpu_ldst.h              | 2 +-
 {tcg =3D> include/tcg}/tcg-gvec-desc.h | 0
 {tcg =3D> include/tcg}/tcg-mo.h        | 0
 {tcg =3D> include/tcg}/tcg-op-gvec.h   | 0
 {tcg =3D> include/tcg}/tcg-op.h        | 2 +-
 {tcg =3D> include/tcg}/tcg-opc.h       | 0
 {tcg =3D> include/tcg}/tcg.h           | 4 ++--
 tcg/i386/tcg-target.h                | 2 +-
 accel/tcg/cpu-exec.c                 | 2 +-
 accel/tcg/tcg-runtime-gvec.c         | 2 +-
 accel/tcg/translate-all.c            | 2 +-
 accel/tcg/user-exec.c                | 2 +-
 bsd-user/main.c                      | 2 +-
 cpus.c                               | 2 +-
 exec.c                               | 2 +-
 linux-user/main.c                    | 2 +-
 target/alpha/translate.c             | 2 +-
 target/arm/helper-a64.c              | 2 +-
 target/arm/translate-a64.c           | 4 ++--
 target/arm/translate-sve.c           | 6 +++---
 target/arm/translate.c               | 4 ++--
 target/cris/translate.c              | 2 +-
 target/hppa/translate.c              | 2 +-
 target/i386/mem_helper.c             | 2 +-
 target/i386/translate.c              | 2 +-
 target/lm32/translate.c              | 2 +-
 target/m68k/translate.c              | 2 +-
 target/microblaze/translate.c        | 2 +-
 target/mips/translate.c              | 2 +-
 target/moxie/translate.c             | 2 +-
 target/nios2/translate.c             | 2 +-
 target/openrisc/translate.c          | 2 +-
 target/ppc/mem_helper.c              | 2 +-
 target/ppc/translate.c               | 4 ++--
 target/riscv/cpu_helper.c            | 2 +-
 target/riscv/translate.c             | 2 +-
 target/s390x/translate.c             | 4 ++--
 target/sh4/translate.c               | 2 +-
 target/sparc/ldst_helper.c           | 2 +-
 target/sparc/translate.c             | 2 +-
 target/tilegx/translate.c            | 2 +-
 target/tricore/translate.c           | 2 +-
 target/unicore32/translate.c         | 2 +-
 target/xtensa/translate.c            | 2 +-
 tcg/aarch64/tcg-target.inc.c         | 4 ++--
 tcg/arm/tcg-target.inc.c             | 4 ++--
 tcg/i386/tcg-target.inc.c            | 4 ++--
 tcg/mips/tcg-target.inc.c            | 2 +-
 tcg/optimize.c                       | 2 +-
 tcg/ppc/tcg-target.inc.c             | 4 ++--
 tcg/riscv/tcg-target.inc.c           | 4 ++--
 tcg/s390/tcg-target.inc.c            | 4 ++--
 tcg/sparc/tcg-target.inc.c           | 2 +-
 tcg/tcg-common.c                     | 2 +-
 tcg/tcg-op-gvec.c                    | 8 ++++----
 tcg/tcg-op-vec.c                     | 6 +++---
 tcg/tcg-op.c                         | 6 +++---
 tcg/tcg.c                            | 2 +-
 tcg/tci.c                            | 2 +-
 MAINTAINERS                          | 1 +
 61 files changed, 76 insertions(+), 76 deletions(-)
 rename {tcg =3D> include/tcg}/tcg-gvec-desc.h (100%)
 rename {tcg =3D> include/tcg}/tcg-mo.h (100%)
 rename {tcg =3D> include/tcg}/tcg-op-gvec.h (100%)
 rename {tcg =3D> include/tcg}/tcg-op.h (99%)
 rename {tcg =3D> include/tcg}/tcg-opc.h (100%)
 rename {tcg =3D> include/tcg}/tcg.h (99%)

--=20
2.21.0


