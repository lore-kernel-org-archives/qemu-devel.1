Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7E4C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1592F24CCA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="AtojzyNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1592F24CCA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47732 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY4DH-0000ez-5W
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:50:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hY4CP-0000DU-7C
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1hY4CN-0006B4-Ar
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:49:37 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1hY4CM-0005qb-In
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:49:35 -0400
Received: by mail-pl1-x642.google.com with SMTP id cl9so2903755plb.10
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 00:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
	h=subject:cc:references:to:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=aSQcriMG28EcmWLfXNagidzNCp+SoemaM0YiDWaUwZg=;
	b=AtojzyNi5HCDEo2fzK430R8uF7FK/+1NxNIx277jgeHtTC/cdTAXE/3D1chDcUac6e
	FtBYFSuZ6Y35vFYGFtPY0L0rHLeBOVSwpHw07U6Hs3FgDN7ijPwpOtiRVw5nnNNEIusU
	ASiDBiGwVDfXZDQurLZwTn5ITJQEFu1AmvCx2immc0Uq0hHz4A8B9PVP2gf0OaO+fjQU
	zAmQ+XmRMdE2ofW4W/WrpTO5AXyQa0Pqb9e8TIxmBtEhJorkQn6xmpaFwCeWmO6UbtEC
	w2rEdZ+58o0OeeiZbHwK9CZGDqfSdDzR8ksiO+A5knt6JJ/alre5mji5Bst8tlmpeVRT
	uy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:cc:references:to:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=aSQcriMG28EcmWLfXNagidzNCp+SoemaM0YiDWaUwZg=;
	b=W8BSpMEU8bz5hzb+Vj+USyr68M5PoEPKesc5dLNNNadxtdEmiIWVRo0ui/HGxXszmE
	P3px+HRiyFkBrIMWpdcfjEenjz49thHQGatnlAxuuFpLRugyrri4XGsr2G5YTOGjnMTf
	cMa5ObfD0QzduQLv0O69bVyQxZnEEmoNEZAPYEslEdhs3+cROwBEL22455HsP/879bEm
	1cltP/fidK271fYC2KFdbRKas5OniBE9v8a2CPjsG3Q+zqpOInThK2qqLq2sjy0muGfu
	1aWwLLGc6YaqaHISqQzOqRXllcPCRGmK4g+qZROoMwzzMkwyThjjgOzNZfWGT7Md4B10
	5K/g==
X-Gm-Message-State: APjAAAWln91t5jRmWQ0ITowkCdgLDk78HxMG98AKoSQl6F3HXYamTCd6
	XBwujHZWKWElllKTJlL14WbLHQ==
X-Google-Smtp-Source: APXvYqzOXUGgl6SBJu6WNXEBthDPFhH6PlZoBpkU4XHJQiz9LOCb+vVKzrWBtqvOiRAZ8RA0oK27wQ==
X-Received: by 2002:a17:902:3a3:: with SMTP id
	d32mr35562121pld.14.1559634572194; 
	Tue, 04 Jun 2019 00:49:32 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10]) by smtp.gmail.com with ESMTPSA id
	a25sm12288160pfn.1.2019.06.04.00.49.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 00:49:31 -0700 (PDT)
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
	<20190529065017.15149-30-david@gibson.dropbear.id.au>
To: clg@kaod.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
	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
Message-ID: <9f6614b2-2f07-ef0c-cca3-d6fcc1f8f87f@ozlabs.ru>
Date: Tue, 4 Jun 2019 17:49:26 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529065017.15149-30-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PULL 29/44] spapr/xive: introduce a VM state
 change handler
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, peter.maydell@linaro.org, groug@kaod.org,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org, rth@twiddle.net,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 29/05/2019 16:50, David Gibson wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> This handler is in charge of stabilizing the flow of event notifications
> in the XIVE controller before migrating a guest. This is a requirement
> before transferring the guest EQ pages to a destination.
> 
> When the VM is stopped, the handler sets the source PQs to PENDING to
> stop the flow of events and to possibly catch a triggered interrupt
> occuring while the VM is stopped. Their previous state is saved. The
> XIVE controller is then synced through KVM to flush any in-flight
> event notification and to stabilize the EQs. At this stage, the EQ
> pages are marked dirty to make sure the EQ pages are transferred if a
> migration sequence is in progress.
> 
> The previous configuration of the sources is restored when the VM
> resumes, after a migration or a stop. If an interrupt was queued while
> the VM was stopped, the handler simply generates the missing trigger.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Message-Id: <20190513084245.25755-6-clg@kaod.org>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

This one breaks my nvlink2 passthru setup. The host is v5.2-rc2.
v5.2-rc3 fixes it though so it is backward compatibility issue which we
care about to what degree here? I am forcing ic-mode=xive which is not
the default so I am not so sure.



aik@u1804kvm:~$ cat /proc/interrupts
           CPU0
 16:          0  XIVE-IPI   0 Edge      IPI
 21:          0  XIVE-IRQ 4096 Edge      RAS_EPOW
 22:          0  XIVE-IRQ 4097 Edge      RAS_HOTPLUG
257:      12372  XIVE-IRQ 4353 Edge      ibmvscsi
258:          0  XIVE-IRQ 4864 Edge      virtio0-config
259:       2157  XIVE-IRQ 4865 Edge      virtio0-input.0
260:          1  XIVE-IRQ 4866 Edge      virtio0-output.0
261:          0  XIVE-IRQ 4868 Edge      xhci_hcd
262:          0  XIVE-IRQ 4869 Edge      xhci_hcd
272:          1  XIVE-IRQ 4368 Edge      hvc_console
LOC:      10508   Local timer interrupts for timer event device
BCT:          0   Broadcast timer interrupts for timer event device
LOC:          0   Local timer interrupts for others
SPU:          5   Spurious interrupts
PMI:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
NMI:          0   System Reset interrupts
DBL:          0   Doorbell interrupts


and 7bfc759c02b8 "spapr/xive: add state synchronization with KVM" works:

           CPU0
 16:          0  XIVE-IPI   0 Edge      IPI
 19:          0  XIVE-IRQ 4610 Level     NPU Device
 20:          0  XIVE-IRQ 4611 Level     NPU Device
 21:          0  XIVE-IRQ 4096 Edge      RAS_EPOW
 22:          0  XIVE-IRQ 4097 Edge      RAS_HOTPLUG
257:      11833  XIVE-IRQ 4353 Edge      ibmvscsi
258:          0  XIVE-IRQ 4864 Edge      virtio0-config
259:       1632  XIVE-IRQ 4865 Edge      virtio0-input.0
260:          1  XIVE-IRQ 4866 Edge      virtio0-output.0
261:          0  XIVE-IRQ 4868 Edge      xhci_hcd
262:          0  XIVE-IRQ 4869 Edge      xhci_hcd
263:         60  XIVE-IRQ 4867 Edge      nvidia
272:          0  XIVE-IRQ 4368 Edge      hvc_console
LOC:       2236   Local timer interrupts for timer event device
BCT:          0   Broadcast timer interrupts for timer event device
LOC:          0   Local timer interrupts for others
SPU:          2   Spurious interrupts
PMI:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
NMI:          0   System Reset interrupts
DBL:          0   Doorbell interrupts



Here is the command line:

/home/aik/pbuild/qemu-aikrhel74alt-ppc64/ppc64-softmmu/qemu-system-ppc64 \
-nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline -nographic -vga none \
-enable-kvm \
-device nec-usb-xhci,id=nec-usb-xhci0 -m 16G \
-netdev "user,id=USER0,hostfwd=tcp::2223-:22" \
-device "virtio-net-pci,id=vnet0,mac=C0:41:49:4b:00:00,netdev=USER0" \
img/u1804-64G-cuda10.1-418.67-swiotlb.qcow2 \
-machine pseries,cap-cfpc=broken,cap-htm=off,ic-mode=xive \
-device "vfio-pci,id=vfio0006_00_00_1,host=0006:00:00.1" \
-device "vfio-pci,id=vfio0006_00_00_0,host=0006:00:00.0" \
-device "vfio-pci,id=vfio0004_04_00_0,host=0004:04:00.0" \
-kernel ./vmldbg -append "root=/dev/sda2 console=hvc0 debug loglevel=8" \
-snapshot \
-smp 1,threads=1 -bios ./slof.bin \
-L /home/aik/t/qemu-ppc64-bios/ \
-trace events=qemu_trace_events -d guest_errors \
-chardev socket,id=SOCKET0,server,nowait,path=qemu.mon.user2223.6_0_0_1 \
-mon chardev=SOCKET0,mode=control




> ---
>  hw/intc/spapr_xive_kvm.c    | 96 ++++++++++++++++++++++++++++++++++++-
>  include/hw/ppc/spapr_xive.h |  1 +
>  2 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 8dd4f96e0b..735577a6f8 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -433,9 +433,100 @@ static void kvmppc_xive_get_queues(SpaprXive *xive, Error **errp)
>      }
>  }
>  
> +/*
> + * The primary goal of the XIVE VM change handler is to mark the EQ
> + * pages dirty when all XIVE event notifications have stopped.
> + *
> + * Whenever the VM is stopped, the VM change handler sets the source
> + * PQs to PENDING to stop the flow of events and to possibly catch a
> + * triggered interrupt occuring while the VM is stopped. The previous
> + * state is saved in anticipation of a migration. The XIVE controller
> + * is then synced through KVM to flush any in-flight event
> + * notification and stabilize the EQs.
> + *
> + * At this stage, we can mark the EQ page dirty and let a migration
> + * sequence transfer the EQ pages to the destination, which is done
> + * just after the stop state.
> + *
> + * The previous configuration of the sources is restored when the VM
> + * runs again. If an interrupt was queued while the VM was stopped,
> + * simply generate a trigger.
> + */
> +static void kvmppc_xive_change_state_handler(void *opaque, int running,
> +                                             RunState state)
> +{
> +    SpaprXive *xive = opaque;
> +    XiveSource *xsrc = &xive->source;
> +    Error *local_err = NULL;
> +    int i;
> +
> +    /*
> +     * Restore the sources to their initial state. This is called when
> +     * the VM resumes after a stop or a migration.
> +     */
> +    if (running) {
> +        for (i = 0; i < xsrc->nr_irqs; i++) {
> +            uint8_t pq = xive_source_esb_get(xsrc, i);
> +            uint8_t old_pq;
> +
> +            old_pq = xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq << 8));
> +
> +            /*
> +             * An interrupt was queued while the VM was stopped,
> +             * generate a trigger.
> +             */
> +            if (pq == XIVE_ESB_RESET && old_pq == XIVE_ESB_QUEUED) {
> +                xive_esb_trigger(xsrc, i);
> +            }
> +        }
> +
> +        return;
> +    }
> +
> +    /*
> +     * Mask the sources, to stop the flow of event notifications, and
> +     * save the PQs locally in the XiveSource object. The XiveSource
> +     * state will be collected later on by its vmstate handler if a
> +     * migration is in progress.
> +     */
> +    for (i = 0; i < xsrc->nr_irqs; i++) {
> +        uint8_t pq = xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +
> +        /*
> +         * PQ is set to PENDING to possibly catch a triggered
> +         * interrupt occuring while the VM is stopped (hotplug event
> +         * for instance) .
> +         */
> +        if (pq != XIVE_ESB_OFF) {
> +            pq = xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_10);
> +        }
> +        xive_source_esb_set(xsrc, i, pq);
> +    }
> +
> +    /*
> +     * Sync the XIVE controller in KVM, to flush in-flight event
> +     * notification that should be enqueued in the EQs and mark the
> +     * XIVE EQ pages dirty to collect all updates.
> +     */
> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
> +                      KVM_DEV_XIVE_EQ_SYNC, NULL, true, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return;
> +    }
> +}
> +
>  void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
>  {
> -    kvmppc_xive_source_get_state(&xive->source);
> +    /*
> +     * When the VM is stopped, the sources are masked and the previous
> +     * state is saved in anticipation of a migration. We should not
> +     * synchronize the source state in that case else we will override
> +     * the saved state.
> +     */
> +    if (runstate_is_running()) {
> +        kvmppc_xive_source_get_state(&xive->source);
> +    }
>  
>      /* EAT: there is no extra state to query from KVM */
>  
> @@ -515,6 +606,9 @@ void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
>                                        "xive.tima", tima_len, xive->tm_mmap);
>      sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xive->tm_mmio);
>  
> +    xive->change = qemu_add_vm_change_state_handler(
> +        kvmppc_xive_change_state_handler, xive);
> +
>      kvm_kernel_irqchip = true;
>      kvm_msi_via_irqfd_allowed = true;
>      kvm_gsi_direct_mapping = true;
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 7e49badd8c..734662c12a 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -42,6 +42,7 @@ typedef struct SpaprXive {
>      /* KVM support */
>      int           fd;
>      void          *tm_mmap;
> +    VMChangeStateEntry *change;
>  } SpaprXive;
>  
>  /*
> 

-- 
Alexey

