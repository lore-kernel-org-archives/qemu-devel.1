Received: from eggs.gnu.org ([2001:4830:134:3::10]:42531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dNERu-0005HZ-2R
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dNERp-0005vs-JT
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:23:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43388
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dNERp-0005vX-Co
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 04:23:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5K8IgI8074327
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 04:23:40 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b6qenbanb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 04:23:38 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Tue, 20 Jun 2017 18:23:35 +1000
Date: Tue, 20 Jun 2017 13:53:28 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
	<20170608050930.2613-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608050930.2613-5-david@gibson.dropbear.id.au>
Message-Id: <20170620082328.GA15438@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] spapr: Make DRC reset force DRC into
 known state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mdroth@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, Jun 08, 2017 at 03:09:28PM +1000, David Gibson wrote:
> The reset handler for DRCs attempts several state transitions which are
> subject to various checks and restrictions.  But at reset time we know
> there is no guest, so we can ignore most of the usual sequencing rules and
> just set the DRC back to a known state.  In fact, it's safer to do so.
> 
> The existing code also has several redundant checks for
> drc->awaiting_release inside a block which has already tested that.  This
> patch removes those and sets the DRC to a fixed initial state based only
> on whether a device is currently plugged or not.
> 
> With DRCs correctly reset to a state based on device presence, we don't
> need to force state transitions as cold plugged devices are processed.
> This allows us to remove all the callers of the set_*_state() methods from
> outside spapr_drc.c.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c     | 15 ---------------
>  hw/ppc/spapr_drc.c | 28 ++++++++--------------------
>  2 files changed, 8 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 01dda9e..c988e38 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2545,12 +2545,6 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
> 
>          spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
>          addr += SPAPR_MEMORY_BLOCK_SIZE;
> -        if (!dev->hotplugged) {
> -            sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -            /* guests expect coldplugged LMBs to be pre-allocated */
> -            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
> -            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);
> -        }
>      }
>      /* send hotplug notification to the
>       * guest only in case of hotplugged memory
> @@ -2901,15 +2895,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           * of hotplugged CPUs.
>           */
>          spapr_hotplug_req_add_by_index(drc);
> -    } else {
> -        /*
> -         * Set the right DRC states for cold plugged CPU.
> -         */
> -        if (drc) {
> -            sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
> -            drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNISOLATED);

So here you are removing the initial state setting for cold plugged CPUs and ...

> -        }
>      }
>      core_slot->cpu = OBJECT(dev);
>  }
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index dc4ac77..7e17f34 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -393,7 +393,6 @@ static bool release_pending(sPAPRDRConnector *drc)
>  static void reset(DeviceState *d)
>  {
>      sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
> -    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> 
>      trace_spapr_drc_reset(spapr_drc_index(drc));
> 
> @@ -401,28 +400,17 @@ static void reset(DeviceState *d)
>      drc->ccs = NULL;
> 
>      /* immediately upon reset we can safely assume DRCs whose devices
> -     * are pending removal can be safely removed, and that they will
> -     * subsequently be left in an ISOLATED state. move the DRC to this
> -     * state in these cases (which will in turn complete any pending
> -     * device removals)
> +     * are pending removal can be safely removed.
>       */
>      if (drc->awaiting_release) {
> -        drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_ISOLATED);
> -        /* generally this should also finalize the removal, but if the device
> -         * hasn't yet been configured we normally defer removal under the
> -         * assumption that this transition is taking place as part of device
> -         * configuration. so check if we're still waiting after this, and
> -         * force removal if we are
> -         */
> -        if (drc->awaiting_release) {
> -            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
> -        }
> +        spapr_drc_release(drc);
> +    }
> 
> -        /* non-PCI devices may be awaiting a transition to UNUSABLE */
> -        if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI &&
> -            drc->awaiting_release) {
> -            drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_UNUSABLE);
> -        }
> +    drc->isolation_state = drc->dev ? SPAPR_DR_ISOLATION_STATE_UNISOLATED
> +        : SPAPR_DR_ISOLATION_STATE_ISOLATED;
> +    if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
> +        drc->allocation_state = drc->dev ? SPAPR_DR_ALLOCATION_STATE_USABLE
> +            : SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
>      }

... adding it via reset. However you are setting drc->isolation_state and
drc->allocation_state directly rather than going via
drck->set_isolation_state() and drck->set_allocation_state() routines.
This results in awaiting_allocation not geting cleared for cold plugged
CPUs. So the effect after this commit is that we can't remove the
CPUs that are specified on cmdline using -device.

The following fixes the issue for me:

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index fd9e07d..da6979a 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -450,13 +450,13 @@ static void reset(DeviceState *d)
         /* A device present at reset is coldplugged */
         drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
         if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
-            drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
+            drc_set_usable(drc);
         }
     } else {
         /* Otherwise device is absent, but might be hotplugged */
         drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
         if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
-            drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
+            drc_set_unusable(drc);
         }
     }
 }

However I thought this will restore the previous behaviour completely:

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index fd9e07d..b7726ef 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -433,6 +433,7 @@ static bool release_pending(sPAPRDRConnector *drc)
 static void reset(DeviceState *d)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(d);
+    sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     trace_spapr_drc_reset(spapr_drc_index(drc));
 
@@ -448,15 +449,15 @@ static void reset(DeviceState *d)
 
     if (drc->dev) {
         /* A device present at reset is coldplugged */
-        drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
+        drck->unisolate(drc);
         if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
-            drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
+            drc_set_usable(drc);
         }
     } else {
         /* Otherwise device is absent, but might be hotplugged */
-        drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
+        drck->isolate(drc);
         if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
-            drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
+            drc_set_unusable(drc);
         }
     }
 }

Regards,
Bharata.
