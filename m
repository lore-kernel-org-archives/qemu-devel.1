Received: from eggs.gnu.org ([2001:4830:134:3::10]:60166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g068F-0007cA-Us
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g068F-0004Yu-1p
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:28:39 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:34561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g068E-0004Yi-P2
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 10:28:38 -0400
Received: by mail-qt0-x235.google.com with SMTP id m13-v6so2051775qth.1
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 07:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <1536755529-2709-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA-gybpeAucvWuUW3QAyvwjMVcxL_5xxrcaaekJS51vT4Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-gybpeAucvWuUW3QAyvwjMVcxL_5xxrcaaekJS51vT4Q@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 12 Sep 2018 22:28:01 +0800
Message-ID: <CAKXe6S+k5M5rr2ZEcq4KxryHMajcTrze9CVcKRSEFXJJ9qVX0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory region: check the old.mmio.read
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: mst@redhat.com, ehabkost@redhat.com, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B49=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:55=E5=86=99=E9=81=93=EF=BC=
=9A

> On 12 September 2018 at 13:32, Li Qiang <liq3ea@gmail.com> wrote:
> > To avoid NULL-deref for the devices without read callbacks
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  memory.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/memory.c b/memory.c
> > index 9b73892768..48d025426b 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -406,6 +406,10 @@ static MemTxResult
> memory_region_oldmmio_read_accessor(MemoryRegion *mr,
> >  {
> >      uint64_t tmp;
> >
> > +    if (!mr->ops->old_mmio.read[ctz32(size)]) {
> > +        return MEMTX_DECODE_ERROR;
> > +    }
> > +
> >      tmp =3D mr->ops->old_mmio.read[ctz32(size)](mr->opaque, addr);
> >      if (mr->subpage) {
> >          trace_memory_region_subpage_read(get_cpu_index(), mr, addr,
> tmp, size);
> > --
> > 2.11.0
> >
>
> There's patches on-list which drop the old_mmio field from the MemoryRegi=
on
> struct entirely, so I think this patch as it stands is obsolete.
>
> Currently our semantics are "you must provide both read and write, even
> if one of them just always returns 0 / does nothing / returns an error".
> We could probably reasonably assert this at the point when the
> MemoryRegionOps is registered.
>

This patch is sent as the results of this thread:
-->https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg01332.html

So I think  I should send a path set to add all the missing read function
as Laszlo Ersek points
in the above thread discussion, right?

Thanks,
Li Qiang




>
> thanks
> -- PMM
>
