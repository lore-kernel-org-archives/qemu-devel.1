Received: from eggs.gnu.org ([209.51.188.92]:47893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gz9Rj-0005gU-3C
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gz9Rc-0006F5-4B
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:21:04 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190227111411.22890-1-david@redhat.com>
	<20190227111411.22890-3-david@redhat.com>
	<ec7a9ec1-3d6d-6d19-246c-4f6d41f52ec1@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e1b83ea1-2ae3-e137-90d1-1d6adcc7a3f3@twiddle.net>
Date: Wed, 27 Feb 2019 16:17:47 -0800
MIME-Version: 1.0
In-Reply-To: <ec7a9ec1-3d6d-6d19-246c-4f6d41f52ec1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/tcg: target/s390: Add test
 for VECTOR LOAD GR FROM VR ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 2/27/19 11:37 AM, David Hildenbrand wrote:
> #define CHECK_SIGILL(STATEMENT)                  \
> do {                                             \
>     if (signal(SIGILL, sig_sigill) == SIG_ERR) { \
>         check("SIGILL not registered", false);   \
>     }                                            \
>     if (setjmp(jmp_env) == 0) {                  \
>         STATEMENT;                               \
>         check("SIGILL not triggered", false);    \
>     }                                            \
>     if (signal(SIGILL, SIG_DFL) == SIG_ERR) {    \
>         check("SIGILL not registered", false);   \
>     }                                            \
> } while (0)
> 
> 
> However it only works once. During the second signal, QEMU decides to
> set the default handler.
> 
> 1. In a signal handler that signal is blocked. We leave that handler via
> a longjump. So after the first signal, the signal is blocked.

And this is why we use sigaction not signal.

You can set action.sa_flags |= SA_RESETHAND to avoid needing the explicit reset
(or leave it clear to avoid the reset action that you are seeing).

You can set action.sa_flags |= SA_NODEFER to avoid having the signal added to
the signal mask of the thread, to avoid neeing to use sigsetjmp/siglongjmp.  Or
you can just use sigsetjmp/siglongjmp.  ;-)


r~
