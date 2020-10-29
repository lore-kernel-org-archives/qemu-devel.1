Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8AEC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C65420790
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcRGuK8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C65420790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYAvF-00015h-0Z
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 12:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYAub-0000a8-4p
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYAuY-0006Pw-FX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603989385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7PhSMFPh0KkjRRYFBjBVZSdhyBiqf+Hoei1+vyZnc1M=;
 b=PcRGuK8A9nsl1SFX4qyT+N9Q0qou8HtY+aoE/cauBnBqzPbyeDavAV5Ma1yrJEl5WpGk5g
 uZ2kSVIK4bhnQmLypMInNzcMVZvX01kDlpJxqdJSrXeQiNSzE5yj7u9cDZRmHjB15dGHFE
 MlWe+f4A6QRWv4bdqvAIZ87HKkYHBc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-jcXXAoWTP8Cr4xNoSfiz9A-1; Thu, 29 Oct 2020 12:36:21 -0400
X-MC-Unique: jcXXAoWTP8Cr4xNoSfiz9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A6D11009E4D;
 Thu, 29 Oct 2020 16:36:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14E465B4A1;
 Thu, 29 Oct 2020 16:36:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 778FE113865F; Thu, 29 Oct 2020 17:36:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v9 1/8] Introduce yank feature
References: <cover.1603909658.git.lukasstraub2@web.de>
 <7b3b182b6ab1a859a1e9fb4ebfa5ce0a7a441e10.1603909658.git.lukasstraub2@web.de>
Date: Thu, 29 Oct 2020 17:36:14 +0100
In-Reply-To: <7b3b182b6ab1a859a1e9fb4ebfa5ce0a7a441e10.1603909658.git.lukasstraub2@web.de>
 (Lukas Straub's message of "Wed, 28 Oct 2020 19:45:14 +0100")
Message-ID: <87a6w556rl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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

Nothing major, looks almost ready to me.

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
>  include/qemu/yank.h |  95 ++++++++++++++++++++
>  qapi/misc.json      | 106 ++++++++++++++++++++++
>  util/meson.build    |   1 +
>  util/yank.c         | 213 ++++++++++++++++++++++++++++++++++++++++++++

checkpatch.pl warns:

    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Can we find a maintainer for the two new files?

>  4 files changed, 415 insertions(+)
>  create mode 100644 include/qemu/yank.h
>  create mode 100644 util/yank.c
>
> diff --git a/include/qemu/yank.h b/include/qemu/yank.h
> new file mode 100644
> index 0000000000..89755e62af
> --- /dev/null
> +++ b/include/qemu/yank.h
> @@ -0,0 +1,95 @@
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
> +#include "qapi/qapi-types-misc.h"
> +
> +typedef void (YankFn)(void *opaque);
> +
> +/**
> + * yank_register_instance: Register a new instance.
> + *
> + * This registers a new instance for yanking. Must be called before any yank
> + * function is registered for this instance.
> + *
> + * This function is thread-safe.
> + *
> + * @instance: The instance.
> + * @errp: Error object.
> + */
> +void yank_register_instance(const YankInstance *instance, Error **errp);
> +
> +/**
> + * yank_unregister_instance: Unregister a instance.
> + *
> + * This unregisters a instance. Must be called only after every yank function
> + * of the instance has been unregistered.
> + *
> + * This function is thread-safe.
> + *
> + * @instance: The instance.
> + */
> +void yank_unregister_instance(const YankInstance *instance);
> +
> +/**
> + * yank_register_function: Register a yank function
> + *
> + * This registers a yank function. All limitations of qmp oob commands apply
> + * to the yank function as well. See docs/devel/qapi-code-gen.txt under
> + * "An OOB-capable command handler must satisfy the following conditions".
> + *
> + * This function is thread-safe.
> + *
> + * @instance: The instance.
> + * @func: The yank function.
> + * @opaque: Will be passed to the yank function.
> + */
> +void yank_register_function(const YankInstance *instance,
> +                            YankFn *func,
> +                            void *opaque);
> +
> +/**
> + * yank_unregister_function: Unregister a yank function
> + *
> + * This unregisters a yank function.
> + *
> + * This function is thread-safe.
> + *
> + * @instance: The instance.
> + * @func: func that was passed to yank_register_function.
> + * @opaque: opaque that was passed to yank_register_function.
> + */
> +void yank_unregister_function(const YankInstance *instance,
> +                              YankFn *func,
> +                              void *opaque);
> +
> +/**
> + * yank_generic_iochannel: Generic yank function for iochannel
> + *
> + * This is a generic yank function which will call qio_channel_shutdown on the
> + * provided QIOChannel.
> + *
> + * @opaque: QIOChannel to shutdown
> + */
> +void yank_generic_iochannel(void *opaque);
> +
> +#define BLOCKDEV_YANK_INSTANCE(the_node_name) (&(YankInstance) { \
> +        .type = YANK_INSTANCE_TYPE_BLOCKDEV, \
> +        .u.blockdev.node_name = (the_node_name) })
> +
> +#define CHARDEV_YANK_INSTANCE(the_id) (&(YankInstance) { \
> +        .type = YANK_INSTANCE_TYPE_CHARDEV, \
> +        .u.chardev.id = (the_id) })
> +
> +#define MIGRATION_YANK_INSTANCE (&(YankInstance) { \
> +        .type = YANK_INSTANCE_TYPE_MIGRATION })
> +
> +#endif
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 40df513856..3b7de02a4d 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -568,3 +568,109 @@
>   'data': { '*option': 'str' },
>   'returns': ['CommandLineOptionInfo'],
>   'allow-preconfig': true }
> +
> +##
> +# @YankInstanceType:
> +#
> +# An enumeration of yank instance types. See "YankInstance" for more

Please write cross-references as @YankInstance.  This gives us a chance
to turn them into links (seems not to be implemented, yet).  More of the
same below.

> +# information.
> +#
> +# Since: 5.2
> +##
> +{ 'enum': 'YankInstanceType',
> +  'data': [ 'blockdev', 'chardev', 'migration' ] }
> +
> +##
> +# @YankInstanceBlockdev:
> +#
> +# Specifies which blockdev to yank. See "YankInstance" for more information.
> +#
> +# @node-name: the blockdev's node-name

Is this really about block devices?  A node-name identifies a block
graph node, which may or may not be associated with a block device.

If I understand PATCH 2 correctly, it makes *any* block node with driver
'nbd' yankable while it has a network connection.  If that's true, then
this is definitely about block graph nodes, not about block devices.

If it is about devices, let's say "block device", not "blockdev".

If it is about nodes, let's say "block graph node".  Also rename
YankInstanceType member 'blockdev' by 'block-node', YankInstanceBlockdev
to YankInstanceBlockNode.

> +#
> +# Since: 5.2
> +##
> +{ 'struct': 'YankInstanceBlockdev',
> +  'data': { 'node-name': 'str' } }
> +
> +##
> +# @YankInstanceChardev:
> +#
> +# Specifies which chardev to yank. See "YankInstance" for more information.

"character device", not "chardev".

> +#
> +# @id: the chardev's ID
> +#
> +# Since: 5.2
> +##
> +{ 'struct': 'YankInstanceChardev',
> +  'data': { 'id': 'str' } }

This is called 'label' in @ChardevInfo.  It's also called 'id' in
@chardev-add.  Oh well, 'id' it is.

> +
> +##
> +# @YankInstance:
> +#
> +# A yank instance can be yanked with the "yank" qmp command to recover from a
> +# hanging qemu.

QEMU

> +#
> +# Currently implemented yank instances:
> +#  -nbd block device:
> +#   Yanking it will shutdown the connection to the nbd server without
> +#   attempting to reconnect.
> +#  -socket chardev:
> +#   Yanking it will shutdown the connected socket.
> +#  -migration:
> +#   Yanking it will shutdown all migration connections.

To my surprise, this is recognized as bullet list markup.  But please
put a space between the bullet and the text anyway.

Also: "shutdown" is a noun, the verb is spelled "shut down".

In my review of v8, I asked how yanking migration is related to command
migrate_cancel.  Daniel explained:

    migrate_cancel will do a shutdown() on the primary migration socket only.
    In addition it will toggle the migration state.

    Yanking will do a shutdown on all migration sockets (important for
    multifd), but won't touch migration state or any other aspect of QEMU
    code.

    Overall yanking has less potential for things to go wrong than the
    migrate_cancel method, as it doesn't try to do any kind of cleanup
    or migration.

Would it make sense to work this into the documentation?

> +#
> +# Since: 5.2
> +##
> +{ 'union': 'YankInstance',
> +  'base': { 'type': 'YankInstanceType' },
> +  'discriminator': 'type',
> +  'data': {
> +      'blockdev': 'YankInstanceBlockdev',
> +      'chardev': 'YankInstanceChardev' } }
> +
> +##
> +# @yank:
> +#
> +# Recover from hanging qemu by yanking the specified instances. See

QEMU

"Try to recover" would be more precise, I think.

> +# "YankInstance" for more information.
> +#
> +# Takes a list of @YankInstance as argument.
> +#
> +# Returns: nothing.
> +#
> +# Example:
> +#
> +# -> { "execute": "yank",
> +#      "arguments": {
> +#          "instances": [
> +#               { "type": "block-node",
> +#                 "node-name": "nbd0" }
> +#          ] } }
> +# <- { "return": {} }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'yank',
> +  'data': { 'instances': ['YankInstance'] },
> +  'allow-oob': true }
> +
> +##
> +# @query-yank:
> +#
> +# Query yank instances. See "YankInstance" for more information.
> +#
> +# Returns: list of @YankInstance
> +#
> +# Example:
> +#
> +# -> { "execute": "query-yank" }
> +# <- { "return": [
> +#          { "type": "block-node",
> +#            "node-name": "nbd0" }
> +#      ] }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'query-yank',
> +  'returns': ['YankInstance'],
> +  'allow-oob': true }
> diff --git a/util/meson.build b/util/meson.build
> index c5159ad79d..dbda9d9123 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -50,6 +50,7 @@ endif
>
>  if have_system
>    util_ss.add(when: 'CONFIG_GIO', if_true: [files('dbus.c'), gio])
> +  util_ss.add(files('yank.c'))
>  endif
>
>  if have_block
> diff --git a/util/yank.c b/util/yank.c
> new file mode 100644
> index 0000000000..0b3a816706
> --- /dev/null
> +++ b/util/yank.c
> @@ -0,0 +1,213 @@
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
> +#include "qapi/qapi-visit-misc.h"
> +#include "qapi/clone-visitor.h"
> +#include "io/channel.h"
> +#include "qemu/yank.h"
> +
> +struct YankFuncAndParam {
> +    YankFn *func;
> +    void *opaque;
> +    QLIST_ENTRY(YankFuncAndParam) next;
> +};
> +
> +struct YankInstanceEntry {
> +    YankInstance *instance;
> +    QLIST_HEAD(, YankFuncAndParam) yankfns;
> +    QLIST_ENTRY(YankInstanceEntry) next;
> +};
> +
> +typedef struct YankFuncAndParam YankFuncAndParam;
> +typedef struct YankInstanceEntry YankInstanceEntry;
> +
> +/*
> + * This lock protects the yank_instance_list below.

Please add something like

    * Because it's taken by OOB-capable commands, it must be "fast",
    * i.e. it may only be held for a bounded, short time.  See
    * docs/devel/qapi-code-gen.txt for additional information.

> + */
> +static QemuMutex yank_lock;
> +
> +static QLIST_HEAD(, YankInstanceEntry) yank_instance_list
> +    = QLIST_HEAD_INITIALIZER(yank_instance_list);
> +
> +static int yank_compare_instances(const YankInstance *a, const YankInstance *b)
> +{
> +    if (a->type != b->type) {
> +        return 0;
> +    }
> +
> +    switch (a->type) {
> +    case YANK_INSTANCE_TYPE_BLOCKDEV:
> +        return !strcmp(a->u.blockdev.node_name, b->u.blockdev.node_name);
> +    break;
> +
> +    case YANK_INSTANCE_TYPE_CHARDEV:
> +        return !strcmp(a->u.chardev.id, b->u.chardev.id);
> +    break;
> +
> +    case YANK_INSTANCE_TYPE_MIGRATION:
> +        return 1;
> +    break;
> +
> +    default:
> +        abort();
> +    }
> +}

Please make this function return bool.  When a comparison function
returns int, I expect it to return negative value when less, zero when
equal, and positive value when greater.

> +
> +static YankInstanceEntry *yank_find_entry(const YankInstance *instance)
> +{
> +    YankInstanceEntry *entry;
> +
> +    QLIST_FOREACH(entry, &yank_instance_list, next) {
> +        if (yank_compare_instances(entry->instance, instance)) {
> +            return entry;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +void yank_register_instance(const YankInstance *instance, Error **errp)
> +{
> +    YankInstanceEntry *entry;
> +
> +    qemu_mutex_lock(&yank_lock);
> +
> +    if (yank_find_entry(instance)) {
> +        error_setg(errp, "duplicate yank instance");

How could this ever be anything but a programming error?

If it is a programming error, use assert(), just like you do in
yank_unregister_instance() below.

> +        qemu_mutex_unlock(&yank_lock);
> +        return;
> +    }
> +
> +    entry = g_slice_new(YankInstanceEntry);

Why not g_new()?  Hmm, GLib documentation says

    For newly written code it is recommended to use the new g_slice API
    instead of g_malloc() and friends, as long as objects are not
    resized during their lifetime and the object size used at allocation
    time is still available when freeing.

I see.

> +    entry->instance = QAPI_CLONE(YankInstance, instance);

You clone so the callers can build the argument on the stack.  Another
way to skin this cat: caller builds on the heap, this function takes
ownership.  But we're at v9, and your code should work just fine :)

> +    QLIST_INIT(&entry->yankfns);
> +    QLIST_INSERT_HEAD(&yank_instance_list, entry, next);
> +
> +    qemu_mutex_unlock(&yank_lock);
> +}
> +
> +void yank_unregister_instance(const YankInstance *instance)
> +{
> +    YankInstanceEntry *entry;
> +
> +    qemu_mutex_lock(&yank_lock);
> +    entry = yank_find_entry(instance);
> +    assert(entry);
> +
> +    assert(QLIST_EMPTY(&entry->yankfns));
> +    QLIST_REMOVE(entry, next);
> +    qapi_free_YankInstance(entry->instance);
> +    g_slice_free(YankInstanceEntry, entry);
> +
> +    qemu_mutex_unlock(&yank_lock);
> +}
> +
> +void yank_register_function(const YankInstance *instance,
> +                            YankFn *func,
> +                            void *opaque)
> +{
> +    YankInstanceEntry *entry;
> +    YankFuncAndParam *func_entry;
> +
> +    qemu_mutex_lock(&yank_lock);
> +    entry = yank_find_entry(instance);
> +    assert(entry);
> +
> +    func_entry = g_slice_new(YankFuncAndParam);
> +    func_entry->func = func;
> +    func_entry->opaque = opaque;
> +
> +    QLIST_INSERT_HEAD(&entry->yankfns, func_entry, next);
> +    qemu_mutex_unlock(&yank_lock);
> +}
> +
> +void yank_unregister_function(const YankInstance *instance,
> +                              YankFn *func,
> +                              void *opaque)
> +{
> +    YankInstanceEntry *entry;
> +    YankFuncAndParam *func_entry;
> +
> +    qemu_mutex_lock(&yank_lock);
> +    entry = yank_find_entry(instance);
> +    assert(entry);
> +
> +    QLIST_FOREACH(func_entry, &entry->yankfns, next) {
> +        if (func_entry->func == func && func_entry->opaque == opaque) {
> +            QLIST_REMOVE(func_entry, next);
> +            g_slice_free(YankFuncAndParam, func_entry);
> +            qemu_mutex_unlock(&yank_lock);
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
> +void qmp_yank(YankInstanceList *instances,
> +              Error **errp)
> +{
> +    YankInstanceList *tail;
> +    YankInstanceEntry *entry;
> +    YankFuncAndParam *func_entry;
> +
> +    qemu_mutex_lock(&yank_lock);
> +    for (tail = instances; tail; tail = tail->next) {
> +        entry = yank_find_entry(tail->value);
> +        if (!entry) {
> +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "Instance not found");

Quote error.h:

 * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
 * strongly discouraged.

Any particular reason for ERROR_CLASS_DEVICE_NOT_FOUND?  If not, then
error_setg(), please.

> +            qemu_mutex_unlock(&yank_lock);
> +            return;
> +        }
> +    }
> +    for (tail = instances; tail; tail = tail->next) {
> +        entry = yank_find_entry(tail->value);
> +        assert(entry);
> +        QLIST_FOREACH(func_entry, &entry->yankfns, next) {
> +            func_entry->func(func_entry->opaque);
> +        }
> +    }
> +    qemu_mutex_unlock(&yank_lock);
> +}
> +
> +YankInstanceList *qmp_query_yank(Error **errp)
> +{
> +    YankInstanceEntry *entry;
> +    YankInstanceList *ret;
> +
> +    ret = NULL;
> +
> +    qemu_mutex_lock(&yank_lock);
> +    QLIST_FOREACH(entry, &yank_instance_list, next) {
> +        YankInstanceList *new_entry;
> +        new_entry = g_new0(YankInstanceList, 1);
> +        new_entry->value = QAPI_CLONE(YankInstance, entry->instance);
> +        new_entry->next = ret;
> +        ret = new_entry;

There is a pull request pending that adds QAPI_LIST_PREPEND().  If it
gets pulled before you respin, using it would be nice.

> +    }
> +    qemu_mutex_unlock(&yank_lock);

Your critical sections all look "fast" to me.  Good.

> +
> +    return ret;
> +}
> +
> +static void __attribute__((__constructor__)) yank_init(void)
> +{
> +    qemu_mutex_init(&yank_lock);
> +}
> --
> 2.20.1


