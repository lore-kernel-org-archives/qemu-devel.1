Received: from eggs.gnu.org ([2001:4830:134:3::10]:59080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ccBjy-0006hw-TJ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ccBjx-0007Hp-VR
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:59:58 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:34607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1ccBjx-0007HZ-Oi
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 08:59:57 -0500
Received: by mail-ot0-x22f.google.com with SMTP id f9so28464411otd.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 05:59:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <239d2e0e-2087-9135-8946-797d006968f9@redhat.com>
References: <20170210014519.12413-1-bobby.prani@gmail.com>
	<52c93dcc-2577-e81f-867c-6159c1f61e91@redhat.com>
	<87zihuw86q.fsf@linaro.org>
	<239d2e0e-2087-9135-8946-797d006968f9@redhat.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 10 Feb 2017 08:59:26 -0500
Message-ID: <CAJhHMCBT9+ETY+3-A5zF5wiv=63Ja-6YR=Pv+6doRbF2SbO-xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>

On Fri, Feb 10, 2017 at 7:29 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 10/02/2017 13:18, Alex Benn=C3=A9e wrote:
> >> I think you can unlock/lock the iothread here, and also call
> >
> > The iothread is already unlocked by this point (see tcg_cpu_exec).
>
> Is this patch on top of the MTTCG branch?  If not, cpu_handle_exception
> runs with the iothread lock taken doesn't it?
>
> >> cpu_exec_end/start to work around the limitation in start_exclusive.
> >
> > While that seems right it also seems very messy as it inverts the calls
> > so far. I fear we may end up very confused in special casing. Is there =
a
> > cleaner way we can unwind this?
>
> I'm not sure what is messy...  cpu_exec_start/end and
> start/end_exclusive are fundamentally a rwlock.
>
> Doing
>
>         cpu_exec_end
>         start_exclusive
>         ...
>         end_exclusive
>         cpu_exec_start
>
> simply means temporarily upgrading the lock from read to write.
>

This seems to be the simplest thing to do for now. I'll send a v2.

Thanks,
--=20
Pranith
