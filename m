Received: from eggs.gnu.org ([2001:4830:134:3::10]:59777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d8W34-00082x-Gl
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d8W31-0002VU-7P
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:09:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:26956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1d8W30-0002Rg-SG
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:09:15 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 10 May 2017 18:09:11 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1AB3F2C@ORSMSX112.amr.corp.intel.com>
References: <1494369432-15418-1-git-send-email-anthony.xu@intel.com>
	<20170510162927.GE19962@stefanha-x1.localdomain>
In-Reply-To: <20170510162927.GE19962@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] trace: add sanity check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>

> Please post steps for reproducing the abort.  I cannot reproduce this
> with qemu-system-x86_64.

The steps to reproduce the issue,

./configure --enable-trace-backend=3Dnop --target-list=3Dx86_64-softmmu

gdb -args ./x86_64-softmmu/qemu-system-x86_64 -bios /home/root/guest/seabio=
s.bin -smp 1 -machine q35,accel=3Dkvm
   -m 1G -drive format=3Draw,file=3D/home/root/images/centos7.2.img,if=3Did=
e,index=3D0 -nographic  -nodefaults
  -serial stdio -monitor pty


(gdb) bt
#0  0x00007ffff04e25f7 in raise () from /lib64/libc.so.6
#1  0x00007ffff04e3ce8 in abort () from /lib64/libc.so.6
#2  0x00005555559de905 in bitmap_new (nbits=3D<optimized out>)
    at /home/root/git/qemu2.git/include/qemu/bitmap.h:96
#3  cpu_common_initfn (obj=3D0x555556621d30) at qom/cpu.c:399
#4  0x0000555555a11869 in object_init_with_type (obj=3D0x555556621d30, ti=
=3D0x55555656bbb0) at qom/object.c:341
#5  0x0000555555a11869 in object_init_with_type (obj=3D0x555556621d30, ti=
=3D0x55555656bd30) at qom/object.c:341
#6  0x0000555555a11efc in object_initialize_with_type (data=3Ddata@entry=3D=
0x555556621d30, size=3D76560,
    type=3Dtype@entry=3D0x55555656bd30) at qom/object.c:376
#7  0x0000555555a12061 in object_new_with_type (type=3D0x55555656bd30) at q=
om/object.c:484
#8  0x0000555555a121c5 in object_new (typename=3Dtypename@entry=3D0x5555565=
50340 "qemu64-x86_64-cpu")
    at qom/object.c:494
#9  0x00005555557f6e3d in pc_new_cpu (typename=3Dtypename@entry=3D0x5555565=
50340 "qemu64-x86_64-cpu", apic_id=3D0,
    errp=3Derrp@entry=3D0x5555565391b0 <error_fatal>) at /home/root/git/qem=
u2.git/hw/i386/pc.c:1101
#10 0x00005555557fa33e in pc_cpus_init (pcms=3Dpcms@entry=3D0x5555565f9690)
    at /home/root/git/qemu2.git/hw/i386/pc.c:1184
#11 0x00005555557fe0f6 in pc_q35_init (machine=3D0x5555565f9690) at /home/r=
oot/git/qemu2.git/hw/i386/pc_q35.c:121
#12 0x000055555574fbad in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at vl.c:4562


Anthony


>=20
> > diff --git a/qom/cpu.c b/qom/cpu.c
> > index f02e9c0..f9111a0 100644
> > --- a/qom/cpu.c
> > +++ b/qom/cpu.c
> > @@ -382,6 +382,7 @@ static void cpu_common_unrealizefn(DeviceState
> *dev, Error **errp)
> >
> >  static void cpu_common_initfn(Object *obj)
> >  {
> > +    uint32_t count;
> >      CPUState *cpu =3D CPU(obj);
> >      CPUClass *cc =3D CPU_GET_CLASS(obj);
> >
> > @@ -396,7 +397,10 @@ static void cpu_common_initfn(Object *obj)
> >      QTAILQ_INIT(&cpu->breakpoints);
> >      QTAILQ_INIT(&cpu->watchpoints);
> >
> > -    cpu->trace_dstate =3D bitmap_new(trace_get_vcpu_event_count());
> > +    count =3D trace_get_vcpu_event_count();
> > +    if (count) {
> > +        cpu->trace_dstate =3D bitmap_new(count);
> > +    }
> >
> >      cpu_exec_initfn(cpu);
> >  }
> > --
> > 1.8.3.1
> >
> >
