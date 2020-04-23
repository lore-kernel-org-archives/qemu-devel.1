Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C8C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DA220724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQiwgLJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DA220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jReKP-0001Zd-DP
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHl-00063I-NP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHS-00025A-FU
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jReHQ-0001xI-7n
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587657641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1ck46pRGrxkDVzNz1NGlYykwF+gi6Gl4IlxLMz7lgHw=;
 b=IQiwgLJtmBfk/pp1/1osBSPq0emKLB0gHNO0kfYFGnYJvAScjZnHO5la8pc6eBMTYnpvHs
 +xxhnywxsHH/EVq9FRNT9kEGdvzZJWeaIinBQzRAhT44hxrZgfxkQrfGvpeh6d0faKmhOa
 cFQDhCpfFejfSyHt3/OlEp1eKIUbzj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-yfXW17f7Pjed5Vw-cVR-_A-1; Thu, 23 Apr 2020 12:00:39 -0400
X-MC-Unique: yfXW17f7Pjed5Vw-cVR-_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 207648005A7;
 Thu, 23 Apr 2020 16:00:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E20EC60605;
 Thu, 23 Apr 2020 16:00:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 54FF411358BC; Thu, 23 Apr 2020 18:00:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/13] qapi: Spring cleaning
Date: Thu, 23 Apr 2020 18:00:23 +0200
Message-Id: <20200423160036.7048-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster (13):
  qapi: Belatedly update visitor.h's big comment for QAPI modules
  qapi: Fix the virtual walk example in visitor.h's big comment
  qapi: Fix typo in visit_start_list()'s contract
  qapi: Document @errp usage more thoroughly in visitor.h
  qapi: Polish prose in visitor.h
  qapi: Assert incomplete object occurs only in dealloc visitor
  qapi: Fix Visitor contract for start_alternate()
  qapi: Assert output visitors see only valid enum values
  qapi: Assert non-input visitors seeg only valid narrow integers
  qapi: Clean up visitor's recovery from input with invalid type
  qapi: Assert non-input visitors see only valid alternate tags
  qapi: Only input visitors can actually fail
  qom: Simplify object_property_get_enum()

 include/qapi/visitor-impl.h         |   9 +-
 include/qapi/visitor.h              | 192 ++++++++++++++++------------
 block.c                             |   9 +-
 block/sheepdog.c                    |   9 +-
 blockdev.c                          |  16 +--
 hw/core/machine-hmp-cmds.c          |   2 +-
 monitor/hmp-cmds.c                  |   3 +-
 qapi/qapi-dealloc-visitor.c         |   7 -
 qapi/qapi-visit-core.c              |  20 +--
 qom/object.c                        |   4 +-
 tests/test-qobject-output-visitor.c |  39 ------
 tests/test-string-output-visitor.c  |  19 ---
 scripts/qapi/visit.py               |   7 +-
 13 files changed, 141 insertions(+), 195 deletions(-)

--=20
2.21.1


