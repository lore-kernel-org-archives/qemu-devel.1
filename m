Received: from eggs.gnu.org ([2001:4830:134:3::10]:38275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gF4LO-0002MC-Da
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gF4B4-0007tn-0B
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 17:25:29 -0400
Date: Tue, 23 Oct 2018 23:25:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181023232517.6b93085b.cohuck@redhat.com>
In-Reply-To: <698a7fdd-47cc-cb3e-a280-3c4b656d92ef@redhat.com>
References: <20181022090255.19671-1-zyimin@linux.ibm.com>
	<698a7fdd-47cc-cb3e-a280-3c4b656d92ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: add common fmb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pmorel@linux.ibm.com, qemu-s390x@nongnu.org

On Mon, 22 Oct 2018 13:17:34 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 2018-10-22 10:02, Yi Min Zhao wrote:
> > Common function measurement block is used to report counters of
> > successfully issued pcilg/stg/stb and rpcit instructions. This patch
> > introduces a new struct ZpciFmb and schedules a timer callback to
> > copy fmb to the guest memory at a interval time which is set to
> > 4s by default. While attemping to update fmb failed, an event error
> > would be generated. After pcilg/stg/stb and rpcit interception
> > handlers issue successfully, increase the related counter. The guest
> > could pass null address to switch off FMB and stop corresponding
> > timer.
> > 
> > Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> > Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---  
> [...]
> > +static int fmb_do_update(S390PCIBusDevice *pbdev, uint8_t offset, int len)
> > +{
> > +    MemTxResult ret;
> > +
> > +    ret = address_space_write(&address_space_memory,
> > +                              pbdev->fmb_addr + (uint64_t)offset,
> > +                              MEMTXATTRS_UNSPECIFIED,
> > +                              (uint8_t *)&pbdev->fmb + offset,
> > +                              len);
> > +    if (ret) {
> > +        s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbdev->fid,
> > +                                      pbdev->fmb_addr, 0);
> > +        fmb_timer_free(pbdev);
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +static void fmb_update(void *opaque)
> > +{
> > +    S390PCIBusDevice *pbdev = opaque;
> > +    int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> > +    uint8_t offset = offsetof(ZpciFmb, last_update);
> > +
> > +    /* Update U bit */
> > +    pbdev->fmb.last_update |= UPDATE_U_BIT;
> > +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
> > +        return;
> > +    }
> > +
> > +    /* Update FMB counters */
> > +    pbdev->fmb.sample++;
> > +    if (fmb_do_update(pbdev, 0, sizeof(ZpciFmb))) {
> > +        return;
> > +    }
> > +
> > +    /* Clear U bit and update the time */
> > +    pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> > +    pbdev->fmb.last_update &= ~UPDATE_U_BIT;
> > +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
> > +        return;
> > +    }
> > +
> > +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
> > +}  
> 
> Sorry for noticing this in v1 already, but is this code endianess-safe?
> I.e. can this also work with qemu-system-s390x running with TCG on a x86
> host? I think you might have to use something like this here instead:
> 
>   pbdev->fmb.sample = cpu_to_be32(be32_to_cpu(pbdev->fmb.sample) + 1);
> 
> etc.

Agreed, that may need some endianness handling.

I would test this with tcg on a LE host, but how can I verify this? Yi
Min, do you have some kind of test tooling you can share?
