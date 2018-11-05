Received: from eggs.gnu.org ([2001:4830:134:3::10]:55146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJfMC-0001I6-Oe
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJfMB-0006pL-Rt
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:55:56 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gJfMB-0006eU-Ie
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 08:55:55 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Nov 2018 13:55:36 +0000
Message-Id: <20181105135538.28025-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-3.1 0/2] Fix qemu_thread_atexit* for OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Our current implementation of qemu_thread_atexit* is broken on OSX.
This is because it works by cerating a piece of thread-specific
data with pthread_key_create() and using the destructor function
for that data to run the notifier function passed to it by
the caller of qemu_thread_atexit_add(). The expected use case
is that the caller uses a __thread variable as the notifier,
and uses the callback to clean up information that it is
keeping per-thread in __thread variables.

Unfortunately, on OSX this does not work, because on OSX
a __thread variable may be destroyed (freed) before the
pthread_key_create() destructor runs. (POSIX imposes no
ordering constraint here; the OSX implementation happens
to implement __thread variables in terms of pthread_key_create((),
whereas Linux uses different mechanisms that mean the __thread
variables will still be present when the pthread_key_create()
destructor is run.)

Fix this by switching to a scheme similar to the one qemu-thread-win32
uses for qemu_thread_atexit: keep the thread's notifiers on a
__thread variable, and run the notifiers on calls to
qemu_thread_exit() and on return from the start routine passed
to qemu_thread_start(). We do this with the pthread_cleanup_push()
API. (This approach was suggested by Paolo.)

There is a slightly awkward corner here for the main thread,
which isn't started via qemu_thread_start() and so can exit
without passing through the cleanup handler. qemu-thread-win32.c
tries to handle the main thread using an atexit() handler to
run its notifiers. I don't think this will work because the atexit
handler may not run on the main thread, in which case notify
callback functions which refer to __thread variables will get
the wrong ones. So instead I have documented that the API
leaves it unspecified whether notifiers are run for thread
exits that happen when the entire process is exiting. This
is OK for our current users (who only use the callbacks to
clean up memory or win32 Fibers which are deleted on process
exit anyway), and means we don't need to worry about running
callbacks on main thread exit (which always causes the whole
process to exit).

In particular, this fixes the ASAN errors and lockups we
currently see on OSX hosts when running test-bdrv-drain.

thanks
-- PMM

Peter Maydell (2):
  include/qemu/thread.h: Document qemu_thread_atexit* API
  util/qemu-thread-posix: Fix qemu_thread_atexit* for OSX

 include/qemu/thread.h    | 22 ++++++++++++++++++++
 util/qemu-thread-posix.c | 44 ++++++++++++++++++----------------------
 2 files changed, 42 insertions(+), 24 deletions(-)

-- 
2.19.1
