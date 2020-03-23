Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E4C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8767E20637
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnZtenow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8767E20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGM7v-0006iB-Mu
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jGM72-0005VC-H8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jGM71-00061F-Bd
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:53882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jGM71-00060p-82
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584966202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5MLpz6R8kFKg+N/NE7v/pfrWzyN3aQRMue3h6vLnFdw=;
 b=SnZtenowxMaAlpk25zj+x5YctCsaH6kPJlSmGl14imjCjVnvRHstwzTjhF5aDJE+JXxeBx
 oQSqwxCE+Ec+FoCyiXWgjBUc5j58ihy0HOKbrnUUopKBmhrwpYI8Vv1pQ5F26ksPXLC107
 bxfvMHSjaY+mbsM7EqKDVnSPV9BzWws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-4AaDoth7O9G-oTgP2ma9lA-1; Mon, 23 Mar 2020 08:23:15 -0400
X-MC-Unique: 4AaDoth7O9G-oTgP2ma9lA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81A03800D50;
 Mon, 23 Mar 2020 12:23:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-176.phx2.redhat.com
 [10.3.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F7711001B09;
 Mon, 23 Mar 2020 12:23:04 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH v6 0/2] net: tulip: add checks to avoid OOB access
Date: Mon, 23 Mar 2020 17:50:58 +0530
Message-Id: <20200323122100.893417-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <pangpei.lq@antfin.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Hello,

* This series adds checks to avoid potential OOB access and infinite loop
  issues while processing rx/tx data.

* Tulip tx descriptors are capped at 128 to avoid infinite loop in
  tulip_xmit_list_update(), wrt Tulip kernel driver
  -> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/net/ethernet/dec/tulip/tulip.h#n319

* Update v3: add .can_receive routine
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html

* Update v4: flush queued packets once they are received
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg05868.html

* Update v5: fixed a typo in patch commit message
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06209.html

* Update v6: merge earlier patch 2 & 3 into one
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06868.html

Thank you.
--
Prasad J Pandit (2):
  net: tulip: check frame size and r/w data length
  net: tulip: add .can_receive routine

 hw/net/tulip.c | 51 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 9 deletions(-)

--
2.25.1


