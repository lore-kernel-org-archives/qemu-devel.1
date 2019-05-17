Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC75C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D519420873
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D519420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdHn-0003Kl-3r
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:52:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hRdDU-0008St-8F
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hRdDS-0003Xo-AH
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hRdDQ-0003Vv-Im
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:48:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDC4DC0A4F49
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 13:47:58 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-83.ams2.redhat.com
	[10.36.116.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91CB37A463;
	Fri, 17 May 2019 13:47:57 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 15:47:45 +0200
Message-Id: <20190517134748.340381-2-sgarzare@redhat.com>
In-Reply-To: <20190517134748.340381-1-sgarzare@redhat.com>
References: <20190517134748.340381-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 17 May 2019 13:47:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/4] net: fix assertion failure when
 ipv6-prefixlen is not a number
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
Cc: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If 'ipv6-prefixlen' is not a number, the current behaviour
produces an assertion failure:
    $ qemu-system-x86_64 -net user,ipv6-net=3Dfeca::0/a
    qemu-system-x86_64: qemu/util/qemu-option.c:1175: qemu_opts_foreach:
    Assertion `!errp || !*errp' failed.
    Aborted (core dumped)

This patch fixes it, jumping to the end of the function when
'ipv6-prefixlen' is not a number, and printing the more friendly
message:
    $ qemu-system-x86_64 -net user,ipv6-net=3Dfeca::0/a
    qemu-system-x86_64: Parameter 'ipv6-prefixlen' expects a number

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 net/net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/net.c b/net/net.c
index 2cf5e76469..555504a404 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1135,11 +1135,11 @@ static int net_client_init(QemuOpts *opts, bool i=
s_netdev, Error **errp)
=20
                 if (err) {
                     error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
-                              "ipv6-prefix", "a number");
-                } else {
-                    qemu_opt_set_number(opts, "ipv6-prefixlen", len,
-                                        &error_abort);
+                               "ipv6-prefixlen", "a number");
+                    goto out;
                 }
+
+                qemu_opt_set_number(opts, "ipv6-prefixlen", len, &error_=
abort);
             }
             qemu_opt_unset(opts, "ipv6-net");
         }
@@ -1161,6 +1161,7 @@ static int net_client_init(QemuOpts *opts, bool is_=
netdev, Error **errp)
         qapi_free_NetLegacy(object);
     }
=20
+out:
     error_propagate(errp, err);
     visit_free(v);
     return ret;
--=20
2.20.1


