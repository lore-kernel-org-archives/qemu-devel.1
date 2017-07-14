Received: from eggs.gnu.org ([2001:4830:134:3::10]:54382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dWAJO-00047U-6M
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dWAJM-0006dE-Sy
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:47:54 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:35272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dWAJM-0006c0-Fi
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 19:47:52 -0400
Received: by mail-lf0-x22a.google.com with SMTP id b207so61130874lfg.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 16:47:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170715023159-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714182012.4595-3-marcandre.lureau@redhat.com>
	<20170714222023-mutt-send-email-mst@kernel.org>
	<5d31f22d-e0ae-92f4-ea17-690419f72944@redhat.com>
	<20170714230852-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJW1pCqJMN3JmGunFKswNnR=J74+Z_m5Lj5WYT2Z1ZoPQ@mail.gmail.com>
	<20170715012551-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJP2DSo-khn+do0YG_ALDXrqBi6wEPH=m+W59rPfRTuiA@mail.gmail.com>
	<20170715023159-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 15 Jul 2017 01:47:50 +0200
Message-ID: <CAJ+F1C+F+HjHxzrq0usibfYUidpBW8DQUS72pDAv7xC6O14t3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/8] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Dave Anderson <anderson@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sat, Jul 15, 2017 at 1:40 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sat, Jul 15, 2017 at 01:30:56AM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Sat, Jul 15, 2017 at 1:09 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>> >
>> > On Sat, Jul 15, 2017 at 12:12:06AM +0200, Marc-Andr=C3=A9 Lureau wrote=
:
>> > > Hi
>> > >
>> > > On Fri, Jul 14, 2017 at 10:17 PM, Michael S. Tsirkin <mst@redhat.com=
> wrote:
>> > > > On Fri, Jul 14, 2017 at 10:04:31PM +0200, Laszlo Ersek wrote:
>> > > >> > It worries me that the format of this seems completely undefine=
d
>> > > >> > except in the patchset cover letter.
>> > > >> > I don't think we should merge this before it is.
>> > > >>
>> > > >> I'm not sure what you mean, this patch adds "docs/specs/vmcoreinf=
o.txt".
>> > > >> That file is the first level contract between the guest firmware
>> > > >> (generally, via the linker/loader), the guest kernel driver
>> > > >> (specifically), and QEMU (also specifically).
>> > > >>
>> > > >> The second level contract is the guest kernel's vmcoreinfo ELF no=
te
>> > > >> (which is pointed-to by the first level contract). The layout of =
that is
>> > > >> specified elsewhere indeed (I don't think it belongs here).
>> > > >>
>> > > >> We've taken care not to trust anything coming from the guest kern=
el.
>> > > >>
>> > > >> Can you clarify please?
>> > > >>
>> > > >> Thanks
>> > > >> Laszlo
>> > > >
>> > > > All there is is this:
>> > > >
>> > > > +Version 0 content:
>> > > > +
>> > > > + uint64 paddr:
>> > > > +  Physical address of the Linux vmcoreinfo ELF note.
>> > > > + uint32 size:
>> > > > +  Size of the vmcoreinfo ELF note.
>> > > >
>> > > > It isn't defined here what is the Linux vmcoreinfo ELF note.
>> > > > You want a bit more info so people trying to use it know where to =
start
>> > > > and what they can get out of it.
>> > >
>> > > QEMU is not responsible for the content of the ELF note. All there i=
s afaik is:
>> > >
>> > > https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-vm=
coreinfo
>> > >
>> > > The rest you need to dig in the kernel code and git history I think.
>> >
>> > We need to do a good enough job to at least make it possible for peopl=
e
>> > to make use of it without reading your python code.
>> >
>> > Documentation/kdump/kdump.txt has a bit more information.
>> >
>> >         All of the necessary information about the system kernel's cor=
e image is
>> >         encoded in the ELF format, and stored in a reserved area of me=
mory
>> >         before a crash. The physical address of the start of the ELF h=
eader is
>> >         passed to the dump-capture kernel through the elfcorehdr=3D bo=
ot
>> >         parameter. Optionally the size of the ELF header can also be p=
assed
>> >         when using the elfcorehdr=3D[size[KMG]@]offset[KMG] syntax.
>> >
>> >
>> >         With the dump-capture kernel, you can access the memory image =
through
>> >         /proc/vmcore. This exports the dump as an ELF-format file that=
 you can
>> >         write out using file copy commands such as cp or scp. Further,=
 you can
>> >         use analysis tools such as the GNU Debugger (GDB) and the Cras=
h tool to
>> >         debug the dump file. This method ensures that the dump pages a=
re correctly
>> >         ordered.
>> >
>> > I know where to find it but most people likely won't be able to.
>> >
>>
>> What do you learn from that regarding vmcoreinfo? That is it being
>> used by kdump? and that you can use gdb/crash, that we already use to
>> analyse our dumps.
>
> Some things I learn:
>
> That its written by a dump-capture kernel (so you need to set one up
> if you want it to work!).

I don't follow you, you don't need a dump-capture kernel / kdump to
have the vmcoreinfo note.

>
> That it's an ELF-format file, that one can use analysis tools such as
> the GNU Debugger (GDB) and the Crash tool to debug the dump file.

Well, that's what kdump does, but qemu is the one making the dump in
our case. Quite irrelevant for us.

>
> There's more info scattered in other places.
>
> Why do you get to document it? Because you are the one exposing it
> across the hypervisor/vm boundary where it will need to be
> understood by people/tools not running within guest.
>
> So "just read the script in qemu source" is not how an interface
> should be documented.

I don't understand the issue, it's a kernel ELF note that qemu passes
for dump/crash tools in the dump headers/sections.

>
>> >
>> > BTW why does it pass ELF header size? Any idea?
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dd3bf37955d46718ee1a7f1fc69f953d2328ba7c2
>
> Right but I mean, ELF header has two options: 32 and 64 bit, that's all.
>
> --
> MST



--=20
Marc-Andr=C3=A9 Lureau
