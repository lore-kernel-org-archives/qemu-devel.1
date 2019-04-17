Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A508C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D32B206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D32B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58191 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGpyQ-00035X-Ed
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:11:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptO-0007dy-Hx
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGptN-0003Y8-Eq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGptN-0003Wr-2l
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:06:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B46453199363
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:06:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A805D9D6
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:06:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id C8A891138648; Wed, 17 Apr 2019 21:06:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:06:26 +0200
Message-Id: <20190417190641.26814-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 17 Apr 2019 19:06:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 00/15] Clean up use of error_printf()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417190626.NC-ax-aiCzCmG6jN_9a9u4YCAei67TRs-IfXr0VTulI@z>

This series cleans up two kinds of error_printf() misuse:

* Errors and warnings should be reported with error_report() and
  warn_report().

* Help output should be go to stdout, not stderr.

This is obviously for 4.1.  If nobody objects, I'll take the whole
series through my tree.

Based-on: <20190131164614.19209-1-cfergeau@redhat.com>

v3:
* PATCH 03: Replaced by new PATCH 14 [Paolo]
* PATCH 10: Trivial conflict with "[PATCH v7 0/2] log: Make glib
  logging go through QEMU" resolved.

v2:
* PATCH 02: Commit message tweaked, indentation fixed [Eric]
* PATCH 10: Indentation fixed [Marcel]
* PATCH 11: Use-after-free fixed [Patchew]
* PATCH 12: test-util-sockets.c updated along with stubs/monitor.c
* PATCH 14: Commit message typo [Eric]

Markus Armbruster (15):
  qemu-img: Use error_vreport() in error_exit()
  block/ssh: Do not report read/write/flush errors to the user
  loader-fit: Wean off error_printf()
  mips/boston: Report errors with error_report(), not error_printf()
  pci: Report fatal errors with error_report(), not error_printf()
  hpet: Report warnings with warn_report(), not error_printf()
  vfio: Report warnings with warn_report(), not error_printf()
  s390x/kvm: Report warnings with warn_report(), not error_printf()
  vl: Make -machine $TYPE,help and -accel help print to stdout
  monitor error: Make printf()-like functions return a value
  qemu-print: New qemu_printf(), qemu_vprintf() etc.
  blockdev: Make -drive format=3Dhelp print to stdout
  char: Make -chardev help print to stdout
  char-pty: Print "char device redirected" message to stdout
  monitor: Simplify how -device/device_add print help

 MAINTAINERS                 |  2 ++
 block/ssh.c                 | 38 +++++++-------------
 block/trace-events          |  3 ++
 blockdev.c                  |  9 ++---
 chardev/char-pty.c          |  5 +--
 chardev/char.c              |  3 +-
 hw/core/loader-fit.c        | 62 +++++++++++++++++++--------------
 hw/mips/boston.c            |  6 ++--
 hw/pci/pci.c                |  2 +-
 hw/timer/hpet.c             |  2 +-
 hw/vfio/pci.c               | 19 ++++++----
 include/monitor/monitor.h   |  7 ++--
 include/qemu/error-report.h |  8 ++---
 include/qemu/qemu-print.h   | 19 ++++++++++
 monitor.c                   | 69 ++++++++++++++++++-------------------
 qdev-monitor.c              | 36 ++++++++-----------
 qemu-img.c                  |  6 ++--
 stubs/error-printf.c        | 13 ++++---
 stubs/monitor.c             |  5 +++
 target/s390x/kvm.c          |  2 +-
 tests/test-util-sockets.c   |  1 +
 util/Makefile.objs          |  1 +
 util/qemu-error.c           | 12 ++++---
 util/qemu-print.c           | 42 ++++++++++++++++++++++
 vl.c                        | 10 +++---
 25 files changed, 227 insertions(+), 155 deletions(-)
 create mode 100644 include/qemu/qemu-print.h
 create mode 100644 util/qemu-print.c

--=20
2.17.2


