Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152DFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95F32083B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDNBpJOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95F32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Z5J-0000du-7U
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1Z4d-0008Ko-QK
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:44:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25888
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k1Z4c-00019f-3C
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596217440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQrR0mr70gNxWQkeLzRX4oFjJO6FR6n2lXH93Y4hnbo=;
 b=WDNBpJOLBsDrXJYEeA7fPA7u98O6qgC2CuG2Mr4hqVPrYbiH9rESBGU1IRFI9hEIQt30LK
 f7M4p2xpnLCtAnf+GdP9Ar2m83CG5tBnJjXI/a+z/g/dqtVxqlpbbe70IWxF2fNVZD4EEX
 DoBihKzW+5ID0oTcLILBAC5Es4QQa8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-5H4MC932OembPIiIdN_Lmw-1; Fri, 31 Jul 2020 13:43:56 -0400
X-MC-Unique: 5H4MC932OembPIiIdN_Lmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 227B718839D6;
 Fri, 31 Jul 2020 17:43:55 +0000 (UTC)
Received: from localhost (ovpn-120-33.rdu2.redhat.com [10.10.120.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAD4169500;
 Fri, 31 Jul 2020 17:43:54 +0000 (UTC)
Date: Fri, 31 Jul 2020 13:43:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH 1/2] hw/core: Add bql_interrupt flag to CPUClass
Message-ID: <20200731174353.GF225270@habkost.net>
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-2-robert.foley@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200731125127.30866-2-robert.foley@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 08:55:49
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
Cc: qemu-devel@nongnu.org, cota@braap.org, pbonzini@redhat.com,
 peter.puhov@linaro.org, alex.bennee@linaro.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 31, 2020 at 08:51:26AM -0400, Robert Foley wrote:
> The new flag bql_interrupt, allows the CPUClass to
> determine if the BQL should be held during calls to
> cpu_exec_interrupt or do_interrupt.
> 
> This is being added in preparation for changes in
> cpu_handle_interrupt, which will use this flag.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  hw/core/cpu.c         | 1 +
>  include/hw/core/cpu.h | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index 8707ce2c34..7ab88caa97 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -425,6 +425,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
>      k->cpu_exec_exit = cpu_common_noop;
>      k->cpu_exec_interrupt = cpu_common_exec_interrupt;
>      k->adjust_watchpoint_address = cpu_adjust_watchpoint_address;
> +    k->bql_interrupt = true;
>      set_bit(DEVICE_CATEGORY_CPU, dc->categories);
>      dc->realize = cpu_common_realizefn;
>      dc->unrealize = cpu_common_unrealizefn;
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 6a2c77682f..d2c426ee5d 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -157,6 +157,8 @@ struct TranslationBlock;
>   * @disas_set_info: Setup architecture specific components of disassembly info
>   * @adjust_watchpoint_address: Perform a target-specific adjustment to an
>   * address before attempting to match it against watchpoints.
> + * @bql_interrupt: Hold BQL while performing the cpu_exec_interrupt
> + *                 or do_interrupt call.
>   *
>   * Represents a CPU family or model.
>   */
> @@ -227,6 +229,7 @@ typedef struct CPUClass {
>      /* Keep non-pointer data at the end to minimize holes.  */
>      int gdb_num_core_regs;
>      bool gdb_stop_before_watchpoint;
> +    bool bql_interrupt;
>  } CPUClass;
>  
>  /*
> @@ -589,6 +592,11 @@ static inline void cpu_tb_jmp_cache_clear(CPUState *cpu)
>      }
>  }
>  
> +static inline void cpu_class_enable_bql_interrupt(CPUClass *cc)
> +{
> +    cc->bql_interrupt = true;
> +}

Class data is not supposed to change outside class_init.  Why do
you need this function?  I don't see it being used anywhere in
this series.

-- 
Eduardo


