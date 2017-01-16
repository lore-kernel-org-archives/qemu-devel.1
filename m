Received: from eggs.gnu.org ([2001:4830:134:3::10]:51340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTCPW-0001SY-Va
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTCPV-0008Lx-S5
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:53:43 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cTCPV-0008Ij-N1
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:53:41 -0500
Received: by mail-ot0-x241.google.com with SMTP id 36so7199089otx.3
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 10:53:38 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1ed4fded-4468-16cd-96e2-f70c1b85ab7d@redhat.com>
References: <1484376662-32063-1-git-send-email-thuth@redhat.com>
	<2296ffa3-8bb9-4652-ebd6-4da5b09596ca@vivier.eu>
	<1ed4fded-4468-16cd-96e2-f70c1b85ab7d@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 16 Jan 2017 10:53:07 -0800
Message-ID: <CAKmqyKP0ejNQOd=AYYP+jNNtgMm6Mv8V7bQms2MVbDuDDAtquQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/null-machine: Add the possibility
 to instantiate a CPU, RAM and kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Sun, Jan 15, 2017 at 11:59 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 14.01.2017 12:03, Laurent Vivier wrote:
>> Le 14/01/2017 =C3=A0 07:51, Thomas Huth a =C3=A9crit :
>>> Sometimes it is useful to have just a machine with CPU and RAM, without
>>> any further hardware in it, e.g. if you just want to do some instructio=
n
>>> debugging for TCG with a remote GDB attached to QEMU, or run some embed=
ded
>>> code with the "-semihosting" QEMU parameter. qemu-system-m68k already
>>> features a "dummy" machine, and xtensa a "sim" machine for exactly this
>>> purpose.
>>> All target architectures have nowadays also a "none" machine, which wou=
ld
>>> be a perfect match for this, too - but it currently does not allow to a=
dd
>>> CPU, RAM or a kernel yet. Thus let's add these possibilities in a gener=
ic
>>> way to the "none" machine, too, so that we hopefully do not need additi=
onal
>>> "dummy" machines in the future anymore (and maybe can also get rid of t=
he
>>> already existing "dummy"/"sim" machines one day).
>>> Note that the default behaviour of the "none" machine is not changed, i=
.e.
>>> no CPU and no RAM is instantiated by default. You've explicitely got to
>>> specify the CPU model with "-cpu" and the amount of RAM with "-m" to ge=
t
>>> these new features.
>>
>> Did you try to use the generic-loader to load the kernel?
>>
>> Something like "-device loader,file=3Dvmlinux" instead of adding this pa=
rt
>> in the none machine?
>
> It does not work by default - because we need a way to set the CPU's
> program counter to the entry point of the ELF file.

The -device loader logic can set the PC to the entry point of the ELF.
You just need to specify 'cpu-num=3Dx' when loading the file.

> But I think the users also expect the "-kernel" parameter to be working,
> so I think we should add the loader code in null-machine.c anyway.

I agree that uses probably expect the '-kernel' option to work as well.

Thanks,

Alistair

>
>> Perhaps we could also add a cpu this way, as they are already available
>> in the device list for the machine that allows hotplug.
>
> The only machine that allows hot-plugging of CPUs with the device
> interface is ppc64 spapr, as far as I know. So this does not help with
> embedded boards like m68k or xtensa. Also I think you need some
> additional magic like a bus where the CPUs could be attached, and maybe
> firmware interfaces, so this does not fit the idea of an embedded board
> very well.
>
>> With the same idea, we could also have a "-device ram,size=3DXXX" to add
>> ram (not DIMM).
>
> That might be useful indeed, but mainly because some embedded boards
> expect some additinal RAM at a higher, non-zero addresses, too.
>
>> I think is is the idea behind the none machine:
> [...]
>>     This
>>     also provides a mode that we can use in the future to construct mach=
ines
>>     entirely through QMP commands.
>
> We're still very far away from the possibility that everything could be
> constructed on the fly. (Embedded) CPUs, RAM, buses ... all that is not
> really pluggable yet. So I think my patch is a good first step into this
> direction to get at least an initial playground for a machine that can
> be defined by the user.
>
>  Thomas
>
>
