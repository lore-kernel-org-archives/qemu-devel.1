Received: from eggs.gnu.org ([2001:4830:134:3::10]:49955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecfZT-0002Pa-Jq
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ecfZP-0002Fh-MH
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:55:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ecfZP-0002EC-Cs
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:55:35 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0JMsARQ110386
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 17:55:32 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fkptqfpm6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 17:55:31 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 19 Jan 2018 17:55:30 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 19 Jan 2018 17:55:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0919c2ab-1a62-f96c-1847-d6f95d3326f3@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Double-free due to e5dc1a6c6c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

I get double-free memory errors when QEMU terminates due to commit=20
e5dc1a6c6c.

The way to reproduce the error is to 1st do a 'system_reset' in the=20
monitor and then get into the grub console and do a 'halt' there.


      Stefan


commit e5dc1a6c6c4359cd783810f63eb68e9e09350708
Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Date:   Thu Jan 4 17:05:15 2018 +0100

     readline: add a free function

     Fixes leaks such as:

     Direct leak of 2 byte(s) in 1 object(s) allocated from:
         #0 0x7eff58beb850 in malloc (/lib64/libasan.so.4+0xde850)
         #1 0x7eff57942f0c in g_malloc ../glib/gmem.c:94
         #2 0x7eff579431cf in g_malloc_n ../glib/gmem.c:331
         #3 0x7eff5795f6eb in g_strdup ../glib/gstrfuncs.c:363
         #4 0x55db720f1d46 in readline_hist_add=20
/home/elmarco/src/qq/util/readline.c:258
         #5 0x55db720f2d34 in readline_handle_byte=20
/home/elmarco/src/qq/util/readline.c:387
         #6 0x55db71539d00 in monitor_read=20
/home/elmarco/src/qq/monitor.c:3896
         #7 0x55db71f9be35 in qemu_chr_be_write_impl=20
/home/elmarco/src/qq/chardev/char.c:167
         #8 0x55db71f9bed3 in qemu_chr_be_write=20
/home/elmarco/src/qq/chardev/char.c:179
         #9 0x55db71fa013c in fd_chr_read=20
/home/elmarco/src/qq/chardev/char-fd.c:66
         #10 0x55db71fe18a8 in qio_channel_fd_source_dispatch=20
/home/elmarco/src/qq/io/channel-watch.c:84
         #11 0x7eff5793a90b in g_main_dispatch ../glib/gmain.c:3182
         #12 0x7eff5793b7ac in g_main_context_dispatch ../glib/gmain.c:38=
47
         #13 0x55db720af3bd in glib_pollfds_poll=20
/home/elmarco/src/qq/util/main-loop.c:214
         #14 0x55db720af505 in os_host_main_loop_wait=20
/home/elmarco/src/qq/util/main-loop.c:261
         #15 0x55db720af6d6 in main_loop_wait=20
/home/elmarco/src/qq/util/main-loop.c:515
         #16 0x55db7184e0de in main_loop /home/elmarco/src/qq/vl.c:1995
         #17 0x55db7185e956 in main /home/elmarco/src/qq/vl.c:4914
         #18 0x7eff4ea17039 in __libc_start_main (/lib64/libc.so.6+0x2103=
9)
