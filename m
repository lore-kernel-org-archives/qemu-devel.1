Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52446C282DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F09E2146E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 13:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F09E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1i9-0007zx-Ex
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 09:31:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dp-0004fe-0f
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dm-00053W-PQ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hG1dj-00051y-4u; Mon, 15 Apr 2019 09:27:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA0DBC4EAC;
	Mon, 15 Apr 2019 13:27:06 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CFB781001E84;
	Mon, 15 Apr 2019 13:27:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Apr 2019 15:27:17 +0200
Message-Id: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 15 Apr 2019 13:27:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 0/5] Fix misuses of
 memory_region_allocate_system_memory()
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
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
	Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415132717.3Do34Q2uDmktAslZSUThsJztY2oMBSM_rnXfHXq56bE@z>


memory_region_allocate_system_memory() is supposed to be called only once=
,
but due to lack of the check some boards abused it by  calling it multipl=
e times.
So here goes fixes that replace it with  memory_region_init_ram() in most=
 of
the cases.
However s390 case a bit convolted as we have to keep cross version migrat=
ion
working and need -mem-path to work there as well. To make it happen I hac=
ked
MemoryRegion aliases to work with migration by allocating 'fake' RAMBlock=
 that
aliases original RAM pointer (asking for comments on approach since I hav=
e no
idea how migration works really). It is one way to fix s390 while not abu=
sing
memory_region_allocate_system_memory() and making it work with -mem-path
correctly.
(another a bit more dirty way would be adding machine callback to handle
 -mem-path and overiding it in s390, but migratable aliases approach look=
s more
cleaner to me API wise and have potential to be reused if we would need t=
o
fix up RAM layout but keep migration stream compatible).

CC: Paolo Bonzini <pbonzini@redhat.com>=20
CC: Richard Henderson <rth@twiddle.net>=20
CC: Helge Deller <deller@gmx.de>=20
CC: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>=20
CC: David Gibson <david@gibson.dropbear.id.au>=20
CC: Cornelia Huck <cohuck@redhat.com>=20
CC: Halil Pasic <pasic@linux.ibm.com>=20
CC: Christian Borntraeger <borntraeger@de.ibm.com>=20
CC: David Hildenbrand <david@redhat.com>=20
CC: Artyom Tarasenko <atar4qemu@gmail.com>=20
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>=20
CC: qemu-ppc@nongnu.org
CC: qemu-s390x@nongnu.org

Igor Mammedov (5):
  sparc64: use memory_region_allocate_system_memory() only for '-m'
    specified RAM
  ppc: rs6000_mc: drop usage of memory_region_allocate_system_memory()
  hppa: drop usage of memory_region_allocate_system_memory() for ROM
  memory: make MemoryRegion alias migratable
  s390: do not call memory_region_allocate_system_memory() multiple
    times

 exec.c                     |  7 ++++---
 hw/hppa/machine.c          |  5 ++---
 hw/ppc/rs6000_mc.c         | 15 ++++++++++-----
 hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++-----
 hw/sparc64/niagara.c       | 25 +++++++++++++------------
 memory.c                   |  5 +++++
 6 files changed, 49 insertions(+), 28 deletions(-)

--=20
2.7.4


