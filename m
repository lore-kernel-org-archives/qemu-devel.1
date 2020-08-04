Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5438BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280D12067C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAhEer6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280D12067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uzR-0007zU-CQ
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 07:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2uyq-0007Uk-3Y
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 07:19:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28966
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2uyo-0007DP-Js
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 07:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596539978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XNtbkgv8HBFaUnPCD0Ol5CUWRLMQoRwdyIhYiRNmD30=;
 b=CAhEer6qyk/K78TVNjOHuclrAwIt1Mz95PJLv4D0e2kXQMaLL+y6SNi8pKdf2aAFDTvKe7
 tN4URx6EqvqMW57SENVIkBR4V4QOUsOX6qaU/aZUVeKQd1UqTMGMVWKQSzNYKJw5Eo9hwL
 dK1mF6kNroHay5uDWiM7hm4Y1RqRVj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-KKTiRbyXP_SNc6XLBcK6rg-1; Tue, 04 Aug 2020 07:19:34 -0400
X-MC-Unique: KKTiRbyXP_SNc6XLBcK6rg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44BBC1083E80;
 Tue,  4 Aug 2020 11:19:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14E9810013D0;
 Tue,  4 Aug 2020 11:19:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B90081141D60; Tue,  4 Aug 2020 13:19:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v6 01/12] monitor: Add Monitor parameter to
 monitor_set_cpu()
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-2-kwolf@redhat.com>
Date: Tue, 04 Aug 2020 13:19:31 +0200
In-Reply-To: <20200528153742.274164-2-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 28 May 2020 17:37:31 +0200")
Message-ID: <87bljqd5fg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Most callers actually don't have to rely on cur_mon, but already know
> for which monitor they call monitor_set_cpu().
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/monitor/monitor.h |  2 +-
>  monitor/hmp-cmds.c        |  2 +-
>  monitor/misc.c            | 10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 1018d754a6..0dcaefd4f9 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -33,7 +33,7 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
>      GCC_FMT_ATTR(2, 0);
>  int monitor_printf(Monitor *mon, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
>  void monitor_flush(Monitor *mon);
> -int monitor_set_cpu(int cpu_index);
> +int monitor_set_cpu(Monitor *mon, int cpu_index);
>  int monitor_get_cpu_index(void);

monitor_set_cpu() now takes a Monitor * argument, while
monitor_get_cpu_index() continues to assume cur_mon.  Not wrong, but the
asymmetry bothers me.

Both callers of the latter look like they could easily pass a Monitor *
argument.  What do you think?

>  
>  void monitor_read_command(MonitorHMP *mon, int show_prompt);
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 9c61e769ca..5e22ee2556 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -969,7 +969,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
>      /* XXX: drop the monitor_set_cpu() usage when all HMP commands that
>              use it are converted to the QAPI */
>      cpu_index = qdict_get_int(qdict, "index");
> -    if (monitor_set_cpu(cpu_index) < 0) {
> +    if (monitor_set_cpu(mon, cpu_index) < 0) {
>          monitor_printf(mon, "invalid CPU index\n");
>      }
>  }
> diff --git a/monitor/misc.c b/monitor/misc.c
> index f5207cd242..bdf49e49e5 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -130,7 +130,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      cur_mon = &hmp.common;
>  
>      if (has_cpu_index) {
> -        int ret = monitor_set_cpu(cpu_index);
> +        int ret = monitor_set_cpu(&hmp.common, cpu_index);
>          if (ret < 0) {
>              cur_mon = old_mon;
>              error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
> @@ -256,7 +256,7 @@ static void monitor_init_qmp_commands(void)
>  }
>  
>  /* Set the current CPU defined by the user. Callers must hold BQL. */
> -int monitor_set_cpu(int cpu_index)
> +int monitor_set_cpu(Monitor *mon, int cpu_index)
>  {
>      CPUState *cpu;
>  
> @@ -264,8 +264,8 @@ int monitor_set_cpu(int cpu_index)
>      if (cpu == NULL) {
>          return -1;
>      }
> -    g_free(cur_mon->mon_cpu_path);
> -    cur_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
> +    g_free(mon->mon_cpu_path);
> +    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
>      return 0;
>  }
>  
> @@ -286,7 +286,7 @@ static CPUState *mon_get_cpu_sync(bool synchronize)
>          if (!first_cpu) {
>              return NULL;
>          }
> -        monitor_set_cpu(first_cpu->cpu_index);
> +        monitor_set_cpu(cur_mon, first_cpu->cpu_index);
>          cpu = first_cpu;
>      }
>      assert(cpu != NULL);

Patch looks good otherwise.


