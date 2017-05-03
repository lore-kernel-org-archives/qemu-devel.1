Received: from eggs.gnu.org ([2001:4830:134:3::10]:40130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5vLx-0006NO-Gw
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5vLr-0005tr-NJ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:34:05 -0400
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <820e7037-13a7-c478-e119-ed64599cb3cb@redhat.com>
Date: Wed, 3 May 2017 16:33:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/ppc: removing spapr_drc_detach_cb
 opaques
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 30/04/2017 19:25, Daniel Henrique Barboza wrote:
> Following up the previous detach_cb change, this patch removes the
> detach_cb_opaque entirely from the code.
> 
> The reason is that the drc->detach_cb_opaque object can't be
> restored in the post load of the upcoming DRC migration and no detach
> callbacks actually need this opaque. 'spapr_core_release' is
> receiving it as NULL, 'spapr_phb_remove_pci_device_cb' is receiving
> a phb object as opaque but is't using it. These were trivial removal
> cases.
> 
> However, the LM removal callback 'spapr_lmb_release' is receiving
> and using the opaque object, a 'sPAPRDIMMState' struct. This struct
> holds the number of LMBs the DIMM object contains and the callback
> was using this counter as a countdown to check if all LMB DRCs were
> release before proceeding to the DIMM unplug. To remove the need of
> this callback we have choices such as:
> 
> - migrate the 'sPAPRDIMMState' struct. This would require creating a
> QTAILQ to store all DIMMStates and an additional 'dimm_id' field to
> associate the DIMMState with the DIMM object. We could attach this
> QTAILQ to the 'sPAPRPHBState' and retrieve it later in the callback.
> 

Did you think about adding the nr_lmbs into PCDIMMDevice structure?
Or to create a SPAPRPCDIMMDevice with PCDIMMDevice parent_obj and
nr_lmbs field we can retrieve from the DeviceState pointer?

I don't know if it is a good idea or an acceptable way to do that, but
I'd like to know if you have thought about that.

Thanks,
Laurent
