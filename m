Received: from eggs.gnu.org ([2001:4830:134:3::10]:42069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1ctpD7-0003vw-Sw
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1ctpD6-0003jj-PV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 01:34:57 -0400
MIME-Version: 1.0
In-Reply-To: <20170331045144.9307-1-david@gibson.dropbear.id.au>
References: <20170331045144.9307-1-david@gibson.dropbear.id.au>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Fri, 31 Mar 2017 11:04:55 +0530
Message-ID: <CAGZKiBrsiFgwuFx4CjasWAg8+qXAiA10w9cMP6MhBec3iRouLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] pseries: Enforce homogeneous
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
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, lvivier@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On Fri, Mar 31, 2017 at 10:21 AM, David Gibson <david@gibson.dropbear.id.au>
wrote:

> For reasons that may be useful in future, CPU core objects, as used on the
> pseries machine type have their own nr-threads property, potentially
> allowing cores with different numbers of threads in the same system.
>

I remember we retained this flexibility to support heterogenous systems in
future ? I think we can go with this enforcement now and relax it later if
we ever reach there.


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
> threads.  While we're at it, also enforce that the core ids are correctly
> aligned based on that number of threads.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_cpu_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 6883f09..935ee62 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -167,6 +167,18 @@ static void spapr_cpu_core_realize(DeviceState *dev,
> Error **errp)
>      void *obj;
>      int i, j;
>
> +    if (cc->nr_threads != smp_threads) {
> +        error_setg(errp,
> +                   "Invalid nr-threads=%d of CPU[core-id: %d], must be
> %d",
> +                   cc->nr_threads, cc->core_id, smp_threads);
> +        return;
> +    }
>

The above check should move to pre_plug handler.


> +    if ((cc->core_id % smp_threads) != 0) {
> +        error_setg(errp, "Invalid CPU core-id=%d, must be a multiple of
> %d",
> +                   cc->core_id, smp_threads);
> +        return;
> +    }
>

Not sure when you will hit this as the same check is already  present in
pre_plug handler.

Regards,
Bharata.
