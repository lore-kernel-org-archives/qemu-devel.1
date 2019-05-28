Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EFEC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2958C208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2958C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVXR2-0000Fi-EW
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 04:26:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVXO6-0006Kv-FW
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVXO5-0002pj-IK
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:23:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVXO5-0002oy-D9
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:23:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCF696147C;
	Tue, 28 May 2019 08:23:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 54C1460DDD;
	Tue, 28 May 2019 08:23:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id DC2951138648; Tue, 28 May 2019 10:23:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 28 May 2019 10:23:04 +0200
Message-Id: <20190528082308.22032-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 28 May 2019 08:23:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] Makefile: Generalize recursion machinery
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
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We make a few sub-directories recursively, in particular
$(TARGET_DIRS).

For goal "all", we do it the nice way: "all" has a prerequisite
subdir-T for each T in $(TARGET_DIRS), and T's recipe runs make
recursively.  Behaves nicely with -j and -k.

For other goals such as "clean" and "install", the recipe runs make
recursively in a for loop.  Ignores -j and -k.

Generalize the recursion machinery used by "all" so we can reuse it
for "clean" and "install".

This was previously posted as PATCH 1-4 of "[RFC v4 0/7] Baby steps
towards saner headers".  Changes since then:
* PATCH 1: Don't lose @ [Philippe]
* PATCH 3: Update check-report-qtest-%.tap [Philippe]

Markus Armbruster (4):
  Makefile: Remove code to smooth transition to config.status
  Makefile: Drop bogus cleaning of $(ALL_SUBDIRS)/qemu-options.def
  Makefile: Rename targets for make recursion
  Makefile: Reuse all's recursion machinery for clean and install

 Makefile               | 73 ++++++++++++++++++++----------------------
 configure              |  6 ++--
 tests/Makefile.include |  5 +--
 3 files changed, 40 insertions(+), 44 deletions(-)

--=20
2.17.2


