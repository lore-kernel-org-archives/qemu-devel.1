Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97F6C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99673205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99673205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42682 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH8cB-00008r-RP
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:06:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8V2-0002PV-JZ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH8QM-0002Bx-2M
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH8QL-0002Ao-Rf
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 929EA30254A2
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 641D55D9C5
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D7C861138648; Thu, 18 Apr 2019 16:53:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 16:53:49 +0200
Message-Id: <20190418145355.21100-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 18 Apr 2019 14:53:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/6] Fix misuse of ctype.h functions
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418145349.d4HSAVVY4G8aT4L8ahOQ0kS_rqYPRbS7DiESLGd_DN0@z>

Markus Armbruster (6):
  qemu-bridge-helper: Fix misuse of isspace()
  tests/vhost-user-bridge: Fix misuse of isdigit()
  gdbstub: Reject invalid RLE repeat counts
  gdbstub: Fix misuse of isxdigit()
  pc-bios/s390-ccw: Clean up harmless misuse of isdigit()
  cutils: Simplify how parse_uint() checks for whitespace

 gdbstub.c                 | 16 ++++++++--------
 pc-bios/s390-ccw/libc.c   |  2 +-
 pc-bios/s390-ccw/menu.c   |  2 +-
 qemu-bridge-helper.c      |  7 ++++---
 tests/vhost-user-bridge.c |  2 +-
 util/cutils.c             |  2 +-
 6 files changed, 16 insertions(+), 15 deletions(-)

-- 
2.17.2


