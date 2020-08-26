Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BD9C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:51:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328F8208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj31U1V3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328F8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvpW-0000UI-EL
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kAvoS-00083V-VN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:50:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55525
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kAvoN-0008F7-WE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598449794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+mmCuAgiFQNVQ9Y0/dbpan2KFSVOjIfo+WjdBsZrpWM=;
 b=Cj31U1V30rSMNJq2W9bqpy7ye7rjbBkqnhucJqAzIna4cCYbgDsDi9tp3+e045+j8uJxUX
 fWg4n2e4utqzAVaFwcxJAA2FkhMb3YG0jFRdWb/OIkdFZWdVFlWEi5Ly9Wix41Xvsw5JYZ
 xuqm7XMVVXxiQvMuusvjiKFUKNvIXa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-R-dvUnOgNzWDltlBqkaOCw-1; Wed, 26 Aug 2020 09:49:52 -0400
X-MC-Unique: R-dvUnOgNzWDltlBqkaOCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA2DA101962C;
 Wed, 26 Aug 2020 13:49:51 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-67.ams2.redhat.com [10.36.114.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A91155D9E8;
 Wed, 26 Aug 2020 13:49:50 +0000 (UTC)
Date: Wed, 26 Aug 2020 15:49:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] Coroutine-aware monitor_cur() with coroutine-specific data
Message-ID: <20200826134949.GE7485@linux.fritz.box>
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-7-kwolf@redhat.com>
 <87tuxia5a9.fsf@dusky.pond.sub.org>
 <20200804160604.GB4860@linux.fritz.box>
 <87sgd15z5w.fsf@dusky.pond.sub.org>
 <87a6z6wqkg.fsf_-_@dusky.pond.sub.org>
 <87mu36zis7.fsf_-_@dusky.pond.sub.org>
 <20200810125856.GD14538@linux.fritz.box>
 <87r1rt4m25.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87r1rt4m25.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: marcandre.lureau@gmail.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 26.08.2020 um 14:40 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 07.08.2020 um 15:29 hat Markus Armbruster geschrieben:
> >> This is just a sketch.  It needs comments and a real commit message.
> >> 
> >> As is, it goes on top of Kevin's series.  It is meant to be squashed
> >> into PATCH 06.
> >> 
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  include/qemu/coroutine.h     |  4 ++++
> >>  include/qemu/coroutine_int.h |  2 ++
> >>  monitor/monitor.c            | 36 +++++++++++++++---------------------
> >>  util/qemu-coroutine.c        | 20 ++++++++++++++++++++
> >>  4 files changed, 41 insertions(+), 21 deletions(-)
> >> 
> >> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> >> index dfd261c5b1..11da47092c 100644
> >> --- a/include/qemu/coroutine.h
> >> +++ b/include/qemu/coroutine.h
> >> @@ -65,6 +65,10 @@ typedef void coroutine_fn CoroutineEntry(void *opaque);
> >>   */
> >>  Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque);
> >>  
> >> +Coroutine *qemu_coroutine_create_with_storage(CoroutineEntry *entry,
> >> +                                              void *opaque, size_t storage);
> >> +void *qemu_coroutine_local_storage(Coroutine *co);
> >> +
> >>  /**
> >>   * Transfer control to a coroutine
> >>   */
> >> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> >> index bd6b0468e1..7d7865a02f 100644
> >> --- a/include/qemu/coroutine_int.h
> >> +++ b/include/qemu/coroutine_int.h
> >> @@ -41,6 +41,8 @@ struct Coroutine {
> >>      void *entry_arg;
> >>      Coroutine *caller;
> >>  
> >> +    void *coroutine_local_storage;
> >> +
> >>      /* Only used when the coroutine has terminated.  */
> >>      QSLIST_ENTRY(Coroutine) pool_next;
> >
> > This increases the size of Coroutine objects typically by 8 bytes and
> > shifts the following fields by the same amount. On my x86_64 build, we
> > have exactly those 8 bytes left in CoroutineUContext until a new
> > cacheline would start. With different CONFIG_* settings, it could be the
> > change that increases the size to a new cacheline. No idea what this
> > looks like on other architectures.
> >
> > Does this or the shifting of fields matter for performance? I don't
> > know. It might even be unlikely. But cache effects are hard to predict
> > and not wanting to do the work of proving that it's indeed harmless is
> > one of the reasons why for the slow paths in question I preferred a
> > solution that doesn't touch the coroutine core at all.
> 
> Point taken.
> 
> Possible mitigation: add at the end rather than in the middle.

Doesn't work: This is a struct that is embedded at the start of
CoroutineUContext, so while you can move it down a bit, you'll never get
to the end of the actual struct used at runtime.

> >> diff --git a/monitor/monitor.c b/monitor/monitor.c
> >> index 50fb5b20d3..047a8fb380 100644
> >> --- a/monitor/monitor.c
> >> +++ b/monitor/monitor.c
> >> @@ -82,38 +82,32 @@ bool qmp_dispatcher_co_shutdown;
> >>   */
> >>  bool qmp_dispatcher_co_busy;
> >>  
> >> -/*
> >> - * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
> >> - * monitor_destroyed.
> >> - */
> >> +/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed. */
> >>  QemuMutex monitor_lock;
> >>  static GHashTable *monitor_qapi_event_state;
> >> -static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
> >>  
> >>  MonitorList mon_list;
> >>  int mon_refcount;
> >>  static bool monitor_destroyed;
> >>  
> >> +static Monitor **monitor_curp(Coroutine *co)
> >> +{
> >> +    static __thread Monitor *global_cur_mon;
> >> +
> >> +    if (co == qmp_dispatcher_co) {
> >> +        return qemu_coroutine_local_storage(co);
> >> +    }
> >> +    return &global_cur_mon;
> >> +}
> >
> > Like the other patch, this needs to be extended for HMP. global_cur_mon
> > is never meant to be set.
> 
> It is, for OOB commands.

Right, I missed this.

> > The solution fails as soon as we have more than a single monitor
> > coroutine running at the same time because it relies on
> > qmp_dispatcher_co.
> 
> Yes, but pretty much everything below handle_qmp_command() falls apart
> then.  Remembering to update monitor_curp() would be the least of my
> worries :)

Fair enough.

> >                    In this respect, it makes the same assumptions as the
> > simple hack.
> >
> > Only knowing that qmp_dispatcher_co is always created with storage
> > containing a Monitor** makes this safe.
> 
> Correct.
> 
> >>  Monitor *monitor_cur(void)
> >>  {
> >> -    Monitor *mon;
> >> -
> >> -    qemu_mutex_lock(&monitor_lock);
> >> -    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
> >> -    qemu_mutex_unlock(&monitor_lock);
> >> -
> >> -    return mon;
> >> +    return *monitor_curp(qemu_coroutine_self());
> >>  }
> >>  
> >>  void monitor_set_cur(Coroutine *co, Monitor *mon)
> >>  {
> >> -    qemu_mutex_lock(&monitor_lock);
> >> -    if (mon) {
> >> -        g_hash_table_replace(coroutine_mon, co, mon);
> >> -    } else {
> >> -        g_hash_table_remove(coroutine_mon, co);
> >> -    }
> >> -    qemu_mutex_unlock(&monitor_lock);
> >> +    *monitor_curp(co) = mon;
> >>  }
> >>  
> >>  /**
> >> @@ -666,14 +660,14 @@ void monitor_init_globals_core(void)
> >>  {
> >>      monitor_qapi_event_init();
> >>      qemu_mutex_init(&monitor_lock);
> >> -    coroutine_mon = g_hash_table_new(NULL, NULL);
> >>  
> >>      /*
> >>       * The dispatcher BH must run in the main loop thread, since we
> >>       * have commands assuming that context.  It would be nice to get
> >>       * rid of those assumptions.
> >>       */
> >> -    qmp_dispatcher_co = qemu_coroutine_create(monitor_qmp_dispatcher_co, NULL);
> >> +    qmp_dispatcher_co = qemu_coroutine_create_with_storage(
> >> +        monitor_qmp_dispatcher_co, NULL, sizeof(Monitor **));
> >>      atomic_mb_set(&qmp_dispatcher_co_busy, true);
> >>      aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
> >>  }
> >> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> >> index c3caa6c770..87bf7f0fc0 100644
> >> --- a/util/qemu-coroutine.c
> >> +++ b/util/qemu-coroutine.c
> >> @@ -81,8 +81,28 @@ Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
> >>      return co;
> >>  }
> >>  
> >> +Coroutine *qemu_coroutine_create_with_storage(CoroutineEntry *entry,
> >> +                                              void *opaque, size_t storage)
> >> +{
> >> +    Coroutine *co = qemu_coroutine_create(entry, opaque);
> >> +
> >> +    if (!co) {
> >> +        return NULL;
> >> +    }
> >> +
> >> +    co->coroutine_local_storage = g_malloc0(storage);
> >> +    return co;
> >> +}
> >
> > As the code above shows, this interface is only useful if you can
> > identify the coroutine. It cannot be used in code that didn't create the
> > current coroutine because then it can't know whether or not the
> > coroutine has coroutine local storage, and if it has, what its structure
> > is.
> >
> > For a supposedly generic solution, I think this is a bit weak.
> 
> Yes, that's fair.
> 
> The solution Daniel proposed is makes the weakness more explicit:
> instead of relying on "coroutine was created with this coroutine-local
> storage", we'd rely on "coroutine_getspecific(key) does not fail".  It
> can fail only if coroutine_setspecific(key, ...) was not called.  Not
> much better in practice.

It would be a little more generic, I guess. So for a solution that wants
to look generic, it might be better.

But as long as we don't have a second user (not even in our
imagination), I'm not sure how important it is to have something that
looks generic. With the simple and stupid patch, it would be more
obvious that it doesn't hurt cases that are unrelated to the monitor.

> > Effectively, this might be a one-off solution in disguise because
> > it's a big restriction on the possible use cases.
> 
> Daniel's solution is basically pthread_getspecific() for coroutines,
> with the keys dumbed down.
> 
> If pthread_getspecific() was good enough for pthreads...
> 
> Well, it wasn't, or rather it was only because something better could
> not be had with just a library, without toolchain support.  And that's
> where we are with coroutines.
> 
> >> +void *qemu_coroutine_local_storage(Coroutine *co)
> >> +{
> >> +    return co->coroutine_local_storage;
> >> +}
> >> +
> >>  static void coroutine_delete(Coroutine *co)
> >>  {
> >> +    g_free(co->coroutine_local_storage);
> >> +    co->coroutine_local_storage = NULL;
> >>      co->caller = NULL;
> >>  
> >>      if (CONFIG_COROUTINE_POOL) {
> >
> > Your list of pros/cons didn't mention coroutine creation/deletion as a
> > hot path at all (which it is, we have one coroutine per request).
> 
> I did not expect coroutine creation / deletion to be a hot path.
> 
> It is not a hot path for QMP, because QMP is not a hot path.
> 
> I'm ready to accept the proposition that it's a hot path elsewhere.

It is a hot path for block device requests. To be more specific, the
part that is executed when taking a coroutine from the pool or putting
it back to the pool is. The code to create a coroutine from scratch or
to actually free it may be less relevant.

Kevin

> > You leave qemu_coroutine_create() untouched (except indirectly by a
> > larger g_malloc0() in the non-pooled case, which is negligible) and I
> > assume that g_free(NULL) is cheap, so at least this is probably as good
> > as it gets for something integrated in the coroutine core. Maybe an
> > explicit if (co->coroutine_local_storage) would improve it slightly.
> >
> > Kevin


