Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791FFC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C995722247
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOSzeSpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C995722247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIU33-0007Qb-QY
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIU1s-00062B-MW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIU1q-0008Du-TS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BheMcis1sJHJd6LosWlCnFQY7a76c84OiIt1JjtLhaY=;
 b=WOSzeSpiOJNNMuXc/eDkIzgwKde6/R2tOgdFuQswfU6zNZeVFkuIzrsMUU30JB660RYub2
 VjVbcrNQb6tpsCR2Xst27W++WBQgfEPMka4eXRvuVCkcEpjByYWgtk7Snv8+KYj/HSh9eg
 zaNULgjfeP369VvRYtksfKJehAPd1oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-6f2OqUl-OEinPl3tJPkmzQ-1; Wed, 16 Sep 2020 05:47:02 -0400
X-MC-Unique: 6f2OqUl-OEinPl3tJPkmzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3889A8030CB;
 Wed, 16 Sep 2020 09:47:01 +0000 (UTC)
Received: from work-vm (ovpn-114-237.ams2.redhat.com [10.36.114.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D580410021AA;
 Wed, 16 Sep 2020 09:46:55 +0000 (UTC)
Date: Wed, 16 Sep 2020 10:46:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 10/13] hmp: Add support for coroutine command handlers
Message-ID: <20200916094653.GB2833@work-vm>
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-11-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909151149.490589-11-kwolf@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: marcandre.lureau@gmail.com, stefanha@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kevin Wolf (kwolf@redhat.com) wrote:
> Often, QMP command handlers are not only called to handle QMP commands,
> but also from a corresponding HMP command handler. In order to give them
> a consistent environment, optionally run HMP command handlers in a
> coroutine, too.
> 
> The implementation is a lot simpler than in QMP because for HMP, we
> still block the VM while the coroutine is running.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  monitor/monitor-internal.h |  1 +
>  monitor/hmp.c              | 37 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index b55d6df07f..ad2e64be13 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -74,6 +74,7 @@ typedef struct HMPCommand {
>      const char *help;
>      const char *flags; /* p=preconfig */
>      void (*cmd)(Monitor *mon, const QDict *qdict);
> +    bool coroutine;
>      /*
>       * @sub_table is a list of 2nd level of commands. If it does not exist,
>       * cmd should be used. If it exists, sub_table[?].cmd should be
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 4b66ca1cd6..b858b0dbde 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1056,12 +1056,26 @@ fail:
>      return NULL;
>  }
>  
> +typedef struct HandleHmpCommandCo {
> +    Monitor *mon;
> +    const HMPCommand *cmd;
> +    QDict *qdict;
> +    bool done;
> +} HandleHmpCommandCo;
> +
> +static void handle_hmp_command_co(void *opaque)
> +{
> +    HandleHmpCommandCo *data = opaque;
> +    data->cmd->cmd(data->mon, data->qdict);
> +    monitor_set_cur(qemu_coroutine_self(), NULL);
> +    data->done = true;
> +}
> +
>  void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
>  {
>      QDict *qdict;
>      const HMPCommand *cmd;
>      const char *cmd_start = cmdline;
> -    Monitor *old_mon;
>  
>      trace_handle_hmp_command(mon, cmdline);
>  
> @@ -1080,10 +1094,23 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
>          return;
>      }
>  
> -    /* old_mon is non-NULL when called from qmp_human_monitor_command() */
> -    old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
> -    cmd->cmd(&mon->common, qdict);
> -    monitor_set_cur(qemu_coroutine_self(), old_mon);
> +    if (!cmd->coroutine) {
> +        /* old_mon is non-NULL when called from qmp_human_monitor_command() */
> +        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
> +        cmd->cmd(&mon->common, qdict);
> +        monitor_set_cur(qemu_coroutine_self(), old_mon);
> +    } else {
> +        HandleHmpCommandCo data = {
> +            .mon = &mon->common,
> +            .cmd = cmd,
> +            .qdict = qdict,
> +            .done = false,
> +        };
> +        Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
> +        monitor_set_cur(co, &mon->common);
> +        aio_co_enter(qemu_get_aio_context(), co);
> +        AIO_WAIT_WHILE(qemu_get_aio_context(), !data.done);
> +    }
>  
>      qobject_unref(qdict);
>  }
> -- 
> 2.25.4
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


