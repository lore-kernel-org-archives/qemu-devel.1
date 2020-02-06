Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C096C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409D321741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409D321741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izge1-0004Mh-C4
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izgcW-00013b-Tk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izgcV-00060N-OK
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:00 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izgcQ-0005b0-PN; Thu, 06 Feb 2020 07:50:55 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9nlN-1iuTwk3gEX-005n7S; Thu, 06 Feb 2020 13:50:36 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] monitor: fix memory leak in
 monitor_fdset_dup_fd_find_remove
Date: Thu,  6 Feb 2020 13:50:17 +0100
Message-Id: <20200206125027.1926263-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206125027.1926263-1-laurent@vivier.eu>
References: <20200206125027.1926263-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PkLbluZi6767fKHrm29TXI9V8f4/V582cxLm+KeDjydbCtXz7Bv
 Tn7ZXQuNi/17LtWUKlKFKQ4SXE9KVkFyDrTp5q/j8sJg2cvmifTj8/cHjHe07iJ2a4BHTxA
 GhwP3qNK4ScCXfEuN4ZqeXgB7g7xgA//KjXuh+IkAEdftV/uLQ0BMGbNLlMRKo3VShKUPfF
 lETwqwIygfPTzZOCoPlug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MyMkWIfuP24=:8fOiACXUsPJBRFpxPx71hE
 5P9iq32APsm62UHeKUGw9GnzBlx4CElui7p5rO4aPQxPr3YsZT4PXTbpfoR8p9YP9Xk5rWz3s
 erRqHPX1jR+cVRtRHxXhRzusn+EDMCYljbIqkkEdKunpvcfCUr+QBdy4C8E8ApOr1pVay4YQ/
 WCPnWWbr9GW6ZgYebmKU80PXSvRjV4/WTckPm0xel+36DPvD+HJn5WEDh2jDL/4Znpi0B2L9O
 rX07gehOAo3Pqv9mz+/FMpXVQUilMXNlldA1MVMWzolLoBuGcc9MHhMhSja2BsBpmEHmbtkup
 Q13eruMCYuJHO9Gmbuj30mcfDlkPkXaSjPX7+KCqJuNPiqWkxO26AR/muHyUWZeJ9VP994kFk
 xkQ5dm+ZEQChK9NrzsArGzD1lStIUodPGd5NNMjXutZggAXPm/iwJW/dVWsGYHgx61uzzoyKq
 9pMXCMMWwem0KrciygVqBudQPhdKB8GGIb0MJFEjpPz1cXlF7YBFB2fkI0n6hcEsA8A2oeoPg
 bqmnWr5LZtniSikc6/pwxbj51DqCHFX1bfzBsa2i30yd8bPpz2MbWRxHpgf/ImYhCQvl5GBjF
 jyKqO45o//hwKcKF+gbeDPwGgG59lOm9DGwWF2XIIuUndMvxGm14VxOwnKR+aQj0cGsYTJSLQ
 B9XRl1IIbhRM6g3a5lqdcMojVudEn/1Kymat2R0aTWXolEOj9zYmYs+ZkhiVESbs907c5QjHo
 BZto7rjLD7zhTpQsihgDIpdEcCJ0+9ifXt1ZGLiLgNHcYDTk6b0S7Mt7RGutKXaMHWUJON5X2
 0P0AXkBUIvHhQGpvi6mzvNJM09fTpC1+hnFxPjCIEFngIIhfdioooDJgkAp5y/TaE3inc8n
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

When remove dup_fd in monitor_fdset_dup_fd_find_remove function,
we need to free mon_fdset_fd_dup. ASAN shows memory leak stack:

Direct leak of 96 byte(s) in 3 object(s) allocated from:
    #0 0xfffd37b033b3 in __interceptor_calloc (/lib64/libasan.so.4+0xd33b3)
    #1 0xfffd375c71cb in g_malloc0 (/lib64/libglib-2.0.so.0+0x571cb)
    #2 0xaaae25bf1c17 in monitor_fdset_dup_fd_add /qemu/monitor/misc.c:1724
    #3 0xaaae265cfd8f in qemu_open /qemu/util/osdep.c:315
    #4 0xaaae264e2b2b in qmp_chardev_open_file_source /qemu/chardev/char-fd.c:122
    #5 0xaaae264e47cf in qmp_chardev_open_file /qemu/chardev/char-file.c:81
    #6 0xaaae264e118b in qemu_char_open /qemu/chardev/char.c:237
    #7 0xaaae264e118b in qemu_chardev_new /qemu/chardev/char.c:964
    #8 0xaaae264e1543 in qemu_chr_new_from_opts /qemu/chardev/char.c:680
    #9 0xaaae25e12e0f in chardev_init_func /qemu/vl.c:2083
    #10 0xaaae26603823 in qemu_opts_foreach /qemu/util/qemu-option.c:1170
    #11 0xaaae258c9787 in main /qemu/vl.c:4089
    #12 0xfffd35b80b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
    #13 0xaaae258d7b63  (/qemu/build/aarch64-softmmu/qemu-system-aarch64+0x8b7b63)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200115072016.167252-1-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 monitor/misc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/misc.c b/monitor/misc.c
index 4752150a6780..9c3484d0a774 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1749,6 +1749,7 @@ static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
             if (mon_fdset_fd_dup->fd == dup_fd) {
                 if (remove) {
                     QLIST_REMOVE(mon_fdset_fd_dup, next);
+                    g_free(mon_fdset_fd_dup);
                     if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
                         monitor_fdset_cleanup(mon_fdset);
                     }
-- 
2.24.1


