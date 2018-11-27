Received: from eggs.gnu.org ([2001:4830:134:3::10]:36302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRbsM-0004Bq-75
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRbsI-00079D-8Z
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:49:58 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gRbsI-00078z-4A
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:49:54 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so21291787qtq.9
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 03:49:54 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181127111109eucas1p2b1eae35e38e46c3f76c86a350ed41926@eucas1p2.samsung.com>
	<20181127111050.18453-1-i.maximets@samsung.com>
	<20181127111050.18453-2-i.maximets@samsung.com>
In-Reply-To: <20181127111050.18453-2-i.maximets@samsung.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 15:49:42 +0400
Message-ID: <CAMxuvay-6X2g1k8TbJR1NAW=Gb_tARb-wbr7H2RRoF9x+-F+aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Maximets, Ilya" <i.maximets@samsung.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi
On Tue, Nov 27, 2018 at 3:11 PM Ilya Maximets <i.maximets@samsung.com> wrote:
>
> If seals are not supported, memfd_create() will fail.
> Furthermore, there is no way to disable it in this case because
> '.seal' property is not registered.
>
> This issue leads to vhost-user-test failures on RHEL 7.2:
>
>   qemu-system-x86_64: -object memory-backend-memfd,id=mem,size=2M,: \
>                       failed to create memfd: Invalid argument
>
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>


This will change the default behaviour of memfd backend, and may thus
me considered a break.

Instead, memfd vhost-user-test should skipped (or tuned with
sealed=false if unsupported)

> ---
>  backends/hostmem-memfd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> index b6836b28e5..ee39bdbde6 100644
> --- a/backends/hostmem-memfd.c
> +++ b/backends/hostmem-memfd.c
> @@ -129,8 +129,8 @@ memfd_backend_instance_init(Object *obj)
>  {
>      HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(obj);
>
> -    /* default to sealed file */
> -    m->seal = true;
> +    /* default to sealed file if supported */
> +    m->seal = qemu_memfd_check(MFD_ALLOW_SEALING);
>  }
>
>  static void
> --
> 2.17.1
>
