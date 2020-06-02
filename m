Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E87C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03C52073B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MARswyJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03C52073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfwSv-0000fU-0l
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 22:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jfwSA-0000Bm-2s
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:14:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jfwS8-0001nW-KW
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591064095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTq8dNN1pvnR9ivxTSzhI6MMk3ub1rKt+JtuxqVe9AA=;
 b=MARswyJB1G41iLiW/YYpR7YxyOarQF4i/tDwSyOROzQe8+a+QEx/Hl3Vt8pcVCnFs+C8lH
 kJFJmGWYWETayLL9RWlWMbPq/IvFdp6I3mVETUccU3Zk9LSdr79B2dTaTEhw4RiNd8aZJz
 f6Mzhqo/AeOJ05Vb0sP3HUnEKtklvTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-rQDPjvx-MUuQUL8HsjDLBw-1; Mon, 01 Jun 2020 22:14:52 -0400
X-MC-Unique: rQDPjvx-MUuQUL8HsjDLBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBA421856948;
 Tue,  2 Jun 2020 02:14:51 +0000 (UTC)
Received: from [10.72.12.140] (ovpn-12-140.pek2.redhat.com [10.72.12.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25193D020D;
 Tue,  2 Jun 2020 02:14:49 +0000 (UTC)
Subject: Re: [PATCH 1/1] e1000e: Added ICR clearing by corresponding IMS bit.
To: Andrew Melnichenko <andrew@daynix.com>
References: <20200513113125.1465650-1-andrew@daynix.com>
 <20200513113125.1465650-2-andrew@daynix.com>
 <57ab1532-c3a6-e631-5b0e-e89fc4d82873@redhat.com>
 <7d8202a5-58ad-d7e9-db29-3316834547b8@redhat.com>
 <CABcq3pGy1yPiEusHnQMwFOwa3hbqXaMWGUi0TnrMLhetMXzq9w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <080ffdec-8fc3-f856-48d2-06c671ea900a@redhat.com>
Date: Tue, 2 Jun 2020 10:14:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABcq3pGy1yPiEusHnQMwFOwa3hbqXaMWGUi0TnrMLhetMXzq9w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 22:14:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


On 2020/6/2 上午12:47, Andrew Melnichenko wrote:
> As I understand it, the e1000e.c was implemented by 82574L 
> spec(https://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datasheet.pdf).
> In the same spec there is 10.2.4 paragraph which provides more details 
> when ICR should be cleared.
>
>     • Case 1 - Interrupt Mask register equals 0x0000 (mask all): ICR
>     content is cleared.
>     • Case 2 - Interrupt was asserted (ICR.INT_ASSERT=1) and auto mask
>     is active: ICR
>     content is cleared, and the IAM register is written to the IMC
>     register.
>     • Case 3 - Interrupt was not asserted (ICR.INT_ASSERT=0): Read has
>     no side affect.
>

Thanks for the pointer, so it looks to me the current implementation is 
fine ?

static uint32_t
e1000e_mac_icr_read(E1000ECore *core, int index)
{
     uint32_t ret = core->mac[ICR];
     trace_e1000e_irq_icr_read_entry(ret);

     if (core->mac[IMS] == 0) {
         trace_e1000e_irq_icr_clear_zero_ims();
         core->mac[ICR] = 0;
     }


// This is the case 1)


     if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
         (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
         trace_e1000e_irq_icr_clear_iame();
         core->mac[ICR] = 0;
         trace_e1000e_irq_icr_process_iame();
         e1000e_clear_ims_bits(core, core->mac[IAM]);
     }


// This is the case 2) and case 3)

     trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
     e1000e_update_interrupt_state(core);
     return ret;
}


Thanks


>
> On Fri, May 29, 2020 at 10:35 AM Jason Wang <jasowang@redhat.com 
> <mailto:jasowang@redhat.com>> wrote:
>
>
>     On 2020/5/29 下午3:18, Jason Wang wrote:
>     >
>     > On 2020/5/13 下午7:31, andrew@daynix.com
>     <mailto:andrew@daynix.com> wrote:
>     >> From: Andrew Melnychenko <andrew@daynix.com
>     <mailto:andrew@daynix.com>>
>     >>
>     >> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
>     >> Added ICR clearing if there is IMS bit - according to the note by
>     >> section 13.3.27 of the 8257X developers manual.
>     >>
>     >> Signed-off-by: Andrew Melnychenko <andrew@daynix.com
>     <mailto:andrew@daynix.com>>
>     >> ---
>     >>   hw/net/e1000e_core.c | 10 ++++++++++
>     >>   hw/net/trace-events  |  1 +
>     >>   2 files changed, 11 insertions(+)
>     >>
>     >> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>     >> index d5676871fa..10212d7932 100644
>     >> --- a/hw/net/e1000e_core.c
>     >> +++ b/hw/net/e1000e_core.c
>     >> @@ -2624,6 +2624,16 @@ e1000e_mac_icr_read(E1000ECore *core,
>     int index)
>     >>           e1000e_clear_ims_bits(core, core->mac[IAM]);
>     >>       }
>     >>   +    /*
>     >> +     * PCIe* GbE Controllers Open Source Software Developer's
>     Manual
>     >> +     * 13.3.27 Interrupt Cause Read Register
>     >> +     */
>     >> +    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
>     >> +        (core->mac[ICR] & core->mac[IMS])) {
>     >> + trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
>     >> core->mac[IMS]);
>     >> +        core->mac[ICR] = 0;
>     >> +    }
>     >> +
>     >
>     >
>     > Hi Andrew:
>     >
>     > So my comments still. I think we need to implement 82574l
>     behavior (if
>     > you go through e1000e.c all chapters it mentioned is for 82574l
>     > datasheet not the one you pointed to me).
>     >
>     > And actually the 82574l behavior is much more simpler.
>
>
>     To be more specific.
>
>     See chapter 7.4.5 which describes the ICR clearing.
>
>     It has three methods for clearing: auto-clear, clear-on-write and
>     clear-on-read.
>
>     And in the part of "Read to clear" it said:
>
>     """
>     All bits in the ICR register are cleared on a read to ICR.
>
>     """
>
>     So there's no need to IMS and other stuffs here.
>
>     Thanks
>
>
>     >
>     > Thanks
>


