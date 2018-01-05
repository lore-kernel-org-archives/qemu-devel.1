Received: from eggs.gnu.org ([2001:4830:134:3::10]:58853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eXS7z-0003Qg-4a
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.vnet.ibm.com>) id 1eXS7u-0004yo-Tx
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:33:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42422
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.vnet.ibm.com>)
	id 1eXS7u-0004yi-PY
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 08:33:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w05DSvDR006220
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 08:33:36 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fa968jtvq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 08:33:36 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.vnet.ibm.com>;
	Fri, 5 Jan 2018 08:33:35 -0500
From: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
Date: Fri,  5 Jan 2018 11:32:41 -0200
In-Reply-To: <20180105133241.14141-1-muriloo@linux.vnet.ibm.com>
References: <20180105133241.14141-1-muriloo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20180105133241.14141-2-muriloo@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] block/nbd: fix segmentation fault when
 .desc is not null-terminated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-ppc@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, R Nageswara Sastry <nasastry@in.ibm.com>, Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>

The find_desc_by_name() from util/qemu-option.c relies on the .name not being
NULL to call strcmp(). This check becomes unsafe when the list is not
NULL-terminated, which is the case of nbd_runtime_opts in block/nbd.c, and can
result in segmentation fault when strcmp() tries to access an invalid memory:

    #0 0x00007fff8c75f7d4 in __strcmp_power9 () from /lib64/libc.so.6
    #1 0x00000000102d3ec8 in find_desc_by_name (desc=0x1036d6f0, name=0x28e46670 "server.path") at util/qemu-option.c:166
    #2 0x00000000102d93e0 in qemu_opts_absorb_qdict (opts=0x28e47a80, qdict=0x28e469a0, errp=0x7fffec247c98) at util/qemu-option.c:1026
    #3 0x000000001012a2e4 in nbd_open (bs=0x28e42290, options=0x28e469a0, flags=24578, errp=0x7fffec247d80) at block/nbd.c:406
    #4 0x00000000100144e8 in bdrv_open_driver (bs=0x28e42290, drv=0x1036e070 <bdrv_nbd_unix>, node_name=0x0, options=0x28e469a0, open_flags=24578, errp=0x7fffec247f50) at block.c:1135
    #5 0x0000000010015b04 in bdrv_open_common (bs=0x28e42290, file=0x0, options=0x28e469a0, errp=0x7fffec247f50) at block.c:1395

>From gdb, the desc[i].name was not NULL and resulted in strcmp() accessing an
invalid memory:

    >>> p desc[5]
    $8 = {
      name = 0x1037f098 "R27A",
      type = 1561964883,
      help = 0xc0bbb23e <error: Cannot access memory at address 0xc0bbb23e>,
      def_value_str = 0x2 <error: Cannot access memory at address 0x2>
    }
    >>> p desc[6]
    $9 = {
      name = 0x103dac78 <__gcov0.do_qemu_init_bdrv_nbd_init> "\001",
      type = 272101528,
      help = 0x29ec0b754403e31f <error: Cannot access memory at address 0x29ec0b754403e31f>,
      def_value_str = 0x81f343b9 <error: Cannot access memory at address 0x81f343b9>
    }

This patch fixes the segmentation fault in strcmp() by adding a NULL element at
the end of nbd_runtime_opts.desc list, which is the common practice to most of
other structs like runtime_opts in block/null.c. Thus, the desc[i].name != NULL
check becomes safe because it will not evaluate to true when .desc list reached
its end.

Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1727259
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.vnet.ibm.com>
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index a50d24b50a..8b8ba56cdd 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -388,6 +388,7 @@ static QemuOptsList nbd_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "ID of the TLS credentials to use",
         },
+        { /* end of list */ }
     },
 };
 
-- 
2.14.3
