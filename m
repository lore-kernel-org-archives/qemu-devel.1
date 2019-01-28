Received: from eggs.gnu.org ([209.51.188.92]:38298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBFD-0004Ns-4e
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBFB-0001ai-0K
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBF7-0001Vt-02
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:47 -0500
Received: by mail-ot1-x341.google.com with SMTP id t5so15471645otk.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-5-philmd@redhat.com>
	<20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
	<ad4d15ab-a625-2171-358a-95266ec53bf4@redhat.com>
In-Reply-To: <ad4d15ab-a625-2171-358a-95266ec53bf4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:02:32 +0000
Message-ID: <CAFEAcA8-FiXLns3Aj42cFkpUE54gAU0SRAO=kmWojU4+QdVm1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/display/milkymist-tmu2: Move
 inlined code from header to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Mon, 28 Jan 2019 at 17:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Cc'ing Thomas/Paolo for Makefile rules...
>
> On 1/24/19 12:43 PM, Gerd Hoffmann wrote:
> > Oops, fails the build:
> >
> >   LINK    lm32-softmmu/qemu-system-lm32
> > hw/lm32/milkymist.o: In function `milkymist_init':
> > milkymist.c:(.text+0xb0f): undefined reference to `milkymist_tmu2_creat=
e'
>
> The problem comes from patch #2:
>
> > diff --git a/default-configs/lm32-softmmu.mak
> b/default-configs/lm32-softmmu.mak
> > index 4889348a10..4049b23562 100644
> > --- a/default-configs/lm32-softmmu.mak
> > +++ b/default-configs/lm32-softmmu.mak
> > @@ -2,7 +2,7 @@
> >
> >  CONFIG_LM32=3Dy
> >  CONFIG_MILKYMIST=3Dy
> > -CONFIG_MILKYMIST_TMU2=3D$(CONFIG_OPENGL)
> > +CONFIG_MILKYMIST_TMU2=3D$(call land,$(CONFIG_X11),$(CONFIG_OPENGL))
> >  CONFIG_FRAMEBUFFER=3Dy
> >  CONFIG_PTIMER=3Dy
> >  CONFIG_PFLASH_CFI01=3Dy
> > diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> > index 97acd5b6cb..079e702f25 100644
> > --- a/hw/display/Makefile.objs
> > +++ b/hw/display/Makefile.objs
> > @@ -29,8 +29,8 @@ common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.o
> >  common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
> >
> >  common-obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
> > -milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS)
> > -milkymist-tmu2.o-libs :=3D $(X11_LIBS)
> > +milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS) $(OPENGL_CFLAGS)
> > +milkymist-tmu2.o-libs :=3D $(X11_LIBS) $(OPENGL_LIBS)
> >
> >  obj-$(CONFIG_OMAP) +=3D omap_dss.o
> >  obj-$(CONFIG_OMAP) +=3D omap_lcdc.o
>
> Using $(call land) seems to break CONFIG_MILKYMIST_TMU2 availability in
> $(common-obj), while it works correctly in the per-target $(obj).
> I'm not sure what is the cause, but moving milkymist-tmu2.o to $(obj)
> makes more sense and fix this, so I'll go this way.

Something weird definitely seems to be going on here -- 'call land'
ought not to be broken in this situation.

I don't understand why the build/config-all-devices.mak versions of
the defines of CONFIG_FOO variables are so weird:

CONFIG_ACPI:=3D$(findstring y,$(CONFIG_ACPI)y)

...are they really intended to be self-referential like that?

The per-target ones in build/foo-softmmu/config-devices.mak are
more like what I expected:

CONFIG_VGA=3Dy

Paolo, git blame says you wrote the makefile rune back in 2013:
I don't suppose you can remember the intent ?

thanks
-- PMM
