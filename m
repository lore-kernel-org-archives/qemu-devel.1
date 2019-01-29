Received: from eggs.gnu.org ([209.51.188.92]:59089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goMFd-0007CT-GQ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 00:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goMFc-00054G-PN
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 00:48:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1goMFc-000540-Hg
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 00:48:00 -0500
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-5-philmd@redhat.com>
	<20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
	<ad4d15ab-a625-2171-358a-95266ec53bf4@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <84607872-9520-8416-b0fe-8883a4b565ea@redhat.com>
Date: Tue, 29 Jan 2019 06:47:50 +0100
MIME-Version: 1.0
In-Reply-To: <ad4d15ab-a625-2171-358a-95266ec53bf4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 2019-01-28 18:47, Philippe Mathieu-Daud=C3=A9 wrote:
> Cc'ing Thomas/Paolo for Makefile rules...
>=20
> On 1/24/19 12:43 PM, Gerd Hoffmann wrote:
>> On Thu, Jan 24, 2019 at 02:15:54AM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> Move the complexity of milkymist_tmu2_create() into the
>>> source file. Doing so we avoid to include the X11/OpenGL
>>> headers in all LM32 devices, and we also avoid the duplicate
>>> declaration of glx_fbconfig_attr[] (it is already declared
>>> in hw/display/milkymist-tmu2.c).
>>> Since TYPE_MILKYMIST_TMU2 is now accessible, use it.
>>
>> Oops, fails the build:
>>
>>   LINK    lm32-softmmu/qemu-system-lm32
>> hw/lm32/milkymist.o: In function `milkymist_init':
>> milkymist.c:(.text+0xb0f): undefined reference to `milkymist_tmu2_crea=
te'
>=20
> The problem comes from patch #2:
>=20
>> diff --git a/default-configs/lm32-softmmu.mak
> b/default-configs/lm32-softmmu.mak
>> index 4889348a10..4049b23562 100644
>> --- a/default-configs/lm32-softmmu.mak
>> +++ b/default-configs/lm32-softmmu.mak
>> @@ -2,7 +2,7 @@
>>
>>  CONFIG_LM32=3Dy
>>  CONFIG_MILKYMIST=3Dy
>> -CONFIG_MILKYMIST_TMU2=3D$(CONFIG_OPENGL)
>> +CONFIG_MILKYMIST_TMU2=3D$(call land,$(CONFIG_X11),$(CONFIG_OPENGL))
>>  CONFIG_FRAMEBUFFER=3Dy
>>  CONFIG_PTIMER=3Dy
>>  CONFIG_PFLASH_CFI01=3Dy
>> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
>> index 97acd5b6cb..079e702f25 100644
>> --- a/hw/display/Makefile.objs
>> +++ b/hw/display/Makefile.objs
>> @@ -29,8 +29,8 @@ common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-vgafb.=
o
>>  common-obj-$(CONFIG_ZAURUS) +=3D tc6393xb.o
>>
>>  common-obj-$(CONFIG_MILKYMIST_TMU2) +=3D milkymist-tmu2.o
>> -milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS)
>> -milkymist-tmu2.o-libs :=3D $(X11_LIBS)
>> +milkymist-tmu2.o-cflags :=3D $(X11_CFLAGS) $(OPENGL_CFLAGS)
>> +milkymist-tmu2.o-libs :=3D $(X11_LIBS) $(OPENGL_LIBS)
>>
>>  obj-$(CONFIG_OMAP) +=3D omap_dss.o
>>  obj-$(CONFIG_OMAP) +=3D omap_lcdc.o
>=20
> Using $(call land) seems to break CONFIG_MILKYMIST_TMU2 availability in
> $(common-obj), while it works correctly in the per-target $(obj).
> I'm not sure what is the cause, but moving milkymist-tmu2.o to $(obj)
> makes more sense and fix this, so I'll go this way.

You could try whether adding an additional

 common-obj-$(CONFIG_ALL) +=3D milkymist-tmu2.o

fixes the issue for you, too.

OTOH, milkymist is only used by one target, so there is really no reason
that this file should be added to common-obj, thus using $(obj) is fine
here.

 Thomas
