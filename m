Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54647C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20AE0207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azCjl5Ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AE0207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEdV-0004Ix-9N
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZEZu-0000cL-Fk
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZEZt-0007mj-GY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:38:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21646
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZEZr-0007jM-Hs
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574689133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+SDnVEfOIyCi9EuodMwOEa0JTuaBFPb0j71Q8OKR2TY=;
 b=azCjl5IiOffWGuTsq+QZfb5Gui7Zsqz2BokvvalNwS71hNZcw/cCM9rlvm5X0qdH5SwguB
 JKQWlBW7B4mQOCVreO1DDuqUImgk8vKdwTzTRGWfLQSQ+lSp8k/tJpr0G/2cqsrUWm1nq0
 JE7B6PlZ0x2Sw7ocw9AmI6kiAEMGrps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-GOTaw1AkOsebSxPVcNK9Qg-1; Mon, 25 Nov 2019 08:38:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDA3A107ACE4;
 Mon, 25 Nov 2019 13:38:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81AA319C69;
 Mon, 25 Nov 2019 13:38:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02FC11138606; Mon, 25 Nov 2019 14:38:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Minor integer parsing improvements
Date: Mon, 25 Nov 2019 14:38:44 +0100
Message-Id: <20191125133846.27790-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GOTaw1AkOsebSxPVcNK9Qg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, tao3.xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not for 4.2, of course.

Markus Armbruster (2):
  util/cutils: Turn FIXME comment into QEMU_BUILD_BUG_ON()
  test-keyval: Tighten test of trailing crap after size

 tests/test-keyval.c | 2 +-
 util/cutils.c       | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

--=20
2.21.0


