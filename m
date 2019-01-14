Received: from eggs.gnu.org ([209.51.188.92]:33094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gj6u8-0002pR-A6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gj6u7-0008Q1-2J
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:24:08 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gj6u6-0008PN-U2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:24:07 -0500
Received: by mail-qk1-f193.google.com with SMTP id o125so11117615qkf.3
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 10:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20190107122304.22997-1-marcandre.lureau@redhat.com>
	<20190107122304.22997-2-marcandre.lureau@redhat.com>
	<CAFEAcA-H__JCb3xcJN3o3DJPbG4-3kv1_2pgWhjGPL3fi1FYkQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-H__JCb3xcJN3o3DJPbG4-3kv1_2pgWhjGPL3fi1FYkQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 14 Jan 2019 22:23:53 +0400
Message-ID: <CAMxuvazndwyrazDMpiHCyAgpEy-VFXChiRxnE78sR=iqSt6NcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 01/28] hw: apply accel compat properties
 without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peter

On Mon, Jan 14, 2019 at 7:50 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Mon, 7 Jan 2019 at 12:23, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Instead of registering compat properties as globals, let's keep them
> > in their own array, to avoid mixing with user globals.
> >
> > Introduce object_apply_global_props() function, to apply compatibility
> > properties from a GPtrArray.
>
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 6b3cc55b27..53b507164f 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -972,6 +972,15 @@ static void device_initfn(Object *obj)
> >
> >  static void device_post_init(Object *obj)
> >  {
> > +    if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
> > +        MachineState *m =3D MACHINE(qdev_get_machine());
> > +        AccelClass *ac =3D ACCEL_GET_CLASS(m->accelerator);
> > +
> > +        if (ac->compat_props) {
> > +            object_apply_global_props(obj, ac->compat_props, &error_ab=
ort);
> > +        }
> > +    }
> > +
> >      qdev_prop_set_globals(DEVICE(obj));
> >  }
>
>
> Hi; I've just noticed that this commit seems to break
> "-device whatever,help" :

[Qemu-devel] [PATCH] qdev: fix -device scsi-hd,help regression

This should now be queued, afaik.

>
> $ gdb --args ./build/x86/arm-softmmu/qemu-system-arm -device iotkit,help =
-M virt
> GNU gdb (Ubuntu 7.11.1-0ubuntu1~16.5) 7.11.1
> [...]
> (gdb) r
> Starting program:
> /home/petmay01/linaro/qemu-from-laptop/qemu/build/x86/arm-softmmu/qemu-sy=
stem-arm
> -device iotkit,help -M virt
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1"=
.
> [New Thread 0x7fffce6c1700 (LWP 23277)]
>
> Thread 1 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
> 0x0000555555d985d1 in object_get_class (obj=3D0x0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:857
> 857         return obj->class;
> (gdb) bt
> #0  0x0000555555d985d1 in object_get_class (obj=3D0x0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:857
> #1  0x0000555555b5675d in object_apply_compat_props (obj=3D0x555556b42600=
)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/core/qdev.c:978
> #2  0x0000555555b567f0 in device_post_init (obj=3D0x555556b42600)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/core/qdev.c:989
> #3  0x0000555555d97294 in object_post_init_with_type
> (obj=3D0x555556b42600, ti=3D0x5555569f7840)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:365
> #4  0x0000555555d972c2 in object_post_init_with_type
> (obj=3D0x555556b42600, ti=3D0x5555569f8640)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:369
> #5  0x0000555555d972c2 in object_post_init_with_type
> (obj=3D0x555556b42600, ti=3D0x555556a12c60)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:369
> #6  0x0000555555d97572 in object_initialize_with_type
> (data=3D0x555556b42600, size=3D1056, type=3D0x555556a12c60) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:425
> #7  0x0000555555d975b0 in object_initialize (data=3D0x555556b42600,
> size=3D1056, typename=3D0x555555ff3ee1 "armv7m_systick") at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:432
> #8  0x0000555555d976fd in object_initialize_childv
> (parentobj=3D0x555556b40fa0, propname=3D0x555555ff3f36 "systick-reg-ns",
> childobj=3D0x555556b42600, size=3D1056, type=3D0x555555ff3ee1
> "armv7m_systick", errp=3D0x5555569775f8 <error_abort>,
> vargs=3D0x7fffffffd7c0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:455
> #9  0x0000555555d97689 in object_initialize_child
> (parentobj=3D0x555556b40fa0, propname=3D0x555555ff3f36 "systick-reg-ns",
> childobj=3D0x555556b42600, size=3D1056, type=3D0x555555ff3ee1
> "armv7m_systick", errp=3D0x5555569775f8 <error_abort>) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:442
> #10 0x0000555555b5d049 in sysbus_init_child_obj
> (parent=3D0x555556b40fa0, childname=3D0x555555ff3f36 "systick-reg-ns",
> child=3D0x555556b42600, childsize=3D1056, childtype=3D0x555555ff3ee1
> "armv7m_systick")
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/core/sysbus.c:376
> #11 0x00005555559231b0 in armv7m_nvic_instance_init (obj=3D0x555556b40fa0=
)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/intc/armv7m_nvic.c:=
2393
> #12 0x0000555555d97263 in object_init_with_type (obj=3D0x555556b40fa0,
> ti=3D0x5555569cbce0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:358
> #13 0x0000555555d9755f in object_initialize_with_type
> (data=3D0x555556b40fa0, size=3D7840, type=3D0x5555569cbce0) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:424
> #14 0x0000555555d975b0 in object_initialize (data=3D0x555556b40fa0,
> size=3D7840, typename=3D0x555556019af8 "armv7m_nvic") at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:432
> #15 0x0000555555d976fd in object_initialize_childv
> (parentobj=3D0x555556b40c90, propname=3D0x555556019b04 "nvnic",
> childobj=3D0x555556b40fa0, size=3D7840, type=3D0x555556019af8 "armv7m_nvi=
c",
> errp=3D0x5555569775f8 <error_abort>, vargs=3D0x7fffffffda90)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:455
> #16 0x0000555555d97689 in object_initialize_child
> (parentobj=3D0x555556b40c90, propname=3D0x555556019b04 "nvnic",
> childobj=3D0x555556b40fa0, size=3D7840, type=3D0x555556019af8 "armv7m_nvi=
c",
> errp=3D0x5555569775f8 <error_abort>) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:442
> #17 0x0000555555b5d049 in sysbus_init_child_obj
> (parent=3D0x555556b40c90, childname=3D0x555556019b04 "nvnic",
> child=3D0x555556b40fa0, childsize=3D7840, childtype=3D0x555556019af8
> "armv7m_nvic")
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/core/sysbus.c:376
> #18 0x00005555559c63ba in armv7m_instance_init (obj=3D0x555556b40c90)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/armv7m.c:137
> #19 0x0000555555d97263 in object_init_with_type (obj=3D0x555556b40c90,
> ti=3D0x5555569db4c0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:358
> #20 0x0000555555d9755f in object_initialize_with_type
> (data=3D0x555556b40c90, size=3D11152, type=3D0x5555569db4c0) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:424
> #21 0x0000555555d975b0 in object_initialize (data=3D0x555556b40c90,
> size=3D11152, typename=3D0x555556022fd1 "armv7m") at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:432
> #22 0x0000555555d976fd in object_initialize_childv
> (parentobj=3D0x555556b40980, propname=3D0x555556022fd1 "armv7m",
> childobj=3D0x555556b40c90, size=3D11152, type=3D0x555556022fd1 "armv7m",
> errp=3D0x5555569775f8 <error_abort>, vargs=3D0x7fffffffdd50)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:455
> #23 0x0000555555d97689 in object_initialize_child
> (parentobj=3D0x555556b40980, propname=3D0x555556022fd1 "armv7m",
> childobj=3D0x555556b40c90, size=3D11152, type=3D0x555556022fd1 "armv7m",
> errp=3D0x5555569775f8 <error_abort>) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:442
> #24 0x0000555555b5d049 in sysbus_init_child_obj
> (parent=3D0x555556b40980, childname=3D0x555556022fd1 "armv7m",
> child=3D0x555556b40c90, childsize=3D11152, childtype=3D0x555556022fd1
> "armv7m")
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/core/sysbus.c:376
> #25 0x00005555559f3fdc in iotkit_init (obj=3D0x555556b40980)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/hw/arm/iotkit.c:115
> #26 0x0000555555d97263 in object_init_with_type (obj=3D0x555556b40980,
> ti=3D0x5555569df840)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:358
> #27 0x0000555555d9755f in object_initialize_with_type
> (data=3D0x555556b40980, size=3D50080, type=3D0x5555569df840) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:424
> #28 0x0000555555d97bb9 in object_new_with_type (type=3D0x5555569df840)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:588
> #29 0x0000555555d97bf6 in object_new (typename=3D0x555556a2b230 "iotkit")
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qom/object.c:598
> #30 0x0000555555aafe8c in qmp_device_list_properties
> (typename=3D0x555556a2b230 "iotkit", errp=3D0x7fffffffe050) at
> /home/petmay01/linaro/qemu-from-laptop/qemu/qmp.c:519
> #31 0x0000555555a8607a in qdev_device_help (opts=3D0x555556a2b1c0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/qdev-monitor.c:283
> #32 0x0000555555a8f77e in device_help_func (opaque=3D0x0,
> opts=3D0x555556a2b1c0, errp=3D0x0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/vl.c:2299
> #33 0x0000555555ef5b21 in qemu_opts_foreach (list=3D0x555556787040
> <qemu_device_opts>, func=3D0x555555a8f75e <device_help_func>,
> opaque=3D0x0, errp=3D0x0)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/util/qemu-option.c:117=
1
> #34 0x0000555555a94310 in main (argc=3D5, argv=3D0x7fffffffe408,
> envp=3D0x7fffffffe438)
>     at /home/petmay01/linaro/qemu-from-laptop/qemu/vl.c:4323
>
> Looking at the backtrace, this seems to happen because in
> device_post_init we look at m->accelerator, but m->accelerator
> is only set when vl.c calls configure_accelerator(), so if
> this function gets called before then, it will cause an assert.
> In particular, the handling of -device foo,help happens before the
> accelerator is configured. (Possibly other things may cause
> device init before then too?)
>
> thanks
> -- PMM
