Received: from eggs.gnu.org ([2001:4830:134:3::10]:33028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cT2Cd-00053R-Tc
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cT2Ca-0006uU-SE
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:59:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cT2Ca-0006uH-JQ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:59:40 -0500
References: <1484376662-32063-1-git-send-email-thuth@redhat.com>
	<2296ffa3-8bb9-4652-ebd6-4da5b09596ca@vivier.eu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1ed4fded-4468-16cd-96e2-f70c1b85ab7d@redhat.com>
Date: Mon, 16 Jan 2017 08:59:33 +0100
MIME-Version: 1.0
In-Reply-To: <2296ffa3-8bb9-4652-ebd6-4da5b09596ca@vivier.eu>
Content-Type: text/plain; charset=utf-8
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
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On 14.01.2017 12:03, Laurent Vivier wrote:
> Le 14/01/2017 =C3=A0 07:51, Thomas Huth a =C3=A9crit :
>> Sometimes it is useful to have just a machine with CPU and RAM, withou=
t
>> any further hardware in it, e.g. if you just want to do some instructi=
on
>> debugging for TCG with a remote GDB attached to QEMU, or run some embe=
dded
>> code with the "-semihosting" QEMU parameter. qemu-system-m68k already
>> features a "dummy" machine, and xtensa a "sim" machine for exactly thi=
s
>> purpose.
>> All target architectures have nowadays also a "none" machine, which wo=
uld
>> be a perfect match for this, too - but it currently does not allow to =
add
>> CPU, RAM or a kernel yet. Thus let's add these possibilities in a gene=
ric
>> way to the "none" machine, too, so that we hopefully do not need addit=
ional
>> "dummy" machines in the future anymore (and maybe can also get rid of =
the
>> already existing "dummy"/"sim" machines one day).
>> Note that the default behaviour of the "none" machine is not changed, =
i.e.
>> no CPU and no RAM is instantiated by default. You've explicitely got t=
o
>> specify the CPU model with "-cpu" and the amount of RAM with "-m" to g=
et
>> these new features.
>=20
> Did you try to use the generic-loader to load the kernel?
>=20
> Something like "-device loader,file=3Dvmlinux" instead of adding this p=
art
> in the none machine?

It does not work by default - because we need a way to set the CPU's
program counter to the entry point of the ELF file.
But I think the users also expect the "-kernel" parameter to be working,
so I think we should add the loader code in null-machine.c anyway.

> Perhaps we could also add a cpu this way, as they are already available
> in the device list for the machine that allows hotplug.

The only machine that allows hot-plugging of CPUs with the device
interface is ppc64 spapr, as far as I know. So this does not help with
embedded boards like m68k or xtensa. Also I think you need some
additional magic like a bus where the CPUs could be attached, and maybe
firmware interfaces, so this does not fit the idea of an embedded board
very well.

> With the same idea, we could also have a "-device ram,size=3DXXX" to ad=
d
> ram (not DIMM).

That might be useful indeed, but mainly because some embedded boards
expect some additinal RAM at a higher, non-zero addresses, too.

> I think is is the idea behind the none machine:
[...]
>     This
>     also provides a mode that we can use in the future to construct mac=
hines
>     entirely through QMP commands.

We're still very far away from the possibility that everything could be
constructed on the fly. (Embedded) CPUs, RAM, buses ... all that is not
really pluggable yet. So I think my patch is a good first step into this
direction to get at least an initial playground for a machine that can
be defined by the user.

 Thomas
