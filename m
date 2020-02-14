Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DE1C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 08:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFF820873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 08:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CikQuUuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFF820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Wio-0003Iy-Jk
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 03:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2WfN-0001OY-Uf
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 03:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2WfM-0006RL-Bh
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 03:49:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2WfM-0006Qf-7k
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 03:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581670179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZLON0yoa6TND0BhtiWvQdg23CYe2y5xuUYRzCAo/3Q=;
 b=CikQuUuQAjNsT8qCn25YPmFN+rsGBtWYlzF+M+VqspoyoAVSXUY9Pku7pItb2LeTKVHPw5
 ReBAEuYNwB4TkGE/wif+3WMiq/n8SsBw+u+XaENKM1R/CCsVNlvBtQiXf2WunrtMvLf7Vj
 AQX3U6LNXmPYWBgOoaovllCKw8rLWQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-1hMnYoIOP1ePmhYbut9uXg-1; Fri, 14 Feb 2020 03:49:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF0B1005510
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 08:49:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D7D95C1C3;
 Fri, 14 Feb 2020 08:49:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B7D4E11385C9; Fri, 14 Feb 2020 09:49:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v5 7/8] multifd: Add multifd-zstd-level parameter
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-8-quintela@redhat.com>
 <20200211184749.GI2751@work-vm> <87wo8q4m84.fsf@dusky.pond.sub.org>
 <87imkalcx7.fsf@secure.laptop>
Date: Fri, 14 Feb 2020 09:49:34 +0100
In-Reply-To: <87imkalcx7.fsf@secure.laptop> (Juan Quintela's message of "Thu, 
 13 Feb 2020 16:33:40 +0100")
Message-ID: <87imk91rkx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1hMnYoIOP1ePmhYbut9uXg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>>
>>> * Juan Quintela (quintela@redhat.com) wrote:
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> ---
>>>>  migration/migration.c | 15 +++++++++++++++
>>>>  monitor/hmp-cmds.c    |  4 ++++
>>>>  qapi/migration.json   | 29 ++++++++++++++++++++++++++---
>>>>  3 files changed, 45 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 3b081e8147..b690500545 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -91,6 +91,8 @@
>>>>  #define DEFAULT_MIGRATE_MULTIFD_METHOD MULTIFD_METHOD_NONE
>>>>  /*0: means nocompress, 1: best speed, ... 9: best compress ratio */
>>>>  #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
>>>> +/* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
>>>> +#define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
>>>> =20
>>>>  /* Background transfer rate for postcopy, 0 means unlimited, note
>>>>   * that page requests can still exceed this limit.
>>>> @@ -805,6 +807,8 @@ MigrationParameters *qmp_query_migrate_parameters(=
Error **errp)
>>>>      params->multifd_method =3D s->parameters.multifd_method;
>>>>      params->has_multifd_zlib_level =3D true;
>>>>      params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
>>>> +    params->has_multifd_zstd_level =3D true;
>>>> +    params->multifd_zstd_level =3D s->parameters.multifd_zstd_level;
>>>
>>> Do we really want different 'multifd_...._level's or just one
>>> 'multifd_compress_level' - or even just reuse the existing
>>> 'compress-level' parameter.
>>
>> compress-level,
>
> possible values: 1 to 9 deprecated
>
>> multifd-zlib-level
>
> possible values: 1 to 9, default 1
> (zlib default is -1, let the lib decide)
>
> , and multifd-zstd-level apply
>
> possible values: 1 to 19, default 1
> (zstd default is 3)
>
>> "normal" live migration compression, multifd zlib live migration
>> compression, and multifd zstd live migration compression, respectively.
>>
>> Any live migration can only use one of the three compressions.
>>
>> Correct?
>
> Yeap.
>
>>> The only tricky thing about combining them is how to handle
>>> the difference in allowed ranges;  When would the right time be
>>> to check it?
>>>
>>> Markus/Eric: Any idea?
>>
>> To have an informed opinion, I'd have to dig through the migration
>> code.
>
> Problem is _how_ to setup them.  if we setup zstd compression method,
> put the value at 19, and then setup zlib compression method, what should
> we do?
>
> Truncate to 9?
> Give one error?
> Don't allow the zlib setup?
>
> Too complicated.

The interface pretends the parameters are all independent: you get to
set them one by one.

They are in fact not independent, and this now leads to difficulties.

To avoid them, the interface should let you specify a desired
configuration all at once, and its implementation should then do what it
takes to get from here to there.

Example: current state is multifd compression method "zstd", compression
level is 19.  User wants to switch to method "zlib" level 9 the obvious
way

    With old interface:
        step 1: set method to "zlib"
        step 2: set level to 9
    Problem: after step 1, we have method "zlib" with invalid level 19.
    Workaround: swap the steps.

    Note that the workaround only works because the set of levels both
    methods support is non-empty.  We might still come up with more
    complicated parameter combinations where that is not the case.

    With new interface:
        set compression to "zlib" level 9

The new interface require us to specify a QAPI type capable of holding
the complete migration configuration.

The stupid way is to throw all migration parameters into a struct, and
make the ones optional that apply only when others have certain values.
Thus, the "applies only when" bits are semantical, documented in
comments, and enforced by C code.

With a bit more care, we can make "applies only when" syntactical
instead.  Examples:

    @max-bandwidth and @downtime-limit always apply.  They go straight
    into the struct.

    @tls-creds, @tls-hostname, @tls-authz apply only when TLS is enabled
    by setting @tls-creds.  Have an optional member @tls, which is a
    struct with mandatory member @creds, optional members @hostname,
    @authz.

    @multifd-zlib-level applies when @multifd-method is "zlib", and
    @multifd-zstd-level applies when it's "zstd".  Have a union
    @multifd-compression, cases "none", "zlib" and "zstd", where each
    case's members are the parameters applying in that case.

Please note the purpose of these examples is to show how things can be
done in the schema.  I'm not trying to tell you how these specific
things *should* be done.

The resulting type is perfectly suited as return value of a query
command.  It's awkward as argument of a "specify desired configuration"
command, because it requires the user to specify *complete*
configuration.  If we want to support omitting the parts of it we don't
want to change, we have to make more members optional.  Imprecise for
the query, where we now have to specify "always present" in comments.
Usually less bad than duplicating a complex type.

>> Documentation of admissible range will become a bit awkward, too.
>>
>> Too many migration parameters...
>
> Sure, but the other option is taking a value and live with it.
> I am all for leaving the library default and call it a day.
>
> Later, Juan.

Hope this helps some.


