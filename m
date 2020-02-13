Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D54C3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B227920675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOdYdeOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B227920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GWW-0008Rj-U2
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2GUy-0007Wh-6n
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2GUv-0006rI-Cl
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:33:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37537
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2GUv-0006pl-8e
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 10:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581608028;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zPvEH8Mzcl+eY8F2e6aHCjg9d41U5lr+/0NzmEpBBVw=;
 b=SOdYdeOn9sj5pBCbgwU1AEiIno7VqrQYAMrYyUUKAmw/0j38bybJqRs+Fw+WqhG/9guUX+
 jlStUuuBCntvmDPgHhEDJHcFtvFsoB+LamWYIbQak0b5SoVGDH4DbyUDtR4ZUsRb2N0WGA
 15MxQGQ3ILixO+hmrbhwHWaYy8pMtoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-h9jvieWQNgW1UKSTC3omgw-1; Thu, 13 Feb 2020 10:33:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF4AF1005502
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:33:44 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D09026FAA;
 Thu, 13 Feb 2020 15:33:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 7/8] multifd: Add multifd-zstd-level parameter
In-Reply-To: <87wo8q4m84.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 13 Feb 2020 15:04:43 +0100")
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-8-quintela@redhat.com>
 <20200211184749.GI2751@work-vm> <87wo8q4m84.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 13 Feb 2020 16:33:40 +0100
Message-ID: <87imkalcx7.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: h9jvieWQNgW1UKSTC3omgw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>
>> * Juan Quintela (quintela@redhat.com) wrote:
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> ---
>>>  migration/migration.c | 15 +++++++++++++++
>>>  monitor/hmp-cmds.c    |  4 ++++
>>>  qapi/migration.json   | 29 ++++++++++++++++++++++++++---
>>>  3 files changed, 45 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 3b081e8147..b690500545 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -91,6 +91,8 @@
>>>  #define DEFAULT_MIGRATE_MULTIFD_METHOD MULTIFD_METHOD_NONE
>>>  /*0: means nocompress, 1: best speed, ... 9: best compress ratio */
>>>  #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
>>> +/* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
>>> +#define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
>>> =20
>>>  /* Background transfer rate for postcopy, 0 means unlimited, note
>>>   * that page requests can still exceed this limit.
>>> @@ -805,6 +807,8 @@ MigrationParameters *qmp_query_migrate_parameters(E=
rror **errp)
>>>      params->multifd_method =3D s->parameters.multifd_method;
>>>      params->has_multifd_zlib_level =3D true;
>>>      params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
>>> +    params->has_multifd_zstd_level =3D true;
>>> +    params->multifd_zstd_level =3D s->parameters.multifd_zstd_level;
>>
>> Do we really want different 'multifd_...._level's or just one
>> 'multifd_compress_level' - or even just reuse the existing
>> 'compress-level' parameter.
>
> compress-level,

possible values: 1 to 9 deprecated

> multifd-zlib-level

possible values: 1 to 9, default 1
(zlib default is -1, let the lib decide)

, and multifd-zstd-level apply

possible values: 1 to 19, default 1
(zstd default is 3)

> "normal" live migration compression, multifd zlib live migration
> compression, and multifd zstd live migration compression, respectively.
>
> Any live migration can only use one of the three compressions.
>
> Correct?

Yeap.

>> The only tricky thing about combining them is how to handle
>> the difference in allowed ranges;  When would the right time be
>> to check it?
>>
>> Markus/Eric: Any idea?
>
> To have an informed opinion, I'd have to dig through the migration
> code.

Problem is _how_ to setup them.  if we setup zstd compression method,
put the value at 19, and then setup zlib compression method, what should
we do?

Truncate to 9?
Give one error?
Don't allow the zlib setup?

Too complicated.

> Documentation of admissible range will become a bit awkward, too.
>
> Too many migration parameters...

Sure, but the other option is taking a value and live with it.
I am all for leaving the library default and call it a day.

Later, Juan.


