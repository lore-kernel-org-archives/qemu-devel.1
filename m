Received: from eggs.gnu.org ([2001:4830:134:3::10]:47870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkuHQ-0008FQ-O3
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkuHN-0001XZ-Hc
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:47:20 -0400
References: <20180801131905.148778-1-frankja@linux.ibm.com>
	<20180801131905.148778-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2da970ab-276f-f792-54d8-c696e899cac5@redhat.com>
Date: Wed, 1 Aug 2018 18:47:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180801131905.148778-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 2/2] s390x: Enable KVM huge
 page backing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com

On 08/01/2018 03:19 PM, Janosch Frank wrote:
> QEMU has had huge page support for a longer time already, but KVM
> memory management under s390x needed some changes to work with huge
> backings.
>=20
> Now that we have support, let's enable it if requested and
> available. Otherwise we now properly tell the user if there is no
> support and back out instead of failing to run the VM later on.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/kvm.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index d923cf4240..d1c72975cf 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -34,6 +34,8 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> +#include "qemu/units.h"
> +#include "qemu/mmap-alloc.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "hw/hw.h"
> @@ -139,6 +141,7 @@ static int cap_mem_op;
>  static int cap_s390_irq;
>  static int cap_ri;
>  static int cap_gs;
> +static int cap_hpage_1m;
> =20
>  static int active_cmma;
> =20
> @@ -220,9 +223,9 @@ static void kvm_s390_enable_cmma(void)
>          .attr =3D KVM_S390_VM_MEM_ENABLE_CMMA,
>      };
> =20
> -    if (mem_path) {
> +    if (cap_hpage_1m) {
>          warn_report("CMM will not be enabled because it is not "
> -                    "compatible with hugetlbfs.");
> +                    "compatible with huge memory backings.");
>          return;
>      }
>      rc =3D kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> @@ -281,10 +284,37 @@ void kvm_s390_crypto_reset(void)
>      }
>  }
> =20
> +static int kvm_s390_configure_mempath_backing(KVMState *s)
> +{
> +    size_t path_psize =3D qemu_mempath_getpagesize(mem_path);
> +
> +    if (path_psize =3D=3D 4 * KiB)
> +        return 0;

Missing curly braces.

> +    if (path_psize !=3D 1 * MiB) {
> +        error_report("Memory backing with 2G pages was specified, "
> +                     "but KVM does not support this memory backing");

May I suggest to use a text that rather matches the condition of the
if-statement (just in case there will be other sizes in the future...),
e.g. "Memory backing is only supported for 1 MiB huge pages" or
something similar.

 Thomas
