Received: from eggs.gnu.org ([2001:4830:134:3::10]:53650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJy41-0000p2-Vh
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJy2z-0004qF-Mr
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:53:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gJy2z-0004nz-F0
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:53:21 -0500
References: <20181105135538.28025-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cec657a3-4152-c951-5165-74604d9d9da5@redhat.com>
Date: Tue, 6 Nov 2018 10:53:16 +0100
MIME-Version: 1.0
In-Reply-To: <20181105135538.28025-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/2] Fix qemu_thread_atexit* for OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>

On 05/11/2018 14:55, Peter Maydell wrote:
> Our current implementation of qemu_thread_atexit* is broken on OSX.
> This is because it works by cerating a piece of thread-specific
> data with pthread_key_create() and using the destructor function
> for that data to run the notifier function passed to it by
> the caller of qemu_thread_atexit_add(). The expected use case
> is that the caller uses a __thread variable as the notifier,
> and uses the callback to clean up information that it is
> keeping per-thread in __thread variables.
> 
> Unfortunately, on OSX this does not work, because on OSX
> a __thread variable may be destroyed (freed) before the
> pthread_key_create() destructor runs. (POSIX imposes no
> ordering constraint here; the OSX implementation happens
> to implement __thread variables in terms of pthread_key_create((),
> whereas Linux uses different mechanisms that mean the __thread
> variables will still be present when the pthread_key_create()
> destructor is run.)
> 
> Fix this by switching to a scheme similar to the one qemu-thread-win32
> uses for qemu_thread_atexit: keep the thread's notifiers on a
> __thread variable, and run the notifiers on calls to
> qemu_thread_exit() and on return from the start routine passed
> to qemu_thread_start(). We do this with the pthread_cleanup_push()
> API. (This approach was suggested by Paolo.)
> 
> There is a slightly awkward corner here for the main thread,
> which isn't started via qemu_thread_start() and so can exit
> without passing through the cleanup handler. qemu-thread-win32.c
> tries to handle the main thread using an atexit() handler to
> run its notifiers. I don't think this will work because the atexit
> handler may not run on the main thread, in which case notify
> callback functions which refer to __thread variables will get
> the wrong ones. So instead I have documented that the API
> leaves it unspecified whether notifiers are run for thread
> exits that happen when the entire process is exiting. This
> is OK for our current users (who only use the callbacks to
> clean up memory or win32 Fibers which are deleted on process
> exit anyway), and means we don't need to worry about running
> callbacks on main thread exit (which always causes the whole
> process to exit).
> 
> In particular, this fixes the ASAN errors and lockups we
> currently see on OSX hosts when running test-bdrv-drain.

Queued, thanks.  As an extra cleanup we can remove
qemu_thread_atexit_remove (it is unused, and a simple notifier_remove
now works), and also remove the atexit from Win32 so we can document
that the notifier does _not_ run for the main thread.

Paolo
