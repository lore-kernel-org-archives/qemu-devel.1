Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D606C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD93F222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsF6shW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD93F222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EXq-000699-4h
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2EX0-0005hX-1m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2EWy-0003AR-KX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:27:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2EWy-0003A0-GT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581600467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVACvJE2iDdy2aQ/FlMkm7ngfFvDanAmGURJDONj6uY=;
 b=RsF6shW86vkzbRAhQS2m68JqzE+wylab8pEqhiQeapZoIkcRoSTrPkXEnu46L6wKSOAc7p
 OBiNm5rs19C96QmBAdbAyRgf8jHBNUjTL8xe/YUIMX1IkNuITw+zI7Znd6hjF35t6AYUJk
 /bSbTYyPLYslUTf0EUL4MuG/sHXrdro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-J8Lie6gQNfudJt3PxnvdNA-1; Thu, 13 Feb 2020 08:27:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DEA4800D41
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 13:27:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E330A60BF4;
 Thu, 13 Feb 2020 13:27:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E30E11385C9; Thu, 13 Feb 2020 14:27:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v5 4/8] multifd: Add multifd-zlib-level parameter
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-5-quintela@redhat.com>
 <87eevhxtfv.fsf@dusky.pond.sub.org>
 <20200211185728.GQ55376@redhat.com>
Date: Thu, 13 Feb 2020 14:27:42 +0100
In-Reply-To: <20200211185728.GQ55376@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
 =?utf-8?Q?rang=C3=A9=22's?=
 message of "Tue, 11 Feb 2020 18:57:28 +0000")
Message-ID: <871rqy62i9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: J8Lie6gQNfudJt3PxnvdNA-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

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

This expresses the connection between compression mode and level.  In
general, we prefer that to a bunch of optional members where the
comments say things like "member A can be present only when member B has
value V", or worse "member A is silently ignored unless member B has
value V".  However:

> Of course this is quite different from how migration parameters are
> done today. Maybe it makes sense to stick with the flat list of
> migration parameters for consistency & ignore normal QAPI design
> practice ?

Unsure.  It's certainly ugly now.  Each parameter is defined in three
places: enum MigrationParameter (for HMP), struct MigrateSetParameters
(for QMP migrate-set-parameters), and struct MigrationParameters (for
QMP query-migrate-parameters).

I don't know how to make this better other than by starting over.
I don't know whether starting over would result in enough of an
improvement to make it worthwhile.


