Received: from eggs.gnu.org ([2001:4830:134:3::10]:60643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQYet-0002GU-Rt
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dQYer-00031k-8c
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 08:34:55 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<4b48ca3f3c45bee1103bcb50d87e6d5cadc88d6f.1498607452.git.alistair.francis@xilinx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b959c21f-1c3e-e3ed-3012-24ef53cb8ff4@redhat.com>
Date: Thu, 29 Jun 2017 14:34:40 +0200
MIME-Version: 1.0
In-Reply-To: <4b48ca3f3c45bee1103bcb50d87e6d5cadc88d6f.1498607452.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v1 4/4] util/oslib-win32: Recursivly pass the
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, qemu-block@nongnu.org



On 28/06/2017 01:57, Alistair Francis wrote:
> +        /* We only found one and we are waiting on more then one. Let's try
> +         * again.
>           */
> -        if (timeout == 0 && nhandles > 1) {
> +        if (nhandles > 1) {
>              /* Remove the handle that fired */
>              int i;
>              if ((ready - WAIT_OBJECT_0) < nhandles - 1) {
> @@ -444,7 +444,20 @@ static int poll_rest(gboolean poll_msgs, HANDLE *handles, gint nhandles,
>                  }
>              }
>              nhandles--;
> -            recursed_result = poll_rest(FALSE, handles, nhandles, fds, nfds, 0);
> +
> +            /* If we just had a very small timeout let's increase it when we
> +             * recurse to ensure we don't just busy wait. This ensures we let
> +             * the Windows threads block at least a little. If we previously
> +             * had some wait let's set it to zero to avoid blocking for too
> +             * long.
> +             */
> +            if (timeout < 10) {
> +                timeout = timeout + 1;
> +            } else {
> +                timeout = 0;
> +            }
> +            recursed_result = poll_rest(FALSE, handles, nhandles, fds,
> +                                        nfds, timeout);
>              return (recursed_result == -1) ? -1 : 1 + recursed_result;

I'm not sure I agree with this change, which is effectively delaying the
processing of events.  The question to me is which handles are
triggering so fast that QEMU effectively busy waits.

Maybe your QEMUs can get some breath with commit 12f8def0e0 ("win32:
replace custom mutex and condition variable with native primitives",
2017-03-27), since the native primitives are more efficient and TCG 2.8
used condvars a lot for qemu_io_proceeded_cond.

Paolo
