Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB82C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B43233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B43233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oJG-0005r1-Hl
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0oHf-00045l-3p
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0oHe-0002oz-5w
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:41:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i0oHd-0002oD-Vw; Thu, 22 Aug 2019 10:41:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44544308FC4E;
 Thu, 22 Aug 2019 14:41:49 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BECCB5D6A7;
 Thu, 22 Aug 2019 14:41:46 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: slirp@lists.freedesktop.org
Date: Thu, 22 Aug 2019 16:41:34 +0200
Message-Id: <20190822144134.23521-3-philmd@redhat.com>
In-Reply-To: <20190822144134.23521-1-philmd@redhat.com>
References: <20190822144134.23521-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 22 Aug 2019 14:41:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 2/2] Delay crash when mbufs are corrupted
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

If the mbufs linked list is corrupted, give the application
a chance to properly shutdown itself without causing dataloss.

For now, this means slowly leaking the heap.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 src/ip_input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/ip_input.c b/src/ip_input.c
index ee52085..36962b5 100644
--- a/src/ip_input.c
+++ b/src/ip_input.c
@@ -185,6 +185,15 @@ void ip_input(struct mbuf *m)
             if (ip =3D=3D NULL)
                 return;
             m =3D dtom(slirp, ip);
+            if (m =3D=3D NULL) {
+                /* The mbufs linked list is corrupted, we
+                 * should properly shutdown the application.
+                 * We prefer to leak a mbuf on the heap
+                 * rather than allowing null dereference
+                 * and eventual crash (data corruption).
+                 */
+                return; /* TODO warn the library consumer! */
+            }
         } else if (fp)
             ip_freef(slirp, fp);
=20
--=20
2.20.1


