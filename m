Received: from eggs.gnu.org ([2001:4830:134:3::10]:46423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d8vxa-0004BZ-Ms
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d8vxZ-0001QP-Sk
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d8vxZ-0001O3-Ln
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:49:21 -0400
Date: Thu, 11 May 2017 15:49:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170511154915.75d7f4b1@w520.home>
In-Reply-To: <20170505020352.8984-13-bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-13-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 12/13] vfio/ccw: update sense data if a
 unit check is pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, eric.auger@redhat.com

On Fri,  5 May 2017 04:03:51 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Concurrent-sense data is currently not delivered. This patch stores
> the concurrent-sense data to the subchannel if a unit check is pending
> and the concurrent-sense bit is enabled. Then a TSCH can retreive the
> right IRB data back to the guest.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---


Acked-by: Alex Williamson <alex.williamson@redhat.com>


>  hw/vfio/ccw.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 3c8b518..73f326f 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -94,6 +94,7 @@ static void vfio_ccw_io_notifier_handler(void *opaque)
>      CcwDevice *ccw_dev = CCW_DEVICE(cdev);
>      SubchDev *sch = ccw_dev->sch;
>      SCSW *s = &sch->curr_status.scsw;
> +    PMCW *p = &sch->curr_status.pmcw;
>      IRB irb;
>      int size;
>  
> @@ -143,6 +144,12 @@ static void vfio_ccw_io_notifier_handler(void *opaque)
>      /* Update control block via irb. */
>      copy_scsw_to_guest(s, &irb.scsw);
>  
> +    /* If a uint check is pending, copy sense data. */
> +    if ((s->dstat & SCSW_DSTAT_UNIT_CHECK) &&
> +        (p->chars & PMCW_CHARS_MASK_CSENSE)) {
> +        memcpy(sch->sense_data, irb.ecw, sizeof(irb.ecw));
> +    }
> +
>  read_err:
>      css_inject_io_interrupt(sch);
>  }
