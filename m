Received: from eggs.gnu.org ([2001:4830:134:3::10]:41910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gYos2-000119-IG
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 04:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gYory-0001ZH-Kg
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 04:07:26 -0500
Date: Mon, 17 Dec 2018 10:07:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181217100710.6cb82fd9.cohuck@redhat.com>
In-Reply-To: <1544806422-21418-1-git-send-email-pmorel@linux.ibm.com>
References: <1544806422-21418-1-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On Fri, 14 Dec 2018 17:53:41 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> After the last review round I worked on endianness.
> Doing this I found some errors in the code and in the interpretation
> of the documentation.
>   
> The new patch changed the following from previous version:
>  
> In s390-pci-bus:
> - Initialize the FMB Format.
>  
> In s390-pci-bus.h 
> - re-organization of the internal counters, having a table for the
>   internal counters.
> 
> In s390-pci-inst.c
> - Internal counters update (LD/ST/STB/RPCIT) is done always.
>   even if the FMB if fmb_addr is NULL.
>   AFAIU this respect the documentation which only states that FMB
>   update is stopped.
> - in mpcifc_service_call(), moved the setting of fmb_addr after
>   the timer has been stopped.
> - fmb_update((), use address_space_stq_be() to handle endianness
>   when storing the FMB.
> - define the format with 32 bits instead of one char and reserved
>   chars, this is easier to handle the FMB copy.
> - No update of the DMA fields inside the FMB, as stipulated by the
>   documentation when format32 is 0.
> 
> Patch is tested (for the good case) on Z(KVM) and X(TCG).

Yes, the values look sane for virtio-pci devices under tcg as well.

Will review and hopefully apply later.

> 
> Yi Min Zhao (1):
>   s390x/pci: add common function measurement block
> 
>  hw/s390x/s390-pci-bus.c  |   4 +-
>  hw/s390x/s390-pci-bus.h  |  29 ++++++++++
>  hw/s390x/s390-pci-inst.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/s390x/s390-pci-inst.h |   1 +
>  4 files changed, 171 insertions(+), 4 deletions(-)
> 
