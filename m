Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998C1C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A292070B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+Sk2T4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A292070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWsfZ-0003z0-KO
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 22:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWsdq-0001Jg-4u
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:21:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWsdo-0005yI-8l
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588904490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMtBd7a6jRkoEAXoNoNYhpGcRh9gUtiF93bDV/X8pu4=;
 b=Z+Sk2T4sXAJYxz040IPfR+t9RK4zjmqhZ4j+pLFpyQjmjK35buLPuuk2W5MwJXhM7/uuV3
 N2o3Jk1S/1DVw7q7/ZRQoiNGGQ6rIyXgtGtWiE6dM1EdARqy1iVduTdwAKTSpV7nFaaStT
 u2HwsbUVw/sh0JLN4BGkI0UbPRv48nE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-0SK9oC_8PQ-Z3tKmkJit4Q-1; Thu, 07 May 2020 22:21:25 -0400
X-MC-Unique: 0SK9oC_8PQ-Z3tKmkJit4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59702474;
 Fri,  8 May 2020 02:21:24 +0000 (UTC)
Received: from [10.72.13.98] (ovpn-13-98.pek2.redhat.com [10.72.13.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 199BC60BF1;
 Fri,  8 May 2020 02:21:22 +0000 (UTC)
Subject: Re: [PATCH v2] e1000e: Added ICR clearing by corresponding IMS bit.
To: andrew@daynix.com, qemu-devel@nongnu.org
References: <20200506212645.894533-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b67e29f9-a904-242f-9df2-801410f07aba@redhat.com>
Date: Fri, 8 May 2020 10:21:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506212645.894533-1-andrew@daynix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 22:21:30
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
Cc: dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/7 =E4=B8=8A=E5=8D=885:26, andrew@daynix.com wrote:
> From: Andrew Melnychenko <andrew@daynix.com>
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1707441
> Added ICR clearing if there is IMS bit - according to the note by
> section 13.3.27 of the 8257X developers manual.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   hw/net/e1000e_core.c | 9 +++++++++
>   hw/net/trace-events  | 1 +
>   2 files changed, 10 insertions(+)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index d5676871fa..302e99ff46 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2624,6 +2624,15 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
>           e1000e_clear_ims_bits(core, core->mac[IAM]);
>       }
>  =20
> +    /*
> +     * PCIe* GbE Controllers Open Source Software Developer's Manual
> +     * 13.3.27 Interrupt Cause Read Register
> +     */


Hi Andrew:

Which version of the manual did you use? I try to use the one mentioned=20
in e1000e.c which is=20
http://www.intel.com/content/dam/doc/datasheet/82574l-gbe-controller-datash=
eet.pdf.

But I couldn't find chapter 13.3.27.

Thanks


> +    if (core->mac[ICR] & core->mac[IMS]) {
> +        trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR], core->mac=
[IMS]);
> +        core->mac[ICR] =3D 0;
> +    }
> +
>       trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
>       e1000e_update_interrupt_state(core);
>       return ret;
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index e18f883cfd..46e40fcfa9 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(uint32_t icr) "Starting ICR=
 read. Current ICR: 0x%x"
>   e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read. Current ICR: 0=
x%x"
>   e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero I=
MS"
>   e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
> +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing I=
CR on read due corresponding IMS bit: 0x%x & 0x%x"
>   e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS =
due to EIAME, IAM: 0x%X, cause: 0x%X"
>   e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bi=
ts due to EIAC, ICR: 0x%X, EIAC: 0x%X"
>   e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IM=
C write 0x%x"


