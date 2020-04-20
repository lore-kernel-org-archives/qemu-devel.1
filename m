Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1294C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9F820735
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdUG3K1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9F820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWXI-0003z6-S4
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59620 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQWTV-0007Sh-T5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:38 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQWTS-0002sH-Kp
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26241
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQWTS-0002lX-2S
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587389312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DXpqKi3g09GVfDfB28U6QJGMtxJDpE9EYMqat2A2hhI=;
 b=JdUG3K1oR1HuJL/U+b2C1bxwxWgQ/wSxcp/CCxWroIxrTyHs+s+52mHXKnXQ3NJRZaDCjo
 tmdta1zyBeh8K/Adj9J/1T/IBAT4x7NSUoJFnJYc+GXOAK2EfOzhvArw5DPj23mMyHHzHm
 hvfns0W54mp0SxpSBfxrPEWqr++ikvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-DbemzOaxNBCuZSEFuslmAw-1; Mon, 20 Apr 2020 09:28:30 -0400
X-MC-Unique: DbemzOaxNBCuZSEFuslmAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A0A380256A;
 Mon, 20 Apr 2020 13:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C70838D;
 Mon, 20 Apr 2020 13:28:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1AD8411358BC; Mon, 20 Apr 2020 15:28:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] Subject: [PATCH 0/4] smbus: SPD fixes
Date: Mon, 20 Apr 2020 15:28:22 +0200
Message-Id: <20200420132826.8879-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PATCH 1 fixes a regression, but it's a rather old one: regressed in
v4.0.0.  I doubt it needs to go into 5.0 at this stage.  But it's up
to the maintainer(s).

Markus Armbruster (4):
  sam460ex: Revert change to SPD memory type for <=3D 128 MiB
  smbus: Fix spd_data_generate() error API violation
  bamboo, sam460ex: Tidy up error message for unsupported RAM size
  smbus: Fix spd_data_generate() for number of banks > 2

 include/hw/i2c/smbus_eeprom.h |  2 +-
 hw/i2c/smbus_eeprom.c         | 32 +++++---------------------------
 hw/mips/mips_fulong2e.c       | 10 ++--------
 hw/ppc/ppc4xx_devs.c          |  4 ++--
 hw/ppc/sam460ex.c             | 13 ++++---------
 5 files changed, 14 insertions(+), 47 deletions(-)

--=20
2.21.1


