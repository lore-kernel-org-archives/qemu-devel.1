Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78040C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B440206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B440206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGo8X-0001NC-Kw
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 13:14:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5R-0007V7-Up
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGo5R-0007Qt-0T
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hGo5O-0007ND-SR; Wed, 17 Apr 2019 13:11:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 070A188312;
	Wed, 17 Apr 2019 17:11:02 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-103.phx2.redhat.com [10.3.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7AE9A19C58;
	Wed, 17 Apr 2019 17:11:01 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 12:10:59 -0500
Message-Id: <20190417171101.1254-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 17 Apr 2019 17:11:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/2] Saner printing of large file sizes
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417171059.Hr0bI7vJRHGt5p1VGcHEKBct9IlJmbhVTOPrv_QBYDo@z>

since v2: Fix problems pointed out by Max:
vmdk (test 59) output had not actually been tested
32-bit builds of size_to_str() have been been broken since 2.10

Eric Blake (2):
  cutils: Fix size_to_str() on 32-bit platforms
  qemu-img: Saner printing of large file sizes

 block/qapi.c               | 49 +++++++++-----------------------------
 util/cutils.c              |  2 +-
 tests/qemu-iotests/043.out |  6 ++---
 tests/qemu-iotests/053.out |  2 +-
 tests/qemu-iotests/059.out | 10 ++++----
 tests/qemu-iotests/060.out | 10 ++++----
 tests/qemu-iotests/061.out | 12 +++++-----
 tests/qemu-iotests/070.out |  2 +-
 tests/qemu-iotests/082.out | 26 ++++++++++----------
 tests/qemu-iotests/084.out |  8 +++----
 tests/qemu-iotests/089.out |  2 +-
 tests/qemu-iotests/095.out |  4 ++--
 tests/qemu-iotests/104.out |  6 ++---
 tests/qemu-iotests/110.out |  6 ++---
 tests/qemu-iotests/114.out |  2 +-
 tests/qemu-iotests/126.out |  4 ++--
 tests/qemu-iotests/130.out | 10 ++++----
 tests/qemu-iotests/153.out |  2 +-
 tests/qemu-iotests/191.out |  8 +++----
 tests/qemu-iotests/195.out |  4 ++--
 tests/qemu-iotests/198.out |  4 ++--
 tests/qemu-iotests/206.out | 10 ++++----
 tests/qemu-iotests/207.out | 12 +++++-----
 tests/qemu-iotests/210.out |  8 +++----
 tests/qemu-iotests/211.out | 10 ++++----
 tests/qemu-iotests/212.out | 10 ++++----
 tests/qemu-iotests/213.out | 10 ++++----
 tests/qemu-iotests/233.out |  4 ++--
 tests/qemu-iotests/237.out | 22 ++++++++---------
 tests/qemu-iotests/242.out | 10 ++++----
 30 files changed, 124 insertions(+), 151 deletions(-)

--=20
2.20.1


