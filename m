Received: from eggs.gnu.org ([2001:4830:134:3::10]:59234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dje@google.com>) id 1cGWEU-0002Is-58
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 14:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dje@google.com>) id 1cGWER-0007Yp-42
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 14:25:54 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:34991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dje@google.com>) id 1cGWEQ-0007SH-U9
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 14:25:51 -0500
Received: by mail-io0-f178.google.com with SMTP id h30so188139599iod.2
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 11:25:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <94eb2c0bfa1c6a9fec0543057483@google.com>
References: <94eb2c0bfa1c6a9fec0543057483@google.com>
From: Doug Evans <dje@google.com>
Date: Mon, 12 Dec 2016 11:23:46 -0800
Message-ID: <CADPb22R4bTg1en3rL3M=3_nLgC7Xj1P=j-mzwVtco0ar3h4EMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] target-i386: Fix eflags.TF/#DB handling of
 syscall/sysret insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Dec 6, 2016 at 3:06 PM, Doug Evans <dje@google.com> wrote:
> Hi.
>
> While qemu's behaviour matches what one would expect from reading
> the docs, it does not match what I'm seeing on h/w.
> Can anyone else confirm what the correct behaviour is here?
>
> ---
>
> The syscall and sysret instructions behave a bit differently:
> TF is checked after the instruction completes.
> This allows the o/s to disable #DB at a syscall by adding TF to FMASK.
> And then when the sysret is executed the #DB is taken "as if" the
> syscall insn just completed.
>
> Signed-off-by: Doug Evans <dje@google.com>

Ping.
Especially, can anyone confirm the correct behaviour here?

I can provide a testcase with Fuchsia if one likes.
https://fuchsia.googlesource.com/fuchsia/
It's not that hard to repro - we trip over it because we don't have a #DB IST
and since SYSCALL doesn't change SP we get a double fault on qemu
trying to establish the interrupt frame for the #DB (whereas the #DB shouldn't
happen in the first place - at least when run on the h/w I'm using).
The Intel/AMD docs are *really* unclear on this AFAICT.

patchwork reference: http://patchwork.ozlabs.org/patch/703373/
