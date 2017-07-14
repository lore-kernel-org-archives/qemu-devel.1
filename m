Received: from eggs.gnu.org ([2001:4830:134:3::10]:49179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW6uG-0006Le-Oz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dW6uB-0005Dz-Pj
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:09:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dW6uB-0005CC-JH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B23477B82
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 20:09:38 +0000 (UTC)
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714182012.4595-4-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4b5ce302-f34f-ad9a-c73e-5cefc1c8f1ae@redhat.com>
Date: Fri, 14 Jul 2017 22:09:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170714182012.4595-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/8] stubs: add vmcoreinfo_get() stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On 07/14/17 20:20, Marc-Andr=C3=A9 Lureau wrote:
> Common dump code may call vmcoreinfo_get() which is not available on
> all targets.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  stubs/vmcoreinfo.c  | 9 +++++++++
>  stubs/Makefile.objs | 1 +
>  2 files changed, 10 insertions(+)
>  create mode 100644 stubs/vmcoreinfo.c
>=20
> diff --git a/stubs/vmcoreinfo.c b/stubs/vmcoreinfo.c
> new file mode 100644
> index 0000000000..a994153832
> --- /dev/null
> +++ b/stubs/vmcoreinfo.c
> @@ -0,0 +1,9 @@
> +#include "qemu/osdep.h"
> +
> +#include "hw/acpi/vmcoreinfo.h"
> +
> +bool vmcoreinfo_get(VMCoreInfoState *vis, uint64_t *paddr, uint32_t *s=
ize,
> +                    Error **errp)
> +{
> +    return false;
> +}
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index f5b47bfd74..3bedc73252 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -36,6 +36,7 @@ stub-obj-y +=3D qmp_pc_dimm_device_list.o
>  stub-obj-y +=3D target-monitor-defs.o
>  stub-obj-y +=3D target-get-monitor-def.o
>  stub-obj-y +=3D pc_madt_cpu_entry.o
> +stub-obj-y +=3D vmcoreinfo.o
>  stub-obj-y +=3D vmgenid.o
>  stub-obj-y +=3D xen-common.o
>  stub-obj-y +=3D xen-hvm.o
>=20

Looks like a good idea -- but now that you are adding this patch, I
think we should actually report an error like "unsupported" via errp:

  error_setg(errp, QERR_UNSUPPORTED);

In patch #5 you report the error (as a warning) with warn_report_err(),
and I think that's going to crash there -- err is pre-inited to NULL,
the above impl. doesn't change it, and warn_report_err() doesn't expect
NULL.

Thanks
Laszlo
