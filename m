Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B956EC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8275E21848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="c55o6Zao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8275E21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4YJ-00038G-G4
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iT4Uh-0000Oz-Ck
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iT4Ug-0007oy-1b
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:40:07 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:57290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iT4Uf-0007n5-FG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:40:05 -0500
Received: from [192.168.61.102] (lfbn-1-8165-82.w90-112.abo.wanadoo.fr
 [90.112.74.82])
 by beetle.greensocs.com (Postfix) with ESMTPSA id BAC9F96EF0;
 Fri,  8 Nov 2019 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573220403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2toLd2TEwZcXSaypVMmHYEAHrK1ah4cuRlP4WOqdn4=;
 b=c55o6ZaoYUrZidniSgmQlmbnhyxl4M/PjKjj8Ux1bOESDpuCYEd6frEoMQs3JcHYDzc0h3
 gd44zjm1KAyNqPpplCe5SHlGoDM8UYfHeuf6r71Mgqc89hUIzHmPpyOZVxHfeb5VX4lrGa
 oKFNR/LTi/LCRtRZjwO/UKpLlp9GZuw=
Subject: Re: [PATCH] gdbstub: Fix buffer overflow in handle_read_all_regs
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191108125534.114474-1-damien.hedde@greensocs.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <e6ed119e-233c-a9a2-cd9e-e6c79d6d34ce@greensocs.com>
Date: Fri, 8 Nov 2019 14:40:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191108125534.114474-1-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573220403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2toLd2TEwZcXSaypVMmHYEAHrK1ah4cuRlP4WOqdn4=;
 b=6cvMUNiT2tLUi3p/vjMfIRW9RGIXIUTUStnfb92avuOY1o2Q2WdqUb8RvjqLQ0GATtUl0s
 TETutvzfLGl4QUHxIKuooHAIGqQ2FYh04748y8sCul2FEI3N+0uKkC240QS6LpLns94/aN
 ZNToHBrl9qg+Ks6oMFL+NlyGP1dkml8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573220403; a=rsa-sha256; cv=none;
 b=tCNTmnicPToZz0X/5vDn4+nb4OTVkx0RWAcS0I6uokLSDiGwnTeG+BJ25xidwRuQ6h/L2W
 dNPLUuFb+D950xd4IYO5kh3wYX4tLOGI7oXV5//513AZSdqdOx6Yl3RF/IkQCK+Zdn2XaI
 Jhk4Bz2ZU9tcLPE2827zHe+YDmlOP9A=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: alex.bennee@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/8/19 1:55 PM, Damien Hedde wrote:
> Ensure we don't put too much register data in buffers. This avoids
> a buffer overflow (and stack corruption) when a target has lots
> of registers.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
> 
> Hi all,
> 
> While working on a target with many registers. I found out the gdbstub
> may do buffer overflows when receiving a 'g' query (to read general
> registers). This patch prevents that.
> 
> Gdb is pretty happy with a partial set of registers and queries
> remaining registers one by one when needed.
> 
> Regards,
> Damien
> ---
>  gdbstub.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index 4cf8af365e..dde0cfe0fe 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1810,8 +1810,17 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
>      cpu_synchronize_state(gdb_ctx->s->g_cpu);
>      len = 0;
>      for (addr = 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
> -        len += gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf + len,
> -                                 addr);
> +        int size = gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf + len,
> +                                     addr);
> +        if (len + size > MAX_PACKET_LENGTH / 2) {
> +            /*
> +             * Prevent gdb_ctx->str_buf overflow in memtohex() below.
> +             * As a consequence, send only the first registers content.
> +             * Gdb will query remaining ones if/when needed.
> +             */
I could not find this behaviour documented in the GDB remote protocol
documentation. However in the GDB source code (in process_g_packet() in
remote.c) :

  /* If this is smaller than we guessed the 'g' packet would be,
     update our records.  A 'g' reply that doesn't include a register's
     value implies either that the register is not available, or that
     the 'p' packet must be used.  */


So:

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> +            break;
> +        }
> +        len += size;
>      }
>  
>      memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
> 

