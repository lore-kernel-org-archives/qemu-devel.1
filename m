Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0813C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A77552177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIOtH6hV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77552177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHA4-0006d4-Um
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kBH9W-00069U-Ef
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:37:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30258
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kBH9T-0005hL-G5
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598531829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jp6f2L9WUFYaQpTHhtlU9nPp2fBc2ZkR5BAESFxmm88=;
 b=JIOtH6hVhdc6WsQE18la4NUqIb/KoGCo0DFt0Br/SQoxBuVwqoh4rXhbDrpK2xZEjSuzOk
 UnwKNGAjtZtA7+n3E/H/Gt7d5UMpuugrnIM3Al6bLlvBuU5bitejgo68wJy3rfuOKiMCAS
 EvmwOmVAikfRf2h6FzwE5gx1zm3YNuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-zay82F2jOnK6cfMHlQzRxg-1; Thu, 27 Aug 2020 08:37:07 -0400
X-MC-Unique: zay82F2jOnK6cfMHlQzRxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0EB81DE0A;
 Thu, 27 Aug 2020 12:37:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28ED55D9E8;
 Thu, 27 Aug 2020 12:37:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 78D8D112D737; Thu, 27 Aug 2020 14:37:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v7 1/8] Introduce yank feature
References: <cover.1596528468.git.lukasstraub2@web.de>
 <0092d4fe5f64078a18db3790c46c508416dbdb6b.1596528468.git.lukasstraub2@web.de>
Date: Thu, 27 Aug 2020 14:37:00 +0200
In-Reply-To: <0092d4fe5f64078a18db3790c46c508416dbdb6b.1596528468.git.lukasstraub2@web.de>
 (Lukas Straub's message of "Tue, 4 Aug 2020 10:11:34 +0200")
Message-ID: <871rjs9ser.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I apologize for not reviewing this much earlier.

Lukas Straub <lukasstraub2@web.de> writes:

> The yank feature allows to recover from hanging qemu by "yanking"
> at various parts. Other qemu systems can register themselves and
> multiple yank functions. Then all yank functions for selected
> instances can be called by the 'yank' out-of-band qmp command.
> Available instances can be queried by a 'query-yank' oob command.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/yank.h |  80 +++++++++++++++++++
>  qapi/misc.json      |  45 +++++++++++
>  util/Makefile.objs  |   1 +
>  util/yank.c         | 184 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 310 insertions(+)
>  create mode 100644 include/qemu/yank.h
>  create mode 100644 util/yank.c
>
> diff --git a/include/qemu/yank.h b/include/qemu/yank.h
> new file mode 100644
> index 0000000000..cd184fcd05
> --- /dev/null
> +++ b/include/qemu/yank.h
> @@ -0,0 +1,80 @@
> +/*
> + * QEMU yank feature
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef YANK_H
> +#define YANK_H
> +
> +typedef void (YankFn) (void *opaque);

No space before parameter lists, please.

> +
> +/**
> + * yank_register_instance: Register a new instance.
> + *
> + * This registers a new instance for yanking. Must be called before any yank
> + * function is registered for this instance.
> + *
> + * This function is thread-safe.
> + *
> + * @instance_name: The globally unique name of the instance.
> + * @errp: ...
> + */
> +void yank_register_instance(const char *instance_name, Error **errp);
> +
> +/**
> + * yank_unregister_instance: Unregister a instance.
> + *
> + * This unregisters a instance. Must be called only after every yank function
> + * of the instance has been unregistered.
> + *
> + * This function is thread-safe.
> + *
> + * @instance_name: The name of the instance.
> + */
> +void yank_unregister_instance(const char *instance_name);
> +
> +/**
> + * yank_register_function: Register a yank function
> + *
> + * This registers a yank function. All limitations of qmp oob commands apply
> + * to the yank function as well.

The restrictions are documented in docs/devel/qapi-code-gen.txt under
"An OOB-capable command handler must satisfy the following conditions".
Let's point there,

> + *
> + * This function is thread-safe.
> + *
> + * @instance_name: The name of the instance
> + * @func: The yank function
> + * @opaque: Will be passed to the yank function
> + */
> +void yank_register_function(const char *instance_name,
> +                            YankFn *func,
> +                            void *opaque);

Pardon my ignorance... can you explain to me why a yank instance may
have multiple functions?

> +
> +/**
> + * yank_unregister_function: Unregister a yank function
> + *
> + * This unregisters a yank function.
> + *
> + * This function is thread-safe.
> + *
> + * @instance_name: The name of the instance
> + * @func: func that was passed to yank_register_function
> + * @opaque: opaque that was passed to yank_register_function
> + */
> +void yank_unregister_function(const char *instance_name,
> +                              YankFn *func,
> +                              void *opaque);
> +
> +/**
> + * yank_unregister_function: Generic yank function for iochannel

Pasto, should be

    * yank_generic_iochannel: ...

> + *
> + * This is a generic yank function which will call qio_channel_shutdown on the
> + * provided QIOChannel.
> + *
> + * @opaque: QIOChannel to shutdown
> + */
> +void yank_generic_iochannel(void *opaque);
> +#endif
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 9d32820dc1..0d6a8f20b7 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1615,3 +1615,48 @@
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>
> +##
> +# @YankInstances:
> +#
> +# @instances: List of yank instances.
> +#
> +# Yank instances are named after the following schema:
> +# "blockdev:<node-name>", "chardev:<chardev-name>" and "migration"
> +#
> +# Since: 5.1
> +##
> +{ 'struct': 'YankInstances', 'data': {'instances': ['str'] } }

I'm afraid this is a problematic QMP interface.

By making YankInstances a struct, you keep the door open to adding more
members, which is good.

But by making its 'instances' member a ['str'], you close the door to
using anything but a single string for the individual instances.  Not so
good.

The single string encodes information which QMP client will need to
parse from the string.  We frown on that in QMP.  Use QAPI complex types
capabilities for structured data.

Could you use something like this instead?

{ 'enum': 'YankInstanceType',
  'data': { 'block-node', 'chardev', 'migration' } }

{ 'struct': 'YankInstanceBlockNode',
  'data': { 'node-name': 'str' } }

{ 'struct': 'YankInstanceChardev',
  'data' { 'label': 'str' } }

{ 'union': 'YankInstance',
  'base': { 'type': 'YankInstanceType' },
  'discriminator': 'type',
  'data': {
      'block-node': 'YankInstanceBlockNode',
      'chardev': 'YankInstanceChardev' } }

{ 'command': 'yank',
  'data': { 'instances': ['YankInstance'] },
  'allow-oob': true }

If you're confident nothing will ever be added to YankInstanceBlockNode
and YankInstanceChardev, you could use str instead.

> +
> +##
> +# @yank:
> +#
> +# Recover from hanging qemu by yanking the specified instances.

What's an "instance", and what does it mean to "yank" it?

The documentation of YankInstances above gives a clue on what an
"instance" is: presumably a block node, a character device or the
migration job.

I guess a YankInstance is whatever the code chooses to make one, and the
current code makes these three kinds.

Does it make every block node a YankInstance?  If not, which ones?

Does it make every character device a YankInstance?  If not, which ones?

Does it make migration always a YankInstance?  If not, when?

> +#
> +# Takes @YankInstances as argument.
> +#
> +# Returns: nothing.
> +#
> +# Example:
> +#
> +# -> { "execute": "yank", "arguments": { "instances": ["blockdev:nbd0"] } }
> +# <- { "return": {} }
> +#
> +# Since: 5.1
> +##
> +{ 'command': 'yank', 'data': 'YankInstances', 'allow-oob': true }
> +
> +##
> +# @query-yank:
> +#
> +# Query yank instances.
> +#
> +# Returns: @YankInstances
> +#
> +# Example:
> +#
> +# -> { "execute": "query-yank" }
> +# <- { "return": { "instances": ["blockdev:nbd0"] } }
> +#
> +# Since: 5.1
> +##
> +{ 'command': 'query-yank', 'returns': 'YankInstances', 'allow-oob': true }
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index cc5e37177a..13faa98425 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -45,6 +45,7 @@ util-obj-$(CONFIG_GIO) += dbus.o
>  dbus.o-cflags = $(GIO_CFLAGS)
>  dbus.o-libs = $(GIO_LIBS)
>  util-obj-$(CONFIG_USER_ONLY) += selfmap.o
> +util-obj-y += yank.o
>
>  #######################################################################
>  # code used by both qemu system emulation and qemu-img
> diff --git a/util/yank.c b/util/yank.c
> new file mode 100644
> index 0000000000..b0cd27728b
> --- /dev/null
> +++ b/util/yank.c
> @@ -0,0 +1,184 @@
> +/*
> + * QEMU yank feature
> + *
> + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/thread.h"
> +#include "qemu/queue.h"
> +#include "qapi/qapi-commands-misc.h"
> +#include "io/channel.h"
> +#include "qemu/yank.h"
> +
> +struct YankFuncAndParam {
> +    YankFn *func;
> +    void *opaque;
> +    QLIST_ENTRY(YankFuncAndParam) next;
> +};
> +
> +struct YankInstance {
> +    char *name;
> +    QLIST_HEAD(, YankFuncAndParam) yankfns;
> +    QLIST_ENTRY(YankInstance) next;
> +};
> +
> +static QemuMutex lock;

Please give the variable a more telling name, such as @yank_lock, and
document what exactly the lock protects.  I can guess it's just the list
that immediately follows, but I prefer to be explicit when it comes to
locking.

> +static QLIST_HEAD(yankinst_list, YankInstance) head
> +    = QLIST_HEAD_INITIALIZER(head);

Please give the variable a more telling name, such as
@yank_instance_list.

I doubt there is a need to name the struct.  This should do:

   static QLIST_HEAD(, YankInstance) yank_instance_list

> +
> +static struct YankInstance *yank_find_instance(const char *name)
> +{
> +    struct YankInstance *tmp, *instance;
> +    instance = NULL;
> +    QLIST_FOREACH(tmp, &head, next) {
> +        if (!strcmp(tmp->name, name)) {
> +            instance = tmp;
> +        }
> +    }
> +    return instance;
> +}

Suggest

   static struct YankInstance *yank_find_instance(const char *name)
   {
       struct YankInstance *instance;

       QLIST_FOREACH(instance, &head, next) {
           if (!strcmp(instance->name, name)) {
               return instance;
           }
       }
       return NULL;
   }

> +
> +void yank_register_instance(const char *instance_name, Error **errp)
> +{
> +    struct YankInstance *instance;
> +
> +    qemu_mutex_lock(&lock);
> +
> +    if (yank_find_instance(instance_name)) {
> +        error_setg(errp, "duplicate yank instance name: '%s'", instance_name);

Rather long line, suggest to wrap before the last argument.

> +        qemu_mutex_unlock(&lock);
> +        return;
> +    }
> +
> +    instance = g_slice_new(struct YankInstance);
> +    instance->name = g_strdup(instance_name);
> +    QLIST_INIT(&instance->yankfns);
> +    QLIST_INSERT_HEAD(&head, instance, next);
> +
> +    qemu_mutex_unlock(&lock);
> +}
> +
> +void yank_unregister_instance(const char *instance_name)
> +{
> +    struct YankInstance *instance;
> +
> +    qemu_mutex_lock(&lock);
> +    instance = yank_find_instance(instance_name);
> +    assert(instance);
> +
> +    assert(QLIST_EMPTY(&instance->yankfns));
> +    QLIST_REMOVE(instance, next);
> +    g_free(instance->name);
> +    g_slice_free(struct YankInstance, instance);
> +
> +    qemu_mutex_unlock(&lock);
> +}
> +
> +void yank_register_function(const char *instance_name,
> +                            YankFn *func,
> +                            void *opaque)
> +{
> +    struct YankInstance *instance;
> +    struct YankFuncAndParam *entry;
> +
> +    qemu_mutex_lock(&lock);
> +    instance = yank_find_instance(instance_name);
> +    assert(instance);
> +
> +    entry = g_slice_new(struct YankFuncAndParam);
> +    entry->func = func;
> +    entry->opaque = opaque;
> +
> +    QLIST_INSERT_HEAD(&instance->yankfns, entry, next);
> +    qemu_mutex_unlock(&lock);
> +}
> +
> +void yank_unregister_function(const char *instance_name,
> +                              YankFn *func,
> +                              void *opaque)
> +{
> +    struct YankInstance *instance;
> +    struct YankFuncAndParam *entry;
> +
> +    qemu_mutex_lock(&lock);
> +    instance = yank_find_instance(instance_name);
> +    assert(instance);
> +
> +    QLIST_FOREACH(entry, &instance->yankfns, next) {
> +        if (entry->func == func && entry->opaque == opaque) {
> +            QLIST_REMOVE(entry, next);
> +            g_slice_free(struct YankFuncAndParam, entry);
> +            qemu_mutex_unlock(&lock);
> +            return;
> +        }
> +    }
> +
> +    abort();
> +}
> +
> +void yank_generic_iochannel(void *opaque)
> +{
> +    QIOChannel *ioc = QIO_CHANNEL(opaque);
> +
> +    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> +}
> +
> +void qmp_yank(strList *instances,
> +              Error **errp)
> +{
> +    strList *tmp;
> +    struct YankInstance *instance;
> +    struct YankFuncAndParam *entry;
> +
> +    qemu_mutex_lock(&lock);
> +    tmp = instances;
> +    for (; tmp; tmp = tmp->next) {

Make that

       for (tail = instances; tail; tail = tail->next) {

> +        instance = yank_find_instance(tmp->value);
> +        if (!instance) {
> +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> +                      "Instance '%s' not found", tmp->value);
> +            qemu_mutex_unlock(&lock);
> +            return;
> +        }
> +    }
> +    tmp = instances;
> +    for (; tmp; tmp = tmp->next) {

Likewise.

> +        instance = yank_find_instance(tmp->value);
> +        assert(instance);
> +        QLIST_FOREACH(entry, &instance->yankfns, next) {
> +            entry->func(entry->opaque);
> +        }
> +    }
> +    qemu_mutex_unlock(&lock);
> +}
> +
> +YankInstances *qmp_query_yank(Error **errp)
> +{
> +    struct YankInstance *instance;
> +    YankInstances *ret;
> +
> +    ret = g_new0(YankInstances, 1);
> +    ret->instances = NULL;
> +
> +    qemu_mutex_lock(&lock);
> +    QLIST_FOREACH(instance, &head, next) {
> +        strList *entry;
> +        entry = g_new0(strList, 1);
> +        entry->value = g_strdup(instance->name);
> +        entry->next = ret->instances;
> +        ret->instances = entry;
> +    }
> +    qemu_mutex_unlock(&lock);
> +
> +    return ret;
> +}
> +
> +static void __attribute__((__constructor__)) yank_init(void)
> +{
> +    qemu_mutex_init(&lock);
> +}
> --
> 2.20.1

The two QMP commands permit out-of-band execution ('allow-oob': true).
OOB is easy to get wrong, but I figure you have a legitimate use case.
Let's review the restrictions documented in
docs/devel/qapi-code-gen.txt:

    An OOB-capable command handler must satisfy the following conditions:

    - It terminates quickly.
    - It does not invoke system calls that may block.
    - It does not access guest RAM that may block when userfaultfd is
      enabled for postcopy live migration.
    - It takes only "fast" locks, i.e. all critical sections protected by
      any lock it takes also satisfy the conditions for OOB command
      handler code.

Since the command handlers take &lock, the restrictions apply to the
other critical sections protected by &lock as well.  I believe these are
all okay: they do nothing but allocate, initialize and free memory.

The restrictions also apply to the YankFn callbacks, but you documented
that.  Okay.

The one such callback included in this patch is
yank_generic_iochannel(), which is a thin wrapper around
qio_channel_shutdown(), which in turn runs the io_shutdown method.
Thus, the restructions also apply to all the io_shutdown methods.
That's not documented.

Daniel, should it be documented?


