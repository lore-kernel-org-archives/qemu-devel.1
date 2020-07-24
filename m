Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFDBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FF420714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 05:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkM1dE1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FF420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyqFg-0007v8-ID
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 01:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAw-0001EZ-Ta
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55407
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jyqAv-0007U0-F3
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 01:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595568196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S/EA+w6rgwhcHjwOl4nlZ8Lovml4gA2gMfAmnWUHcDo=;
 b=UkM1dE1UyutJPYa6JDMOfTT+fuyjZhFuO6pH2hz555jvMUWN6dLWutHE8+TqDq4LW3xrR9
 jAwkgKGX2jEFVNDnhcM/3nNn9SMtUkMI5dHwOinKfHJJ9XUqclcqowOi4kcZmxHAqK4v47
 eeh9YJfkfh93zh1n0hpxRknjYfJExvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-arrSvDUDN-eoo3uSCIndrQ-1; Fri, 24 Jul 2020 01:23:02 -0400
X-MC-Unique: arrSvDUDN-eoo3uSCIndrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB6411009440;
 Fri, 24 Jul 2020 05:23:01 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-120-206.rdu2.redhat.com [10.10.120.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1ED307AC80;
 Fri, 24 Jul 2020 05:23:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] IDE: SRST and other fixes
Date: Fri, 24 Jul 2020 01:22:53 -0400
Message-Id: <20200724052300.1163728-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 01:23:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Alexander Bulekov <alxndr@bu.edu>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The goal of this series is to fix the Software Reset (SRST) routine.=0D
That said, the first six patches are almost entirely unrelated...=0D
=0D
Patches 2, 3, and 6 fix extremely minor deviations from the spec I=0D
noticed while researching SRST. (One of them gets rid of a FIXME from=0D
2003.)=0D
=0D
Patches 1, 4, and 5 are very small code cleanups that don't cause any=0D
functional changes that should make patches 2, 3, and 6 more obvious to=0D
review.=0D
=0D
Patch 7 fixes SRST; it depends on the other patches only for a changed=0D
constant name. With a small rebase, it could be suitable for 5.1.=0D
=0D
John Snow (7):=0D
  ide: rename cmd_write to ctrl_write=0D
  ide: don't tamper with the device register=0D
  ide: model HOB correctly=0D
  ide: reorder set/get sector functions=0D
  ide: remove magic constants from the device register=0D
  ide: clear interrupt on command write=0D
  ide: cancel pending callbacks on SRST=0D
=0D
 include/hw/ide/internal.h |  21 +++++--=0D
 hw/ide/core.c             | 124 +++++++++++++++++++++++---------------=0D
 hw/ide/ioport.c           |   2 +-=0D
 hw/ide/macio.c            |   2 +-=0D
 hw/ide/mmio.c             |   8 +--=0D
 hw/ide/pci.c              |  12 ++--=0D
 hw/ide/trace-events       |   2 +-=0D
 7 files changed, 106 insertions(+), 65 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


