Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4115FC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19740208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19740208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49283 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVtHm-0004Go-D9
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:46:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hVszv-0006XV-HE
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hVszu-00083R-Ld
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:27:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hVszt-00082s-Fj; Wed, 29 May 2019 03:27:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81B89308795E;
	Wed, 29 May 2019 07:27:40 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-110.ams2.redhat.com [10.36.116.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AFF5F5D704;
	Wed, 29 May 2019 07:27:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:27:24 +0200
Message-Id: <20190529072726.7875-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 29 May 2019 07:27:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 0/2] s390x: Fix vector register alignment
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the alignment of "vregs". While at it, use an uin64_t as data type.

David Hildenbrand (2):
  s390x: Align vector registers to 16 bytes
  s390x: Use uint64_t for vector registers

 linux-user/s390x/signal.c  |   4 +-
 target/s390x/arch_dump.c   |   8 +--
 target/s390x/cpu.h         |   4 +-
 target/s390x/excp_helper.c |   6 +-
 target/s390x/gdbstub.c     |  16 ++---
 target/s390x/helper.c      |  10 +--
 target/s390x/kvm.c         |  16 ++---
 target/s390x/machine.c     | 128 ++++++++++++++++++-------------------
 target/s390x/translate.c   |   2 +-
 9 files changed, 97 insertions(+), 97 deletions(-)

--=20
2.20.1


