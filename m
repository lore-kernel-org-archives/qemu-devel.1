Received: from eggs.gnu.org ([209.51.188.92]:56765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEV9I-0001Ns-Ng
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEV8Y-0001LI-5J
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:32:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hEV8X-0001KS-OR
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:32:46 -0400
References: <20190411071739.22889-1-richardw.yang@linux.intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fc11042f-023f-3396-e68a-22dfd4ab0be7@redhat.com>
Date: Thu, 11 Apr 2019 10:32:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190411071739.22889-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: check apci hotplug capability
 before nvdimm's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On 11/04/2019 09.17, Wei Yang wrote:
> pc_memory_pre_plug() is called during hotplug for both pc-dimm and
> nvdimm. This is more proper to check apci hotplug capability before
> check nvdimm specific capability.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  hw/i386/pc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f2c15bf1f2..d48b6f9582 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2091,17 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
> -        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '=
-M'");
> -        return;
> -    }
> -
>      hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
> +    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
> +        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '=
-M'");
> +        return;
> +    }
> +
>      pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
>                       pcmc->enforce_aligned_dimm ? NULL : &legacy_align=
, errp);
>  }

Works fine for me, too (i.e. no crash with older machine types).

Tested-by: Thomas Huth <thuth@redhat.com>
