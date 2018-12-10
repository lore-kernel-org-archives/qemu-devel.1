Received: from eggs.gnu.org ([2001:4830:134:3::10]:56044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWOGu-0003Ek-4M
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWOGr-0003ny-0N
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:19:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWOGq-0003nX-O6
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:19:00 -0500
Date: Mon, 10 Dec 2018 17:18:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181210171845.4f132e25@Igors-MacBook-Pro.local>
In-Reply-To: <20181127135030.1671-2-i.maximets@samsung.com>
References: <20181127135030.1671-1-i.maximets@samsung.com>
	<CGME20181127135045eucas1p1e259cacbab5e715f7845b9beee22f882@eucas1p1.samsung.com>
	<20181127135030.1671-2-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Ilya Maximets <i.maximets@samsung.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 27 Nov 2018 16:50:27 +0300
Ilya Maximets <i.maximets@samsung.com> wrote:

s/wihtout/without/ in subj

> If seals are not supported, memfd_create() will fail.
> Furthermore, there is no way to disable it in this case because
> '.seal' property is not registered.
> 
> This issue leads to vhost-user-test failures on RHEL 7.2:
> 
>   qemu-system-x86_64: -object memory-backend-memfd,id=mem,size=2M,: \
>                       failed to create memfd: Invalid argument
> 
> and actually breaks the feature on such systems.
> 
> Let's restrict memfd backend to systems with sealing support.
> 
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> ---
>  backends/hostmem-memfd.c | 18 ++++++++----------
>  tests/vhost-user-test.c  |  6 +++---
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index b6836b28e5..a3455da9c9 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -156,15 +156,13 @@ memfd_backend_class_init(ObjectClass *oc, void *data)
>                                                "Huge pages size (ex: 2M, 1G)",
>                                                &error_abort);
>      }
> -    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
> -        object_class_property_add_bool(oc, "seal",
> -                                       memfd_backend_get_seal,
> -                                       memfd_backend_set_seal,
> -                                       &error_abort);
> -        object_class_property_set_description(oc, "seal",
> -                                              "Seal growing & shrinking",
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
>  static const TypeInfo memfd_backend_info = {
> @@ -177,7 +175,7 @@ static const TypeInfo memfd_backend_info = {
>  
>  static void register_types(void)
>  {
> -    if (qemu_memfd_check(0)) {
> +    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
>          type_register_static(&memfd_backend_info);
that would either lead to not clear error that type doesn't exist.
it could be better to report sensible error from memfd_backend_memory_alloc() if
the feature is required but not supported by host 

>      }
>  }
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index 45d58d8ea2..e3e9a33580 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -169,7 +169,7 @@ static char *get_qemu_cmd(TestServer *s,
>                            int mem, enum test_memfd memfd, const char *mem_path,
>                            const char *chr_opts, const char *extra)
>  {
> -    if (memfd == TEST_MEMFD_AUTO && qemu_memfd_check(0)) {
> +    if (memfd == TEST_MEMFD_AUTO && qemu_memfd_check(MFD_ALLOW_SEALING)) {
>          memfd = TEST_MEMFD_YES;
>      }
>  
> @@ -903,7 +903,7 @@ static void test_multiqueue(void)
>      s->queues = 2;
>      test_server_listen(s);
>  
> -    if (qemu_memfd_check(0)) {
> +    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
>          cmd = g_strdup_printf(
>              QEMU_CMD_MEMFD QEMU_CMD_CHR QEMU_CMD_NETDEV ",queues=%d "
>              "-device virtio-net-pci,netdev=net0,mq=on,vectors=%d",
> @@ -963,7 +963,7 @@ int main(int argc, char **argv)
>      /* run the main loop thread so the chardev may operate */
>      thread = g_thread_new(NULL, thread_function, loop);
>  
> -    if (qemu_memfd_check(0)) {
> +    if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
>          qtest_add_data_func("/vhost-user/read-guest-mem/memfd",
>                              GINT_TO_POINTER(TEST_MEMFD_YES),
>                              test_read_guest_mem);
