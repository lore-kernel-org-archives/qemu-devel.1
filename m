Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55009C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 21:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCDC26242
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 21:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCDC26242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWT5D-0006P0-Dk
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 17:59:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hWT3i-0005XA-Rm
	for qemu-devel@nongnu.org; Thu, 30 May 2019 17:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hWT3h-0001V1-Mm
	for qemu-devel@nongnu.org; Thu, 30 May 2019 17:58:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hWT3h-0001Sq-HP
	for qemu-devel@nongnu.org; Thu, 30 May 2019 17:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BB393082B6B
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 21:57:58 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
	(virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B47E564026;
	Thu, 30 May 2019 21:57:55 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 17:57:54 -0400
Message-Id: <20190530215755.328-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 30 May 2019 21:57:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/1] -accel should list enabled accelerators
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
Cc: pbonzini@redhat.com, philmd@redhat.com, ehabkost@redhat.com,
	crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On this series I changed the semantics of -accel help so that
it shows only the accelerators enabled in the QEMU target
binary. This behavior is now alike -cpu and -machine helps.

Another reason for this proposal is that I am working on
an improvement of Avocado QEMU framework which should skip
tests tagged with, e.g, "accel:tcg" if tcg is not enabled
in the binary. And it seems the best approach to detect
the presence (or not) of an accelerator is to query QEMU
with -accel help.

Phillipe Mathieu-Daud=C3=A9 proposed a similar fix [1] but it
was never merged. My patch is slightly different but it
implements some decisions that seemed consensus at that time:

1. Do not display qtest. It's an internal only accelerator.
2. It should display those that have support on the target
binary, regardless if they are not present on the host.

Example with this patch on x86_64 host (kvm not installed):
---
$ configure --enable-kvm --enable-xen --target-list=3D"x86_64-softmmu ppc=
64-softmmu"
$ x86_64-softmmu/qemu-system-x86_64 -accel help
Accelerators supported in QEMU binary:
tcg
xen
kvm
$ ppc64-softmmu/qemu-system-ppc64 -accel help
Accelerators supported in QEMU binary:
tcg
---

Git: https://github.com/wainersm/qemu
Branch: accel_list
Travis: https://travis-ci.org/wainersm/qemu/builds/539366851

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg491542.html

Wainer dos Santos Moschetta (1):
  vl: make -accel help to list enabled accelerators only

 vl.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--=20
2.21.0


