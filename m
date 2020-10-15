Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EC4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA262076A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA262076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTBla-0008OF-CR
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 18:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kTBkm-0007xL-3q; Thu, 15 Oct 2020 18:29:44 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:40715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kTBkk-000142-0B; Thu, 15 Oct 2020 18:29:43 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.13])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 2A7D8663D038;
 Fri, 16 Oct 2020 00:29:37 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 16 Oct
 2020 00:29:36 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003af4abcb0-331d-4217-b443-42e7536bbde6,
 5A607CA2FDFC15889347860E260273CBCC5C5388) smtp.auth=groug@kaod.org
Date: Fri, 16 Oct 2020 00:29:34 +0200
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] ppc/spapr: re-assert IRQs during event-scan if there
 are pending
Message-ID: <20201016002934.400992c9@bahia.lan>
In-Reply-To: <20201015210318.117386-1-lvivier@redhat.com>
References: <20201015210318.117386-1-lvivier@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: e4aad456-81cd-4bd1-834b-fd0bc1d860e3
X-Ovh-Tracer-Id: 14794324776044567008
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedutdeijeejveehkeeileetgfelteekteehtedtieefffevhffflefftdefleejnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 18:29:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Oct 2020 23:03:18 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> If we hotplug a CPU during the first second of the kernel boot,
> the IRQ can be sent to the kernel while the RTAS event handler
> is not installed. The event is queued, but the kernel doesn't
> collect it and ignores the new CPU.
> 
> As the code relies on edge-triggered IRQ, we can re-assert it
> during the event-scan RTAS call if there are still pending
> events (as it is already done in check-exception).
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Any BugId to share ?

>  hw/ppc/spapr_events.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index 1069d0197b4f..1add53547ec3 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -1000,10 +1000,22 @@ static void event_scan(PowerPCCPU *cpu, SpaprMachineState *spapr,
>                         target_ulong args,
>                         uint32_t nret, target_ulong rets)
>  {
> +    int i;
>      if (nargs != 4 || nret != 1) {
>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>          return;
>      }
> +
> +    for (i = 0; i < EVENT_CLASS_MAX; i++) {
> +        if (rtas_event_log_contains(EVENT_CLASS_MASK(i))) {
> +            const SpaprEventSource *source =
> +                spapr_event_sources_get_source(spapr->event_sources, i);
> +
> +            g_assert(source->enabled);
> +            qemu_irq_pulse(spapr_qirq(spapr, source->irq));
> +        }
> +    }
> +

This looks good but any reason for not putting this in a function called by
both event_scan() and check_exception() ?

Anyway, this can be done as a follow-up:

Reviewed-by: Greg Kurz <groug@kaod.org>

>      rtas_st(rets, 0, RTAS_OUT_NO_ERRORS_FOUND);
>  }
>  


