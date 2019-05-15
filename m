Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF535C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8961A2070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8961A2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0cE-0008GG-Pp
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:35:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yf-0005oE-K7
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hR0Yd-0002Bp-M2
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:31:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hR0Yb-00029r-QT; Wed, 15 May 2019 16:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C795F300513A;
	Wed, 15 May 2019 20:31:17 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1BBE66266C;
	Wed, 15 May 2019 20:31:12 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:31:07 +0200
Message-Id: <20190515203112.506-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 15 May 2019 20:31:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v1 0/5] s390x/tcg: Vector Instruction Support
 Part 3
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the third part of vector instruction support for s390x. It is bas=
ed
on part 2, which is will send a pull-request for to Conny soon.

Part 1: Vector Support Instructions
Part 2: Vector Integer Instructions
Part 3: Vector String Instructions
Part 4: Vector Floating-Point Instructions

The current state can be found at (kept updated):
    https://github.com/davidhildenbrand/qemu/tree/vx

With the current state I can boot Linux kernel + user space compiled with
SIMD support. This allows to boot distributions compiled exclusively for
z13, requiring SIMD support. Also, it is now possible to build a complete
kernel using rpmbuild as quite some issues have been sorted out.

In this part, all Vector String Instructions introduced with the
"Vector Facility" are added.

David Hildenbrand (5):
  s390x/tcg: Implement VECTOR FIND ANY ELEMENT EQUAL
  s390x/tcg: Implement VECTOR FIND ELEMENT EQUAL
  s390x/tcg: Implement VECTOR FIND ELEMENT NOT EQUAL
  s390x/tcg: Implement VECTOR ISOLATE STRING
  s390x/tcg: Implement VECTOR STRING RANGE COMPARE

 target/s390x/Makefile.objs       |   2 +-
 target/s390x/helper.h            |  32 +++
 target/s390x/insn-data.def       |  13 ++
 target/s390x/translate_vx.inc.c  | 164 ++++++++++++++
 target/s390x/vec_string_helper.c | 358 +++++++++++++++++++++++++++++++
 5 files changed, 568 insertions(+), 1 deletion(-)
 create mode 100644 target/s390x/vec_string_helper.c

--=20
2.20.1


