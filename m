Received: from eggs.gnu.org ([2001:4830:134:3::10]:41375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHnmW-0004SA-Di
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHnmR-0008Q2-CK
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:26:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eHnmR-0008PJ-5y
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:26:47 -0500
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-5-git-send-email-pmorel@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5741f969-30b8-eda9-3b37-a89f8c8e7310@redhat.com>
Date: Thu, 23 Nov 2017 10:26:42 +0100
MIME-Version: 1.0
In-Reply-To: <1511388334-16347-5-git-send-email-pmorel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/7] s390x/pci: rework PCI STORE BLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de

On 22.11.2017 23:05, Pierre Morel wrote:
> Enhance the fault detection.
> 
> Fixup the precedence to check the destination path existance
> before checking for the source accessibility.
> 
> Add the maxstbl entry to both the Query PCI Function Group
> response and the PCIBusDevice structure.
> 
> Initialize the maxstbl to 128 per default until we get
> the actual data from the hardware.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.h  |  1 +
>  hw/s390x/s390-pci-inst.c | 63 ++++++++++++++++++++++++++++++------------------
>  hw/s390x/s390-pci-inst.h |  2 +-
>  3 files changed, 41 insertions(+), 25 deletions(-)
[...]
> @@ -722,6 +733,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
>  
>      setcc(cpu, ZPCI_PCI_LS_OK);
>      return 0;
> +
> +addressing_error:
> +    program_interrupt(env, PGM_SPECIFICATION, 6);

The label is called "addressing_error", but then you insert a
PGM_SPECIFICTATION ? According to the name of the label, I'd rather
expected a PGM_ADDRESSING here ... so maybe rename the label to
"spec_error" or something similar?

> +    return 0;
>  }

 Thomas
