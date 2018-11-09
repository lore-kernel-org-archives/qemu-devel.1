Received: from eggs.gnu.org ([2001:4830:134:3::10]:39912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1gL3eN-0000Da-69
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1gL3eJ-00071f-8S
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:04:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:53174 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1gL3eI-00070t-Rb
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:04:23 -0500
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
	<c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
	<20181109072015.GA86700@gmail.com>
	<38905d35-29af-b522-1629-b13e98a47a42@intel.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
Date: Fri, 9 Nov 2018 11:04:19 +0100
MIME-Version: 1.0
In-Reply-To: <38905d35-29af-b522-1629-b13e98a47a42@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <zhijianx.li@intel.com>, Ingo Molnar <mingo@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org, hpa@zytor.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kees Cook <keescook@chromium.org>

On 09/11/2018 10:57, Li Zhijian wrote:
> On 11/9/2018 3:20 PM, Ingo Molnar wrote:
>> * Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>>
>>>> If the kernel initrd creation process creates an initrd which
>>>> is larger than 2GB and also claims that it can't be placed
>>>> with any part of it above 2GB, then that sounds like a bug
>>>> in the initrd creation process...
>>> Exactly, it's a real problem.
>>>
>>> Add x86 maintainers and LKML:
>>>
>>> The background is that QEMU want to support up to 4G initrd. but
>>> linux header (
>>> initrd_addr_max field) only allow 2G-1.
>>> Is one of the below approaches reasonable:
>>> 1) change initrd_addr_max to 4G-1 directly
>>> simply(arch/x86/boot/header.S)?
>>> 2) lie QEMU bootloader the initrd_addr_max is 4G-1 even though header
>>> said 2G-1
>>> 3) any else
>> A 10 years old comment from hpa says:
>>
>> =C2=A0=C2=A0 initrd_addr_max: .long 0x7fffffff
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # (Header version 0x0203 or
>> later)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # The highest safe address for
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # the contents of an initrd
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # The current kernel allows
>> up to 4 GB,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # but leave it at 2 GB to avoid
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # possible bootloader bugs.
>>
>> To avoid the potential of bugs lurking in dozens of major and hundreds=
 of
>> minor iterations of various Linux bootloaders I'd prefer a real soluti=
on
>> and extend it - because if there's a 2GB initrd for some weird reason
>> today there might be a 4GB one in two years.
>=20
> thank a lots. that's amazing.
>=20
>=20
>>
>> The real solution would be to:
>>
>> =C2=A0 - Extend the boot protocol with a 64-bit field, named initrd_ad=
dr64_max
>> =C2=A0=C2=A0=C2=A0 or such.
>> =C2=A0 - We don't change the old field - but if the new field is set b=
y new
>> =C2=A0=C2=A0=C2=A0 kernels then new bootloaders can use that as a new =
initrd_addr64_max
>> =C2=A0=C2=A0=C2=A0 value. (or reject to load the kernel if the address=
 is too high.)
>>
>> =C2=A0 - The kernel build should also emit a warning when building lar=
ger than
>> =C2=A0=C2=A0=C2=A0 2GB initrds, with a list of bootloaders that suppor=
t the new
>> protocol.
>=20
> Actually i just knew QEMU(Seabios + optionrom(linuxboot_dma.bin)) can
> support ~4GB initrd so far.
>=20
> i just drafted at patch to add this field. could you have a look.
> another patch which is to document initrd_addr64_max is ongoing.
>=20
> commit db463ac9c1975f115d1ce2acb82d530c2b63b888
> Author: Li Zhijian <lizhijian@cn.fujitsu.com>
> Date:=C2=A0=C2=A0 Fri Nov 9 17:24:14 2018 +0800
>=20
> =C2=A0=C2=A0=C2=A0 x86: Add header field initrd_addr64_max
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Years ago, kernel had support loa=
d ~4GB initrd. But for some
> weird reasons (
> =C2=A0=C2=A0=C2=A0 avoid possible bootloader bugs), it only allow leave=
 initrd under
> 2GB address
> =C2=A0=C2=A0=C2=A0 space(see initrd_addr_max fild at arch/x86/boot/head=
er.S).
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 So modern bootloaders have not ch=
ance to load >=3D2G initrd
> previously.
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 To avoid the potential of bugs lu=
rking in dozens of major and
> hundreds of
> =C2=A0=C2=A0=C2=A0 minor iterations of various Linux bootloaders. Ingo =
suggests to add
> a new field
> =C2=A0=C2=A0=C2=A0 initrd_addr64_max. If bootloader believes that it ca=
n load initrd to
>>=3D2G
> =C2=A0=C2=A0=C2=A0 address space, it can use initrd_addr64_max as the m=
aximum loading
> address in
> =C2=A0=C2=A0=C2=A0 stead of the old field initrd_addr_max.
>=20
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 4c881c8..5fc3ebe 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -300,7 +300,7 @@ _start:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Part 2 of the header, from=
 the old setup.S
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .ascii=C2=A0 "HdrS"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # header signature
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 .word=C2=A0=C2=A0 0x020e=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # header version number (>=3D 0x0105)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 .word=C2=A0=C2=A0 0x020f=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # header version number (>=3D 0x0105)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 # or else old loadlin-1.5 will
> fail)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 .globl realmode_swtch
> =C2=A0realmode_swtch:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .word=C2=
=A0=C2=A0 0, 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 # default_switch, SETUPSEG
> @@ -562,6 +562,12 @@ acpi_rsdp_addr:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .quad 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> # 64-bit physical pointer to the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # ACPI RSDP =
table, added
> with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # version 2.=
14
> =C2=A0
> +#ifdef CONFIG_INITRD_SIZE_4GB
> +initrd_addr64_max:=C2=A0=C2=A0=C2=A0=C2=A0 .quad 0xffffffff=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # allow ~4G initrd since
> 2.15
> +#else
> +initrd_addr64_max:=C2=A0=C2=A0=C2=A0=C2=A0 .quad 0

Shouldn't this be 0x7fffffff?

And please update Documentation/x86/boot.txt


Juergen
