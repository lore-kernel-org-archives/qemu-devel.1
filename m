Received: from eggs.gnu.org ([2001:4830:134:3::10]:49056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gL2q2-0002rt-Ko
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gL2q1-0004wv-90
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 04:12:26 -0500
Date: Fri, 9 Nov 2018 10:12:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181109101210.0ee25ec8@redhat.com>
In-Reply-To: <20181105014047.26447-14-sameo@linux.intel.com>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-14-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 13/24] hw: acpi: Do not create hotplug
 method when handler is not defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Mon,  5 Nov 2018 02:40:36 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> CPU and memory ACPI hotplug are not necessarily handled through SCI
> events. For example, with Hardware-reduced ACPI, the GED device will
> manage ACPI hotplug entirely.
> As a consequence, we make the CPU and memory specific events AML
> generation optional. The code will only be added when the method name is
> not NULL.
patch doesn't belong to this series, it should be go along with
GED device patch.

Suggest to drop it for now.

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  hw/acpi/cpu.c            |  8 +++++---
>  hw/acpi/memory_hotplug.c | 11 +++++++----
>  2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index f10b190019..cd41377b5a 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -569,9 +569,11 @@ void build_cpus_aml(Aml *table, MachineState *machin=
e, CPUHotplugFeatures opts,
>      aml_append(sb_scope, cpus_dev);
>      aml_append(table, sb_scope);
> =20
> -    method =3D aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> -    aml_append(table, method);
> +    if (event_handler_method) {
> +        method =3D aml_method(event_handler_method, 0, AML_NOTSERIALIZED=
);
> +        aml_append(method, aml_call0("\\_SB.CPUS." CPU_SCAN_METHOD));
> +        aml_append(table, method);
> +    }
> =20
>      g_free(cphp_res_path);
>  }
> diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
> index 8c7c1013f3..db2c4df961 100644
> --- a/hw/acpi/memory_hotplug.c
> +++ b/hw/acpi/memory_hotplug.c
> @@ -715,10 +715,13 @@ void build_memory_hotplug_aml(Aml *table, uint32_t =
nr_mem,
>      }
>      aml_append(table, dev_container);
> =20
> -    method =3D aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
> -    aml_append(method,
> -        aml_call0(MEMORY_DEVICES_CONTAINER "." MEMORY_SLOT_SCAN_METHOD));
> -    aml_append(table, method);
> +    if (event_handler_method) {
> +        method =3D aml_method(event_handler_method, 0, AML_NOTSERIALIZED=
);
> +        aml_append(method,
> +                   aml_call0(MEMORY_DEVICES_CONTAINER "."
> +                             MEMORY_SLOT_SCAN_METHOD));
> +        aml_append(table, method);
> +    }
> =20
>      g_free(mhp_res_path);
>  }
