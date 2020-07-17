Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95D6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 03:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F8A2070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 03:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QT39JeKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F8A2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwGmZ-00053x-Qf
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 23:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwGly-0004dv-Tj
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 23:10:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jwGlv-0002Ew-M6
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 23:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594955449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=senjhGnYP6x3JOOdBGMC+rZzVHwyJQHsFBFRCWwpvE4=;
 b=QT39JeKOFXiRBC/cIDxq47T3AYfZmCl/cTscK5EiMUvBGffeFljgRs2eszqoAB7XCietde
 frgk6vQcz1NfZe5K9X/3NpjY4sbPvW88P3eFusSuTIaWBQ6fOZVcSuPq0T9YuXmxlgEl7y
 TayLdM+/0Xdw4r1md20gRlCLgjLM7z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-I4xehnm5N-Wj2BOm4PeWww-1; Thu, 16 Jul 2020 23:10:45 -0400
X-MC-Unique: I4xehnm5N-Wj2BOm4PeWww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B19538014D4;
 Fri, 17 Jul 2020 03:10:43 +0000 (UTC)
Received: from [10.72.12.157] (ovpn-12-157.pek2.redhat.com [10.72.12.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3C6772AC8;
 Fri, 17 Jul 2020 03:10:31 +0000 (UTC)
Subject: Re: [PATCH] e1000e: using bottom half to send packets
To: Li Qiang <liq3ea@163.com>, dmitry.fleytman@gmail.com,
 pbonzini@redhat.com, mst@redhat.com
References: <20200716161453.61295-1-liq3ea@163.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <281e3c85-b8eb-0c3e-afc3-41011861b8ea@redhat.com>
Date: Fri, 17 Jul 2020 11:10:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716161453.61295-1-liq3ea@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:10:49
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/17 上午12:14, Li Qiang wrote:
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


I think several things were missed in this patch (take virtio-net as a 
reference), do we need the following things:

- Cancel the bh when VM is stopped.
- A throttle to prevent bh from executing too much timer?
- A flag to record whether or not this a pending tx (and migrate it?)

Thanks


>
> This patch fixes this UAF.
>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   hw/net/e1000e_core.c | 25 +++++++++++++++++--------
>   hw/net/e1000e_core.h |  2 ++
>   2 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index bcd186cac5..6165b04b68 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2423,32 +2423,27 @@ e1000e_set_dbal(E1000ECore *core, int index, uint32_t val)
>   static void
>   e1000e_set_tctl(E1000ECore *core, int index, uint32_t val)
>   {
> -    E1000E_TxRing txr;
>       core->mac[index] = val;
>   
>       if (core->mac[TARC0] & E1000_TARC_ENABLE) {
> -        e1000e_tx_ring_init(core, &txr, 0);
> -        e1000e_start_xmit(core, &txr);
> +        qemu_bh_schedule(core->tx[0].tx_bh);
>       }
>   
>       if (core->mac[TARC1] & E1000_TARC_ENABLE) {
> -        e1000e_tx_ring_init(core, &txr, 1);
> -        e1000e_start_xmit(core, &txr);
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
> @@ -3322,6 +3317,16 @@ e1000e_vm_state_change(void *opaque, int running, RunState state)
>       }
>   }
>   
> +static void e1000e_core_tx_bh(void *opaque)
> +{
> +    struct e1000e_tx *tx = opaque;
> +    E1000ECore *core = tx->core;
> +    E1000E_TxRing txr;
> +
> +    e1000e_tx_ring_init(core, &txr, tx - &core->tx[0]);
> +    e1000e_start_xmit(core, &txr);
> +}
> +
>   void
>   e1000e_core_pci_realize(E1000ECore     *core,
>                           const uint16_t *eeprom_templ,
> @@ -3340,6 +3345,8 @@ e1000e_core_pci_realize(E1000ECore     *core,
>       for (i = 0; i < E1000E_NUM_QUEUES; i++) {
>           net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
>                           E1000E_MAX_TX_FRAGS, core->has_vnet);
> +        core->tx[i].core = core;
> +        core->tx[i].tx_bh = qemu_bh_new(e1000e_core_tx_bh, &core->tx[i]);
>       }
>   
>       net_rx_pkt_init(&core->rx_pkt, core->has_vnet);
> @@ -3367,6 +3374,8 @@ e1000e_core_pci_uninit(E1000ECore *core)
>       for (i = 0; i < E1000E_NUM_QUEUES; i++) {
>           net_tx_pkt_reset(core->tx[i].tx_pkt);
>           net_tx_pkt_uninit(core->tx[i].tx_pkt);
> +        qemu_bh_delete(core->tx[i].tx_bh);
> +        core->tx[i].tx_bh = NULL;
>       }
>   
>       net_rx_pkt_uninit(core->rx_pkt);
> diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
> index aee32f7e48..94ddc6afc2 100644
> --- a/hw/net/e1000e_core.h
> +++ b/hw/net/e1000e_core.h
> @@ -77,6 +77,8 @@ struct E1000Core {
>           unsigned char sum_needed;
>           bool cptse;
>           struct NetTxPkt *tx_pkt;
> +        QEMUBH *tx_bh;
> +        E1000ECore *core;
>       } tx[E1000E_NUM_QUEUES];
>   
>       struct NetRxPkt *rx_pkt;


