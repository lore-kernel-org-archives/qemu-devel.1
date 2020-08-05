Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0906C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D21D20792
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/+2xwk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D21D20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Er5-00006n-TY
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3EqL-0007xe-6H
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:32:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45811
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k3EqJ-0006db-3u
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596616330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z4pQR/gNAa1udyzfqCrap+YDtxtgJnp94XkfWRT8zkU=;
 b=B/+2xwk+Eh5H8a/oAazRiJ/CuoP2NcyFs4KJ+q9AfFcvtCsVav7yLZaWAPp50BRBycTiwb
 GjnNKd7eD9PiEu+ts2uZkWAl8xF2LUOaVN202il71PMqh3Puhg7clRFfwI8u3132Y08DtD
 QRVqBeKf4mLGiWt4gpmF0V1ctTAJ08U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-XmGIycUvOCWNcfT0g0pasw-1; Wed, 05 Aug 2020 04:32:08 -0400
X-MC-Unique: XmGIycUvOCWNcfT0g0pasw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 904D8106B244;
 Wed,  5 Aug 2020 08:32:07 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 440128AC0C;
 Wed,  5 Aug 2020 08:32:06 +0000 (UTC)
Date: Wed, 5 Aug 2020 10:32:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 06/12] monitor: Make current monitor a per-coroutine
 property
Message-ID: <20200805083204.GB4679@linux.fritz.box>
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-7-kwolf@redhat.com>
 <87tuxia5a9.fsf@dusky.pond.sub.org>
 <20200804160604.GB4860@linux.fritz.box>
 <87sgd15z5w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sgd15z5w.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 05.08.2020 um 09:28 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 04.08.2020 um 15:50 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> 
> >> > This way, a monitor command handler will still be able to access the
> >> > current monitor, but when it yields, all other code code will correctly
> >> > get NULL from monitor_cur().
> >> >
> >> > Outside of coroutine context, qemu_coroutine_self() returns the leader
> >> > coroutine of the current thread.
> >> 
> >> Unsaid: you use it as a hash table key to map from coroutine to monitor,
> >> and for that you need it to return a value unique to the coroutine in
> >> coroutine context, and a value unique to the thread outside coroutine
> >> context.  Which qemu_coroutine_self() does.  Correct?
> >
> > Correct.
> >
> >> The hash table works, but I hate it just as much as I hate
> >> pthread_getspecific() / pthread_setspecific().
> >> 
> >> What we have here is a need for coroutine-local data.  Feels like a
> >> perfectly natural concept to me.
> >
> > If you have a good concept how to implement this in a generic way that
> > doesn't impact the I/O fast path, feel free to implement it and I'll
> > happily use it.
> 
> Fair enough; I'll give it a shot.
> 
> > But the hash table is simple and works for this use case, so I see
> > little reason to invest a lot of time in something that we haven't ever
> > had another user for.
> >
> >> Are we going to create another hash table whenever we need another piece
> >> of coroutine-local data?  Or shall we reuse the hash table, suitably
> >> renamed and moved to another file?
> >
> > I think I would vote for separate hash tables rather than having a hash
> > table containing a struct that mixes values from all subsystems, but
> > this can be discussed when (if) the need arises.
> >
> >> Why not simply associate an opaque pointer with each coroutine?  All it
> >> takes is one more member of struct Coroutine.  Whatever creates the
> >> coroutine decides what to use it for.  The monitor coroutine would use
> >> it to point to the monitor.
> >
> > This doesn't work. error_report() is called from all kinds of
> > coroutines, not just from coroutines created from the monitor, and it
> > wants to know the current monitor.
> 
> Yup, monitor_cur() and monitor_set_cur() need to work both in coroutine
> context and outside coroutine context.

And in coroutine contexts, but in coroutine created by someone else than
the monitor.

> >> At least, discuss the design alternatives in the commit message.
> >
> > *sigh* Fine. Tell me which set of alternatives to discuss.
> 
> Let me first play with the alternative I suggested.
> 
> >> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> > ---
> >> >  include/monitor/monitor.h |  2 +-
> >> >  monitor/hmp.c             |  4 ++--
> >> >  monitor/monitor.c         | 27 +++++++++++++++++++++------
> >> >  qapi/qmp-dispatch.c       |  4 ++--
> >> >  stubs/monitor-core.c      |  2 +-
> >> >  5 files changed, 27 insertions(+), 12 deletions(-)
> >> >
> >> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> >> > index 43cc746078..16072e325c 100644
> >> > --- a/include/monitor/monitor.h
> >> > +++ b/include/monitor/monitor.h
> >> > @@ -13,7 +13,7 @@ typedef struct MonitorOptions MonitorOptions;
> >> >  extern QemuOptsList qemu_mon_opts;
> >> >  
> >> >  Monitor *monitor_cur(void);
> >> > -void monitor_set_cur(Monitor *mon);
> >> > +void monitor_set_cur(Coroutine *co, Monitor *mon);
> >> >  bool monitor_cur_is_qmp(void);
> >> >  
> >> >  void monitor_init_globals(void);
> >> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> >> > index 79be6f26de..3e73a4c3ce 100644
> >> > --- a/monitor/hmp.c
> >> > +++ b/monitor/hmp.c
> >> > @@ -1082,9 +1082,9 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
> >> >  
> >> >      /* old_mon is non-NULL when called from qmp_human_monitor_command() */
> >> >      old_mon = monitor_cur();
> >> > -    monitor_set_cur(&mon->common);
> >> > +    monitor_set_cur(qemu_coroutine_self(), &mon->common);
> >> >      cmd->cmd(&mon->common, qdict);
> >> > -    monitor_set_cur(old_mon);
> >> > +    monitor_set_cur(qemu_coroutine_self(), old_mon);
> >> >  
> >> >      qobject_unref(qdict);
> >> >  }
> >> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> >> > index 182ba136b4..35003bb486 100644
> >> > --- a/monitor/monitor.c
> >> > +++ b/monitor/monitor.c
> >> > @@ -58,24 +58,38 @@ IOThread *mon_iothread;
> >> >  /* Bottom half to dispatch the requests received from I/O thread */
> >> >  QEMUBH *qmp_dispatcher_bh;
> >> >  
> >> > -/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
> >> > +/*
> >> > + * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
> >> > + * monitor_destroyed.
> >> > + */
> >> >  QemuMutex monitor_lock;
> >> >  static GHashTable *monitor_qapi_event_state;
> >> > +static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
> >> >  
> >> >  MonitorList mon_list;
> >> >  int mon_refcount;
> >> >  static bool monitor_destroyed;
> >> >  
> >> > -static __thread Monitor *cur_monitor;
> >> > -
> >> >  Monitor *monitor_cur(void)
> >> >  {
> >> > -    return cur_monitor;
> >> > +    Monitor *mon;
> >> > +
> >> > +    qemu_mutex_lock(&monitor_lock);
> >> > +    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
> >> > +    qemu_mutex_unlock(&monitor_lock);
> >> > +
> >> > +    return mon;
> >> >  }
> >> >  
> >> > -void monitor_set_cur(Monitor *mon)
> >> > +void monitor_set_cur(Coroutine *co, Monitor *mon)
> >> >  {
> >> > -    cur_monitor = mon;
> >> > +    qemu_mutex_lock(&monitor_lock);
> >> > +    if (mon) {
> >> > +        g_hash_table_replace(coroutine_mon, co, mon);
> >> > +    } else {
> >> > +        g_hash_table_remove(coroutine_mon, co);
> >> > +    }
> >> > +    qemu_mutex_unlock(&monitor_lock);
> >> >  }
> >> 
> >> You really need a contract now: any call to monitor_set_cur() with a
> >> non-null @mon must be followed by a call with a null @mon.
> >
> > Why? g_hash_table_replace() removes the old value and replaces it with
> > the new one.
> 
> If you monitor_set_cur(NULL) is forgotten or bypassed somehow, the hash
> table entry stays even when the coroutine dies.  Minor memory leak.  If
> another coroutine gets created at the same address, it "inherits" the
> current monitor.  Not good.  If the monitor has died meanwhile, dangling
> pointer.  Fortunately, monitors die only during shutdown, except for the
> dummy in qmp_human_monitor_command().

Ah, yes, fair. I can document this.

In practice not a problem because the QMP dispatcher coroutine and HMP
command handler coroutines are the only places that set (and reset) it.

In fact, HMP needs to be fixed to reset to NULL before the coroutine
terminates.

Kevin


