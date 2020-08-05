Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B481C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E392206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d40HqwM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E392206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GkS-00082S-Dp
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3Gjb-00073Q-4e
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3GjZ-0004gp-Ae
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596623600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hRuOlKALyPZm4jnRCLEOKp4XoIgDtMYJQ57vgPiYc2U=;
 b=d40HqwM78z+y44O5ybA2TYPxKDCZ18UGq273XYprcUQCaaivufACf+UCt5dacrOQ6nhXfA
 +PosnYcch7vjJBYGVmW8083xS+Zbn8WpZVkFelP5gI0fr/DuCassvFpR5JsJAokiTYvfyW
 3xdpz+4TCiSjT1gQH2vEpVOtDLr2AA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-nDmIqGj0M_CHZDLjlcX_tQ-1; Wed, 05 Aug 2020 06:33:18 -0400
X-MC-Unique: nDmIqGj0M_CHZDLjlcX_tQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 695261DE1;
 Wed,  5 Aug 2020 10:33:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 624C85C1BD;
 Wed,  5 Aug 2020 10:33:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECE751141D60; Wed,  5 Aug 2020 12:33:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v6 09/12] hmp: Add support for coroutine command handlers
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-10-kwolf@redhat.com>
Date: Wed, 05 Aug 2020 12:33:14 +0200
In-Reply-To: <20200528153742.274164-10-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 28 May 2020 17:37:39 +0200")
Message-ID: <87imdx2xhx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 06:27:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@gmail.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
>  monitor/hmp.c              | 38 ++++++++++++++++++++++++++++++++------
>  2 files changed, 33 insertions(+), 6 deletions(-)
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
> index 3e73a4c3ce..ab0e3e279f 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1056,12 +1056,25 @@ fail:
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
> @@ -1080,11 +1093,24 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
>          return;
>      }
>  
> -    /* old_mon is non-NULL when called from qmp_human_monitor_command() */
> -    old_mon = monitor_cur();
> -    monitor_set_cur(qemu_coroutine_self(), &mon->common);
> -    cmd->cmd(&mon->common, qdict);
> -    monitor_set_cur(qemu_coroutine_self(), old_mon);
> +    if (!cmd->coroutine) {
> +        /* old_mon is non-NULL when called from qmp_human_monitor_command() */
> +        Monitor *old_mon = monitor_cur();
> +        monitor_set_cur(qemu_coroutine_self(), &mon->common);
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

Where is the matching monitor_set_cur(co, NULL)?

> +        aio_co_enter(qemu_get_aio_context(), co);
> +        AIO_WAIT_WHILE(qemu_get_aio_context(), !data.done);
> +    }
>  
>      qobject_unref(qdict);
>  }


