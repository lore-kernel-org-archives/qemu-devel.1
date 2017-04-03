Received: from eggs.gnu.org ([2001:4830:134:3::10]:60563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1custB-0005mT-Tt
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 23:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1custA-00044K-OL
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 23:42:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170402063802.30997-1-david@gibson.dropbear.id.au>
References: <20170402063802.30997-1-david@gibson.dropbear.id.au>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Mon, 3 Apr 2017 09:12:42 +0530
Message-ID: <CAGZKiBpk03okqW4Gbv3_Hg3EyoH+YJpReQA_1bHPjYYhMaA4jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCHv2 for-2.9] pseries: Enforce homogeneous
 threads-per-core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, lvivier@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Sun, Apr 2, 2017 at 12:08 PM, David Gibson <david@gibson.dropbear.id.au>
wrote:

> For reasons that may be useful in future, CPU core objects, as used on the
> pseries machine type have their own nr-threads property, potentially
> allowing cores with different numbers of threads in the same system.
>
> If the user/management uses the values specified in query-hotpluggable-cpus
> as they're expected to do, this will never matter in pratice.  But that's
> not actually enforced - it's possible to manually specify a core with
> a different number of threads from that in -smp.  That will confuse the
> platform - most immediately, this can be used to create a CPU thread with
> index above max_cpus which leads to an assertion failure in
> spapr_cpu_core_realize().
>
> For now, enforce that all cores must have the same, standard, number of
> threads.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 44c26e4..35db949 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2790,6 +2790,12 @@ static void spapr_core_pre_plug(HotplugHandler
> *hotplug_dev, DeviceState *dev,
>          goto out;
>      }
>
> +    if (cc->nr_threads != smp_threads) {
> +        error_setg(errp, "invalid nr-threads %d, must be %d",
> +                   cc->nr_threads, smp_threads);
> +        return;
> +    }
> +
>      core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id,
> &index);
>      if (!core_slot) {
>          error_setg(&local_err, "core id %d out of range", cc->core_id);
>

Reviewed-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
