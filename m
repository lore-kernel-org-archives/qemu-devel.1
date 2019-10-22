Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FD6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DC120684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DC120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpUE-0003KN-E9
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpGP-0002x4-1L
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpGN-00059p-Mr
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMpGN-00058r-D5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:11:31 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MxEcg-1i7KeK3sL2-00xcAc; Tue, 22 Oct 2019 10:11:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] Fix unsigned integer underflow in fd-trans.c
Date: Tue, 22 Oct 2019 10:10:55 +0200
Message-Id: <20191022081104.11814-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
References: <20191022081104.11814-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/EOLVfh5U6JtshaL7XfHmPPLuvVwQL+Pm/VOhnw9mXZBSPzVfCH
 ACw/s4wckistsVigmphzCAubR7VRbTeVZ4opReuxbh2rMFJR9Uf4Ot64XfQZ5gnnG0pfYgg
 eTjyBHSkhSYqorkw5SaXOUd0trmg17NA/wPnmg1S6SPel0tDgpJQPMz1OmzK2b3CVEbTXAt
 X+J2zvHaBt24Ixo9jPQKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hScm5NS3y3g=:46Mq5zLSD0MfCA6poFUlYD
 pDJUoNglsi/HbDZhkh/VifSnHY8GwZkoJHw0YfsjK4f/unBEs5J5OVUaM5koz9fl78aa6CR/3
 LcnprfpNeYYRTGNTGg6R9jNE0a8Yn8VN3OsRUmb87CnS8mPVPAXBsRp9TOv+uUYDR/WJxm3wB
 svOFEHaSLIYmL14nyCqJtMhQjTA95ucnZVwXb90bPpaJyur5fay4/66rU5qJQYy+ZoH03RvI1
 vbvrs/cS/LMHUYfjTkWq/X7AVx+U7cNWA+rDwYOtx2cm+bwtaCgj90xPWHeyVVG2fZ+IBeBAZ
 QUg98Wt1cTP9CES9P0dOXs/px+FLhph+fhDnC9km7XhIUxSdFejr8cN/26gm1l6/iZPzYde4A
 j0LqBj94eOrP5whVPJvdegul+ABXi5BDpFr3rhBDCvz9YCTZUXlkgNoYg0g2T0h47ciXIcUWL
 cLxrxJZ62AQeaUcaJgFvUIgsb8hABonv+L5DBopC2VMJhsaXTSOhJODJMJ02KoKuPuhTpmw6h
 TH93NK31GcLPoVJA5ED3EqTN1kkIzNH/XbTaBeGVUr039ZrrjYnz2/lDC3LwQV+yRi67PLm5v
 TC/xUluQh/vUXaUxUIkUiHagO5uqwXZzwTmsLt5yLiOpz+FytuizL2UbTvflrsLg8l8ondKty
 xmhBp+d3MclUDerOZ2iHixnaczqI8eXzWf9aVHX/oFeIoBntMX4SX5VvE7ZtA4AJ0cf0/SPWb
 cJ0fheIYFYRcpDxY3rPoyDoXTRt6PR16qF7gijbuxvqftee5jJjY3Sdna+kkF5wcpy5Vj5u3b
 sZxLW0W+UZcdALJiNeqCjeL3LmIAotWWaGgmk99qMSfmshsB1vsZLx+8+udCQLsZEsFXOKiUm
 XaJYbKBQRkdWKZJU0hIw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shu-Chun Weng <scw@google.com>

In any of these `*_for_each_*` functions, the last entry in the buffer (so the
"remaining length in the buffer" `len` is equal to the length of the
entry `nlmsg_len`/`nla_len`/etc) has size that is not a multiple of the
alignment, the aligned lengths `*_ALIGN(*_len)` will be greater than `len`.
Since `len` is unsigned (`size_t`), it underflows and the loop will read
pass the buffer.

This may manifest as random EINVAL or EOPNOTSUPP error on IO or network
system calls.

Signed-off-by: Shu-Chun Weng <scw@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191018001920.178283-1-scw@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/fd-trans.c | 51 +++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 60077ce5319d..9b92386abf51 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -279,6 +279,7 @@ static abi_long host_to_target_for_each_nlmsg(struct nlmsghdr *nlh,
                                                        (struct nlmsghdr *))
 {
     uint32_t nlmsg_len;
+    uint32_t aligned_nlmsg_len;
     abi_long ret;
 
     while (len > sizeof(struct nlmsghdr)) {
@@ -312,8 +313,13 @@ static abi_long host_to_target_for_each_nlmsg(struct nlmsghdr *nlh,
             break;
         }
         tswap_nlmsghdr(nlh);
-        len -= NLMSG_ALIGN(nlmsg_len);
-        nlh = (struct nlmsghdr *)(((char*)nlh) + NLMSG_ALIGN(nlmsg_len));
+
+        aligned_nlmsg_len = NLMSG_ALIGN(nlmsg_len);
+        if (aligned_nlmsg_len >= len) {
+            break;
+        }
+        len -= aligned_nlmsg_len;
+        nlh = (struct nlmsghdr *)(((char*)nlh) + aligned_nlmsg_len);
     }
     return 0;
 }
@@ -323,6 +329,7 @@ static abi_long target_to_host_for_each_nlmsg(struct nlmsghdr *nlh,
                                               abi_long (*target_to_host_nlmsg)
                                                        (struct nlmsghdr *))
 {
+    uint32_t aligned_nlmsg_len;
     int ret;
 
     while (len > sizeof(struct nlmsghdr)) {
@@ -349,8 +356,13 @@ static abi_long target_to_host_for_each_nlmsg(struct nlmsghdr *nlh,
                 return ret;
             }
         }
-        len -= NLMSG_ALIGN(nlh->nlmsg_len);
-        nlh = (struct nlmsghdr *)(((char *)nlh) + NLMSG_ALIGN(nlh->nlmsg_len));
+
+        aligned_nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len);
+        if (aligned_nlmsg_len >= len) {
+            break;
+        }
+        len -= aligned_nlmsg_len;
+        nlh = (struct nlmsghdr *)(((char *)nlh) + aligned_nlmsg_len);
     }
     return 0;
 }
@@ -363,6 +375,7 @@ static abi_long host_to_target_for_each_nlattr(struct nlattr *nlattr,
                                                          void *context))
 {
     unsigned short nla_len;
+    unsigned short aligned_nla_len;
     abi_long ret;
 
     while (len > sizeof(struct nlattr)) {
@@ -377,8 +390,13 @@ static abi_long host_to_target_for_each_nlattr(struct nlattr *nlattr,
         if (ret < 0) {
             return ret;
         }
-        len -= NLA_ALIGN(nla_len);
-        nlattr = (struct nlattr *)(((char *)nlattr) + NLA_ALIGN(nla_len));
+
+        aligned_nla_len = NLA_ALIGN(nla_len);
+        if (aligned_nla_len >= len) {
+            break;
+        }
+        len -= aligned_nla_len;
+        nlattr = (struct nlattr *)(((char *)nlattr) + aligned_nla_len);
     }
     return 0;
 }
@@ -389,6 +407,7 @@ static abi_long host_to_target_for_each_rtattr(struct rtattr *rtattr,
                                                         (struct rtattr *))
 {
     unsigned short rta_len;
+    unsigned short aligned_rta_len;
     abi_long ret;
 
     while (len > sizeof(struct rtattr)) {
@@ -403,8 +422,13 @@ static abi_long host_to_target_for_each_rtattr(struct rtattr *rtattr,
         if (ret < 0) {
             return ret;
         }
-        len -= RTA_ALIGN(rta_len);
-        rtattr = (struct rtattr *)(((char *)rtattr) + RTA_ALIGN(rta_len));
+
+        aligned_rta_len = RTA_ALIGN(rta_len);
+        if (aligned_rta_len >= len) {
+            break;
+        }
+        len -= aligned_rta_len;
+        rtattr = (struct rtattr *)(((char *)rtattr) + aligned_rta_len);
     }
     return 0;
 }
@@ -1058,6 +1082,7 @@ static abi_long target_to_host_for_each_rtattr(struct rtattr *rtattr,
                                                abi_long (*target_to_host_rtattr)
                                                         (struct rtattr *))
 {
+    unsigned short aligned_rta_len;
     abi_long ret;
 
     while (len >= sizeof(struct rtattr)) {
@@ -1071,9 +1096,13 @@ static abi_long target_to_host_for_each_rtattr(struct rtattr *rtattr,
         if (ret < 0) {
             return ret;
         }
-        len -= RTA_ALIGN(rtattr->rta_len);
-        rtattr = (struct rtattr *)(((char *)rtattr) +
-                 RTA_ALIGN(rtattr->rta_len));
+
+        aligned_rta_len = RTA_ALIGN(rtattr->rta_len);
+        if (aligned_rta_len >= len) {
+            break;
+        }
+        len -= aligned_rta_len;
+        rtattr = (struct rtattr *)(((char *)rtattr) + aligned_rta_len);
     }
     return 0;
 }
-- 
2.21.0


