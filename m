Received: from eggs.gnu.org ([2001:4830:134:3::10]:60748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gEZ9S-0003jh-PZ
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gEZ9O-0004VR-Oe
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gEZ9O-0004Ud-DW
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:17:38 -0400
References: <20181022090255.19671-1-zyimin@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <698a7fdd-47cc-cb3e-a280-3c4b656d92ef@redhat.com>
Date: Mon, 22 Oct 2018 13:17:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181022090255.19671-1-zyimin@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, pmorel@linux.ibm.com

On 2018-10-22 10:02, Yi Min Zhao wrote:
> Common function measurement block is used to report counters of
> successfully issued pcilg/stg/stb and rpcit instructions. This patch
> introduces a new struct ZpciFmb and schedules a timer callback to
> copy fmb to the guest memory at a interval time which is set to
> 4s by default. While attemping to update fmb failed, an event error
> would be generated. After pcilg/stg/stb and rpcit interception
> handlers issue successfully, increase the related counter. The guest
> could pass null address to switch off FMB and stop corresponding
> timer.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
[...]
> +static int fmb_do_update(S390PCIBusDevice *pbdev, uint8_t offset, int len)
> +{
> +    MemTxResult ret;
> +
> +    ret = address_space_write(&address_space_memory,
> +                              pbdev->fmb_addr + (uint64_t)offset,
> +                              MEMTXATTRS_UNSPECIFIED,
> +                              (uint8_t *)&pbdev->fmb + offset,
> +                              len);
> +    if (ret) {
> +        s390_pci_generate_error_event(ERR_EVENT_FMBA, pbdev->fh, pbdev->fid,
> +                                      pbdev->fmb_addr, 0);
> +        fmb_timer_free(pbdev);
> +    }
> +
> +    return ret;
> +}
> +
> +static void fmb_update(void *opaque)
> +{
> +    S390PCIBusDevice *pbdev = opaque;
> +    int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    uint8_t offset = offsetof(ZpciFmb, last_update);
> +
> +    /* Update U bit */
> +    pbdev->fmb.last_update |= UPDATE_U_BIT;
> +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
> +        return;
> +    }
> +
> +    /* Update FMB counters */
> +    pbdev->fmb.sample++;
> +    if (fmb_do_update(pbdev, 0, sizeof(ZpciFmb))) {
> +        return;
> +    }
> +
> +    /* Clear U bit and update the time */
> +    pbdev->fmb.last_update = time2tod(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
> +    pbdev->fmb.last_update &= ~UPDATE_U_BIT;
> +    if (fmb_do_update(pbdev, offset, sizeof(uint64_t))) {
> +        return;
> +    }
> +
> +    timer_mod(pbdev->fmb_timer, t + DEFAULT_MUI);
> +}

Sorry for noticing this in v1 already, but is this code endianess-safe?
I.e. can this also work with qemu-system-s390x running with TCG on a x86
host? I think you might have to use something like this here instead:

  pbdev->fmb.sample = cpu_to_be32(be32_to_cpu(pbdev->fmb.sample) + 1);

etc.

 Thomas
