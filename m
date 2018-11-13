Received: from eggs.gnu.org ([2001:4830:134:3::10]:41911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMVet-0000HO-2m
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMVer-0008VY-MW
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:10:59 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:38787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gMVer-0008Us-Ec
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:10:57 -0500
Received: by mail-io1-xd41.google.com with SMTP id h4so4339341iom.5
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 02:10:57 -0800 (PST)
MIME-Version: 1.0
References: <1542073341-2843-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA-GU85D_7kopc2s7GmTExsqSda0j73v2ecafr_FGKYBLw@mail.gmail.com>
In-Reply-To: <CAFEAcA-GU85D_7kopc2s7GmTExsqSda0j73v2ecafr_FGKYBLw@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Nov 2018 18:10:20 +0800
Message-ID: <CAKXe6S+rCv4qGnGYQiR0KO3CLcjL0BvkwY0SrVTMqsiUS=BUZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory: check write/read_with_attrs in
 memory dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B411=E6=9C=881=
3=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:49=E5=86=99=E9=81=93=EF=BC=
=9A

> On 13 November 2018 at 01:42, Li Qiang <liq3ea@gmail.com> wrote:
> > This can avoid the NULL-deref if the rm doesn't has a
> > read/write nor write/read_with_attrs callback.
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  memory.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
>
> Alternative approach -- assert that every MemoryRegionOps has
> pointers to callbacks in it, when it is registered in
> memory_region_init_io()
>

Actually I have considered this approach, but I rember Paolo remind me that
some
of this MR without read callback's is valid because the read can never be
called, such as
'notdirty_mem_ops'. So I choose add a check here.



> and memory_region_init_rom_device_nomigrate().
>
> I don't have a strong opinion on which is better, but I guess
> I slightly favour requiring devices to be specific about what
> their read/write behaviour is.
>
> Do we have many devices that legitimately only want to implement
> one of read and write, not both ?


AFAICS, the device has just one read or write is not uncommon.
But nearly all of them implement a nop function does nothing.
So there just very little lack of the read or write function.

Thanks,
Li Qiang


>
> thanks
> -- PMM
>
