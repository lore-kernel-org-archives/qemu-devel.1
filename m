Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9894C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606FC20672
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGE8CEJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606FC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFuB-0008Gx-E2
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOFsb-0006mU-Km
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOFsP-00068l-2b
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rwcqXzy7uW6QrC9zM/ft4hGeEMus9jnHmAT29wtMqDY=;
 b=jGE8CEJ09p7dcdLUgpuuZ44Fd/CPIqOXc+6n2UQJuL2WFjw9GVrE3IMJDrCrBvnHB5ss4i
 a4d0hBlV67/8G2cmw+LbqbEOzwlDBlWkNCCtIG6bunpXZOwBRBHYL0NW3QJlMi6muVUG07
 Lagp9nrrdqFGK8Ovo9iq8zgoc886fPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-Ga6t0hBpNLqcvrqQZ6gbKA-1; Fri, 02 Oct 2020 03:53:07 -0400
X-MC-Unique: Ga6t0hBpNLqcvrqQZ6gbKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E46C71DDE8;
 Fri,  2 Oct 2020 07:53:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A54665D9E4;
 Fri,  2 Oct 2020 07:53:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3FF731132784; Fri,  2 Oct 2020 09:53:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 07/13] monitor: Make current monitor a per-coroutine
 property
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-8-kwolf@redhat.com>
Date: Fri, 02 Oct 2020 09:53:01 +0200
In-Reply-To: <20200909151149.490589-8-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:43 +0200")
Message-ID: <87tuvdoyhu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Additional nitpick detail on Kevin's request.

Kevin Wolf <kwolf@redhat.com> writes:

> This way, a monitor command handler will still be able to access the
> current monitor, but when it yields, all other code code will correctly
> get NULL from monitor_cur().
>
> This uses a hash table to map the coroutine pointer to the current
> monitor of that coroutine.  Outside of coroutine context, we associate
> the current monitor with the leader coroutine of the current thread.
>
> Approaches to implement some form of coroutine local storage directly in
> the coroutine core code have been considered and discarded because they
> didn't end up being much more generic than the hash table and their
> performance impact on coroutines not using coroutine local storage was
> unclear. As the block layer uses a coroutine per I/O request, this is a
> fast path and we have to be careful. It's safest to just stay out of
> this path with code only used by the monitor.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/monitor/monitor.h |  2 +-
>  monitor/hmp.c             |  4 ++--
>  monitor/monitor.c         | 34 +++++++++++++++++++++++++++-------
>  qapi/qmp-dispatch.c       |  4 ++--
>  stubs/monitor-core.c      |  2 +-
>  5 files changed, 33 insertions(+), 13 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 7b0ad1de12..026f8a31b2 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -13,7 +13,7 @@ typedef struct MonitorOptions MonitorOptions;
>  extern QemuOptsList qemu_mon_opts;
>  
>  Monitor *monitor_cur(void);
> -Monitor *monitor_set_cur(Monitor *mon);
> +Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
>  bool monitor_cur_is_qmp(void);
>  
>  void monitor_init_globals(void);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 896c670183..4b66ca1cd6 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1081,9 +1081,9 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
>      }
>  
>      /* old_mon is non-NULL when called from qmp_human_monitor_command() */
> -    old_mon = monitor_set_cur(&mon->common);
> +    old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
>      cmd->cmd(&mon->common, qdict);
> -    monitor_set_cur(old_mon);
> +    monitor_set_cur(qemu_coroutine_self(), old_mon);
>  
>      qobject_unref(qdict);
>  }
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index be3839a7aa..629aa073ee 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -58,29 +58,48 @@ IOThread *mon_iothread;
>  /* Bottom half to dispatch the requests received from I/O thread */
>  QEMUBH *qmp_dispatcher_bh;
>  
> -/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
> +/*
> + * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
> + * monitor_destroyed.
> + */
>  QemuMutex monitor_lock;
>  static GHashTable *monitor_qapi_event_state;
> +static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
>  
>  MonitorList mon_list;
>  int mon_refcount;
>  static bool monitor_destroyed;
>  
> -static __thread Monitor *cur_monitor;
> -
>  Monitor *monitor_cur(void)
>  {
> -    return cur_monitor;
> +    Monitor *mon;
> +
> +    qemu_mutex_lock(&monitor_lock);
> +    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
> +    qemu_mutex_unlock(&monitor_lock);
> +
> +    return mon;
>  }
>  
>  /**
>   * Sets a new current monitor and returns the old one.
> + *
> + * If a non-NULL monitor is set for a coroutine, another call resetting it to
> + * NULL is required before the coroutine terminates, otherwise a stale entry
> + * would remain in the hash table.

Wrapping the comment around column 70 or so would make it easier to
read.

>   */
> -Monitor *monitor_set_cur(Monitor *mon)
> +Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>  {
> -    Monitor *old_monitor = cur_monitor;
> +    Monitor *old_monitor = monitor_cur();
> +
> +    qemu_mutex_lock(&monitor_lock);
> +    if (mon) {
> +        g_hash_table_replace(coroutine_mon, co, mon);
> +    } else {
> +        g_hash_table_remove(coroutine_mon, co);
> +    }
> +    qemu_mutex_unlock(&monitor_lock);
>  
> -    cur_monitor = mon;
>      return old_monitor;
>  }
>  
[...]


