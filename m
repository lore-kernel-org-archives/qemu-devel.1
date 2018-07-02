Received: from eggs.gnu.org ([2001:4830:134:3::10]:44359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fZz82-0005Eg-AN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fZz7z-0000ct-60
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:44:30 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:51036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fZz7y-0000cI-SJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:44:27 -0400
Received: from player718.ha.ovh.net (unknown [10.109.122.7])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1EF1C1C08AB
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 15:44:25 +0200 (CEST)
Date: Mon, 2 Jul 2018 15:44:12 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180702154412.3634679f@bahia.lan>
In-Reply-To: <20180629203424.GG914@localhost.localdomain>
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
	<20180629103910.GE27016@redhat.com>
	<65a3597e-5560-1fd3-4f04-8a60e9e99b44@redhat.com>
	<20180629130701.6ab5d88a@bahia.lan>
	<29caab50-f853-66bf-805e-984e76619a9a@redhat.com>
	<20180629111405.GG27016@redhat.com>
	<20180629171821.5e379a31@redhat.com>
	<20180629201652.GA7451@localhost.localdomain>
	<20180629203424.GG914@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Fri, 29 Jun 2018 17:34:24 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, Jun 29, 2018 at 05:16:52PM -0300, Eduardo Habkost wrote:
> > On Fri, Jun 29, 2018 at 05:18:21PM +0200, Igor Mammedov wrote: =20
> > > On Fri, 29 Jun 2018 12:14:05 +0100
> > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > >  =20
> > > > On Fri, Jun 29, 2018 at 01:08:38PM +0200, Paolo Bonzini wrote: =20
> > > > > On 29/06/2018 13:07, Greg Kurz wrote:   =20
> > > > > >>>> Also asserting current_machine !=3D NULL is not necessary, s=
ince you're
> > > > > >>>> immediately dereferencing it.     =20
> > > > > >>> Is there a practical way to simply initialize the accelerator=
s earlier
> > > > > >>> in startup sequence, so we just remove or at least reduce, th=
e liklihood
> > > > > >>> of accessing it too early ?     =20
> > > > > >> We can try, though not for 3.0 of course.
> > > > > >>   =20
> > > > > > FWIW, the motivation for this patch was kvm_enabled() being cal=
led under
> > > > > > the class_init function of the machine TypeInfo. This happens w=
ay earlier
> > > > > > than accelerator init. Not sure this is doable, but I can have =
a look.
> > > > > >    =20
> > > > >=20
> > > > > Probably not, that's way too early indeed.   =20
> > > >=20
> > > > Yeah, doing anything non-trivial in class_init is just asking for t=
rouble,
> > > > as conceivably nothing is initialized at that point.  =20
> > > isn't class_init called lazily? (so it might actually work as far as =
type
> > > isn't touched before kvm is initialized) =20
> >=20
> > You have a good point: this means class_init bugs won't always
> > trigger the assert because of lazy class_init.  It would be a
> > good idea to add a functional test that calls qom-list-types
> > using --preconfig to try to trigger them. =20
>=20
> Heh, I just noticed that the first thing we do immediately after
> parsing command-line options is calling:
>=20
>  select_machine()
>  find_default_machine()
>  object_class_get_list()
>  object_class_foreach()
>  g_hash_table_foreach()
>  object_class_foreach_tramp()
>  type_initialize()
>=20
> ...which will call class_init for every single QOM type in QEMU.
>=20

Yes indeed. IIUC, this would trigger the assert if any QOM type
calls a ${acc}_enabled() from its class_init then.

BTW, I've just realized it triggers on x86:

#0  0x00007fffef7f0660 in raise () at /lib64/libc.so.6
#1  0x00007fffef7f1c41 in abort () at /lib64/libc.so.6
#2  0x00007fffef7e8f7a in __assert_fail_base () at /lib64/libc.so.6
#3  0x00007fffef7e8ff2 in  () at /lib64/libc.so.6
#4  0x0000555555860cdd in assert_accelerator_initialized (allowed=3Dfalse) =
at /home/greg/Work/qemu/qemu-master/accel/accel.c:56
#5  0x000055555593c4db in host_x86_cpu_class_init (oc=3D0x5555566864c0, dat=
a=3D0x0) at /home/greg/Work/qemu/qemu-master/target/i386/cpu.c:2841
#6  0x0000555555c93ff3 in type_initialize (ti=3D0x5555565ef3c0) at /home/gr=
eg/Work/qemu/qemu-master/qom/object.c:342
#7  0x0000555555c95143 in object_class_foreach_tramp (key=3D0x5555565ca630,=
 value=3D0x5555565ef3c0, opaque=3D0x7fffffffd9b0) at /home/greg/Work/qemu/q=
emu-master/qom/object.c:813
#8  0x00007ffff76afec0 in g_hash_table_foreach () at /lib64/libglib-2.0.so.0
#9  0x0000555555c95222 in object_class_foreach (fn=3D0x555555c95373 <object=
_class_get_list_tramp>, implements_type=3D0x555555e31996 "machine", include=
_abstract=3Dfalse, opaque=3D0x7fffffffda00) at /home/greg/Work/qemu/qemu-ma=
ster/qom/object.c:835
#10 0x0000555555c953f1 in object_class_get_list (implements_type=3D0x555555=
e31996 "machine", include_abstract=3Dfalse) at /home/greg/Work/qemu/qemu-ma=
ster/qom/object.c:889
#11 0x00005555559c1608 in find_default_machine () at /home/greg/Work/qemu/q=
emu-master/vl.c:1416
#12 0x00005555559c5517 in select_machine () at /home/greg/Work/qemu/qemu-ma=
ster/vl.c:2668
#13 0x00005555559c846d in main (argc=3D1, argv=3D0x7fffffffdd88, envp=3D0x7=
fffffffdd98) at /home/greg/Work/qemu/qemu-master/vl.c:3987

static void host_x86_cpu_class_init(ObjectClass *oc, void *data)
{
    X86CPUClass *xcc =3D X86_CPU_CLASS(oc);

    xcc->host_cpuid_required =3D true;
    xcc->ordering =3D 8;

    if (kvm_enabled()) {
        xcc->model_description =3D
            "KVM processor with all supported host features ";
    } else if (hvf_enabled()) {
        xcc->model_description =3D
            "HVF processor with all supported host features ";
    }
}

And, indeed, since commit d6dcc5583e7 (QEMU 2.11), -cpu ? shows the base
class description:

x86             host  Enables all features supported by the accelerator in =
the current host

instead of the expected:

x86             host  KVM processor with all supported host features=20

This is a good illustration on how a bug can go unnoticed, but would be
caught with this patch. So I'll polish v3 and post it ASAP.

Cheers,

--
Greg
