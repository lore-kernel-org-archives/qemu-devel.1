Received: from eggs.gnu.org ([2001:4830:134:3::10]:59298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Tony.Garnock-Jones@glasgow.ac.uk>)
	id 1fyhwD-0003Km-0J
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 14:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Tony.Garnock-Jones@glasgow.ac.uk>)
	id 1fyhvm-0005D7-FL
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 14:26:28 -0400
Date: Sat, 8 Sep 2018 19:22:05 +0100
From: Tony Garnock-Jones <tony.garnock-jones@glasgow.ac.uk>
Message-ID: <20180908182205.GB409@mornington.dcs.gla.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] linux-user: write(fd, NULL,
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Bring linux-user write(2) handling into line with linux for the case
of a 0-byte write with a NULL buffer. Based on a patch originally
written by Zhuowei Zhang.

Addresses https://bugs.launchpad.net/qemu/+bug/1716292.

>From Zhuowei Zhang's patch (https://lists.gnu.org/archive/html/qemu-devel/2=
017-09/msg08073.html):

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
---
 linux-user/syscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 850b72a0c7..8f46540534 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8168,6 +8168,9 @@ static abi_long do_syscall1(void *cpu_env, int num, a=
bi_long arg1,
         }
         return ret;
     case TARGET_NR_write:
+        if (arg2 =3D=3D 0 && arg3 =3D=3D 0) {
+            return get_errno(safe_write(arg1, 0, 0));
+        }
         if (!(p =3D lock_user(VERIFY_READ, arg2, arg3, 1)))
             return -TARGET_EFAULT;
         if (fd_trans_target_to_host_data(arg1)) {
--
2.18.0


[University of Glasgow: The Times Scottish University of the Year 2018]
