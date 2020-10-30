Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0A8C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64972087E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1NJySxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64972087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYV0o-00062p-8a
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYUz2-0004ku-O0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kYUz0-000601-H6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604066541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JNHM3yfWtHPgWNBcdCD2jLdozfJprCFunJOAm9uBv6Y=;
 b=F1NJySxIc6WC2RUA+EL0HfEaUubcWgFq2uCVzrSVUlIrb8mwKDh04cs+AFa276CK5t28MY
 TrrnFkH0gOtsejbhYYTnsTZH8Dwt8n4a6vElzmSIGq9v1MUmgUqOzSYceZmKMqZDDoxxrF
 YR2DH349eJyaz1vStMoGhj1u3Q0U9Wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-xeq8TlbYN7GnLK3-uie6yw-1; Fri, 30 Oct 2020 10:02:17 -0400
X-MC-Unique: xeq8TlbYN7GnLK3-uie6yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A453C1800D42;
 Fri, 30 Oct 2020 14:02:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 005D74149;
 Fri, 30 Oct 2020 14:02:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B1C5113865F; Fri, 30 Oct 2020 15:02:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v9 1/8] Introduce yank feature
References: <cover.1603909658.git.lukasstraub2@web.de>
 <7b3b182b6ab1a859a1e9fb4ebfa5ce0a7a441e10.1603909658.git.lukasstraub2@web.de>
 <87a6w556rl.fsf@dusky.pond.sub.org> <20201030113212.37ddf1fb@luklap>
Date: Fri, 30 Oct 2020 15:02:09 +0100
In-Reply-To: <20201030113212.37ddf1fb@luklap> (Lukas Straub's message of "Fri, 
 30 Oct 2020 11:32:12 +0100")
Message-ID: <87lffnstge.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Lukas Straub <lukasstraub2@web.de> writes:

> On Thu, 29 Oct 2020 17:36:14 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Nothing major, looks almost ready to me.
>> 
>> Lukas Straub <lukasstraub2@web.de> writes:
>> 
>> > The yank feature allows to recover from hanging qemu by "yanking"
>> > at various parts. Other qemu systems can register themselves and
>> > multiple yank functions. Then all yank functions for selected
>> > instances can be called by the 'yank' out-of-band qmp command.
>> > Available instances can be queried by a 'query-yank' oob command.
>> >
>> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > ---
>> >  include/qemu/yank.h |  95 ++++++++++++++++++++
>> >  qapi/misc.json      | 106 ++++++++++++++++++++++
>> >  util/meson.build    |   1 +
>> >  util/yank.c         | 213 ++++++++++++++++++++++++++++++++++++++++++++  
>> 
>> checkpatch.pl warns:
>> 
>>     WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>> 
>> Can we find a maintainer for the two new files?
>
> Yes, I'm maintaining this for now, see patch 7.

Thanks!  Would it make sense to add the yank stuff to a new QAPI module
yank.json instead of misc.jaon, so the new MAINTAINERS stanza can cover
it?

[...]
>> > diff --git a/qapi/misc.json b/qapi/misc.json
>> > index 40df513856..3b7de02a4d 100644
>> > --- a/qapi/misc.json
>> > +++ b/qapi/misc.json
[...]
>> > +##
>> > +# @YankInstance:
>> > +#
>> > +# A yank instance can be yanked with the "yank" qmp command to recover from a
>> > +# hanging qemu.  
>> 
>> QEMU
>> 
>> > +#
>> > +# Currently implemented yank instances:
>> > +#  -nbd block device:
>> > +#   Yanking it will shutdown the connection to the nbd server without
>> > +#   attempting to reconnect.
>> > +#  -socket chardev:
>> > +#   Yanking it will shutdown the connected socket.
>> > +#  -migration:
>> > +#   Yanking it will shutdown all migration connections.  
>> 
>> To my surprise, this is recognized as bullet list markup.  But please
>> put a space between the bullet and the text anyway.
>> 
>> Also: "shutdown" is a noun, the verb is spelled "shut down".
>
> Both changed for the next version.
>
>> In my review of v8, I asked how yanking migration is related to command
>> migrate_cancel.  Daniel explained:
>> 
>>     migrate_cancel will do a shutdown() on the primary migration socket only.
>>     In addition it will toggle the migration state.
>> 
>>     Yanking will do a shutdown on all migration sockets (important for
>>     multifd), but won't touch migration state or any other aspect of QEMU
>>     code.
>> 
>>     Overall yanking has less potential for things to go wrong than the
>>     migrate_cancel method, as it doesn't try to do any kind of cleanup
>>     or migration.
>> 
>> Would it make sense to work this into the documentation?
>
> How about this?
>
>   - migration:
>     Yanking it will shut down all migration connections. Unlike
>     @migrate_cancel, it will not notify the migration process,
>     so migration will go into @failed state, instead of @cancelled
>     state.

Works for me.  Advice on when to use it rather than migrate_cancel would
be nice, though.

>> > +#
>> > +# Since: 5.2
>> > +##
>> > +{ 'union': 'YankInstance',
>> > +  'base': { 'type': 'YankInstanceType' },
>> > +  'discriminator': 'type',
>> > +  'data': {
>> > +      'blockdev': 'YankInstanceBlockdev',
>> > +      'chardev': 'YankInstanceChardev' } }
>> > +
>> > +##
>> > +# @yank:
>> > +#
>> > +# Recover from hanging qemu by yanking the specified instances. See  
>> 
>> QEMU
>> 
>> "Try to recover" would be more precise, I think.
>
> Changed for the next version.
>
>> > +# "YankInstance" for more information.
>> > +#
>> > +# Takes a list of @YankInstance as argument.
>> > +#
>> > +# Returns: nothing.
>> > +#
>> > +# Example:
>> > +#
>> > +# -> { "execute": "yank",
>> > +#      "arguments": {
>> > +#          "instances": [
>> > +#               { "type": "block-node",
>> > +#                 "node-name": "nbd0" }
>> > +#          ] } }
>> > +# <- { "return": {} }
>> > +#
>> > +# Since: 5.2
>> > +##
>> > +{ 'command': 'yank',
>> > +  'data': { 'instances': ['YankInstance'] },
>> > +  'allow-oob': true }
>> > +
[...]
>> > diff --git a/util/yank.c b/util/yank.c
>> > new file mode 100644
>> > index 0000000000..0b3a816706
>> > --- /dev/null
>> > +++ b/util/yank.c
[...]
>> > +void qmp_yank(YankInstanceList *instances,
>> > +              Error **errp)
>> > +{
>> > +    YankInstanceList *tail;
>> > +    YankInstanceEntry *entry;
>> > +    YankFuncAndParam *func_entry;
>> > +
>> > +    qemu_mutex_lock(&yank_lock);
>> > +    for (tail = instances; tail; tail = tail->next) {
>> > +        entry = yank_find_entry(tail->value);
>> > +        if (!entry) {
>> > +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "Instance not found");  
>> 
>> Quote error.h:
>> 
>>  * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
>>  * strongly discouraged.
>> 
>> Any particular reason for ERROR_CLASS_DEVICE_NOT_FOUND?  If not, then
>> error_setg(), please.
>
> There may be a time-to-check to time-to-use race condition here. Suppose
> the management application (via QMP) calls 'blockev-del nbd0', then QEMU
> hangs, so after a timeout it calls 'yank nbd0' while shortly before that
> QEMU unhangs for some reason and removes the blockdev. Then yank returns
> this error.
>
> QMP errors should not be parsed except for the error class, so the the
> management application can only differentiate between this (ignorable)
> error and other (possibly fatal) ones by parsing the error class.

I see.

DeviceNotFound doesn't really fit, but none of the other error classes
is any better.

I think the line

      # Returns: nothing.

in the QAPI schema (quoted above) should be expanded to something like


      # Returns: - Nothing on success
                 - If the YankInstance doesn't exist, DeviceNotFound

>> > +            qemu_mutex_unlock(&yank_lock);
>> > +            return;
>> > +        }
>> > +    }
>> > +    for (tail = instances; tail; tail = tail->next) {
>> > +        entry = yank_find_entry(tail->value);
>> > +        assert(entry);
>> > +        QLIST_FOREACH(func_entry, &entry->yankfns, next) {
>> > +            func_entry->func(func_entry->opaque);
>> > +        }
>> > +    }
>> > +    qemu_mutex_unlock(&yank_lock);
>> > +}
[...]


