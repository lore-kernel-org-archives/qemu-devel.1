Received: from eggs.gnu.org ([2001:4830:134:3::10]:55514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwouj-0004hC-6R
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwouf-0008Jc-5r
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:24:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwoue-0008J0-SJ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 08:24:33 -0400
Date: Tue, 26 Sep 2017 09:24:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170926122427.GC4115@localhost.localdomain>
References: <20170919201850.14772-1-ehabkost@redhat.com>
	<20170919201850.14772-2-ehabkost@redhat.com>
	<6990d924-47e0-0445-c769-c1128035640d@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6990d924-47e0-0445-c769-c1128035640d@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 01/12] vl: Clean up user-creatable objects
 when exiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Sep 26, 2017 at 12:14:23PM +0200, Christian Borntraeger wrote:
> This patch triggers the following crash on shutdown:
>=20
>=20
>                 Stack trace of thread 61598:
>                 #0  0x000003ff8990915e pthread_join (libpthread.so.0)
>                 #1  0x00000000014ddfda qemu_thread_join (qemu-system-s390=
x)
>                 #2  0x00000000011bbd68 iothread_stop (qemu-system-s390x)
>                 #3  0x00000000011bbe36 iothread_instance_finalize (qemu-s=
ystem-s390x)
>                 #4  0x000000000135b4a4 object_deinit (qemu-system-s390x)
>                 #5  0x000000000135b548 object_finalize (qemu-system-s390x)
>                 #6  0x000000000135cc02 object_unref (qemu-system-s390x)
>                 #7  0x000000000135e61a object_finalize_child_property (qe=
mu-system-s390x)
>                 #8  0x000000000135b16a object_property_del_all (qemu-syst=
em-s390x)
>                 #9  0x000000000135b536 object_finalize (qemu-system-s390x)
>                 #10 0x000000000135cc02 object_unref (qemu-system-s390x)
>                 #11 0x000000000135e61a object_finalize_child_property (qe=
mu-system-s390x)
>                 #12 0x000000000135b2ea object_property_del_child (qemu-sy=
stem-s390x)
>                 #13 0x000000000135b44a object_unparent (qemu-system-s390x)
>                 #14 0x0000000001362754 user_creatable_cleanup (qemu-syste=
m-s390x)
>                 #15 0x00000000011d012a main (qemu-system-s390x)
>                 #16 0x000003ff8972289a __libc_start_main (libc.so.6)
>                 #17 0x0000000001017646 _start (qemu-system-s390x)

It seems to be reproducible with:

$ echo quit | ./x86_64-softmmu/qemu-system-x86_64 -object iothread,id=3Diot=
hread0 -monitor stdio -display none
QEMU 2.10.50 monitor - type 'help' for more information
(qemu) quit
qemu: qemu_thread_join: No such process
Aborted (core dumped)

iothread_stop() is being called twice for the same thread:

Thread 1 "qemu-system-x86" hit Breakpoint 3, qemu_thread_join (thread=3Dthr=
ead@entry=3D0x10118e198) at /home/ehabkost/rh/proj/virt/qemu/util/qemu-thre=
ad-posix.c:543
543     {
(gdb) bt
#0  0x00000001005dc980 in qemu_thread_join (thread=3Dthread@entry=3D0x10118=
e198) at /home/ehabkost/rh/proj/virt/qemu/util/qemu-thread-posix.c:543
#1  0x000000010034a12c in iothread_stop (object=3D<optimized out>, opaque=
=3D<optimized out>) at /home/ehabkost/rh/proj/virt/qemu/iothread.c:96
#2  0x0000000100509117 in do_object_child_foreach (obj=3Dobj@entry=3D0x1011=
8e390, fn=3Dfn@entry=3D0x10034a0f0 <iothread_stop>, opaque=3Dopaque@entry=
=3D0x0, recurse=3Drecurse@entry=3Dfalse) at /home/ehabkost/rh/proj/virt/qem=
u/qom/object.c:843
#3  0x000000010050a7a7 in object_child_foreach (obj=3Dobj@entry=3D0x10118e3=
90, fn=3Dfn@entry=3D0x10034a0f0 <iothread_stop>, opaque=3Dopaque@entry=3D0x=
0) at /home/ehabkost/rh/proj/virt/qemu/qom/object.c:858
#4  0x000000010034a3be in iothread_stop_all () at /home/ehabkost/rh/proj/vi=
rt/qemu/iothread.c:331
#5  0x000000010021da4d in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at /home/ehabkost/rh/proj/virt/qemu/vl.c:4886
(gdb) c
Continuing.

Thread 1 "qemu-system-x86" hit Breakpoint 3, qemu_thread_join (thread=3Dthr=
ead@entry=3D0x10118e198) at /home/ehabkost/rh/proj/virt/qemu/util/qemu-thre=
ad-posix.c:543
543     {
(gdb) bt
#0  0x00000001005dc980 in qemu_thread_join (thread=3Dthread@entry=3D0x10118=
e198) at /home/ehabkost/rh/proj/virt/qemu/util/qemu-thread-posix.c:543
#1  0x000000010034a12c in iothread_stop (object=3Dobject@entry=3D0x10118e17=
0, opaque=3Dopaque@entry=3D0x0) at /home/ehabkost/rh/proj/virt/qemu/iothrea=
d.c:96
#2  0x000000010034a175 in iothread_instance_finalize (obj=3D0x10118e170) at=
 /home/ehabkost/rh/proj/virt/qemu/iothread.c:111
#3  0x000000010050a90a in object_deinit (type=3D0x1010dd860, obj=3D<optimiz=
ed out>) at /home/ehabkost/rh/proj/virt/qemu/qom/object.c:453
#4  0x000000010050a90a in object_finalize (data=3D0x10118e170) at /home/eha=
bkost/rh/proj/virt/qemu/qom/object.c:467
#5  0x000000010050a90a in object_unref (obj=3D0x10118e170) at /home/ehabkos=
t/rh/proj/virt/qemu/qom/object.c:902
#6  0x000000010050a99d in object_property_del_all (obj=3D0x10118e390) at /h=
ome/ehabkost/rh/proj/virt/qemu/qom/object.c:404
#7  0x000000010050a99d in object_finalize (data=3D0x10118e390) at /home/eha=
bkost/rh/proj/virt/qemu/qom/object.c:466
#8  0x000000010050a99d in object_unref (obj=3D0x10118e390) at /home/ehabkos=
t/rh/proj/virt/qemu/qom/object.c:902
#9  0x0000000100509915 in object_property_del_child (obj=3D0x101180900, chi=
ld=3D0x10118e390, errp=3D<optimized out>) at /home/ehabkost/rh/proj/virt/qe=
mu/qom/object.c:427
#10 0x000000010021da87 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at /home/ehabkost/rh/proj/virt/qemu/vl.c:4897

>=20
>=20
> command line parameters are long (one of my test systems)
>=20
> -name guest=3Dzhyp137,debug-threads=3Don -S -object secret,id=3DmasterKey=
0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-7-zhyp137/master-key.aes=
 -machine s390-ccw-virtio-2.11,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff,=
loadparm=3DPROMPT -m 2048 -realtime mlock=3Doff -smp 4,sockets=3D4,cores=3D=
1,threads=3D1 -object iothread,id=3Diothread1 -object iothread,id=3Diothrea=
d2 -object iothread,id=3Diothread3 -object iothread,id=3Diothread4 -object =
iothread,id=3Diothread5 -object iothread,id=3Diothread6 -object iothread,id=
=3Diothread7 -object iothread,id=3Diothread8 -object iothread,id=3Diothread=
9 -object iothread,id=3Diothread10 -object iothread,id=3Diothread11 -object=
 iothread,id=3Diothread12 -object iothread,id=3Diothread13 -object iothread=
,id=3Diothread14 -object iothread,id=3Diothread15 -object iothread,id=3Diot=
hread16 -object iothread,id=3Diothread17 -object iothread,id=3Diothread18 -=
object iothread,id=3Diothread19 -object iothread,id=3Diothread20 -uuid 4c3a=
e636-529d-4d90-b203-c8d3d150f0d0 -display none -no-user-config -nodefaults =
-chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvirt/qemu/domain-7-zhyp=
137/monitor.sock,server,nowait -mon chardev=3Dcharmonitor,id=3Dmonitor,mode=
=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don -drive file=3D/va=
r/lib/libvirt/qemu/image.zhyp137,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio=
-disk0,serial=3Dskel,cache=3Dnone -device virtio-blk-ccw,iothread=3Diothrea=
d1,scsi=3Doff,devno=3Dfe.0.0000,drive=3Ddrive-virtio-disk0,id=3Dvirtio-disk=
0,bootindex=3D1 -drive file=3D/var/lib/libvirt/qemu/image.zhyp137.old,forma=
t=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk1,serial=3Dold,cache=3Dnone -devi=
ce virtio-blk-ccw,iothread=3Diothread1,scsi=3Doff,devno=3Dfe.0.0001,drive=
=3Ddrive-virtio-disk1,id=3Dvirtio-disk1 -netdev tap,fd=3D24,id=3Dhostnet0,v=
host=3Don,vhostfd=3D26 -device virtio-net-ccw,netdev=3Dhostnet0,id=3Dnet0,m=
ac=3D52:54:00:d1:cd:1c,devno=3Dfe.0.000d -chardev pty,id=3Dcharconsole0 -de=
vice sclpconsole,chardev=3Dcharconsole0,id=3Dconsole0 -device virtio-balloo=
n-ccw,id=3Dballoon0,devno=3Dfe.3.ffba -drive driver=3Dnull-aio,id=3Dnull1,i=
f=3Dnone,size=3D1500G -device virtio-blk-ccw,scsi=3Doff,drive=3Dnull1,seria=
l=3Dnull1,iothread=3Diothread16 -drive driver=3Dnull-aio,id=3Dnull2,if=3Dno=
ne,size=3D1500G -device virtio-blk-ccw,scsi=3Doff,drive=3Dnull2,serial=3Dnu=
ll2,iothread=3Diothread17 -drive driver=3Dnull-aio,id=3Dnull3,if=3Dnone,siz=
e=3D1500G -device virtio-blk-ccw,scsi=3Doff,drive=3Dnull3,serial=3Dnull3,io=
thread=3Diothread18 -drive driver=3Dnull-aio,id=3Dnull4,if=3Dnone,size=3D15=
00G -device virtio-blk-ccw,scsi=3Doff,drive=3Dnull4,serial=3Dnull4,iothread=
=3Diothread19 -drive driver=3Dnull-aio,id=3Dnull5,if=3Dnone,size=3D1500G -d=
evice virtio-blk-ccw,scsi=3Doff,drive=3Dnull5,serial=3Dnull5,iothread=3Diot=
hread20,num-queues=3D10 -gdb tcp::1409 -msg timestamp=3Don
>=20
> On 09/19/2017 10:18 PM, Eduardo Habkost wrote:
> > Delete all user-creatable objects in /objects when exiting QEMU, so they
> > can perform cleanup actions.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > Message-Id: <20170824192315.5897-2-ehabkost@redhat.com>
> > Acked-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Tested-by: Zack Cornelius <zack.cornelius@kove.net>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/qom/object_interfaces.h | 8 ++++++++
> >  qom/object_interfaces.c         | 5 +++++
> >  vl.c                            | 1 +
> >  3 files changed, 14 insertions(+)
> >=20
> > diff --git a/include/qom/object_interfaces.h b/include/qom/object_inter=
faces.h
> > index d63c1c28f8..d23e11bc53 100644
> > --- a/include/qom/object_interfaces.h
> > +++ b/include/qom/object_interfaces.h
> > @@ -147,4 +147,12 @@ int user_creatable_add_opts_foreach(void *opaque,
> >   */
> >  void user_creatable_del(const char *id, Error **errp);
> > =20
> > +/**
> > + * user_creatable_cleanup:
> > + *
> > + * Delete all user-creatable objects and the user-creatable
> > + * objects container.
> > + */
> > +void user_creatable_cleanup(void);
> > +
> >  #endif
> > diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> > index 3bb8959f09..6824a88caa 100644
> > --- a/qom/object_interfaces.c
> > +++ b/qom/object_interfaces.c
> > @@ -193,6 +193,11 @@ void user_creatable_del(const char *id, Error **er=
rp)
> >      object_unparent(obj);
> >  }
> > =20
> > +void user_creatable_cleanup(void)
> > +{
> > +    object_unparent(object_get_objects_root());
> > +}
> > +
> >  static void register_types(void)
> >  {
> >      static const TypeInfo uc_interface_info =3D {
> > diff --git a/vl.c b/vl.c
> > index 9e62e92aea..ad49314608 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -4887,6 +4887,7 @@ int main(int argc, char **argv, char **envp)
> >      audio_cleanup();
> >      monitor_cleanup();
> >      qemu_chr_cleanup();
> > +    user_creatable_cleanup();
> >      /* TODO: unref root container, check all devices are ok */
> > =20
> >      return 0;
> >=20

--=20
Eduardo
