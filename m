Received: from eggs.gnu.org ([2001:4830:134:3::10]:54279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKoIp-0004dp-G0
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eKoIo-0002rt-3Y
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:36:39 -0500
Date: Fri, 1 Dec 2017 11:38:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171201113821.0eb92bf4.cohuck@redhat.com>
In-Reply-To: <1512046530-17773-4-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1512046530-17773-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1512046530-17773-4-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/7] s390x/pci: rework PCI LOAD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, mst@redhat.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

On Thu, 30 Nov 2017 13:55:26 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Enhance the fault detection, correction of the fault reporting.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 

> @@ -395,8 +395,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>          break;
>      }
>  
> -    if (pcias < 6) {
> -        if ((8 - (offset & 0x7)) < len) {
> +    switch (pcias) {
> +    case ZPCI_IO_BAR_MIN ... ZPCI_IO_BAR_MAX:

Will make this

case ZPCI_IO_BAR_MIN...ZPCI_IO_BAR_MAX:

> +        if (!len || (len > (8 - (offset & 0x7)))) {
>              program_interrupt(env, PGM_OPERAND, 4);
>              return 0;
>          }
