Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7390C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9612084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9612084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40441 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxy4-0005hb-Pt
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:45:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQxwF-0004Vb-TA
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQxwE-0004Kf-UN
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:43:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hQxwE-0004K3-OT
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:43:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34230E1F0A
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 17:43:33 +0000 (UTC)
Received: from thuth.com (ovpn-117-96.ams2.redhat.com [10.36.117.96])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6AFD1166A9;
	Wed, 15 May 2019 17:43:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Wed, 15 May 2019 19:43:22 +0200
Message-Id: <20190515174328.16361-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 15 May 2019 17:43:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/6] Get rid of global_qtest in q35-, qom-,
 numa- and more tests
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here are some more patches that get rid of global_qtest and related
functions in some of the qtests (hacked along the way while waiting
for other compilation and test processes to finish). A global variable
like global_qtest is very problematic in tests that track multiple test
states (like migration tests). But since we often share code between
tests, it is better to avoid these global_qtest related functions
completely - i.e. the plan is to get rid of global_qtest completely
in the long run.

Thomas Huth (6):
  tests/libqos: Get rid of global_qtest dependency in qvring_init()
  tests/q35-test: Make test independent of global_qtest
  tests/numa-test: Use qtest_init() instead of qtest_start()
  tests/qom-test: Use qtest_init() instead of qtest_start()
  tests/device-introspect: Use qtest_init() instead of qtest_start()
  tests/hd-geo-test: Use qtest_init() instead of qtest_start()

 tests/device-introspect-test.c | 85 ++++++++++++++++++----------------
 tests/hd-geo-test.c            | 76 ++++++++++++++++--------------
 tests/libqos/virtio-mmio.c     |  2 +-
 tests/libqos/virtio-pci.c      |  3 +-
 tests/libqos/virtio.c          | 18 +++----
 tests/libqos/virtio.h          |  3 +-
 tests/numa-test.c              | 53 ++++++++++++---------
 tests/q35-test.c               | 39 +++++++---------
 tests/qom-test.c               | 28 ++++++-----
 9 files changed, 163 insertions(+), 144 deletions(-)

--=20
2.21.0


