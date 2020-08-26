Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7876C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA262076C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6CmOlhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA262076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAukr-0005Rg-14
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAujc-0003l9-B9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:41:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAuja-0007ER-9b
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598445657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5RuVwwhn6W7C0E8wlnyHRfkiTe6w3RDwoIZb8aOR0ZM=;
 b=V6CmOlhpzqC/gagLM/qUuyMuwN4GthAVX774YU5I9DuOJp/ZCPV+YHEW+XgVSsAB7gsZOt
 gOoEItD/KauX9FlGgo8gXnc8YDtkIPnjfpLg6GlWamthlC5ozDebK0hkh63a0v6idPrr8a
 bKntHlLiIxJtLBe8mWqte2pswM6MYug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-xtgM5az7MaG9I5eB7bpUHQ-1; Wed, 26 Aug 2020 08:40:55 -0400
X-MC-Unique: xtgM5az7MaG9I5eB7bpUHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4100B1009469;
 Wed, 26 Aug 2020 12:40:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A16285D9E4;
 Wed, 26 Aug 2020 12:40:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 28434112D737; Wed, 26 Aug 2020 14:40:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] Coroutine-aware monitor_cur() with coroutine-specific data
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-7-kwolf@redhat.com>
 <87tuxia5a9.fsf@dusky.pond.sub.org>
 <20200804160604.GB4860@linux.fritz.box>
 <87sgd15z5w.fsf@dusky.pond.sub.org>
 <87a6z6wqkg.fsf_-_@dusky.pond.sub.org>
 <87mu36zis7.fsf_-_@dusky.pond.sub.org>
 <20200810125856.GD14538@linux.fritz.box>
Date: Wed, 26 Aug 2020 14:40:50 +0200
In-Reply-To: <20200810125856.GD14538@linux.fritz.box> (Kevin Wolf's message of
 "Mon, 10 Aug 2020 14:58:56 +0200")
Message-ID: <87r1rt4m25.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@gmail.com,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 07.08.2020 um 15:29 hat Markus Armbruster geschrieben:
>> This is just a sketch.  It needs comments and a real commit message.
>> 
>> As is, it goes on top of Kevin's series.  It is meant to be squashed
>> into PATCH 06.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qemu/coroutine.h     |  4 ++++
>>  include/qemu/coroutine_int.h |  2 ++
>>  monitor/monitor.c            | 36 +++++++++++++++---------------------
>>  util/qemu-coroutine.c        | 20 ++++++++++++++++++++
>>  4 files changed, 41 insertions(+), 21 deletions(-)
>> 
>> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
>> index dfd261c5b1..11da47092c 100644
>> --- a/include/qemu/coroutine.h
>> +++ b/include/qemu/coroutine.h
>> @@ -65,6 +65,10 @@ typedef void coroutine_fn CoroutineEntry(void *opaque);
>>   */
>>  Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque);
>>  
>> +Coroutine *qemu_coroutine_create_with_storage(CoroutineEntry *entry,
>> +                                              void *opaque, size_t storage);
>> +void *qemu_coroutine_local_storage(Coroutine *co);
>> +
>>  /**
>>   * Transfer control to a coroutine
>>   */
>> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
>> index bd6b0468e1..7d7865a02f 100644
>> --- a/include/qemu/coroutine_int.h
>> +++ b/include/qemu/coroutine_int.h
>> @@ -41,6 +41,8 @@ struct Coroutine {
>>      void *entry_arg;
>>      Coroutine *caller;
>>  
>> +    void *coroutine_local_storage;
>> +
>>      /* Only used when the coroutine has terminated.  */
>>      QSLIST_ENTRY(Coroutine) pool_next;
>
> This increases the size of Coroutine objects typically by 8 bytes and
> shifts the following fields by the same amount. On my x86_64 build, we
> have exactly those 8 bytes left in CoroutineUContext until a new
> cacheline would start. With different CONFIG_* settings, it could be the
> change that increases the size to a new cacheline. No idea what this
> looks like on other architectures.
>
> Does this or the shifting of fields matter for performance? I don't
> know. It might even be unlikely. But cache effects are hard to predict
> and not wanting to do the work of proving that it's indeed harmless is
> one of the reasons why for the slow paths in question I preferred a
> solution that doesn't touch the coroutine core at all.

Point taken.

Possible mitigation: add at the end rather than in the middle.

>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index 50fb5b20d3..047a8fb380 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -82,38 +82,32 @@ bool qmp_dispatcher_co_shutdown;
>>   */
>>  bool qmp_dispatcher_co_busy;
>>  
>> -/*
>> - * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
>> - * monitor_destroyed.
>> - */
>> +/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed. */
>>  QemuMutex monitor_lock;
>>  static GHashTable *monitor_qapi_event_state;
>> -static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
>>  
>>  MonitorList mon_list;
>>  int mon_refcount;
>>  static bool monitor_destroyed;
>>  
>> +static Monitor **monitor_curp(Coroutine *co)
>> +{
>> +    static __thread Monitor *global_cur_mon;
>> +
>> +    if (co == qmp_dispatcher_co) {
>> +        return qemu_coroutine_local_storage(co);
>> +    }
>> +    return &global_cur_mon;
>> +}
>
> Like the other patch, this needs to be extended for HMP. global_cur_mon
> is never meant to be set.

It is, for OOB commands.

> The solution fails as soon as we have more than a single monitor
> coroutine running at the same time because it relies on
> qmp_dispatcher_co.

Yes, but pretty much everything below handle_qmp_command() falls apart
then.  Remembering to update monitor_curp() would be the least of my
worries :)

>                    In this respect, it makes the same assumptions as the
> simple hack.
>
> Only knowing that qmp_dispatcher_co is always created with storage
> containing a Monitor** makes this safe.

Correct.

>>  Monitor *monitor_cur(void)
>>  {
>> -    Monitor *mon;
>> -
>> -    qemu_mutex_lock(&monitor_lock);
>> -    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
>> -    qemu_mutex_unlock(&monitor_lock);
>> -
>> -    return mon;
>> +    return *monitor_curp(qemu_coroutine_self());
>>  }
>>  
>>  void monitor_set_cur(Coroutine *co, Monitor *mon)
>>  {
>> -    qemu_mutex_lock(&monitor_lock);
>> -    if (mon) {
>> -        g_hash_table_replace(coroutine_mon, co, mon);
>> -    } else {
>> -        g_hash_table_remove(coroutine_mon, co);
>> -    }
>> -    qemu_mutex_unlock(&monitor_lock);
>> +    *monitor_curp(co) = mon;
>>  }
>>  
>>  /**
>> @@ -666,14 +660,14 @@ void monitor_init_globals_core(void)
>>  {
>>      monitor_qapi_event_init();
>>      qemu_mutex_init(&monitor_lock);
>> -    coroutine_mon = g_hash_table_new(NULL, NULL);
>>  
>>      /*
>>       * The dispatcher BH must run in the main loop thread, since we
>>       * have commands assuming that context.  It would be nice to get
>>       * rid of those assumptions.
>>       */
>> -    qmp_dispatcher_co = qemu_coroutine_create(monitor_qmp_dispatcher_co, NULL);
>> +    qmp_dispatcher_co = qemu_coroutine_create_with_storage(
>> +        monitor_qmp_dispatcher_co, NULL, sizeof(Monitor **));
>>      atomic_mb_set(&qmp_dispatcher_co_busy, true);
>>      aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
>>  }
>> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
>> index c3caa6c770..87bf7f0fc0 100644
>> --- a/util/qemu-coroutine.c
>> +++ b/util/qemu-coroutine.c
>> @@ -81,8 +81,28 @@ Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
>>      return co;
>>  }
>>  
>> +Coroutine *qemu_coroutine_create_with_storage(CoroutineEntry *entry,
>> +                                              void *opaque, size_t storage)
>> +{
>> +    Coroutine *co = qemu_coroutine_create(entry, opaque);
>> +
>> +    if (!co) {
>> +        return NULL;
>> +    }
>> +
>> +    co->coroutine_local_storage = g_malloc0(storage);
>> +    return co;
>> +}
>
> As the code above shows, this interface is only useful if you can
> identify the coroutine. It cannot be used in code that didn't create the
> current coroutine because then it can't know whether or not the
> coroutine has coroutine local storage, and if it has, what its structure
> is.
>
> For a supposedly generic solution, I think this is a bit weak.

Yes, that's fair.

The solution Daniel proposed is makes the weakness more explicit:
instead of relying on "coroutine was created with this coroutine-local
storage", we'd rely on "coroutine_getspecific(key) does not fail".  It
can fail only if coroutine_setspecific(key, ...) was not called.  Not
much better in practice.

> Effectively, this might be a one-off solution in disguise because
> it's a big restriction on the possible use cases.

Daniel's solution is basically pthread_getspecific() for coroutines,
with the keys dumbed down.

If pthread_getspecific() was good enough for pthreads...

Well, it wasn't, or rather it was only because something better could
not be had with just a library, without toolchain support.  And that's
where we are with coroutines.

>> +void *qemu_coroutine_local_storage(Coroutine *co)
>> +{
>> +    return co->coroutine_local_storage;
>> +}
>> +
>>  static void coroutine_delete(Coroutine *co)
>>  {
>> +    g_free(co->coroutine_local_storage);
>> +    co->coroutine_local_storage = NULL;
>>      co->caller = NULL;
>>  
>>      if (CONFIG_COROUTINE_POOL) {
>
> Your list of pros/cons didn't mention coroutine creation/deletion as a
> hot path at all (which it is, we have one coroutine per request).

I did not expect coroutine creation / deletion to be a hot path.

It is not a hot path for QMP, because QMP is not a hot path.

I'm ready to accept the proposition that it's a hot path elsewhere.

> You leave qemu_coroutine_create() untouched (except indirectly by a
> larger g_malloc0() in the non-pooled case, which is negligible) and I
> assume that g_free(NULL) is cheap, so at least this is probably as good
> as it gets for something integrated in the coroutine core. Maybe an
> explicit if (co->coroutine_local_storage) would improve it slightly.
>
> Kevin


