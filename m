Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAB6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743FD2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idPbmEcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743FD2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZK3-0000Qx-LH
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jeZIA-0006cx-7V
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:18:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jeZHj-0007Rr-R0
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590736710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuaqtisDSBKm7YZLwfnfdtBwnrjw4+rbSUpEYkq4uh0=;
 b=idPbmEcB2Aerk0hjGahmIM49/m2qa9wFQqhrcbhw9wUmfrGk8X25mdOzh/53oLk/dKZ5Fa
 6EP+TucyVfRKNvj+4B6g+wdv3hCJ/z1A3l63zkEzac27qpmlnYy87krXcHoJ7z3f775zvw
 l28JgAu0AcAOWus4UCpa7mzPJZvDEqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-zm4RX5xZOqKkkL3JHEzapA-1; Fri, 29 May 2020 03:18:28 -0400
X-MC-Unique: zm4RX5xZOqKkkL3JHEzapA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4E2980183C;
 Fri, 29 May 2020 07:18:27 +0000 (UTC)
Received: from [10.72.13.231] (ovpn-13-231.pek2.redhat.com [10.72.13.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 725B72E020;
 Fri, 29 May 2020 07:18:26 +0000 (UTC)
Subject: Re: [PATCH 1/1] e1000e: Added ICR clearing by corresponding IMS bit.
To: andrew@daynix.com, qemu-devel@nongnu.org
References: <20200513113125.1465650-1-andrew@daynix.com>
 <20200513113125.1465650-2-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <57ab1532-c3a6-e631-5b0e-e89fc4d82873@redhat.com>
Date: Fri, 29 May 2020 15:18:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513113125.1465650-2-andrew@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/13 下午7:31, andrew@daynix.com wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
> Added ICR clearing if there is IMS bit - according to the note by
> section 13.3.27 of the 8257X developers manual.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   hw/net/e1000e_core.c | 10 ++++++++++
>   hw/net/trace-events  |  1 +
>   2 files changed, 11 insertions(+)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index d5676871fa..10212d7932 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2624,6 +2624,16 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
>           e1000e_clear_ims_bits(core, core->mac[IAM]);
>       }
>   
> +    /*
> +     * PCIe* GbE Controllers Open Source Software Developer's Manual
> +     * 13.3.27 Interrupt Cause Read Register
> +     */
> +    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
> +        (core->mac[ICR] & core->mac[IMS])) {
> +        trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR], core->mac[IMS]);
> +        core->mac[ICR] = 0;
> +    }
> +


Hi Andrew:

So my comments still. I think we need to implement 82574l behavior (if 
you go through e1000e.c all chapters it mentioned is for 82574l 
datasheet not the one you pointed to me).

And actually the 82574l behavior is much more simpler.

Thanks


>       trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
>       e1000e_update_interrupt_state(core);
>       return ret;
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index e18f883cfd..46e40fcfa9 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(uint32_t icr) "Starting ICR read. Current ICR: 0x%x"
>   e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read. Current ICR: 0x%x"
>   e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
>   e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
> +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
>   e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
>   e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
>   e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write 0x%x"


