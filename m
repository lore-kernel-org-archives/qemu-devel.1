Received: from eggs.gnu.org ([2001:4830:134:3::10]:60012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1csafh-0008DH-9d
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1csaff-0000Ue-Jl
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:51:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1csaff-0000Rl-AS
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:51:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2RJkNJt002309
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 15:51:15 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29f96bg8a9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 15:51:15 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 27 Mar 2017 15:51:13 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170327132242.17104-1-lvivier@redhat.com>
References: <20170327132242.17104-1-lvivier@redhat.com>
Date: Mon, 27 Mar 2017 14:48:25 -0500
Message-Id: <149064410502.3776.14148553913820748455@loki>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix memory hot-unplugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Quoting Laurent Vivier (2017-03-27 08:22:42)
> If, once the kernel has booted, we try to remove a memory
> hotplugged while the kernel was not started, QEMU crashes on
> an assert:
> =

>     qemu-system-ppc64: hw/virtio/vhost.c:651:
>                        vhost_commit: Assertion `r >=3D 0' failed.
>     ...
>     #4  in vhost_commit
>     #5  in memory_region_transaction_commit
>     #6  in pc_dimm_memory_unplug
>     #7  in spapr_memory_unplug
>     #8  spapr_machine_device_unplug
>     #9  in hotplug_handler_unplug
>     #10 in spapr_lmb_release
>     #11 in detach
>     #12 in set_allocation_state
>     #13 in rtas_set_indicator
>     ...
> =

> If we take a closer look to the guest kernel log, we can see when
> we try to unplug the memory:
> =

>     pseries-hotplug-mem: Attempting to hot-add 4 LMB(s)
> =

> What happens:
> =

>     1- The kernel has ignored the memory hotplug event because
>        it was not started when it was generated.
> =

>     2- When we hot-unplug the memory,
>        QEMU starts to remove the memory,
>             generates an hot-unplug event,
>         and signals the kernel of the incoming new event
> =

>     3- as the kernel is started, on the QEMU signal, it reads
>        the event list, decodes the hotplug event and tries to
>        finish the hotplugging.
> =

>     4- QEMU receives the hotplug notification while it
>        is trying to hot-unplug the memory. This moves the memory
>        DRC to an invalid state

So, IIUC, it looks like the the memory is already onlined at boot-time, and
when it attempts to handle the hotplug event the kernel does the following:

static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
{
        ...
        pr_info("Attempting to hot-add %d LMB(s)\n", lmbs_to_add);
        ...
        for (i =3D 0; i < num_lmbs && lmbs_to_add !=3D lmbs_added; i++) {
                rc =3D dlpar_acquire_drc(lmbs[i].drc_index);
                if (rc)
                        continue;

                rc =3D dlpar_add_lmb(&lmbs[i]);
                if (rc) {
                        dlpar_release_drc(lmbs[i].drc_index);
                        continue;
                }

                lmbs_added++;

                /* Mark this lmb so we can remove it later if all of the
                 * requested LMBs cannot be added.
                 */
                lmbs[i].reserved =3D 1;
        }

dlpar_add_lmb likely fails because the memory was already onlined, and the
acquire/release cause allocation_state transitions of USABLE and UNUSABLE,
respectively. But since in the meantime we've marked the memory for unplug,
this UNUSABLE transition falsely indicates to QEMU that the guest has
acknowledged the unplug and released the memory, so we nuke it prematurely.

> =

> This patch prevents this by not allowing to set the allocation
> state to USABLE while the DRC is awaiting release and allocation.
> =

> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1432382
> =

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/ppc/spapr_drc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> =

> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 150f6bf..377ea65 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -135,6 +135,12 @@ static uint32_t set_allocation_state(sPAPRDRConnecto=
r *drc,
>          if (!drc->dev) {
>              return RTAS_OUT_NO_SUCH_INDICATOR;
>          }
> +        if (drc->awaiting_release && drc->awaiting_allocation) {
> +            /* kernel is acknowledging a previous hotplug event
> +             * while we are already removing it.
> +             */
> +            return RTAS_OUT_NO_SUCH_INDICATOR;
> +        }

So basically if the unplug happens soon-enough after the hotplug (or in the
special-case of hotplugging at boot-time, any time after hotplug), we force
the dlpar_acquire_drc to fail so we don't subsequently nuke it on release.
This might trip up test cases where it's common to fire off a ton of
plug/unplug and assume each operation succeeds in turn, but the new behavior
does seem appropriate since there's no reason acquire should be expected to
succeed if we've since marked the memory for removal; that choice is wholly
up to the platform up until the point the acquire actually succeeds.

Technically, though, it's the *release* part that's the real problem, since
that's what's getting misconstrued. Unfortunately I don't see any way to
address things on that end, so this approach seems reasonable.

As for the follow-up question I think clearing awaiting_allocation would be
necessary to allow subsequent unplug to succeed and not be stuck with the
unused DIMM until reset. My main concern there though is if any code ever
decided to retry the hotplug for some reason, they could bypass this check
and trigger the same error. If it was highly unlikely to occur I think I
would opt to simply clear awaiting_allocation, but I think this scenario
could be triggered by simply invoking:

  drmgr -c lmb -s ... -a

after the initial plug and unplug requests fail. Ideally we would keep the
awaiting_allocation && awaiting_release guard in place so dlpar_acquire_drc
never succeeds in this case, but still allow for unplug to succeed. One
*assumption* we can make use of is that acquire/release are done in pairs
by the hotplug code, so if acquire/allocation_state:USABLE always fail, then
a subsequent allocate_state:UNUSABLE would then likely be the result of the
unplug path where release can be reasonably issued in isolation (under the
assumption that hotplug handled the acquire).

So perhaps something like (untested):

       if (drc->awaiting_release && drc->awaiting_allocation) {
           /* kernel is acknowledging a previous hotplug event
            * while we are already removing it.
-           */
+           * it's safe to ignore awaiting_allocation here since we know the
+           * situation is predicated on the guest either already having do=
ne
+           * so (boot-time hotplug), or never being able to acquire in the
+           * first place (hotplug followed by immediate unplug).
+           */
+          drc->awaiting_allocation_skippable =3D true;
           return RTAS_OUT_NO_SUCH_INDICATOR;
       }

and then in detach():

    if (drc->awaiting_allocation) {
-       drc->awaiting_release =3D true;
-       trace_spapr_drc_awaiting_allocation(get_index(drc));
-       return;
+       if (!drc->awaiting_allocation_skippable) {
+           drc->awaiting_release =3D true;
+           trace_spapr_drc_awaiting_allocation(get_index(drc));
+           return;
+       }
    }

...

    drc->awaiting_release =3D false;
+   drc->awaiting_release_skippable =3D false;


>      }
> =

>      if (drc->type !=3D SPAPR_DR_CONNECTOR_TYPE_PCI) {
> -- =

> 2.9.3
> =

>=20
