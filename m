Received: from eggs.gnu.org ([2001:4830:134:3::10]:53676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fhyPv-0004R7-R8
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fhyPs-00059T-G3
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:35:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57350 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fhyPs-00059B-9U
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:35:56 -0400
Date: Tue, 24 Jul 2018 15:35:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180724143551.GK19167@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180724142504.15092-1-stefanha@redhat.com>
	<20180724142504.15092-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724142504.15092-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PULL for-3.0 1/1] trace/simple: fix hang in child
 after fork(2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Tue, Jul 24, 2018 at 03:25:04PM +0100, Stefan Hajnoczi wrote:
> The simple trace backend spawns a write-out thread which is used to
> asynchronously flush the in-memory ring buffer to disk.
> 
> fork(2) does not clone all threads, only the thread that invoked
> fork(2).  As a result there is no write-out thread in the child process!
> 
> This causes a hang during shutdown when atexit(3) handler installed by
> the simple trace backend waits for the non-existent write-out thread.
> 
> This patch uses pthread_atfork(3) to terminate the write-out thread
> before fork and restart it in both the parent and child after fork.
> This solves a hang in qemu-iotests 147 due to qemu-nbd --fork usage.

I'm not convinced this is safe, as it looks like it has a window in
which both the parent and child processes will be doing write-out to
the same file.

In particular in the main QEMU system emulators it means that any
time we fork() in QEMU, eg for spawning commands with migration
exec: URI, or TAP devuce ifup scripts, etc, we'll be starting a
write-out thread in the child. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
