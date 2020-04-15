Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA567C2BB85
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FFA206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVP9igO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FFA206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOdVM-0000Fu-RZ
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 04:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOdRf-0002j3-AZ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOdRe-0004KE-41
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55960
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOdRd-0004Ii-SO
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 04:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586939453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9B2KP4LXGa4bCYSs6QlLPCoOKi3ra0OsfqNB6tL8mHo=;
 b=BVP9igO+W1UmJP5BsoeqKr9fPTPx/4Y8gF+WybUQh7WIuJdNBMchghy+N57KpIwVRzPuoB
 lZonmvXs3kc9oiHv432xK8pvbFPjTtdLFcP/0EpgP2SOYIPXidZRV22HloTv7CVC/8sCPG
 xnE6VOKllhqq6womglrWKuiAmWwMPeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-YMMb0uwAM8q_Lum1b6MJ6A-1; Wed, 15 Apr 2020 04:30:51 -0400
X-MC-Unique: YMMb0uwAM8q_Lum1b6MJ6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FCC719067E3;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E93C5C1B2;
 Wed, 15 Apr 2020 08:30:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9915111385C8; Wed, 15 Apr 2020 10:30:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 0/5] qobject: Minor spring cleaning
Date: Wed, 15 Apr 2020 10:30:43 +0200
Message-Id: <20200415083048.14339-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Markus Armbruster (5):
  qobject: Clean up QLIST_FOREACH_ENTRY()
  qobject: Factor out helper json_pretty_newline()
  qobject: Eliminate qlist_iter(), use QLIST_FOREACH_ENTRY() instead
  qobject: Eliminate qdict_iter(), use qdict_first(), qdict_next()
  qemu-option: Clean up after the previous commit

 include/qapi/qmp/qdict.h     |   3 -
 include/qapi/qmp/qlist.h     |  10 ++--
 qapi/qobject-input-visitor.c |  21 +++----
 qobject/qdict.c              |  19 -------
 qobject/qjson.c              | 107 +++++++++++++----------------------
 qobject/qlist.c              |  44 ++++----------
 tests/check-qlist.c          |  37 +++++-------
 util/qemu-option.c           |  43 +++++++-------
 8 files changed, 98 insertions(+), 186 deletions(-)

--=20
2.21.1


