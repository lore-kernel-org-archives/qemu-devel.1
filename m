Received: from eggs.gnu.org ([2001:4830:134:3::10]:60626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGHOa-00050Z-LG
	for Qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGHOX-00029B-JG
	for Qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:35:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cGHOX-00028h-EB
	for Qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:35:17 -0500
Date: Mon, 12 Dec 2016 11:35:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161212033512.GA3725@lemon>
References: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6BBB3038-0389-4221-9A41-63800F3FF514@livius.net>
Subject: Re: [Qemu-devel] experience with SDL2, event loop & main thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developer <Qemu-devel@nongnu.org>

On Sat, 12/10 18:16, Liviu Ionescu wrote:
> conclusions:
> 
> - the graphical event loop and all graphical primitives must be called from the main thread context
> - in qemu this is not possible directly; an inefficient but functional
> solution uses a timer programmed to call a function every few milliseconds, to
> poll the event loop. (if the qemu I/O event loop is executed on the main
> thread, the timer function will be called from the main thread context)

Isn't it possible to notify the main thread with an EventNotifier and process
the deferred events in its handler?

Fam

> - all graphical operations initiated by the all other thread (like the emulator thread), must be deferred (in SDL using user events) to the graphical event loop
> - a function to run graphical destruction must be registered with atexit()
> - only the main thread can call exit(), to ensure the destruction functions are not called from other threads
> - exiting from other threads must be also deferred to the main thread, possibly with unlocking a mutex.
> 
> 
> I hope that helps,
> 
> Liviu
> 
> 
> 
> 
> 
> 
> 
