Received: from eggs.gnu.org ([2001:4830:134:3::10]:59377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dgWCu-0007IL-M7
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 09:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dgWCr-0000ze-Bo
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 09:12:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dgWCr-0000yl-2g
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 09:11:57 -0400
Date: Sat, 12 Aug 2017 10:02:59 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170812130259.GK3108@localhost.localdomain>
References: <1502527090-11473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502527090-11473-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr_cpu_core: Add a proper check
 for spapr machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

On Sat, Aug 12, 2017 at 10:38:10AM +0200, Thomas Huth wrote:
> QEMU currently crashes when the user tries to add a spapr-cpu-core
> on a non-pseries machine:
> 
> $ qemu-system-ppc64 -S -machine ppce500,accel=tcg \
>                     -device POWER5+_v2.1-spapr-cpu-core
> hw/ppc/spapr_cpu_core.c:178:spapr_cpu_core_realize_child:
> Object 0x55cee1f55160 is not an instance of type spapr-machine
> Aborted (core dumped)
> 
> So let's add a proper check for the correct machine time with
> a more friendly error message here.
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/ppc/spapr_cpu_core.c   | 9 ++++++++-
>  scripts/device-crash-test | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ea278ce..0f3d653 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -175,11 +175,18 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
>  static void spapr_cpu_core_realize_child(Object *child, Error **errp)
>  {
>      Error *local_err = NULL;
> -    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +    sPAPRMachineState *spapr;
>      CPUState *cs = CPU(child);
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>      Object *obj;
>  
> +    spapr = (sPAPRMachineState *)object_dynamic_cast(qdev_get_machine(),
> +                                                     TYPE_SPAPR_MACHINE);
> +    if (!spapr) {
> +        error_setg(errp, "spapr-cpu-core needs a pseries machine");
> +        return;
> +    }
> +
>      object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
>          goto error;
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index e77b693..8eb2d02 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -200,6 +200,7 @@ ERROR_WHITELIST = [
>      {'log':r"Multiple VT220 operator consoles are not supported"},
>      {'log':r"core 0 already populated"},
>      {'log':r"could not find stage1 bootloader"},
> +    {'log':r"spapr-cpu-core needs a pseries machine"},

device/machine whitelist entries are preferred, if possible.
This way, we can set expected=True and device-crash-test will
avoid testing a device/machine combination known to be
incompatible (when running in quick mode), or print a warning if
it doesn't fail as expected (when running in full mode).

I suggest the following (untested):

  # "spapr-cpu-core needs a pseries machine"
  {'machine':'(?!pseries.*)', 'device':'.*-spapr-cpu-core', 'expected':True},

-- 
Eduardo
