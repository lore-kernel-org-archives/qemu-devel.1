Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8F1C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7EB214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7EB214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY95g-0002EC-1F
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 09:03:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hY93a-0000xU-50
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hY93L-0001X9-0P
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:00:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36870 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hY93K-0000Jh-Ke
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:00:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id CC9DD1A2106;
	Tue,  4 Jun 2019 14:59:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 900B01A1DC9;
	Tue,  4 Jun 2019 14:59:31 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 14:59:00 +0200
Message-Id: <1559653142-31892-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559653142-31892-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559653142-31892-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 1/3] linux-user: Add support for
 setsockopt() options IPV6_<ADD|DROP>_MEMBERSHIP
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
Cc: arikalo@wavecomp.com, lvivier@redhat.com, Neng Chen <nchen@wavecomp.com>,
	ysu@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Neng Chen <nchen@wavecomp.com>

Add support for options IPV6_ADD_MEMBERSHIP and IPV6_DROP_MEMPEMBERSHIP
of the syscall setsockopt(). These options control membership in
multicast groups. Their argument is a pointer to a struct ipv6_mreq,
which is in turn defined in IP v6 header netinet/in.h as:

 struct ipv6_mreq {
     /* IPv6 multicast address of group */
     struct  in6_addr  ipv6mr_multiaddr;
     /* local IPv6 address of interface */
     int     ipv6mr_interface;
 };

...whereas its definition in kernel's include/uapi/linux/in6.h is:

 #if __UAPI_DEF_IPV6_MREQ
 struct ipv6_mreq {
     /* IPv6 multicast address of group */
         struct  in6_addr ipv6mr_multiaddr;
     /* local IPv6 address of interface */
     int     ipv6mr_ifindex;
 };
 #endif

The first field of ipv6_mreq has the same name ("ipv6mr_multiaddr")
and type ("in6_addr") in both cases. Moreover, the in6_addr structure
consists of fields that are always big-endian (on host of any endian),
therefore the ipv6_mreq's field ipv6mr_multiaddr doesn't need any
endian conversion.

The second field of ipv6_mreq may, however, depending on the build
environment, have different names. This is the reason why the lines
"#if __UAPI_DEF_IPV6_MREQ" and "#if defined(__UAPI_DEF_IPV6_MREQ)"
are used in this patch - to establish the right choice for the field
name. Also, endian conversion is needed for this field, since it is
of type "int".

Signed-off-by: Neng Chen <nchen@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/syscall.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5e29e67..dde6889 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1921,6 +1921,33 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
                                        &pki, sizeof(pki)));
             break;
         }
+        case IPV6_ADD_MEMBERSHIP:
+        case IPV6_DROP_MEMBERSHIP:
+        {
+            struct ipv6_mreq ipv6mreq;
+
+            if (optlen < sizeof(ipv6mreq)) {
+                return -TARGET_EINVAL;
+            }
+
+            if (copy_from_user(&ipv6mreq, optval_addr, sizeof(ipv6mreq))) {
+                return -TARGET_EFAULT;
+            }
+
+#if defined(__UAPI_DEF_IPV6_MREQ)
+#if __UAPI_DEF_IPV6_MREQ
+            ipv6mreq.ipv6mr_ifindex = tswap32(ipv6mreq.ipv6mr_ifindex);
+#else
+            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
+#endif /* __UAPI_DEF_IVP6_MREQ */
+#else
+            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
+#endif /* defined (__UAPI_DEF_IPV6_MREQ) */
+
+            ret = get_errno(setsockopt(sockfd, level, optname,
+                                       &ipv6mreq, sizeof(ipv6mreq)));
+            break;
+        }
         default:
             goto unimplemented;
         }
-- 
2.7.4


