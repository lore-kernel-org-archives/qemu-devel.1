Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7915FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC6E216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 13:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC6E216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP5o6-00035S-Jg
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 09:43:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hP5mw-0002TP-9e
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hP5mv-0007TM-BZ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hP5mv-0007T1-6r
	for qemu-devel@nongnu.org; Fri, 10 May 2019 09:42:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2A503D37;
	Fri, 10 May 2019 13:42:10 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.205.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 083B61001E65;
	Fri, 10 May 2019 13:42:04 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 15:42:00 +0200
Message-Id: <20190510134203.24012-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 10 May 2019 13:42:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/3] rng-builtin: add an RNG backend that
 uses qemu_guest_getrandom()
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>,
	"Richard W . M . Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new RNG backend using QEMU builtin getrandom function.

This patch applies on top of
    "[PATCH v5 00/24] Add qemu_getrandom and ARMv8.5-RNG etc"
Based-on: 20190510012458.22706-1-richard.henderson@linaro.org

v3: Include Kashyap's patch in the series
    Add a patch to change virtio-rng default backend to rng-builtin

v2: Update qemu-options.hx
    describe the new backend and specify virtio-rng uses the
    rng-random by default

Kashyap Chamarthy (1):
  VirtIO-RNG: Update default entropy source to `/dev/urandom`

Laurent Vivier (2):
  rng-builtin: add an RNG backend that uses qemu_guest_getrandom()
  virtio-rng: change default backend to rng-builtin

 backends/Makefile.objs         |  2 +-
 backends/rng-builtin.c         | 54 ++++++++++++++++++++++++++++++++++
 backends/rng-random.c          |  2 +-
 hw/virtio/virtio-rng.c         |  2 +-
 include/hw/virtio/virtio-rng.h |  4 +--
 include/sysemu/rng-builtin.h   | 17 +++++++++++
 qemu-options.hx                |  9 +++++-
 7 files changed, 84 insertions(+), 6 deletions(-)
 create mode 100644 backends/rng-builtin.c
 create mode 100644 include/sysemu/rng-builtin.h

--=20
2.20.1


