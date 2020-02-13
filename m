Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA51C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A22C24677
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUJmgAPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A22C24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2HSW-0001OO-87
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2HR7-0000Gs-6p
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2HR5-0001Lt-4k
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:33:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21071
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2HR0-0001Gw-QO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581611630;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Sh4JJ2KOezV00QcC7TQ2lg2iZzt7bhQNfK+UfSEiDw=;
 b=HUJmgAPZ7TLOjqmmOUylhMRz6KhgeHW1udzL4F7WCheNki81fRLWqhb9Ep1fzhdu32UtXd
 vbi4Rz1h89M1HpItxNV5nj6rCmEKkGvQJYlryGeVAT+wlTSn7lGfWN5lkD8jiNP+kBBB2q
 cC2gMPvNr9rWHRxsoeAn/xhkya3SVuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-GSPaQct6NsKGINXlx6czZA-1; Thu, 13 Feb 2020 11:33:48 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6A278C80DC
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:33:47 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B8F35C100;
 Thu, 13 Feb 2020 16:33:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v5 4/8] multifd: Add multifd-zlib-level parameter
In-Reply-To: <20200211185728.GQ55376@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
 =?utf-8?Q?rang=C3=A9=22's?=
 message of "Tue, 11 Feb 2020 18:57:28 +0000")
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-5-quintela@redhat.com>
 <87eevhxtfv.fsf@dusky.pond.sub.org>
 <20200211185728.GQ55376@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 13 Feb 2020 17:33:43 +0100
Message-ID: <87d0aila54.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: GSPaQct6NsKGINXlx6czZA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Jan 30, 2020 at 09:03:00AM +0100, Markus Armbruster wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>=20
>> > It will indicate which level use for compression.
>> >
>> > Signed-off-by: Juan Quintela <quintela@redhat.com>
>>=20
>> This is slightly confusing (there is no zlib compression), unless you
>> peek at the next patch (which adds zlib compression).
>>=20
>> Three ways to make it less confusing:
>>=20
>> * Squash the two commits
>>=20
>> * Swap them: first add zlib compression with level hardcoded to 1, then
>>   make the level configurable.
>>=20
>> * Have the first commit explain itself better.  Something like
>>=20
>>     multifd: Add multifd-zlib-level parameter
>>=20
>>     This parameter specifies zlib compression level.  The next patch
>>     will put it to use.
>
> Wouldn't the "normal" best practice for QAPI design be to use a
> enum and discriminated union. eg
>
>   { 'enum': 'MigrationCompression',
>      'data': ['none', 'zlib'] }
>
>   { 'struct': 'MigrationCompressionParamsZLib',
>     'data': { 'compression-level' } }
>
>   { 'union':  'MigrationCompressionParams',
>     'base': { 'mode': 'MigrationCompression' },
>     'discriminator': 'mode',
>     'data': {
>       'zlib': 'MigrationCompressionParamsZLib',
>     }

How is this translate into HMP?

Markus says to start over, so lets see the dependencies:

Announce: Allawys there

announce-initial
announce-max
announce-rounds
announce-step

Osd compression (deprecated)

compress-level
compress-threads
compress-wait-thread
decompress-threads

cpu-throttles-initial
cpu-throottle-incroment
max-cpu-throotle

tls-creds
tls-hostname
tls-auth


Real params

max-bandwidth
downtime-limit


colo

x-checkpoint-delay

block-incremental

multifd-channels

xbzrle-cache-size

max-postcopy-bandwidth

New things:
- multifd method
- multifd-zlib-level
- multifd-zstd-level

What is a good way to define them?

Why do I ask, because the current method is as bad as it can be.
To add a new parameter:
- for qapi, add it in three places (as Markus said)
- go to hmp-cmds.c and do things by hand
- qemu_migrate_set_parameters
- migrate_params_check
- migrate_params_apply
(last three functions are almost identical in structure, not in
content).

So, if you can give me something that is _easier_ of maintaining, I am
all ears.

Later, Juan.

>
> Of course this is quite different from how migration parameters are
> done today. Maybe it makes sense to stick with the flat list of
> migration parameters for consistency & ignore normal QAPI design
> practice ?
>
>
> Regards,
> Daniel


