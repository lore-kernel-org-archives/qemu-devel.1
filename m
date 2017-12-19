Received: from eggs.gnu.org ([2001:4830:134:3::10]:58936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRKtY-0005mY-5t
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRKtX-0002nw-30
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:37:32 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 13:37:13 -0300
Message-Id: <20171219163713.31383-3-f4bug@amsat.org>
In-Reply-To: <20171219163713.31383-1-f4bug@amsat.org>
References: <20171219163713.31383-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] qemu-iotests: check socket_scm_helper is
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Wenchao Xia <xiawenc@linux.vnet.ibm.com>, Stratos Psomadakis <psomas@grnet.gr>, Eric Blake <eblake@redhat.com>

This now throws a more helpful error message when not found:

  tests/qemu-iotests$ ./check 045
  QEMU          -- "/qemu/build/x86_64-softmmu/qemu-system-x86_64" -nodefaults -machine accel=qtest
  QEMU_IMG      -- "/qemu/build/qemu-img"
  QEMU_IO       -- "/qemu/build/qemu-io"  --cache writeback -f raw
  QEMU_NBD      -- "/qemu/build/qemu-nbd"
  TEST_DIR      -- /qemu/build/tests/qemu-iotests/scratch
  SOCKET_SCM_HELPER --

  045 1s ... [failed, exit status 1] - output mismatch (see 045.out.bad)
  -...........
  +......EE.EE
  +======================================================================
  +ERROR: test_add_fd (__main__.TestSCMFd)
  +----------------------------------------------------------------------
  +Traceback (most recent call last):
  +  File "045", line 147, in test_add_fd
  +    self._send_fd_by_SCM()
  +  File "045", line 143, in _send_fd_by_SCM
  +    ret = self.vm.send_fd_scm(image0)
  +  File "/source/qemu/tests/qemu-iotests/../../scripts/qemu.py", line 125, in send_fd_scm
  +    self._socket_scm_helper)
  +QEMUMachineError: socket_scm_helper does not exist
  +
   ----------------------------------------------------------------------
  Failures: 045
  Failed 1 of 1 tests

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qemu-iotests/check | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e6b6ff7a04..a2c0bab1cc 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -597,6 +597,8 @@ fi
 if [ -x "$build_iotests/socket_scm_helper" ]
 then
     export SOCKET_SCM_HELPER="$build_iotests/socket_scm_helper"
+else
+    _init_error "socket_scm_helper not found"
 fi
 
 default_machine=$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*//p')
-- 
2.15.1
