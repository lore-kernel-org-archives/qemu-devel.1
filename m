Received: from eggs.gnu.org ([2001:4830:134:3::10]:59065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGUUi-00012D-C8
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGUUd-0000Yt-Ej
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGUUd-0000WT-9J
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:06:43 -0400
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
	<20170601130325.6433-2-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <465a7b69-a3c0-1492-8e30-c562a76cd65a@redhat.com>
Date: Thu, 1 Jun 2017 20:06:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170601130325.6433-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] dump: add DumpInfo structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: anderson@redhat.com, qiaonuohan@cn.fujitsu.com

On 06/01/17 15:03, Marc-Andr=C3=A9 Lureau wrote:
> One way or another, the guest could communicate various dump info (via
> guest agent or vmcoreinfo device) and populate that structure. It can
> then be used to augment the dump with various details, as done in the
> following patch.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/dump-info.h | 18 ++++++++++++++++++
>  dump.c                     |  3 +++
>  2 files changed, 21 insertions(+)
>  create mode 100644 include/sysemu/dump-info.h
>=20
> diff --git a/include/sysemu/dump-info.h b/include/sysemu/dump-info.h
> new file mode 100644
> index 0000000000..d2378e15e2
> --- /dev/null
> +++ b/include/sysemu/dump-info.h
> @@ -0,0 +1,18 @@
> +#ifndef DUMP_INFO_H
> +#define DUMP_INFO_H
> +
> +typedef struct DumpInfo {
> +    bool received;
> +    /* kernel base address */
> +    bool has_phys_base;
> +    uint64_t phys_base;
> +    /* "_text" symbol location */
> +    bool has_text;
> +    uint64_t text;
> +    /* the content of /sys/kernel/vmcoreinfo on Linux */
> +    char *vmcoreinfo;
> +} DumpInfo;
> +
> +extern DumpInfo dump_info;
> +
> +#endif /* DUMP_INFO_H */
> diff --git a/dump.c b/dump.c
> index d9090a24cc..bdf3270f02 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -20,6 +20,7 @@
>  #include "monitor/monitor.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/dump.h"
> +#include "sysemu/dump-info.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/memory_mapping.h"
>  #include "sysemu/cpus.h"
> @@ -38,6 +39,8 @@
>  #define ELF_MACHINE_UNAME "Unknown"
>  #endif
> =20
> +DumpInfo dump_info =3D { 0, };
> +
>  uint16_t cpu_to_dump16(DumpState *s, uint16_t val)
>  {
>      if (s->dump_info.d_endian =3D=3D ELFDATA2LSB) {
>=20

Can you please spell out, in the commit message, the reason for
introducing a new header file? (I suspect your reason, but it should be
documented explicitly.)

Thanks
Laszlo
