Received: from eggs.gnu.org ([2001:4830:134:3::10]:42646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRdTC-0002Sk-LA
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRdTA-00055N-GE
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:32:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gRdTA-00054i-6z
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:32:04 -0500
Received: by mail-wr1-x443.google.com with SMTP id v13so19241250wrw.5
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:32:04 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181127111109eucas1p2b1eae35e38e46c3f76c86a350ed41926@eucas1p2.samsung.com>
	<20181127111050.18453-1-i.maximets@samsung.com>
	<20181127111050.18453-2-i.maximets@samsung.com>
	<CAMxuvay-6X2g1k8TbJR1NAW=Gb_tARb-wbr7H2RRoF9x+-F+aw@mail.gmail.com>
	<78f31962-8d54-19c1-e8fb-c21f95a491f0@samsung.com>
	<CAJ+F1C+XFs++Q044Y8CvVYFhtNpaEDS8qjx0BjsJN1yukZURkA@mail.gmail.com>
	<2edee79d-4d23-913a-3536-a8794ee16528@samsung.com>
	<CAJ+F1CK_WtcLCg+hi76J6x85zTvYkF1YN7b8hgP4-p-M_4-cag@mail.gmail.com>
	<00227750-5d8e-8375-dd93-b86990a786d8@samsung.com>
	<CAJ+F1CKA6Rc4XLn0YP+DLQorFToHsLrMjnfbjpNiBTW0j7om7Q@mail.gmail.com>
	<ac8a4443-f912-fadb-2c73-2167bc15c6c6@samsung.com>
In-Reply-To: <ac8a4443-f912-fadb-2c73-2167bc15c6c6@samsung.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Nov 2018 17:31:50 +0400
Message-ID: <CAJ+F1C+YFC7o1mrPp-mSZS7QdU5Sc+q75ovZG0cC1GFki=2rhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] hostmem-memfd: enable seals only if
 supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Nov 27, 2018 at 5:07 PM Ilya Maximets <i.maximets@samsung.com> wrot=
e:
>
> On 27.11.2018 15:56, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Nov 27, 2018 at 4:37 PM Ilya Maximets <i.maximets@samsung.com> =
wrote:
> >>
> >> On 27.11.2018 15:29, Marc-Andr=C3=A9 Lureau wrote:
> >>> Hi
> >>>
> >>> On Tue, Nov 27, 2018 at 4:02 PM Ilya Maximets <i.maximets@samsung.com=
> wrote:
> >>>>
> >>>> On 27.11.2018 15:00, Marc-Andr=C3=A9 Lureau wrote:
> >>>>> Hi
> >>>>> On Tue, Nov 27, 2018 at 3:56 PM Ilya Maximets <i.maximets@samsung.c=
om> wrote:
> >>>>>>
> >>>>>> On 27.11.2018 14:49, Marc-Andr=C3=A9 Lureau wrote:
> >>>>>>> Hi
> >>>>>>> On Tue, Nov 27, 2018 at 3:11 PM Ilya Maximets <i.maximets@samsung=
.com> wrote:
> >>>>>>>>
> >>>>>>>> If seals are not supported, memfd_create() will fail.
> >>>>>>>> Furthermore, there is no way to disable it in this case because
> >>>>>>>> '.seal' property is not registered.
> >>>>>>>>
> >>>>>>>> This issue leads to vhost-user-test failures on RHEL 7.2:
> >>>>>>>>
> >>>>>>>>   qemu-system-x86_64: -object memory-backend-memfd,id=3Dmem,size=
=3D2M,: \
> >>>>>>>>                       failed to create memfd: Invalid argument
> >>>>>>>>
> >>>>>>>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> >>>>>>>
> >>>>>>>
> >>>>>>> This will change the default behaviour of memfd backend, and may =
thus
> >>>>>>> me considered a break.
> >>>>>>
> >>>>>> This will change the default behaviour only on systems without sea=
ling
> >>>>>> support. But current implementation is broken there anyway and doe=
s not
> >>>>>> work.
> >>>>>>
> >>>>>>>
> >>>>>>> Instead, memfd vhost-user-test should skipped (or tuned with
> >>>>>>> sealed=3Dfalse if unsupported)
> >>>>>>
> >>>>>> vhost-user-test is just an example here. In fact memfd could not b=
e
> >>>>>> used at all on system without sealing support. And there is no way
> >>>>>> to disable seals.
> >>>>>
> >>>>> which system supports memfd without sealing?
> >>>>
> >>>> RHEL 7.2. kernel version 3.10.0-327.el7.x86_64
> >>>
> >>> Correct, it was backported without sealing for some reason.
> >>>
> >>> I would rather have an explicit seal=3Doff argument on such system
> >>> (because sealing is expected to be available with memfd in general)
> >>>
> >>
> >> But '.seal' property registering is guarded by 'qemu_memfd_check(MFD_A=
LLOW_SEALING)'.
> >> And you can not disable it:
> >>
> >> qemu-system-x86_64: -object memory-backend-memfd,seal=3Doff,id=3Dmem,s=
ize=3D2M,: Property '.seal' not found
> >
> > Right
> >
> >>
> >> Enabling this option on system that does not support sealing will
> >> probably break some libvirt feature discovering or something similar.
> >>
> >> What about adding some warning to 'memfd_backend_instance_init' if
> >> sealing not supported before disabling it ?
> >
> > What do you think of Gerd suggestion, and disable memfd backend if
> > sealing is not available? (the sealing property check can be removed
> > then).
>
> It's OK in general for me.
> What about something like this:
>
> ---
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index ee39bdbde6..a3455da9c9 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -156,15 +156,13 @@ memfd_backend_class_init(ObjectClass *oc, void *dat=
a)
>                                                "Huge pages size (ex: 2M, =
1G)",
>                                                &error_abort);
>      }
> -    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
> -        object_class_property_add_bool(oc, "seal",
> -                                       memfd_backend_get_seal,
> -                                       memfd_backend_set_seal,
> -                                       &error_abort);
> -        object_class_property_set_description(oc, "seal",
> -                                              "Seal growing & shrinking"=
,
> -                                              &error_abort);
> -    }
> +    object_class_property_add_bool(oc, "seal",
> +                                   memfd_backend_get_seal,
> +                                   memfd_backend_set_seal,
> +                                   &error_abort);
> +    object_class_property_set_description(oc, "seal",
> +                                          "Seal growing & shrinking",
> +                                          &error_abort);
>  }
>
>  static const TypeInfo memfd_backend_info =3D {
> @@ -177,7 +175,7 @@ static const TypeInfo memfd_backend_info =3D {
>
>  static void register_types(void)
>  {
> -    if (qemu_memfd_check(0)) {
> +    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
>          type_register_static(&memfd_backend_info);
>      }
>  }
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 45d58d8ea2..e3e9a33580 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -169,7 +169,7 @@ static char *get_qemu_cmd(TestServer *s,
>                            int mem, enum test_memfd memfd, const char *me=
m_path,
>                            const char *chr_opts, const char *extra)
>  {
> -    if (memfd =3D=3D TEST_MEMFD_AUTO && qemu_memfd_check(0)) {
> +    if (memfd =3D=3D TEST_MEMFD_AUTO && qemu_memfd_check(MFD_ALLOW_SEALI=
NG)) {
>          memfd =3D TEST_MEMFD_YES;
>      }
>
> @@ -903,7 +903,7 @@ static void test_multiqueue(void)
>      s->queues =3D 2;
>      test_server_listen(s);
>
> -    if (qemu_memfd_check(0)) {
> +    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
>          cmd =3D g_strdup_printf(
>              QEMU_CMD_MEMFD QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=3D%d "
>              "-device virtio-net-pci,netdev=3Dnet0,mq=3Don,vectors=3D%d",
> @@ -963,7 +963,7 @@ int main(int argc, char **argv)
>      /* run the main loop thread so the chardev may operate */
>      thread =3D g_thread_new(NULL, thread_function, loop);
>
> -    if (qemu_memfd_check(0)) {
> +    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
>          qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
>                              GINT_TO_POINTER(TEST_MEMFD_YES),
>                              test_read_guest_mem);
>

looks fine, waiting for your v2 series

> ---
>
> ?
>
> >
> >>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> ---
> >>>>>>>>  backends/hostmem-memfd.c | 4 ++--
> >>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> >>>>>>>> index b6836b28e5..ee39bdbde6 100644
> >>>>>>>> --- a/backends/hostmem-memfd.c
> >>>>>>>> +++ b/backends/hostmem-memfd.c
> >>>>>>>> @@ -129,8 +129,8 @@ memfd_backend_instance_init(Object *obj)
> >>>>>>>>  {
> >>>>>>>>      HostMemoryBackendMemfd *m =3D MEMORY_BACKEND_MEMFD(obj);
> >>>>>>>>
> >>>>>>>> -    /* default to sealed file */
> >>>>>>>> -    m->seal =3D true;
> >>>>>>>> +    /* default to sealed file if supported */
> >>>>>>>> +    m->seal =3D qemu_memfd_check(MFD_ALLOW_SEALING);
> >>>>>>>>  }
> >>>>>>>>
> >>>>>>>>  static void
> >>>>>>>> --
> >>>>>>>> 2.17.1
> >>>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>>
> >>>
> >>>
> >>>
> >
> >
> >



--=20
Marc-Andr=C3=A9 Lureau
