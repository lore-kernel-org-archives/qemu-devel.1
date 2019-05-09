Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B71EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403332173B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403332173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOike-0000wx-E6
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:06:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOiie-0007fd-Fs
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hOiid-0007fM-Gt
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:04:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hOiid-0007M6-C0
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:04:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0386C3079B66
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 13:03:53 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-227.ams2.redhat.com
	[10.36.116.227])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC5DA60F8A;
	Thu,  9 May 2019 13:03:49 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:03:42 +0200
Message-Id: <20190509130345.227526-2-sgarzare@redhat.com>
In-Reply-To: <20190509130345.227526-1-sgarzare@redhat.com>
References: <20190509130345.227526-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 09 May 2019 13:03:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/4] net: fix assertion failure when
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
---
 net/net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/net.c b/net/net.c
index f3a3c5444c..d5071e49e2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1134,11 +1134,11 @@ static int net_client_init(QemuOpts *opts, bool i=
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
@@ -1160,6 +1160,7 @@ static int net_client_init(QemuOpts *opts, bool is_=
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


