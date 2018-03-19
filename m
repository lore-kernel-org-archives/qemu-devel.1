Received: from eggs.gnu.org ([2001:4830:134:3::10]:35909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1exx0w-00036x-Gd
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1exx0t-0003aV-Du
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:47:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1exx0t-0003a7-9R
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 11:47:55 -0400
Date: Mon, 19 Mar 2018 16:47:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180319164740.2c3592f8@igors-macbook-pro.local>
In-Reply-To: <1521229281-73637-24-git-send-email-mjc@sifive.com>
References: <1521229281-73637-1-git-send-email-mjc@sifive.com>
	<1521229281-73637-24-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 23/24] RISC-V: Convert cpu definition
 towards future model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, patches@groups.riscv.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

On Fri, 16 Mar 2018 12:41:20 -0700
Michael Clark <mjc@sifive.com> wrote:

> - Model borrowed from target/sh4/cpu.c
> - Rewrote riscv_cpu_list to use object_class_get_list
> - Dropped 'struct RISCVCPUInfo' and used TypeInfo array
> - Replaced riscv_cpu_register_types with DEFINE_TYPES
> - Marked base class as abstract
>=20
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
[...]

> -static void riscv_cpu_register_types(void)
> +static void riscv_cpu_list_entry(gpointer data, gpointer user_data)
>  {
> -    const RISCVCPUInfo *info =3D riscv_cpus;
> +    RISCVCPUListState *s =3D user_data;
> +    const char *typename =3D object_class_get_name(OBJECT_CLASS(data));
> +    int len =3D strlen(typename) - strlen(RISCV_CPU_TYPE_SUFFIX);
This also fixes "-cpu" output,
before this patch:

# qemu-system-riscv32 -cpu help=20
any-riscv-cpu
rv32gcsu-v1.9.1-riscv-cpu
rv32gcsu-v1.10.0-riscv-cpu
rv32imacu-nommu-riscv-cpu
sifive-e31-riscv-cpu
sifive-u34-riscv-cpu

# qemu-system-riscv32 -cpu rv32gcsu-v1.9.1-riscv-cpu=20
qemu-system-riscv32: unable to find CPU model 'rv32gcsu-v1.9.1-riscv-cpu'

after this patch:

# qemu-system-riscv32 -cpu help
any
rv32gcsu-v1.10.0
rv32gcsu-v1.9.1
rv32imacu-nommu
sifive-e31
sifive-u34

which cpu model matches conversion rules of riscv_cpu_class_by_name()
and matching cpu type is found as expected.

> -    type_register_static(&riscv_cpu_type_info);
> +    (*s->cpu_fprintf)(s->file, "%.*s\n", len, typename);
> +}
[...]
