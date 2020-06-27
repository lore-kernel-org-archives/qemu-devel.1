Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA5C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 12:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D002420FC3
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 12:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiXXpkdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D002420FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp9oK-0007BC-2X
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 08:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9nf-0006hk-OY
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 08:19:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9nd-0005IW-2v
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 08:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593260351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=poDhA73nm3dpGcZcUBO2vTsJlQyj4YnTkyOJdIf0xlU=;
 b=KiXXpkdog9r/l/WmjbGYalGkkzqc3tqYqE7pbJCMDWQ2NbSxoo9Y5OO+z3xSC7/S1bRyUM
 aQEcCBscxYaPFNFs/S+FqEwed0GuvG02zCvt9588GGJkJHBik/3YyZl0SsXeDDldDNJHjE
 hKq9tIkT5OaKLNKDjKu0jrIMB5PN9Fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-L7YTzWRgNlOQF4ERcxXmEQ-1; Sat, 27 Jun 2020 08:18:58 -0400
X-MC-Unique: L7YTzWRgNlOQF4ERcxXmEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0144510059A5;
 Sat, 27 Jun 2020 12:18:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3D8D10013C2;
 Sat, 27 Jun 2020 12:18:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7183811384A6; Sat, 27 Jun 2020 14:18:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 07/46] error: Avoid more error_propagate() when error is
 not used here
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-8-armbru@redhat.com>
 <aa48ada1-2712-e658-6c36-440b402b046a@virtuozzo.com>
Date: Sat, 27 Jun 2020 14:18:18 +0200
In-Reply-To: <aa48ada1-2712-e658-6c36-440b402b046a@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 26 Jun 2020 20:21:24 +0300")
Message-ID: <878sg8r9bp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 07:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 24.06.2020 19:43, Markus Armbruster wrote:
>> When all we do with an Error we receive into a local variable is
>> propagating to somewhere else, we can just as well receive it there
>> right away.  The previous commit did that for simple cases with
>> Coccinelle.  Do it for a few more manually.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   blockdev.c     |  5 +----
>>   hw/core/numa.c | 44 ++++++++++++++------------------------------
>>   qdev-monitor.c | 11 ++++-------
>>   3 files changed, 19 insertions(+), 41 deletions(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index b66863c42a..73736a4eaf 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -1009,13 +1009,10 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
>>       }
>>         /* Actual block device init: Functionality shared with
>> blockdev-add */
>> -    blk = blockdev_init(filename, bs_opts, &local_err);
>> +    blk = blockdev_init(filename, bs_opts, errp);
>>       bs_opts = NULL;
>>       if (!blk) {
>> -        error_propagate(errp, local_err);
>>           goto fail;
>> -    } else {
>> -        assert(!local_err);
>>       }
>>         /* Create legacy DriveInfo */
>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>> index 5f81900f88..aa8c6be210 100644
>> --- a/hw/core/numa.c
>> +++ b/hw/core/numa.c
>> @@ -449,40 +449,33 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>>     void set_numa_options(MachineState *ms, NumaOptions *object,
>> Error **errp)
>>   {
>> -    Error *err = NULL;
>> -
>>       if (!ms->numa_state) {
>>           error_setg(errp, "NUMA is not supported by this machine-type");
>> -        goto end;
>> +        return;
>>       }
>>         switch (object->type) {
>>       case NUMA_OPTIONS_TYPE_NODE:
>> -        parse_numa_node(ms, &object->u.node, &err);
>> -        if (err) {
>> -            goto end;
>> -        }
>> +        parse_numa_node(ms, &object->u.node, errp);
>>           break;
>
> Could we use return here and and for other "break" operators here, to stress, that we
> are not going to do something more in case of failure (as well as in case of
> success)? To prevent the future addition of some code after the switch without
> handling the error carefully here.

Can do.

>>       case NUMA_OPTIONS_TYPE_DIST:
>> -        parse_numa_distance(ms, &object->u.dist, &err);
>> -        if (err) {
>> -            goto end;
>> -        }
>> +        parse_numa_distance(ms, &object->u.dist, errp);
>>           break;
>>       case NUMA_OPTIONS_TYPE_CPU:
>>           if (!object->u.cpu.has_node_id) {
>> -            error_setg(&err, "Missing mandatory node-id property");
>> -            goto end;
>> +            error_setg(errp, "Missing mandatory node-id property");
>> +            return;
>>           }
>>           if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
>> -            error_setg(&err, "Invalid node-id=%" PRId64 ", NUMA node must be "
>> -                "defined with -numa node,nodeid=ID before it's used with "
>> -                "-numa cpu,node-id=ID", object->u.cpu.node_id);
>> -            goto end;
>> +            error_setg(errp, "Invalid node-id=%" PRId64 ", NUMA node must be "
>> +                       "defined with -numa node,nodeid=ID before it's used with "
>> +                       "-numa cpu,node-id=ID", object->u.cpu.node_id);
>> +            return;
>>           }
>>   -        machine_set_cpu_numa_node(ms,
>> qapi_NumaCpuOptions_base(&object->u.cpu),
>> -                                  &err);
>> +        machine_set_cpu_numa_node(ms,
>> +                                  qapi_NumaCpuOptions_base(&object->u.cpu),
>> +                                  errp);
>>           break;
>>       case NUMA_OPTIONS_TYPE_HMAT_LB:
>>           if (!ms->numa_state->hmat_enabled) {
>> @@ -492,10 +485,7 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>>               return;
>>           }
>>   -        parse_numa_hmat_lb(ms->numa_state, &object->u.hmat_lb,
>> &err);
>> -        if (err) {
>> -            goto end;
>> -        }
>> +        parse_numa_hmat_lb(ms->numa_state, &object->u.hmat_lb, errp);
>>           break;
>>       case NUMA_OPTIONS_TYPE_HMAT_CACHE:
>>           if (!ms->numa_state->hmat_enabled) {
>> @@ -505,17 +495,11 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
>>               return;
>>           }
>>   -        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
>> -        if (err) {
>> -            goto end;
>> -        }
>> +        parse_numa_hmat_cache(ms, &object->u.hmat_cache, errp);
>>           break;
>>       default:
>>           abort();
>>       }
>> -
>> -end:
>> -    error_propagate(errp, err);
>>   }
>>     static int parse_numa(void *opaque, QemuOpts *opts, Error
>> **errp)
>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>> index e38030429b..40c34bb9cf 100644
>> --- a/qdev-monitor.c
>> +++ b/qdev-monitor.c
>> @@ -600,7 +600,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>>       const char *driver, *path;
>>       DeviceState *dev = NULL;
>>       BusState *bus = NULL;
>> -    Error *err = NULL;
>>       bool hide;
>>         driver = qemu_opt_get(opts, "driver");
>> @@ -655,15 +654,14 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>>       dev = qdev_new(driver);
>>         /* Check whether the hotplug is allowed by the machine */
>> -    if (qdev_hotplug && !qdev_hotplug_allowed(dev, &err)) {
>> +    if (qdev_hotplug && !qdev_hotplug_allowed(dev, errp)) {
>>           /* Error must be set in the machine hook */
>> -        assert(err);
>>           goto err_del_dev;
>>       }
>>         if (!bus && qdev_hotplug &&
>> !qdev_get_machine_hotplug_handler(dev)) {
>>           /* No bus, no machine hotplug handler --> device is not hotpluggable */
>> -        error_setg(&err, "Device '%s' can not be hotplugged on this machine",
>> +        error_setg(errp, "Device '%s' can not be hotplugged on this machine",
>>                      driver);
>>           goto err_del_dev;
>>       }
>> @@ -671,19 +669,18 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>>       qdev_set_id(dev, qemu_opts_id(opts));
>>         /* set properties */
>> -    if (qemu_opt_foreach(opts, set_property, dev, &err)) {
>> +    if (qemu_opt_foreach(opts, set_property, dev, errp)) {
>
> Here is an example, what I was afraid, when we discussed introducing a lot more
> bool functions (true is success).
>
> Here are two functions with different semantics, and it looks a bit weird,
> one if (func()) and one if (!func()). Still "goto err" makes it obvious
> that it's all about error checking.
>
> I don't remember, did we considered a convention to avoid if (func()) to check
> errors, and use instead if (func() < 0) for such case? So here, update it to be
>
> if (qemu_opt_foreach(opts, set_property, dev, errp) < 0)

qemu_opt_foreach()'s contract:

  /**
   * For each member of @opts, call @func(@opaque, name, value, @errp).
   * @func() may store an Error through @errp, but must return non-zero then.
   * When @func() returns non-zero, break the loop and return that value.
   * Return zero when the loop completes.
   */

Thus, < 0 would be wrong.

Contracts can be changed, of course.  We can make qemu_opt_foreach()
return true on success, and false on failure.  Confusing unless we
change the callback's contract as well, and that requires updating all
the callbacks.  Feasible, just work.

> (I don't insist to do it exactly in this patch, as its aim is another, I just
>  want to remind about this problem)

Appreciated.

>>           goto err_del_dev;
>>       }
>>         dev->opts = opts;
>> -    if (!qdev_realize(DEVICE(dev), bus, &err)) {
>> +    if (!qdev_realize(DEVICE(dev), bus, errp)) {
>>           dev->opts = NULL;
>>           goto err_del_dev;
>>       }
>>       return dev;
>>     err_del_dev:
>> -    error_propagate(errp, err);
>>       if (dev) {
>>           object_unparent(OBJECT(dev));
>>           object_unref(OBJECT(dev));
>>
>
>
> Also, suggest a squash-in, I've noted during previous patch review:
>
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
> index dbe5a8aae6..3cdc406b0d 100644
> --- a/backends/cryptodev-vhost-user.c
> +++ b/backends/cryptodev-vhost-user.c
> @@ -184,15 +184,13 @@ static void cryptodev_vhost_user_init(
>  {
>      int queues = backend->conf.peers.queues;
>      size_t i;
> -    Error *local_err = NULL;
>      Chardev *chr;
>      CryptoDevBackendClient *cc;
>      CryptoDevBackendVhostUser *s =
>                        CRYPTODEV_BACKEND_VHOST_USER(backend);
>  -    chr = cryptodev_vhost_claim_chardev(s, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    chr = cryptodev_vhost_claim_chardev(s, errp);
> +    if (!chr) {
>          return;
>      }

I like this change, but I'd rather not squash it into this patch,
because this patch is about doing exactly the things the previous patch
does with Coccinelle for cases where the Coccinelle script doesn't
match.

In particular, the patch does not switch from "use @local_err to check
for failure" to "use return value to check for failure".

The closest match is probably "[PATCH 10/46] qemu-option: Check return
value instead of @err where convenient", but that one's strictly about
qemu-options.

Perhaps a future series could transform more calls of functions that
return non-null on succes, null on failure.  How can we identify them?
False negatives would be tolerable, false positives absolutely not.


