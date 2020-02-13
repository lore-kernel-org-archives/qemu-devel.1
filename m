Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A1DC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC954218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC954218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2DWh-0000jd-6b
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j2DUm-0006e5-09
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j2DUk-0003RQ-OO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:27 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33905)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j2DUk-0003Pr-FJ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:26 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmDAW-1jkJjd48RM-00iDZO; Thu, 13 Feb 2020 13:21:14 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] linux-user: implement TARGET_SO_PEERSEC
Date: Thu, 13 Feb 2020 13:21:08 +0100
Message-Id: <20200213122108.965455-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213122108.965455-1-laurent@vivier.eu>
References: <20200213122108.965455-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pXdY38UTIdcbZNZR88eBsXzg58bbI5HYUMzcwVSUd7ASq4azCuG
 7wK2FkvwqbCTlVA9qTPcECDpFoCm0aJoCbWlClrGq8sHilrsnESxZhN19va4WrS0bNVK9Yc
 Vpu7fqpqH24Lrbc2q79+ryU1XGo01pcd0whueVtTmxCpypu9gC4gUb9SDXQI5jaa7xcmRRr
 bZT8xaLjAsPeoLiGgOC3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iJgSuFHQbf4=:DMRKxnf85KIDcqlFlFkITr
 QA1q4lwoHgzvyGfBUi223bRs4815vC61J9qJLRz/1i7ZXozixt0RkGBOzO8lX/OaRHZB7ZJAk
 YXugjmH1f5o5bheLdxlGwHeqnbVXVRO2Tge3tA+UqSrdzJkpwqFrj3nZuDKutaps0OOXawcE/
 4hUZQO2kfh+coH10nQJZMMPZajIfBF02mJWpJQ8eVd56fcvhkoCf2RTHiSpZA7o6ZsZIPw83T
 r++h228FCAzLVrDDSDe/1Ttg6Hpxgqm/sEmqJWgDlFVIz0dEbT5BO/rIT2ZEpZM/j7Tx9Rkyd
 ZZzpfd9DdataEjFFh62WOkfri8GKmqeECvGvBPWvTnQ+ZNws1u1k5O77khJYRkK8+EMkWB5m3
 4pXqnqhdIXiqUUvjYijKKCbFbZGn4yOHVc7vMSp1/JjH7la+ZvXzPe0lijC3QKvSfJP6SrtO0
 5A+H4yy9KyjNV58T+vdU/kJcMVVKA6JXObSXhz08hx83ujDGuFLC3cNvdOU0mloOc+GO9KOQG
 Vs3PeCrjfX63pBXDrluWfBWrT82qW21NWDjfl45zT8hovKkraK7uRNRO2lrtB4zlGB4Rv9RaG
 IPWhdYqbNUsrXZ1tpexwbGgAC3eDpncCEB9pB5Taa+yvKVCY63x6Rtgp/LFvyXKf2tkd77g6p
 ncto1TkSpHp6/g+C4R5rzAEf4viwnZ19urwA8iOBMUpiV7AftkEYDAXRS8QYZV7XGRv9h140E
 AahogyMdl+Qv+i+55TQqvW/z0kV7pStvElnRho4HR/XGsSvi0QK+mFWxlkSFGoh+GzvsCI7/G
 JDTyG829HYGDU3XsWqeSUYYdSuH+NKQARdIBmByYXGZhXB5KDjjy955yV/nZGe/x5RfGJr5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Matthias=20L=C3=BCscher?= <lueschem@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"The purpose of this option is to allow an application to obtain the
security credentials of a Unix stream socket peer.  It is analogous to
SO_PEERCRED (which provides authentication using standard Unix credentials
of pid, uid and gid), and extends this concept to other security
models." -- https://lwn.net/Articles/62370/

Until now it was passed to the kernel with an "int" argument and
fails when it was supported by the host because the parameter is
like a filename: it is always a \0-terminated string with no embedded
\0 characters, but is not guaranteed to be ASCII or UTF-8.

I've tested the option with the following program:

    /*
     * cc -o getpeercon getpeercon.c
     */

    #include <stdio.h>
    #include <sys/types.h>
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <arpa/inet.h>

    int main(void)
    {
        int fd;
        struct sockaddr_in server, addr;
        int ret;
        socklen_t len;
        char buf[256];

        fd = socket(PF_INET, SOCK_STREAM, 0);
        if (fd == -1) {
            perror("socket");
            return 1;
        }

        server.sin_family = AF_INET;
        inet_aton("127.0.0.1", &server.sin_addr);
        server.sin_port = htons(40390);

        connect(fd, (struct sockaddr*)&server, sizeof(server));

        len = sizeof(buf);
        ret = getsockopt(fd, SOL_SOCKET, SO_PEERSEC, buf, &len);
        if (ret == -1) {
            perror("getsockopt");
            return 1;
        }
        printf("%d %s\n", len, buf);
        return 0;
    }

On host:

  $ ./getpeercon
  33 system_u:object_r:unlabeled_t:s0

With qemu-aarch64/bionic without the patch:

  $ ./getpeercon
  getsockopt: Numerical result out of range

With the patch:

  $ ./getpeercon
  33 system_u:object_r:unlabeled_t:s0

Bug: https://bugs.launchpad.net/qemu/+bug/1823790
Reported-by: Matthias Lüscher <lueschem@gmail.com>
Tested-by: Matthias Lüscher <lueschem@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200204211901.1731821-1-laurent@vivier.eu>
---
 linux-user/syscall.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d60142f0691c..c930577686da 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2344,6 +2344,28 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
             }
             break;
         }
+        case TARGET_SO_PEERSEC: {
+            char *name;
+
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+            name = lock_user(VERIFY_WRITE, optval_addr, len, 0);
+            if (!name) {
+                return -TARGET_EFAULT;
+            }
+            lv = len;
+            ret = get_errno(getsockopt(sockfd, level, SO_PEERSEC,
+                                       name, &lv));
+            if (put_user_u32(lv, optlen)) {
+                ret = -TARGET_EFAULT;
+            }
+            unlock_user(name, optval_addr, lv);
+            break;
+        }
         case TARGET_SO_LINGER:
         {
             struct linger lg;
-- 
2.24.1


