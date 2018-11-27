Received: from eggs.gnu.org ([2001:4830:134:3::10]:52767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRdr6-00073i-4T
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRdr2-00028H-0g
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:56:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gRdr1-00027s-RA
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:56:43 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so21758347qtr.12
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:56:43 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-1-i.maximets@samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
In-Reply-To: <20181127135030.1671-2-i.maximets@samsung.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 17:56:31 +0400
Message-ID: <CAMxuvaywwXomy=A+pwfA6QPs+argdhL=faibUsLaSVDpduUCgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] hostmem-memfd: disable for systems
 wihtout sealing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maximets, Ilya" <i.maximets@samsung.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>

Hi
On Tue, Nov 27, 2018 at 5:50 PM Ilya Maximets <i.maximets@samsung.com> wrot=
e:
>
> If seals are not supported, memfd_create() will fail.
> Furthermore, there is no way to disable it in this case because
> '.seal' property is not registered.
>
> This issue leads to vhost-user-test failures on RHEL 7.2:
>
>   qemu-system-x86_64: -object memory-backend-memfd,id=3Dmem,size=3D2M,: \
>                       failed to create memfd: Invalid argument
>
> and actually breaks the feature on such systems.
>
> Let's restrict memfd backend to systems with sealing support.
>
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

> ---
>  backends/hostmem-memfd.c | 18 ++++++++----------
>  tests/vhost-user-test.c  |  6 +++---
>  2 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index b6836b28e5..a3455da9c9 100644
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
> --
> 2.17.1
>
