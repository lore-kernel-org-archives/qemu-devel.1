Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3416AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F026F206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTxTytsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F026F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUWk9-000283-QR
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iUWiC-0000lj-W6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iUWiB-0005l2-Ha
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:00:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45371
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iUWiB-0005ku-E6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573567203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QMaz93oeeSwpj+0Bg8d84jsyitV/43/J5C+F+DvC3MY=;
 b=DTxTytsR7z0nwBn0IotiXLqDIDVkQI9RDYHj2I9M873te9JBvBiTm0gmJ4j+PAyr8Z818Z
 gwaXX593e5k02gMxm3GacWx4bJDETdEF/oXS0t3oUowIiMH3DXtCXyQVLA5KWes4OTsRgI
 SkLUtIbPIavVUex9WxmH42ThUej/y7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-e-q08fHBN5-Uz45moYrp1g-1; Tue, 12 Nov 2019 08:58:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59E39107ACC5
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 13:58:10 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84F0B100EBAC;
 Tue, 12 Nov 2019 13:58:02 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tests/acceptance: Use QEMUMachine on tests that expect
 failure
Date: Tue, 12 Nov 2019 08:57:59 -0500
Message-Id: <20191112135801.854-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: e-q08fHBN5-Uz45moYrp1g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The linux_initrd and empty_cpu_model tests assert that QEMU exit
with failure on certain scenarios. Currently they are not able
to use QEMUMachine object due to the QMP monitor connection which
is tentatively established always. Instead they handle the QEMU binary
directy, but ideally they should use QEMUMachine in order to:
 a) Take advantage of error handling and logging in QEMUMachine.
 b) Follow the pattern in other acceptance tests.

Notes worth it:
 - Patch 01 first appeared in [1]. Here I propose the same
   implementation but the code was rebased.
 - empty_cpu_model used to check both stdout and stderr of the process. The
   QEMUMachine doesn't provide an interface to access the underneath
   process object, instead the process' output is available through
   get_log(). This method in turn returns the content of stdout (stderr is
   redirected to stdout). Therefore, I adapted the assertion statement
   to check the '-cpu option cannot be empty' message shows in the output.

Git:
 - Tree: https://github.com/wainersm/qemu
 - Branch: tests_without_qmp

CI:
 - Travis (PASS): https://travis-ci.org/wainersm/qemu/builds/610499693

References:
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg627498.html

Wainer dos Santos Moschetta (2):
  python/qemu: Add set_qmp_monitor() to QEMUMachine
  tests/acceptance: Makes linux_initrd and empty_cpu_model use
    QEMUMachine

 python/qemu/machine.py              | 68 +++++++++++++++++++----------
 tests/acceptance/empty_cpu_model.py | 13 +++---
 tests/acceptance/linux_initrd.py    | 13 +++---
 3 files changed, 59 insertions(+), 35 deletions(-)

--=20
2.18.1


