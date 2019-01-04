Received: from eggs.gnu.org ([208.118.235.92]:43251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfQd2-0006Uz-LR
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfQcy-00020B-1F
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 09:39:16 -0500
Date: Fri, 4 Jan 2019 15:39:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190104153901.0bd2f703.cohuck@redhat.com>
In-Reply-To: <1546510620-6707-2-git-send-email-pmorel@linux.ibm.com>
References: <1546510620-6707-1-git-send-email-pmorel@linux.ibm.com>
	<1546510620-6707-2-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] s390x/pci: add common function
 measurement block
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

On Thu,  3 Jan 2019 11:17:00 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> +static void fmb_update(void *opaque)
> +{
> +    S390PCIBusDevice *pbdev = opaque;
> +    int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    int i;
> +
> +    /* Update U bit */
> +    pbdev->fmb.last_update *= 2;
> +    pbdev->fmb.last_update |= UPDATE_U_BIT;
> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_update),
> +                      pbdev->fmb.last_update,
> +                      sizeof(((ZpciFmb *)0)->last_update))) {

I really don't want to be a pain, but... this looks weird. Why not
simply sizeof(pbdev->fmb.last_update)?

> +        return;
> +    }
> +
> +    /* Update FMB sample count */
> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, sample),
> +                      pbdev->fmb.sample++,
> +                      sizeof(((ZpciFmb *)0)->sample))) {
> +        return;
> +    }
> +
> +    /* Update FMB counters */
> +    for (i = 0; i < ZPCI_FMB_CNT_MAX; i++) {
> +        if (fmb_do_update(pbdev, offsetof(ZpciFmb, counter[i]),
> +                          pbdev->fmb.counter[i],
> +                          sizeof(((ZpciFmb *)0)->counter[0]))) {
> +            return;
> +        }
> +    }
> +
> +    /* Clear U bit and update the time */
> +    pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +    pbdev->fmb.last_update *= 2;
> +    if (fmb_do_update(pbdev, offsetof(ZpciFmb, last_update),
> +                      pbdev->fmb.last_update,
> +                      sizeof(((ZpciFmb *)0)->last_update))) {
> +        return;
> +    }
> +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
> +}
> +
