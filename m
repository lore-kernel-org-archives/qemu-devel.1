Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513C6C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C9920787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XydK5ZhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C9920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFoi-0007P0-7o
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRFjm-0000BH-AB
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRFji-000891-Eu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:48:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36961
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRFjh-00084v-VQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587563301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GrtN8TOESb6y1QyiD4p9c8fYHGs3BJN69R9JXXahwZA=;
 b=XydK5ZhYQzuo71fxkl5nQk6svdZeCFRypLfqKfL4D/CveGzaz6E5R0x2O24TF7Nons/WD3
 JOxwEA7ZfGkvlEgpRTF+mcsFOvCNKINsgHxh2snvJOhgnQAUw957YK1qVYEjCOOHWj11Q2
 JXZBnOf1Z63+Ya5/2auO6icMQl86Vo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-Unaz_TsVN5aAKPyEYpc24w-1; Wed, 22 Apr 2020 09:48:19 -0400
X-MC-Unique: Unaz_TsVN5aAKPyEYpc24w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F2E3100960F;
 Wed, 22 Apr 2020 13:48:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A9C7600DB;
 Wed, 22 Apr 2020 13:48:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB7AA11358BC; Wed, 22 Apr 2020 15:48:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] smbus: SPD fixes
Date: Wed, 22 Apr 2020 15:48:11 +0200
Message-Id: <20200422134815.1584-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
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
Cc: philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
* PATCH 1: Do not revert commit 08fd99179a's silent change of memory
  type [Zoltan]
* PATCH 3: Improve error message some more [Philippe]

Markus Armbruster (4):
  sam460ex: Suppress useless warning on -m 32 and -m 64
  smbus: Fix spd_data_generate() error API violation
  bamboo, sam460ex: Tidy up error message for unsupported RAM size
  smbus: Fix spd_data_generate() for number of banks > 2

 include/hw/i2c/smbus_eeprom.h |  2 +-
 hw/i2c/smbus_eeprom.c         | 32 +++++---------------------------
 hw/mips/mips_fulong2e.c       | 10 ++--------
 hw/ppc/ppc4xx_devs.c          |  8 ++++----
 hw/ppc/sam460ex.c             | 13 ++++---------
 5 files changed, 16 insertions(+), 49 deletions(-)

--=20
2.21.1


