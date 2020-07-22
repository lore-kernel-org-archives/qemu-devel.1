Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E46C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 05:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E80A20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 05:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HA9a9owj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E80A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy7dx-0001qe-Af
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 01:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jy7dF-0001RZ-3g
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 01:49:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jy7dB-0001z7-TX
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 01:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595396968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WxwSQHZF0Z5Fa7FbHhh4+eqPyx4S5zRqzKkNklvfWLQ=;
 b=HA9a9owj4a6EYoXr91oAucitrnyBWjIlUHMVhD7d3t1QOwEVmN0w477a5M41fw9sUKAyw3
 ZKp0/sESrib38vdPJD17S0LdqxLCiWTrrC9apI9eMDnnP9WsgT6JU3UfUnZXFkhwM1HINQ
 bp+XJmn+NufplRK/I1rAeRmDDG+RwNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-o65coMvOPt63yM1Bv1VNGg-1; Wed, 22 Jul 2020 01:49:21 -0400
X-MC-Unique: o65coMvOPt63yM1Bv1VNGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2145C8014D7;
 Wed, 22 Jul 2020 05:49:20 +0000 (UTC)
Received: from [10.72.13.156] (ovpn-13-156.pek2.redhat.com [10.72.13.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86A4F101E1BF;
 Wed, 22 Jul 2020 05:49:13 +0000 (UTC)
Subject: Re: [PATCH v3] e1000e: using bottom half to send packets
To: Li Qiang <liq3ea@gmail.com>
References: <20200721151728.112395-1-liq3ea@163.com>
 <307795f9-70bb-b83b-6110-da2c923e4dc2@redhat.com>
 <CAKXe6SL4bscJXYe3ybCvP2p9C+M4KcE8g8u36iShXNm_BqV-2w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d13466c3-f1f1-49bc-8583-fc85afd0be4a@redhat.com>
Date: Wed, 22 Jul 2020 13:49:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SL4bscJXYe3ybCvP2p9C+M4KcE8g8u36iShXNm_BqV-2w@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/22 下午12:47, Li Qiang wrote:
> Jason Wang <jasowang@redhat.com> 于2020年7月22日周三 上午11:32写道：
>>
>> On 2020/7/21 下午11:17, Li Qiang wrote:
>>> Alexander Bulekov reported a UAF bug related e1000e packets send.
>>>
>>> -->https://bugs.launchpad.net/qemu/+bug/1886362
>>>
>>> This is because the guest trigger a e1000e packet send and set the
>>> data's address to e1000e's MMIO address. So when the e1000e do DMA
>>> it will write the MMIO again and trigger re-entrancy and finally
>>> causes this UAF.
>>>
>>> Paolo suggested to use a bottom half whenever MMIO is doing complicate
>>> things in here:
>>> -->https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg03342.html
>>>
>>> Reference here:
>>> 'The easiest solution is to delay processing of descriptors to a bottom
>>> half whenever MMIO is doing something complicated.  This is also better
>>> for latency because it will free the vCPU thread more quickly and leave
>>> the work to the I/O thread.'
>>>
>>> This patch fixes this UAF.
>>>
>>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>>> Signed-off-by: Li Qiang <liq3ea@163.com>
>>> ---
>>> Change since v2:
>>> 1. Add comments for the tx bh schdule when VM resumes
>>> 2. Leave the set ics code in 'e1000e_start_xmit'
>>> 3. Cancel the tx bh and reset tx_waiting in e1000e_core_reset
>>
>> So based on our discussion this is probably not sufficient. It solves
>> the issue TX re-entrancy but not RX (e.g RX DMA to RDT?) Or is e1000e's
>> RX is reentrant?
>>
> It seems the RX has no reentrant issue if we address the TX reentrant issue.


Just to make sure I understand.

Did you mean

1) RX code is reentrant

or

2) the following can't happen

e1000_receive()
     e1000e_write_packet_to_guest()
         e1000e_write_to_rx_buffers()
             pci_dma_write()
                 ...
                     e1000e_set_rdt()
                         qemu_flush_queued_packets()
                             e1000e_receive()

?


> Though we can write the RX-related DMA register, then when we receive
> packets, we write to the MMIO with any data.
> However this is not different between the guest write any data to MMIO.
>
> I think we can hold on this patch and discuss more about this MMIO
> reentrant issue then make
> the decision.


Right, and we need start to think of how to do the test, e.g qtest?

Thanks


>
> Thanks,
> Li Qiang
>
>
>> Thanks
>>
>>
>>> Change since v1:
>>> Per Jason's review here:
>>> -- https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05368.html
>>> 1. Cancel and schedule the tx bh when VM is stopped or resume
>>> 2. Add a tx_burst for e1000e configuration to throttle the bh execution
>>> 3. Add a tx_waiting to record whether the bh is pending or not
>>> Don't use BQL in the tx_bh handler as when tx_bh is executed, the BQL is
>>> acquired.
>>>
>>>    hw/net/e1000e.c      |   6 +++
>>>    hw/net/e1000e_core.c | 107 +++++++++++++++++++++++++++++++++++--------
>>>    hw/net/e1000e_core.h |   8 ++++
>>>    3 files changed, 101 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
>>> index fda34518c9..24e35a78bf 100644
>>> --- a/hw/net/e1000e.c
>>> +++ b/hw/net/e1000e.c
>>> @@ -77,10 +77,14 @@ typedef struct E1000EState {
>>>
>>>        bool disable_vnet;
>>>
>>> +    int32_t tx_burst;
>>> +
>>>        E1000ECore core;
>>>
>>>    } E1000EState;
>>>
>>> +#define TX_BURST 256
>>> +
>>>    #define E1000E_MMIO_IDX     0
>>>    #define E1000E_FLASH_IDX    1
>>>    #define E1000E_IO_IDX       2
>>> @@ -263,6 +267,7 @@ static void e1000e_core_realize(E1000EState *s)
>>>    {
>>>        s->core.owner = &s->parent_obj;
>>>        s->core.owner_nic = s->nic;
>>> +    s->core.tx_burst = s->tx_burst;
>>>    }
>>>
>>>    static void
>>> @@ -665,6 +670,7 @@ static Property e1000e_properties[] = {
>>>                            e1000e_prop_subsys_ven, uint16_t),
>>>        DEFINE_PROP_SIGNED("subsys", E1000EState, subsys, 0,
>>>                            e1000e_prop_subsys, uint16_t),
>>> +    DEFINE_PROP_INT32("x-txburst", E1000EState, tx_burst, TX_BURST),
>>>        DEFINE_PROP_END_OF_LIST(),
>>>    };
>>>
>>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>>> index bcd186cac5..2fdfc23204 100644
>>> --- a/hw/net/e1000e_core.c
>>> +++ b/hw/net/e1000e_core.c
>>> @@ -910,18 +910,17 @@ e1000e_rx_ring_init(E1000ECore *core, E1000E_RxRing *rxr, int idx)
>>>    }
>>>
>>>    static void
>>> -e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
>>> +e1000e_start_xmit(struct e1000e_tx *q)
>>>    {
>>> +    E1000ECore *core = q->core;
>>>        dma_addr_t base;
>>>        struct e1000_tx_desc desc;
>>> -    bool ide = false;
>>> -    const E1000E_RingInfo *txi = txr->i;
>>> -    uint32_t cause = E1000_ICS_TXQE;
>>> +    const E1000E_RingInfo *txi;
>>> +    E1000E_TxRing txr;
>>> +    int32_t num_packets = 0;
>>>
>>> -    if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
>>> -        trace_e1000e_tx_disabled();
>>> -        return;
>>> -    }
>>> +    e1000e_tx_ring_init(core, &txr, q - &core->tx[0]);
>>> +    txi = txr.i;
>>>
>>>        while (!e1000e_ring_empty(core, txi)) {
>>>            base = e1000e_ring_head_descr(core, txi);
>>> @@ -931,14 +930,24 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
>>>            trace_e1000e_tx_descr((void *)(intptr_t)desc.buffer_addr,
>>>                                  desc.lower.data, desc.upper.data);
>>>
>>> -        e1000e_process_tx_desc(core, txr->tx, &desc, txi->idx);
>>> -        cause |= e1000e_txdesc_writeback(core, base, &desc, &ide, txi->idx);
>>> +        e1000e_process_tx_desc(core, txr.tx, &desc, txi->idx);
>>> +        q->cause |= e1000e_txdesc_writeback(core, base, &desc,
>>> +                                            &q->ide, txi->idx);
>>>
>>>            e1000e_ring_advance(core, txi, 1);
>>> +        if (++num_packets >= core->tx_burst) {
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    if (num_packets >= core->tx_burst) {
>>> +        qemu_bh_schedule(q->tx_bh);
>>> +        q->tx_waiting = 1;
>>> +        return;
>>>        }
>>>
>>> -    if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
>>> -        e1000e_set_interrupt_cause(core, cause);
>>> +    if (!q->ide || !e1000e_intrmgr_delay_tx_causes(core, &q->cause)) {
>>> +        e1000e_set_interrupt_cause(core, q->cause);
>>>        }
>>>    }
>>>
>>> @@ -2423,32 +2432,41 @@ e1000e_set_dbal(E1000ECore *core, int index, uint32_t val)
>>>    static void
>>>    e1000e_set_tctl(E1000ECore *core, int index, uint32_t val)
>>>    {
>>> -    E1000E_TxRing txr;
>>>        core->mac[index] = val;
>>>
>>>        if (core->mac[TARC0] & E1000_TARC_ENABLE) {
>>> -        e1000e_tx_ring_init(core, &txr, 0);
>>> -        e1000e_start_xmit(core, &txr);
>>> +        if (core->tx[0].tx_waiting) {
>>> +            return;
>>> +        }
>>> +        core->tx[0].tx_waiting = 1;
>>> +        if (!core->vm_running) {
>>> +            return;
>>> +        }
>>> +        qemu_bh_schedule(core->tx[0].tx_bh);
>>>        }
>>>
>>>        if (core->mac[TARC1] & E1000_TARC_ENABLE) {
>>> -        e1000e_tx_ring_init(core, &txr, 1);
>>> -        e1000e_start_xmit(core, &txr);
>>> +        if (core->tx[1].tx_waiting) {
>>> +            return;
>>> +        }
>>> +        core->tx[1].tx_waiting = 1;
>>> +        if (!core->vm_running) {
>>> +            return;
>>> +        }
>>> +        qemu_bh_schedule(core->tx[1].tx_bh);
>>>        }
>>>    }
>>>
>>>    static void
>>>    e1000e_set_tdt(E1000ECore *core, int index, uint32_t val)
>>>    {
>>> -    E1000E_TxRing txr;
>>>        int qidx = e1000e_mq_queue_idx(TDT, index);
>>>        uint32_t tarc_reg = (qidx == 0) ? TARC0 : TARC1;
>>>
>>>        core->mac[index] = val & 0xffff;
>>>
>>>        if (core->mac[tarc_reg] & E1000_TARC_ENABLE) {
>>> -        e1000e_tx_ring_init(core, &txr, qidx);
>>> -        e1000e_start_xmit(core, &txr);
>>> +        qemu_bh_schedule(core->tx[qidx].tx_bh);
>>>        }
>>>    }
>>>
>>> @@ -3315,11 +3333,52 @@ e1000e_vm_state_change(void *opaque, int running, RunState state)
>>>            trace_e1000e_vm_state_running();
>>>            e1000e_intrmgr_resume(core);
>>>            e1000e_autoneg_resume(core);
>>> +        core->vm_running = 1;
>>> +
>>> +        for (int i = 0; i < E1000E_NUM_QUEUES; i++) {
>>> +            /*
>>> +             * Schedule tx bh unconditionally to make sure
>>> +             * tx work after live migration since we don't
>>> +             * migrate tx_waiting.
>>> +             */
>>> +            qemu_bh_schedule(core->tx[i].tx_bh);
>>> +        }
>>> +
>>>        } else {
>>>            trace_e1000e_vm_state_stopped();
>>> +
>>> +        for (int i = 0; i < E1000E_NUM_QUEUES; i++) {
>>> +            qemu_bh_cancel(core->tx[i].tx_bh);
>>> +        }
>>> +
>>>            e1000e_autoneg_pause(core);
>>>            e1000e_intrmgr_pause(core);
>>> +        core->vm_running = 0;
>>> +    }
>>> +}
>>> +
>>> +
>>> +static void e1000e_core_tx_bh(void *opaque)
>>> +{
>>> +    struct e1000e_tx *q = opaque;
>>> +    E1000ECore *core = q->core;
>>> +
>>> +    if (!core->vm_running) {
>>> +        assert(q->tx_waiting);
>>> +        return;
>>> +    }
>>> +
>>> +    q->tx_waiting = 0;
>>> +
>>> +    if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
>>> +        trace_e1000e_tx_disabled();
>>> +        return;
>>>        }
>>> +
>>> +    q->cause = E1000_ICS_TXQE;
>>> +    q->ide = false;
>>> +
>>> +    e1000e_start_xmit(q);
>>>    }
>>>
>>>    void
>>> @@ -3334,12 +3393,15 @@ e1000e_core_pci_realize(E1000ECore     *core,
>>>                                           e1000e_autoneg_timer, core);
>>>        e1000e_intrmgr_pci_realize(core);
>>>
>>> +    core->vm_running = runstate_is_running();
>>>        core->vmstate =
>>>            qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
>>>
>>>        for (i = 0; i < E1000E_NUM_QUEUES; i++) {
>>>            net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
>>>                            E1000E_MAX_TX_FRAGS, core->has_vnet);
>>> +        core->tx[i].core = core;
>>> +        core->tx[i].tx_bh = qemu_bh_new(e1000e_core_tx_bh, &core->tx[i]);
>>>        }
>>>
>>>        net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
>>> @@ -3367,6 +3429,9 @@ e1000e_core_pci_uninit(E1000ECore *core)
>>>        for (i = 0; i < E1000E_NUM_QUEUES; i++) {
>>>            net_tx_pkt_reset(core->tx[i].tx_pkt);
>>>            net_tx_pkt_uninit(core->tx[i].tx_pkt);
>>> +        qemu_bh_cancel(core->tx[i].tx_bh);
>>> +        qemu_bh_delete(core->tx[i].tx_bh);
>>> +        core->tx[i].tx_bh = NULL;
>>>        }
>>>
>>>        net_rx_pkt_uninit(core->rx_pkt);
>>> @@ -3480,6 +3545,8 @@ e1000e_core_reset(E1000ECore *core)
>>>            net_tx_pkt_reset(core->tx[i].tx_pkt);
>>>            memset(&core->tx[i].props, 0, sizeof(core->tx[i].props));
>>>            core->tx[i].skip_cp = false;
>>> +        qemu_bh_cancel(core->tx[i].tx_bh);
>>> +        core->tx[i].tx_waiting = 0;
>>>        }
>>>    }
>>>
>>> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
>>> index aee32f7e48..0c16dce3a6 100644
>>> --- a/hw/net/e1000e_core.h
>>> +++ b/hw/net/e1000e_core.h
>>> @@ -77,10 +77,18 @@ struct E1000Core {
>>>            unsigned char sum_needed;
>>>            bool cptse;
>>>            struct NetTxPkt *tx_pkt;
>>> +        QEMUBH *tx_bh;
>>> +        uint32_t tx_waiting;
>>> +        uint32_t cause;
>>> +        bool ide;
>>> +        E1000ECore *core;
>>>        } tx[E1000E_NUM_QUEUES];
>>>
>>>        struct NetRxPkt *rx_pkt;
>>>
>>> +    int32_t tx_burst;
>>> +
>>> +    bool vm_running;
>>>        bool has_vnet;
>>>        int max_queue_num;
>>>


