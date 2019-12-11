Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1F9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C689206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDULWdhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C689206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7AM-0000Wr-LO
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 13:56:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1if79I-00086E-AP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1if79F-0006UG-TE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:55:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34843
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1if79F-0006TH-Oo
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576090545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K68BSETA9lVUevu9J6yYxMzalX9dV2wyMtU2XCSU+lg=;
 b=eDULWdhmq6vOvAxmzSGcQeQOOUWbCYSIqgDDOC/NNxBz4CV4ANxPC1BK0RbA4bmLlbuqLS
 y/Ud9+4Ksf6RnELOixR/HvYjO4pnG/2qYdQLBy2XJ6UdFV7rBmECXIgWEkaZQBI98hG9xD
 BbkT4DIzHLiuAEoyY/0LqHgbABmkUlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-c78SB3M3M_W9TYVuFgNvKw-1; Wed, 11 Dec 2019 13:55:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EC4D107ACC4
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 18:55:40 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 773D55D6AE;
 Wed, 11 Dec 2019 18:55:37 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] tests/acceptance: Use QEMUMachine on tests that expect
 failure
Date: Wed, 11 Dec 2019 13:55:34 -0500
Message-Id: <20191211185536.16962-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: c78SB3M3M_W9TYVuFgNvKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

Changes v2 -> v1:
- set_qmp_monitor() uses enabled=3DTrue instead of disabled=3DFalse
  (patch 01) [crosa]
- removed monitor_address parameter from set_qmp_monitor()
  (patch 01) [crosa]
- adjusted to use 'enabled' (patch 02) [crosa]

Changes v1 -> null:
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
- Branch: tests_without_qmp_v2

CI:
- Travis (PASS): https://travis-ci.org/wainersm/qemu/builds/623716505

References:
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg627498.html


Wainer dos Santos Moschetta (2):
  python/qemu: Add set_qmp_monitor() to QEMUMachine
  tests/acceptance: Makes linux_initrd and empty_cpu_model use
    QEMUMachine

 python/qemu/machine.py              | 66 +++++++++++++++++++----------
 tests/acceptance/empty_cpu_model.py | 12 +++---
 tests/acceptance/linux_initrd.py    | 13 +++---
 3 files changed, 56 insertions(+), 35 deletions(-)

--=20
2.21.0


