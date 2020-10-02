Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5C4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CBA206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNcQ0Mky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CBA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOG1x-0005s1-EM
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOG0i-0004hE-Ja
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOG0g-0007PP-QS
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NmlVOlesERPv/vPrMv7z+tcWb+QCA4eVCAoOH7P3vQY=;
 b=YNcQ0MkyCEoyqyk6iajLbtq88+fAc4hCnjNiUMo9K2zUjn8ViLxYbe+ov8UdsY1YxzGdE7
 4vJgvkj83EWbQoYRDx+07aDuRuUExM/DiOPCYfyBOgLvQ9BdnPTqeTEe60emTWfX/HWU91
 h5MeghYuO1+rt1xDfv976WBkO2+FTDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-Fy90-i0CPsebKlxrhzzqXw-1; Fri, 02 Oct 2020 04:01:39 -0400
X-MC-Unique: Fy90-i0CPsebKlxrhzzqXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9390610BBED0;
 Fri,  2 Oct 2020 08:01:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B3337368D;
 Fri,  2 Oct 2020 08:01:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4DBA81132784; Fri,  2 Oct 2020 10:01:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 10/13] hmp: Add support for coroutine command handlers
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-11-kwolf@redhat.com>
Date: Fri, 02 Oct 2020 10:01:36 +0200
In-Reply-To: <20200909151149.490589-11-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:46 +0200")
Message-ID: <877ds9oy3j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Additional nitpick detail on Kevin's request.

Kevin Wolf <kwolf@redhat.com> writes:

> Often, QMP command handlers are not only called to handle QMP commands,
> but also from a corresponding HMP command handler. In order to give them
> a consistent environment, optionally run HMP command handlers in a
> coroutine, too.
>
> The implementation is a lot simpler than in QMP because for HMP, we
> still block the VM while the coroutine is running.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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

Long line.  David seems fine with it, and he's the maintainer.

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


