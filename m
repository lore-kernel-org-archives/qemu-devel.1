Received: from eggs.gnu.org ([2001:4830:134:3::10]:55743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e9AC9-0000iP-Ij
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e9AC5-0004Te-KN
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:33:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e9AC5-0004TH-EQ
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:33:33 -0400
Date: Mon, 30 Oct 2017 10:05:56 +0100
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171030090556.GB2993@localhost.localdomain>
References: <20171030030553.21259-1-f4bug@amsat.org>
	<20171030030553.21259-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171030030553.21259-3-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] target/i386: tcg stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org

On Mon, Oct 30, 2017 at 12:05:50AM -0300, Philippe Mathieu-Daud=E9 wrote:
> missing since 55c3ceef61:
>=20
>     LINK    x86_64-softmmu/qemu-system-x86_64
>   target/i386/cpu.o: In function `x86_cpu_common_class_init':
>   target/i386/cpu.c:4215: undefined reference to `tcg_x86_init'
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  target/i386/tcg-stub.c    | 13 +++++++++++++
>  target/i386/Makefile.objs |  1 +
>  2 files changed, 14 insertions(+)
>  create mode 100644 target/i386/tcg-stub.c
>=20
> diff --git a/target/i386/tcg-stub.c b/target/i386/tcg-stub.c
> new file mode 100644
> index 0000000000..e13d993a80
> --- /dev/null
> +++ b/target/i386/tcg-stub.c
> @@ -0,0 +1,13 @@
> +/*
> + * QEMU TCG x86 specific function stubs
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +
> +void tcg_x86_init(void)
> +{
> +}

I'm not sure my suggestion was really a good one.  Requiring a
separate stub file for each architecture looks like too much
boilerplate code, which defeats the purpose of eliminating the
#ifdefs.  What if we just define inline stubs at target-*/cpu.h?


> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 6a26e9d9f0..2b3db1e5c2 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -3,6 +3,7 @@ obj-$(CONFIG_TCG) +=3D translate.o
>  obj-$(CONFIG_TCG) +=3D bpt_helper.o cc_helper.o excp_helper.o fpu_help=
er.o
>  obj-$(CONFIG_TCG) +=3D int_helper.o mem_helper.o misc_helper.o mpx_hel=
per.o
>  obj-$(CONFIG_TCG) +=3D seg_helper.o smm_helper.o svm_helper.o
> +obj-$(call lnot,$(CONFIG_TCG)) +=3D tcg-stub.o
>  obj-$(CONFIG_SOFTMMU) +=3D machine.o arch_memory_mapping.o arch_dump.o=
 monitor.o
>  obj-$(CONFIG_KVM) +=3D kvm.o hyperv.o
>  obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
> --=20
> 2.15.0.rc2
>=20

--=20
Eduardo
