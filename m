Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE142C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F86221773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F86221773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJHWN-0003cW-Rc
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 09:01:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hJHUq-0002at-AK
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hJHUY-0000mo-VJ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:59:27 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54895 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hJHUX-0007qf-PZ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:59:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 98B071A413F;
	Wed, 24 Apr 2019 14:58:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 3F8631A23E6;
	Wed, 24 Apr 2019 14:58:11 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 14:57:02 +0200
Message-Id: <1556110623-655-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v2 4/5] linux-user: setsockopt(): Add support
 for the option IPV6_ADD_MEMBERSHIP
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
Cc: lvivier@redhat.com, thuth@redhat.com, jcmvbkbc@gmail.com,
	arikalo@wavecomp.com, daniel.santos@pobox.com,
	amarkovic@wavecomp.com, Neng Chen <nchen@wavecomp.com>,
	philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424125702.1Ee9NqqSdK_lrAt2kSMqYMmbsjR8aDD3cLZmgGWi3ak@z>

From: Neng Chen <nchen@wavecomp.com>

Add support for the option IPV6_ADD_MEMBERSHIP of the syscall
setsockopt(). This option controls membership in multicast groups.
Argument is a pointer to a struct ipv6_mreq, which is in turn defined
in a platform-inedependant manner in the Linux kernel file
include/uapi/linux/in6.h as:

The <netinet/in.h> header defines the ipv6_mreq structure, which
includes the following members:

struct in6_addr ipv6mr_multiaddr  /* IPv6 multicast address   */
unsigned int    ipv6mr_interface  /* local interface index    */

struct ipv6_mreq {
    /* IPv6 multicast address of group */
    struct in6_addr  ipv6mr_multiaddr;

    /* local IPv6 address of interface */
    int              ipv6mr_ifindex;
};

The <netinet/in.h> header also defines the in6_addr structure,
which a union of the following structure:

struct in6_addr {
    union {
        __u8    u6_addr8[16];
        __be16  u6_addr16[8];
        __be32  u6_addr32[4];
    } in6_u;

The emulation behavior of IPV6_ADD_MEMBERSHIP is devised based on
the definitions above.

Signed-off-by: Neng Chen <nchen@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/syscall.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 96cd4bf..b47a45d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1892,6 +1892,24 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
                                        &pki, sizeof(pki)));
             break;
         }
+        case IPV6_ADD_MEMBERSHIP:
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
+            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
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


