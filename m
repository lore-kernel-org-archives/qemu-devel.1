Received: from eggs.gnu.org ([209.51.188.92]:42824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB475-0003co-Jw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB474-0004xU-6C
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41894
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB474-0004mU-0j
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4bSf053573
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx58sw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:41 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:00 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:53 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-80-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 79/97] linux-user: write(fd, NULL,
 0) parity with linux's treatment of same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tony Garnock-Jones <tony.garnock-jones@glasgow.ac.uk>, Tony Garnock-Jones <tonygarnockjones@gmail.com>, Laurent Vivier <laurent@vivier.eu>

From: Tony Garnock-Jones <tony.garnock-jones@glasgow.ac.uk>

Bring linux-user write(2) handling into line with linux for the case
of a 0-byte write with a NULL buffer. Based on a patch originally
written by Zhuowei Zhang.

Addresses https://bugs.launchpad.net/qemu/+bug/1716292.

>From Zhuowei Zhang's patch (https://lists.gnu.org/archive/html/qemu-deve=
l/2017-09/msg08073.html):

    Linux returns success for the special case of calling write with a
    zero-length NULL buffer: compiling and running

    int main() {
       ssize_t ret =3D write(STDOUT_FILENO, NULL, 0);
       fprintf(stderr, "write returned %ld\n", ret);
       return 0;
    }

    gives "write returned 0" when run directly, but "write returned
    -1" in QEMU.

    This commit checks for this situation and returns success if
    found.

Subsequent discussion raised the following questions (and my answers):

 - Q. Should TARGET_NR_read pass through to safe_read in this
      situation too?
   A. I'm wary of changing unrelated code to the specific problem I'm
      addressing. TARGET_NR_read is already consistent with Linux for
      this case.

 - Q. Do pread64/pwrite64 need to be changed similarly?
   A. Experiment suggests not: both linux and linux-user yield -1 for
      NULL 0-length reads/writes.

Signed-off-by: Tony Garnock-Jones <tonygarnockjones@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180908182205.GB409@mornington.dcs.gla.ac.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit 58cfa6c2e6eb51b23cc98f81d16136b3ca929b31)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5a4af76c03..1477509cf2 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8077,6 +8077,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
         }
         break;
     case TARGET_NR_write:
+        if (arg2 =3D=3D 0 && arg3 =3D=3D 0) {
+            return get_errno(safe_write(arg1, 0, 0));
+        }
         if (!(p =3D lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
         if (fd_trans_target_to_host_data(arg1)) {
--=20
2.17.1
