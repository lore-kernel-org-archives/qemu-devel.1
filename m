Received: from eggs.gnu.org ([2001:4830:134:3::10]:58224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g0Gdh-00081c-CK
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g0GZ9-0007Qx-Hf
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:37:09 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g0GZ9-0007Pv-C4
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 21:37:07 -0400
Received: by mail-qk1-x742.google.com with SMTP id f17-v6so2360194qkh.4
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 18:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <1536755529-2709-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA-gybpeAucvWuUW3QAyvwjMVcxL_5xxrcaaekJS51vT4Q@mail.gmail.com>
	<9b7e968f-b683-c431-b524-4df7de36b806@redhat.com>
	<CAFEAcA_50n98m=9a9hiLvV5_iQyXicf70WT1CFAYyV_mfhJnrg@mail.gmail.com>
In-Reply-To: <CAFEAcA_50n98m=9a9hiLvV5_iQyXicf70WT1CFAYyV_mfhJnrg@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 13 Sep 2018 09:36:28 +0800
Message-ID: <CAKXe6SLHY4-Ttfa1AzFSJfyeZqUC_EzrjCKCMWVhh8i4L_d74Q@mail.gmail.com>
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
Cc: Laszlo Ersek <lersek@redhat.com>, mst@redhat.com, ehabkost@redhat.com, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B49=E6=9C=8813=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=888:31=E5=86=99=E9=81=93=EF=BC=
=9A

> On 12 September 2018 at 18:43, Laszlo Ersek <lersek@redhat.com> wrote:
> > On 09/12/18 14:54, Peter Maydell wrote:
> >> There's patches on-list which drop the old_mmio field from the
> MemoryRegion
> >> struct entirely, so I think this patch as it stands is obsolete.
> >>
> >> Currently our semantics are "you must provide both read and write, eve=
n
> >> if one of them just always returns 0 / does nothing / returns an error=
".
> >
> > That's new to me. Has this always been the case?
>
> Pretty sure it has, yes, because the code assumes that if you can
> get a guest read then your MemoryRegion provides an accessor for it.
> If your guest never actually tries to do a read then of course we'll
> never notice...
>
> > There are several
> > static MemoryRegionOps structures that don't conform. (See the end of m=
y
> > other email:
> > <
> http://mid.mail-archive.com/84da6f02-1f60-4bc7-92da-6a7f74deded3@redhat.c=
om
> >.)
> > Beyond the one that Li Qiang reported directly ("fw_cfg_ctl_mem_read").
> >
> > Are all of those ops guest-triggerable QEMU crashers?
>
> Some of them are special cases like the notdirty-memory one where
> reads always go to host RAM rather than taking the slow path via
> the io accessor. But others are probably guest crashers.
>
> >> We could probably reasonably assert this at the point when the
> >> MemoryRegionOps is registered.
> >
> > Apparently, we should have...
>
> Yeah. Or we could define a default for if there's no read function,
> which I guess should be the same as what we do if
> memory_region_access_valid() fails.

If we want that then the
> simplest thing is for memory_region_access_valid() itself to
> check that at least one of the accessor functions exists and
> return false if none do.


I thinks this proposal makes sense as every memory region write/read will
go to this path and also the device code can make no change.

Thanks,
Li Qiang

(But as I mention above we should get
> all the "old_mmio is going away" patches in first and base the
> change on that, or there'll be a conflict.)
>
>



> thanks
> -- PMM
>
