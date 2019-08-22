Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FC6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7EF233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7EF233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oNw-00029t-It
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0oHa-0003uw-Jd
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0oHX-0002gu-Tx
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i0oHX-0002ec-Nc; Thu, 22 Aug 2019 10:41:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AF61A70E;
 Thu, 22 Aug 2019 14:41:42 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 273435D6A7;
 Thu, 22 Aug 2019 14:41:36 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: slirp@lists.freedesktop.org
Date: Thu, 22 Aug 2019 16:41:32 +0200
Message-Id: <20190822144134.23521-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 22 Aug 2019 14:41:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] slirp: Fix heap buffer overflow during
 packet reassembly (CVE-2019-14378)
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org, Petr Matousek <pmatouse@redhat.com>,
 qemu-devel@nongnu.org, Prasad J Pandit <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, this is a SLiRP bug, however as QEMU comsumes the library, it is
directly concerned, so I'm cross-posting both QEMU and SLiRP lists
for a stricter review.

The 2nd patch is a PoC, to give QEMU a chance to shutdown properly
if SLiRP internals get corrupted. Simply sent as RFC.

The vulnerability is very well described here:
https://vishnudevtj.github.io/notes/qemu-vm-escape-cve-2019-14378

Exploit (used as reproducer):
https://github.com/vishnudevtj/exploits/blob/master/qemu/CVE-2019-14378/e=
xp.c

Philippe Mathieu-Daud=C3=A9 (2):
  Do not reassemble fragments pointing outside of the original payload
  RFC Delay crash when mbufs are corrupted

 src/ip_input.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--=20
2.20.1


