Received: from eggs.gnu.org ([209.51.188.92]:54072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hImSe-0005NC-3E
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 23:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hImSc-0001EY-9h
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 23:51:12 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hImSb-0001DX-UL
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 23:51:10 -0400
Received: by mail-ot1-x344.google.com with SMTP id m10so11598998otp.2
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 20:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-2-liq3ea@163.com>
	<46a216be-0898-2d52-485d-fd07428c8b76@redhat.com>
	<CAKXe6S+5TTO3Czxsx98rd3d5UvyCnd5gMeWE6RW8b_eeE_b+3Q@mail.gmail.com>
	<6538e063-8710-3ad1-cb88-cda110d57212@redhat.com>
In-Reply-To: <6538e063-8710-3ad1-cb88-cda110d57212@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 23 Apr 2019 11:50:32 +0800
Message-ID: <CAKXe6SJuPw9cMcc-d9fYH1NiBVq3Oe5uN7R28nBtKX+zx2ReUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] edu: mmio: set 'max_access_size' to
 8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, Jiri Slaby <jslaby@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=
=9C=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:28=E5=86=99=E9=81=
=93=EF=BC=9A

> On 4/22/19 3:17 AM, Li Qiang wrote:
> >
> >
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E
> > 2019=E5=B9=B44=E6=9C=8821=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=88=
6:28=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     Hi Li,
> >
> >     The patch title is not very descriptive, maybe "allow 64-bit access=
"
> >
> >
> >     On 4/20/19 6:14 PM, Li Qiang wrote:
> >     > The edu spec said, the MMIO area can be accessed by 8 bytes.
> >
> >     or 64-bit...
> >
> >     > However currently the 'max_access_size' is not so the MMIO
> >     > access dispatch can only access 4 bytes one time. This patch
> >
> >     32-bit
> >
> >     > fixes this to respect the spec.
> >     >
> >     > Notice: here the 'min_access_size' is not a must, I set this
> >     > for completement.
> >
> >     Which one? valid/impl? I think you can drop this comment from the
> commit
> >     description.
> >
> >
> > Both needed. from memory_access_size, if we has no valid.max_access_siz=
e,
> > this function will set it to 4.
> >
> > static int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr=
)
> > {
> >     unsigned access_size_max =3D mr->ops->valid.max_access_size;
> >
> >     /* Regions are assumed to support 1-4 byte accesses unless
> >        otherwise specified.  */
> >     if (access_size_max =3D=3D 0) {
> >         access_size_max =3D 4;
> >     }
> >    ...
> > }
> >
> > From access_with_adjusted_size, if we has no impl.max_access_size,
> > this function will set it to 4.
> >
> > ps: I will appreciate if anyone can explain what's the meaning of valid
> > and impl's min/max_access_size
> > and how it affects the behavior.
>
> "valid" describes the valid access from the bus to the device.
>
> Indeed in the EDU case those are 4 and 8.
>
> "impl" describes the accesses implemented by the QEMU device model.
> The developper who writes the device is free to choose the accesses he
> will model.
>
> If valid/impl accesses don't match, the function
> access_with_adjusted_size() from memory.c will adjust the bus access to
> the device implementation.
>
> For example, if the device only implements 1 and 2 bytes accesses, with
> a 1-4 valid access, if the CPU executes a 32-bit access, this function
> will do 2x 16-bit access to the device (incrementing the address by 2)
> and returns a 32-bit result.
>
> Similarly, if the CPU does a 8-bit access on a 32-bit impl device,
> access_with_adjusted_size() will execute a single 32-bit access to the
> device, then mask/shift the returned value and returns a 8-bit result to
> the caller.
>
>
Thanks  Philippe,

I think I get the pointer.

Thanks,
Li Qiang



> > Thanks,
> > Li Qiang
> >
> >     >
> >     > Signed-off-by: Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>>
> >     > ---
> >     >  hw/misc/edu.c | 9 +++++++++
> >     >  1 file changed, 9 insertions(+)
> >     >
> >     > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> >     > index 91af452c9e..65fc32b928 100644
> >     > --- a/hw/misc/edu.c
> >     > +++ b/hw/misc/edu.c
> >     > @@ -289,6 +289,15 @@ static const MemoryRegionOps edu_mmio_ops =
=3D {
> >     >      .read =3D edu_mmio_read,
> >     >      .write =3D edu_mmio_write,
> >     >      .endianness =3D DEVICE_NATIVE_ENDIAN,
> >     > +    .valid =3D {
> >     > +        .min_access_size =3D 4,
> >
> >     Per the spec, this is correct.
> >
> >     > +        .max_access_size =3D 8,
> >
> >     Correct.
> >
> >     > +    },
> >     > +    .impl =3D {
> >     > +        .min_access_size =3D 4,
> >
> >     OK.
> >
> >     > +        .max_access_size =3D 8,
> >
> >     Correct.
> >
> >     > +    },
> >     > +
> >     >  };
> >     >
> >     >  /*
> >     >
> >
> >     With title/description updated:
> >     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
> >     <mailto:philmd@redhat.com>>
> >
>
