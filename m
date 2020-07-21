Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3905C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 02:04:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1F1206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 02:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC5P2iCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1F1206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxhdn-0003Hu-KJ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 22:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxhdD-0002ru-1a
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 22:03:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25436
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jxhd9-00018x-JW
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 22:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595297021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkbNsfeRCFA0bvEFcgTB7aNur9wQlx++O4X/lrb1poo=;
 b=DC5P2iCO2HsOKapPcFTlZwTLIMOs+BYKzucbgwB0oHZOxXaVNsk/4qGjgoj62wuiZBaaYH
 5eeffQNlfWCnbqbrKCvMVdlKASQG7zyWtobmWbr65eC6OIa92r4OTJyUfWZRXsTWEBiDL/
 otlP8rQrzJYc01c04QMlQj+K09uC0A0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-qORXnMMFNJGh4zMAkOnl4Q-1; Mon, 20 Jul 2020 22:03:37 -0400
X-MC-Unique: qORXnMMFNJGh4zMAkOnl4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56A768005B0;
 Tue, 21 Jul 2020 02:03:35 +0000 (UTC)
Received: from [10.72.13.146] (ovpn-13-146.pek2.redhat.com [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70CEE5C22A;
 Tue, 21 Jul 2020 02:03:32 +0000 (UTC)
Subject: Re: [PATCH v2] e1000e: using bottom half to send packets
To: Li Qiang <liq3ea@163.com>, dmitry.fleytman@gmail.com, pbonzini@redhat.com
References: <20200720164535.76559-1-liq3ea@163.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <53b2e92c-e05b-46af-ffbc-a895a7cdcbe3@redhat.com>
Date: Tue, 21 Jul 2020 10:03:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720164535.76559-1-liq3ea@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 22:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alxndr@bu.edu, liq3ea@gmail.com, qemu-devel@nongnu.org, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/21 上午12:45, Li Qiang wrote:
> Alexander Bulekov reported a UAF bug related e1000e packets send.
>
> -->https://bugs.launchpad.net/qemu/+bug/1886362
>
> This is because the guest trigger a e1000e packet send and set the
> data's address to e1000e's MMIO address. So when the e1000e do DMA
> it will write the MMIO again and trigger re-entrancy and finally
> causes this UAF.
>
> Paolo suggested to use a bottom half whenever MMIO is doing complicate
> things in here:
> -->https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg03342.html
>
> Reference here:
> 'The easiest solution is to delay processing of descriptors to a bottom
> half whenever MMIO is doing something complicated.  This is also better
> for latency because it will free the vCPU thread more quickly and leave
> the work to the I/O thread.'
>
> This patch fixes this UAF.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> Change since v1:
> Per Jason's review here:
> -- https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05368.html
> 1. Cancel and schedule the tx bh when VM is stopped or resume
> 2. Add a tx_burst for e1000e configuration to throttle the bh execution
> 3. Add a tx_waiting to record whether the bh is pending or not
> Don't use BQL in the tx_bh handler as when tx_bh is executed, the BQL is
> acquired.
>
>   hw/net/e1000e.c      |   6 +++
>   hw/net/e1000e_core.c | 106 ++++++++++++++++++++++++++++++++++---------
>   hw/net/e1000e_core.h |   8 ++++
>   3 files changed, 98 insertions(+), 22 deletions(-)
>
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index fda34518c9..24e35a78bf 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -77,10 +77,14 @@ typedef struct E1000EState {
>   
>       bool disable_vnet;
>   
> +    int32_t tx_burst;
> +
>       E1000ECore core;
>   
>   } E1000EState;
>   
> +#define TX_BURST 256
> +
>   #define E1000E_MMIO_IDX     0
>   #define E1000E_FLASH_IDX    1
>   #define E1000E_IO_IDX       2
> @@ -263,6 +267,7 @@ static void e1000e_core_realize(E1000EState *s)
>   {
>       s->core.owner = &s->parent_obj;
>       s->core.owner_nic = s->nic;
> +    s->core.tx_burst = s->tx_burst;
>   }
>   
>   static void
> @@ -665,6 +670,7 @@ static Property e1000e_properties[] = {
>                           e1000e_prop_subsys_ven, uint16_t),
>       DEFINE_PROP_SIGNED("subsys", E1000EState, subsys, 0,
>                           e1000e_prop_subsys, uint16_t),
> +    DEFINE_PROP_INT32("x-txburst", E1000EState, tx_burst, TX_BURST),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index bcd186cac5..0a38a50cca 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -909,19 +909,18 @@ e1000e_rx_ring_init(E1000ECore *core, E1000E_RxRing *rxr, int idx)
>       rxr->i      = &i[idx];
>   }
>   
> -static void
> -e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
> +static int32_t
> +e1000e_start_xmit(struct e1000e_tx *q)
>   {
> +    E1000ECore *core = q->core;
>       dma_addr_t base;
>       struct e1000_tx_desc desc;
> -    bool ide = false;
> -    const E1000E_RingInfo *txi = txr->i;
> -    uint32_t cause = E1000_ICS_TXQE;
> +    const E1000E_RingInfo *txi;
> +    E1000E_TxRing txr;
> +    int32_t num_packets = 0;
>   
> -    if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
> -        trace_e1000e_tx_disabled();
> -        return;
> -    }
> +    e1000e_tx_ring_init(core, &txr, q - &core->tx[0]);
> +    txi = txr.i;
>   
>       while (!e1000e_ring_empty(core, txi)) {
>           base = e1000e_ring_head_descr(core, txi);
> @@ -931,15 +930,17 @@ e1000e_start_xmit(E1000ECore *core, const E1000E_TxRing *txr)
>           trace_e1000e_tx_descr((void *)(intptr_t)desc.buffer_addr,
>                                 desc.lower.data, desc.upper.data);
>   
> -        e1000e_process_tx_desc(core, txr->tx, &desc, txi->idx);
> -        cause |= e1000e_txdesc_writeback(core, base, &desc, &ide, txi->idx);
> +        e1000e_process_tx_desc(core, txr.tx, &desc, txi->idx);
> +        q->cause |= e1000e_txdesc_writeback(core, base, &desc,
> +                                            &q->ide, txi->idx);
>   
>           e1000e_ring_advance(core, txi, 1);
> +        if (++num_packets >= core->tx_burst) {
> +            break;
> +        }
>       }
>   
> -    if (!ide || !e1000e_intrmgr_delay_tx_causes(core, &cause)) {
> -        e1000e_set_interrupt_cause(core, cause);
> -    }
> +    return num_packets;
>   }
>   
>   static bool
> @@ -2423,32 +2424,41 @@ e1000e_set_dbal(E1000ECore *core, int index, uint32_t val)
>   static void
>   e1000e_set_tctl(E1000ECore *core, int index, uint32_t val)
>   {
> -    E1000E_TxRing txr;
>       core->mac[index] = val;
>   
>       if (core->mac[TARC0] & E1000_TARC_ENABLE) {
> -        e1000e_tx_ring_init(core, &txr, 0);
> -        e1000e_start_xmit(core, &txr);
> +        if (core->tx[0].tx_waiting) {
> +            return;
> +        }
> +        core->tx[0].tx_waiting = 1;
> +        if (!core->vm_running) {
> +            return;
> +        }
> +        qemu_bh_schedule(core->tx[0].tx_bh);
>       }
>   
>       if (core->mac[TARC1] & E1000_TARC_ENABLE) {
> -        e1000e_tx_ring_init(core, &txr, 1);
> -        e1000e_start_xmit(core, &txr);
> +        if (core->tx[1].tx_waiting) {
> +            return;
> +        }
> +        core->tx[1].tx_waiting = 1;
> +        if (!core->vm_running) {
> +            return;
> +        }
> +        qemu_bh_schedule(core->tx[1].tx_bh);
>       }
>   }
>   
>   static void
>   e1000e_set_tdt(E1000ECore *core, int index, uint32_t val)
>   {
> -    E1000E_TxRing txr;
>       int qidx = e1000e_mq_queue_idx(TDT, index);
>       uint32_t tarc_reg = (qidx == 0) ? TARC0 : TARC1;
>   
>       core->mac[index] = val & 0xffff;
>   
>       if (core->mac[tarc_reg] & E1000_TARC_ENABLE) {
> -        e1000e_tx_ring_init(core, &txr, qidx);
> -        e1000e_start_xmit(core, &txr);
> +        qemu_bh_schedule(core->tx[qidx].tx_bh);
>       }
>   }
>   
> @@ -3315,10 +3325,56 @@ e1000e_vm_state_change(void *opaque, int running, RunState state)
>           trace_e1000e_vm_state_running();
>           e1000e_intrmgr_resume(core);
>           e1000e_autoneg_resume(core);
> +        core->vm_running = 1;
> +
> +        for (int i = 0; i < E1000E_NUM_QUEUES; i++) {
> +            qemu_bh_schedule(core->tx[i].tx_bh);


I guess the reason for the unconditional scheduling of bh is to make 
sure tx work after live migration since we don't migrate tx_waiting.

If yes, better add a comment here. And do we need to clear tx_waiting here?


> +        }
> +
>       } else {
>           trace_e1000e_vm_state_stopped();
> +
> +        for (int i = 0; i < E1000E_NUM_QUEUES; i++) {
> +            qemu_bh_cancel(core->tx[i].tx_bh);
> +        }
> +
>           e1000e_autoneg_pause(core);
>           e1000e_intrmgr_pause(core);
> +        core->vm_running = 0;
> +    }
> +}
> +
> +
> +static void e1000e_core_tx_bh(void *opaque)
> +{
> +    struct e1000e_tx *q = opaque;
> +    E1000ECore *core = q->core;
> +    int32_t ret;
> +
> +    if (!core->vm_running) {
> +        assert(q->tx_waiting);
> +        return;
> +    }
> +
> +    q->tx_waiting = 0;
> +
> +    if (!(core->mac[TCTL] & E1000_TCTL_EN)) {
> +        trace_e1000e_tx_disabled();
> +        return;
> +    }
> +
> +    q->cause = E1000_ICS_TXQE;
> +    q->ide = false;
> +
> +    ret = e1000e_start_xmit(q);
> +    if (ret >= core->tx_burst) {
> +        qemu_bh_schedule(q->tx_bh);
> +        q->tx_waiting = 1;
> +        return;
> +    }
> +
> +    if (!q->ide || !e1000e_intrmgr_delay_tx_causes(core, &q->cause)) {
> +        e1000e_set_interrupt_cause(core, q->cause);


So I think this will cause some delay of the interrupt delivering. It 
looks to be it's better to leave the set ics in e1000e_start_xmit().


>       }
>   }
>   
> @@ -3334,12 +3390,15 @@ e1000e_core_pci_realize(E1000ECore     *core,
>                                          e1000e_autoneg_timer, core);
>       e1000e_intrmgr_pci_realize(core);
>   
> +    core->vm_running = runstate_is_running();
>       core->vmstate =
>           qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
>   
>       for (i = 0; i < E1000E_NUM_QUEUES; i++) {
>           net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
>                           E1000E_MAX_TX_FRAGS, core->has_vnet);
> +        core->tx[i].core = core;
> +        core->tx[i].tx_bh = qemu_bh_new(e1000e_core_tx_bh, &core->tx[i]);
>       }
>   
>       net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
> @@ -3367,6 +3426,9 @@ e1000e_core_pci_uninit(E1000ECore *core)
>       for (i = 0; i < E1000E_NUM_QUEUES; i++) {
>           net_tx_pkt_reset(core->tx[i].tx_pkt);
>           net_tx_pkt_uninit(core->tx[i].tx_pkt);
> +        qemu_bh_cancel(core->tx[i].tx_bh);
> +        qemu_bh_delete(core->tx[i].tx_bh);
> +        core->tx[i].tx_bh = NULL;
>       }
>   
>       net_rx_pkt_uninit(core->rx_pkt);
> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
> index aee32f7e48..0c16dce3a6 100644
> --- a/hw/net/e1000e_core.h
> +++ b/hw/net/e1000e_core.h
> @@ -77,10 +77,18 @@ struct E1000Core {
>           unsigned char sum_needed;
>           bool cptse;
>           struct NetTxPkt *tx_pkt;
> +        QEMUBH *tx_bh;
> +        uint32_t tx_waiting;
> +        uint32_t cause;
> +        bool ide;
> +        E1000ECore *core;
>       } tx[E1000E_NUM_QUEUES];
>   
>       struct NetRxPkt *rx_pkt;
>   
> +    int32_t tx_burst;
> +
> +    bool vm_running;
>       bool has_vnet;
>       int max_queue_num;
>   


Do we need to cancel the bh and reset tx_waiting in e1000e_core_reset()?

Thanks


