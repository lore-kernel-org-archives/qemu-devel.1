Received: from eggs.gnu.org ([2001:4830:134:3::10]:58536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g0GeG-00007l-3K
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g0GeE-0000k5-4V
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:42:23 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g0Ge8-0000Zd-DR
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:42:18 -0400
Received: by mail-qt0-x242.google.com with SMTP id x7-v6so3943172qtk.5
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 18:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180912160118.21158-1-liq3ea@163.com>
	<c8bfd44b-4d12-c2f6-7ac1-f8cda7178355@amsat.org>
In-Reply-To: <c8bfd44b-4d12-c2f6-7ac1-f8cda7178355@amsat.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 13 Sep 2018 09:41:33 +0800
Message-ID: <CAKXe6SL7zAsE78qL4-iJkTLrX2Lg+gv4WhwwneTJCNdPxeBXCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/8] Add missed read callback for some
 memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org, Eric Blake <eblake@redhat.com>, atar4qemu@gmail.com
Cc: =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, ehabkost@redhat.com, mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =E4=BA=8E2018=E5=B9=B49=E6=9C=
=8813=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:12=E5=86=99=E9=81=93=
=EF=BC=9A

> Hi Li,
>
> On 9/12/18 6:01 PM, Li Qiang wrote:
> > From: Li Qiang <liq3ea@gmail.com>
> >
> > This patch set try to add the missed read callback for memory region.
> > Without this patchset, when the guest reads the IO port/memory, it will
> > cause an NULL-dereference issue. For example, add
> > "-device isa-debug-exit" to command, then read the 0x501 port, it cause=
s
> a
> > SIGSEGV.
> >
> > The only exception is 'readonly_mem_ops' as its read is directly
> > access the underlying host ram as the comments says.
> >
> > These missed read callback is mostly pointed by Laszlo Ersek.
> >
> >
> >
> > Li Qiang (8):
> >   fw_cfg_mem: add read memory region callback
> >   hw: debugexit: add read callback
> >   hw: hyperv_testdev: add read callback
> >   hw: pc-testdev: add read memory region callback
> >   hw: designware: add read memory region callback
> >   hw: pvrdma: add read memory region callback
> >   hw: sun4c: add read memory region callback
> >   exec: add read callback for notdirty memory region
>
> Why not rather simply add a check in
> memory_region_oldmmio_read_accessor() instead?
>
> Eventually:
>
> {
>     uint64_t tmp;
>     int idx =3D ctz32(size);
>
>     if (unlikely(mr->ops->old_mmio.write[idx]
>                  && !mr->ops->old_mmio.read[idx])) {
>         tmp =3D 0; /* XXX is 0 the expected value??? */
>     } else {
>         tmp =3D mr->ops->old_mmio.read[idx](mr->opaque, addr);
>     }
>     ...
>

Hi, I have sent this patch. But...


We have discussed in another thread:
-->https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg01391.html

Thanks,
Li Qiang
