Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D31C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BD52072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BD52072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJYB-0001v4-7B
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJVc-0005KC-JX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJVb-0007WJ-JW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:28 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJVb-0007Vf-Av
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:27 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MPXlM-1itoeJ1A94-00MdSq; Fri, 20 Mar 2020 16:24:18 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 02/32] linux-user: do prlimit selectively
Date: Fri, 20 Mar 2020 16:23:38 +0100
Message-Id: <20200320152408.182899-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bnwVjysfey4/Hw/cNsxeK7+oIrp934ZV+iOIvIUpIo11btSUk7C
 SVs0lQasihp8TQiT6xZsZeKybX+bDSktvPKjgblxQkL4DYGM/c46f2VAIoCix+amJ3we7El
 FZkrxzpOI9KO3vsX5MoUAdOZXW3yy3Is7z7IlHnEehop2fjkomCt6542m5L+6XJbv1njWFZ
 s/b0xb7Y++1D9g5VQSFTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MkeHn26e3DA=:NyedpBi3ClJe3UcUq+3G6p
 WcvWENTl9cIFWXysZUK5tsUNF0+okiAtY5wCvOJQbK6xMusfGYlWOZKR70MDTtBdNdKNnJyfi
 WGweJxF0tzhA9JFfGHb4hBw9Dy+IXo13SPYxQcASbZLGLm95177AozA4nRPQKbH4cDO7WQE0d
 6r1It1In2AYKvmYQ+d/tWle6fC/nVNzysUdUsUfOkkOIatF4i7Qh7WmaCgPq9C2T0a+YaRwgu
 siOf+ATdo5YLZc1ZQzbD7J3Y0UajUUkwqFolLDQOA27p2FD1eHDIjsH3IeqMWjhOM1MMA+rXY
 pq2ANaSxFW/BgZszc93zGrcrVMeUxKj9dzGcVPeipVg6hY5P3Lobul+rR5ZSeVSNHBuVDLeqA
 6JV9FtbUkjHsmW1PSJBi78d5MX9PUpdKF+bU4BNggNv5A6/bhcIc6xocxQy/Fjv8pRlksug1Z
 KyZ27HRMj56xqCXLG1R7uJGkcr9YpS0KVi0qboM5ACll0G5PiznbxIx2iKcBQdSzp9cfttEXT
 ZeR5STVTM6D7o+D/rDubcrbxzlVCRZHdmMehGGc2Z7BdBqY6S5+JC7UxowJwuuG3pKUrlLljY
 gH9om8B6HLpuXAM9826yoelCSCu1me1RMp/Y527d8y/AI+0SXM7tTvU6q3j/SR8OrPzyVyJtY
 VY8P+G+IvutaNqAJwJ3YeLBmf65WHALqA1Xq/NSYIsdy/8dObBMGXVLhUflwY6H7/FFhxvAVQ
 81jBvna2LMzgTwm4lZ9/M+kHu9iuXOnLsBi3pZwhQqf8zjq75tUzC7lM85vOJSTt5O6sEi0wv
 DvJurPVCv/XDFmPXg3Wfqvhnpzc+/vw9Gidl8N9nwSbs0muV7fZJWLFbTaT4wN+0MCwsh5P
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
 Tobias Koch <tobias.koch@nonterra.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tobias Koch <tobias.koch@nonterra.com>

Analogous to what commit 5dfa88f7 did for setrlimit, this commit
selectively ignores limits for memory-related resources in prlimit64
calls. This is to prevent too restrictive limits from causing QEMU
itself to malfunction.

Signed-off-by: Tobias Koch <tobias.koch@nonterra.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200305202400.27574-1-tobias.koch@nonterra.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d1080752..4f2f9eb12b59 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11871,7 +11871,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         struct target_rlimit64 *target_rnew, *target_rold;
         struct host_rlimit64 rnew, rold, *rnewp = 0;
         int resource = target_to_host_resource(arg2);
-        if (arg3) {
+
+        if (arg3 && (resource != RLIMIT_AS &&
+                     resource != RLIMIT_DATA &&
+                     resource != RLIMIT_STACK)) {
             if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
                 return -TARGET_EFAULT;
             }
-- 
2.25.1


