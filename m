Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6D3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02FB120709
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIPTJGk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FB120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k56mb-0007Gj-7F
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 08:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k56lw-0006l2-LG
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 08:19:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43647
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k56lt-0008Rn-Jo
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 08:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597061959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jtj60eUk+p+48v2evNN2+w+A2Uk02UIM0OtgIuFU3UI=;
 b=QIPTJGk0j2Dpp+GT7m0bCrSj/EMji8UMt4pcTzGy9fd1Zq04zAYK71h/iaquL8C57N77/s
 v20MzdoAayKQVKSe4vhG6RjebrAkwX5MfFR12zH1EkImtHx4RScB7PoCcEpZvyYuoBOIpv
 YKtZYg9c3tuBvzDm9JHx/PGjlMnr8Gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-wgKizoeAM7C0efIiUy4hdw-1; Mon, 10 Aug 2020 08:19:18 -0400
X-MC-Unique: wgKizoeAM7C0efIiUy4hdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BB498005B0;
 Mon, 10 Aug 2020 12:19:17 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D41A98BA1D;
 Mon, 10 Aug 2020 12:19:15 +0000 (UTC)
Date: Mon, 10 Aug 2020 14:19:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] Simple & stupid coroutine-aware monitor_cur()
Message-ID: <20200810121914.GC14538@linux.fritz.box>
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-7-kwolf@redhat.com>
 <87tuxia5a9.fsf@dusky.pond.sub.org>
 <20200804160604.GB4860@linux.fritz.box>
 <87sgd15z5w.fsf@dusky.pond.sub.org>
 <87a6z6wqkg.fsf_-_@dusky.pond.sub.org>
 <87sgcyziul.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sgcyziul.fsf_-_@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.08.2020 um 15:27 hat Markus Armbruster geschrieben:
> This is just a sketch.  It's incomplete, needs comments and a real
> commit message.
> 
> Support for "[PATCH v6 09/12] hmp: Add support for coroutine command
> handlers" is missing.  Marked FIXME.
> 
> As is, it goes on top of Kevin's series.  It is meant to be squashed
> into PATCH 06, except for the FIXME, which needs to be resolved in PATCH
> 09 instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor/monitor.c | 35 +++++++++++++++--------------------
>  1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 50fb5b20d3..8601340285 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -82,38 +82,34 @@ bool qmp_dispatcher_co_shutdown;
>   */
>  bool qmp_dispatcher_co_busy;
>  
> -/*
> - * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
> - * monitor_destroyed.
> - */
> +/* Protects mon_list, monitor_qapi_event_state, * monitor_destroyed. */
>  QemuMutex monitor_lock;
>  static GHashTable *monitor_qapi_event_state;
> -static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
>  
>  MonitorList mon_list;
>  int mon_refcount;
>  static bool monitor_destroyed;
>  
> +static Monitor **monitor_curp(Coroutine *co)
> +{
> +    static __thread Monitor *thread_local_mon;
> +    static Monitor *qmp_dispatcher_co_mon;
> +
> +    if (qemu_coroutine_self() == qmp_dispatcher_co) {
> +        return &qmp_dispatcher_co_mon;
> +    }
> +    /* FIXME the coroutine hidden in handle_hmp_command() */
> +    return &thread_local_mon;
> +}

Is thread_local_mon supposed to ever be set? The only callers of
monitor_set_cur() are the HMP and QMP dispatchers, which will return
something different.

So should we return NULL insetad of thread_local_mon...

>  Monitor *monitor_cur(void)
>  {
> -    Monitor *mon;
> -
> -    qemu_mutex_lock(&monitor_lock);
> -    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
> -    qemu_mutex_unlock(&monitor_lock);
> -
> -    return mon;
> +    return *monitor_curp(qemu_coroutine_self());
>  }

...and return NULL here if monitor_curp() returned NULL...

>  void monitor_set_cur(Coroutine *co, Monitor *mon)
>  {
> -    qemu_mutex_lock(&monitor_lock);
> -    if (mon) {
> -        g_hash_table_replace(coroutine_mon, co, mon);
> -    } else {
> -        g_hash_table_remove(coroutine_mon, co);
> -    }
> -    qemu_mutex_unlock(&monitor_lock);
> +    *monitor_curp(co) = mon;

...and assert(monitor_curp(co) != NULL) here?

This approach looks workable, though the implementation of
monitor_curp() feels a bit brittle. The code is not significantly
simpler than the hash table based approach, but the assumptions it makes
are a bit more hidden.

Saving the locks is more a theoretical improvement because all callers
are slows paths anyway.

Kevin


