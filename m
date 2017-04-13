Received: from eggs.gnu.org ([2001:4830:134:3::10]:50828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyXyq-0000tO-JB
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyXyp-0004gc-Nm
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:11:44 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cyXyp-0004gR-HI
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 02:11:43 -0400
Received: by mail-wm0-x241.google.com with SMTP id q125so10450848wmd.3
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 23:11:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170406210917.6896-1-eblake@redhat.com>
	<877f2pnb2t.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d2c2ce7-418d-aa07-ff73-d7bf49727a95@redhat.com>
Date: Thu, 13 Apr 2017 14:11:32 +0800
MIME-Version: 1.0
In-Reply-To: <877f2pnb2t.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>



On 12/04/2017 19:02, Markus Armbruster wrote:
>>                           Note that mingw lacks decent signal
>> support, and will never report a signal because it never calls
>> qemu_system_killed().
> 
> Awkward.

ISO C trivia of the day: "kill" is only a POSIX function.

> os-posix.c arranges for SIGINT, SIGHUP and SIGTERM to be caught.  Here's
> the handler:
> 
>     static void termsig_handler(int signal, siginfo_t *info, void *c)
>     {
>         qemu_system_killed(info->si_signo, info->si_pid);
>     }
> 
>     void qemu_system_killed(int signal, pid_t pid)
>     {
>         shutdown_signal = signal;
>         shutdown_pid = pid;
>         no_shutdown = 0;
> 
>         /* Cannot call qemu_system_shutdown_request directly because
>          * we are in a signal handler.
>          */
>         shutdown_requested = 1;
>         qemu_notify_event();
>     }
> 
> The variables are all int or pid_t.  Works in practice (pedants might
> ask for sig_atomic_t, but I won't).
> 
> In other words, these three signals are polite requests to terminate
> QEMU.
> 
> Stefan, are there equivalent requests under Windows?  I guess there
> might be one at least for SIGINT, namely whatever happens when you hit
> ^C on the console.

SIGINT and SIGBREAK exist, so you can just use a termsig_handler which
passes 0 for the pid.

Paolo
