Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2216C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4C7206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPUs5ejF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4C7206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLhC-0005rl-Ej
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYLgN-0005CN-Lf
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:34:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jYLgM-0001h1-E7
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589254453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ywAz4mxLcotE5cqpBnbqzSyVB/bG3cN8GlfgNmkNBM=;
 b=iPUs5ejFz6K3zIaq+ZS0UPc4Kl8YAM0Z4ZyRkmic6iy+ZPWueyMGC2FM4AFitFQqnFN+vP
 JqtH4fHqwvk0JpYx+XPEQ6z1NlWb9THV6KpNSnQx2UKiCJWXLicS4h/7tuUlWY66BTCC+x
 pAv22Qv8qA0F/k3PUM8eOreSuQm2wbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-IC0Qu31ePqyX9woCiAD0yw-1; Mon, 11 May 2020 23:34:09 -0400
X-MC-Unique: IC0Qu31ePqyX9woCiAD0yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F3B4108C310;
 Tue, 12 May 2020 03:34:08 +0000 (UTC)
Received: from [10.72.13.96] (ovpn-13-96.pek2.redhat.com [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19BAD60C87;
 Tue, 12 May 2020 03:34:06 +0000 (UTC)
Subject: Re: [PATCH v2] e1000e: Added ICR clearing by corresponding IMS bit.
To: Andrew Melnichenko <andrew@daynix.com>
References: <20200506212645.894533-1-andrew@daynix.com>
 <b67e29f9-a904-242f-9df2-801410f07aba@redhat.com>
 <CABcq3pEicPdvMDAC7v_ns_YasCBvc8o-3-6vOb=+mTfXzvTJeQ@mail.gmail.com>
 <53be0d4e-214d-dc9c-58a4-0bbd9c46b78f@redhat.com>
 <CABcq3pGvAdXazPs-91F=seUQxv3VUNVwbFOrQ42CBSLSwMw_Kg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <910f7851-3876-2753-08e7-67adbf64fe21@redhat.com>
Date: Tue, 12 May 2020 11:34:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABcq3pGvAdXazPs-91F=seUQxv3VUNVwbFOrQ42CBSLSwMw_Kg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 21:14:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: dmitry.fleytman@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/11 下午6:08, Andrew Melnichenko wrote:
> Yo,
>
>     So I think we should implement the 82574l behavior?
>
>  Well, as I understand it - its already implemented. I've added ICR 
> clearance if ICR & IMS(also need to add ICR_ASSERTED check, my bad, 
> I'll prepare new patch).


Yes, but it behave more like e.g 82573 not what we claim to emulate like 
82574l.


>
> At first, I had hacks to clear 'msi_causes_pending' at 
> 'e1000e_core_set_link_status()' before link down. It works but it's 
> not a solution.
> Also, on Windows the bug doesn't reproduce. I've traced Windows and 
> Linux - the difference that Windows driver clears pending by writing 
> to ICR, where Linux tries to clear by reading it.
> I had another possible fix - for Linux driver(writing to ICR at 
> interrupt routine).
> I've asked intel guys, does Linux driver works with a device(I don't 
> have real one). Thay said that it works and suggested to check 8257x 
> spec. I'll forward the message to you.


Ok.

Thanks


>
> On Sat, May 9, 2020 at 9:02 AM Jason Wang <jasowang@redhat.com 
> <mailto:jasowang@redhat.com>> wrote:
>
>
>     On 2020/5/9 上午2:13, Andrew Melnichenko wrote:
>     > Yo, I've used OpenSDM_8257x-18.pdf specification.
>     > This document was recommended by Intel guys(Also, they
>     referenced to
>     > that note).
>     > I've made a fast fix and it works. Before that I had a fix for
>     Linux
>     > e1000e driver.
>     > Overall, the issue was in pending interrupts that can't be
>     cleared by
>     > reading ICR in Linux(Windows driver clears by writing to ICR).
>     >
>     > You can download spec for example from:
>     >
>     http://iweb.dl.sourceforge.net/project/e1000/8257x%20Developer%20Manual/Revision%201.8/OpenSDM_8257x-18.pdf
>
>
>     Interesting, this spec doesn't include 82574l which is what e1000e
>     claims to emulate:
>
>          c->vendor_id = PCI_VENDOR_ID_INTEL;
>          c->device_id = E1000_DEV_ID_82574L;
>
>     Looking at 82574l spec (using the link mentioned in
>     e1000e_core.c), it
>     said (7.4.3):
>
>     In MSI-X mode the bits in this register can be configured to
>     auto-clear
>     when the MSI-X
>     interrupt message is sent, in order to minimize driver overhead, and
>     when using MSI-X
>     interrupt signaling.
>     In systems that do not support MSI-X, reading the ICR register clears
>     it's bits or writing
>     1b's clears the corresponding bits in this register.
>
>     So the auto clear is under the control of EIAC (MSIX) or
>     unconditionally
>     (non MSI-X).
>
>     But what has been implemented in e1000e_mac_icr_read() is something
>     similar to the behavior of non 82574l card.
>
>     So I think we should implement the 82574l behavior?
>
>     Thanks
>
>
>     >
>     > On Fri, May 8, 2020 at 5:21 AM Jason Wang <jasowang@redhat.com
>     <mailto:jasowang@redhat.com>
>     > <mailto:jasowang@redhat.com <mailto:jasowang@redhat.com>>> wrote:
>     >
>     >
>     >     On 2020/5/7 上午5:26, andrew@daynix.com
>     <mailto:andrew@daynix.com> <mailto:andrew@daynix.com
>     <mailto:andrew@daynix.com>>
>     >     wrote:
>     >     > From: Andrew Melnychenko <andrew@daynix.com
>     <mailto:andrew@daynix.com>
>     >     <mailto:andrew@daynix.com <mailto:andrew@daynix.com>>>
>     >     >
>     >     > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
>     >     > Added ICR clearing if there is IMS bit - according to the
>     note by
>     >     > section 13.3.27 of the 8257X developers manual.
>     >     >
>     >     > Signed-off-by: Andrew Melnychenko <andrew@daynix.com
>     <mailto:andrew@daynix.com>
>     >     <mailto:andrew@daynix.com <mailto:andrew@daynix.com>>>
>     >     > ---
>     >     >   hw/net/e1000e_core.c | 9 +++++++++
>     >     >   hw/net/trace-events  | 1 +
>     >     >   2 files changed, 10 insertions(+)
>     >     >
>     >     > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>     >     > index d5676871fa..302e99ff46 100644
>     >     > --- a/hw/net/e1000e_core.c
>     >     > +++ b/hw/net/e1000e_core.c
>     >     > @@ -2624,6 +2624,15 @@ e1000e_mac_icr_read(E1000ECore
>     *core, int
>     >     index)
>     >     >           e1000e_clear_ims_bits(core, core->mac[IAM]);
>     >     >       }
>     >     >
>     >     > +    /*
>     >     > +     * PCIe* GbE Controllers Open Source Software Developer's
>     >     Manual
>     >     > +     * 13.3.27 Interrupt Cause Read Register
>     >     > +     */
>     >
>     >
>     >     Hi Andrew:
>     >
>     >     Which version of the manual did you use? I try to use the one
>     >     mentioned
>     >     in e1000e.c which is
>     >
>     http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf.
>     >
>     >     But I couldn't find chapter 13.3.27.
>     >
>     >     Thanks
>     >
>     >
>     >     > +    if (core->mac[ICR] & core->mac[IMS]) {
>     >     > + trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
>     >     core->mac[IMS]);
>     >     > +        core->mac[ICR] = 0;
>     >     > +    }
>     >     > +
>     >     >  trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
>     >     >       e1000e_update_interrupt_state(core);
>     >     >       return ret;
>     >     > diff --git a/hw/net/trace-events b/hw/net/trace-events
>     >     > index e18f883cfd..46e40fcfa9 100644
>     >     > --- a/hw/net/trace-events
>     >     > +++ b/hw/net/trace-events
>     >     > @@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(uint32_t icr)
>     >     "Starting ICR read. Current ICR: 0x%x"
>     >     >   e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read.
>     >     Current ICR: 0x%x"
>     >     >   e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on
>     read due
>     >     to zero IMS"
>     >     >   e1000e_irq_icr_clear_iame(void) "Clearing ICR on read
>     due to IAME"
>     >     > +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims)
>     >     "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
>     >     >   e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause)
>     >     "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
>     >     >   e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac)
>     >     "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
>     >     >   e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS
>     bits
>     >     due to IMC write 0x%x"
>     >
>


