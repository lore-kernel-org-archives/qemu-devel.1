Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9EFC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B072073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMNUD9zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B072073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2F7j-0007NX-RS
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2F6o-0006SK-KC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2F6m-0000sk-V3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:04:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33134
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2F6m-0000sa-RQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581602688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIzoajkaQ3d6/hLmrNbJtIQ1jsVrxvtAnrQE+B8Hebk=;
 b=ZMNUD9zmd7p2kU2k40Li+kWxtAsNIH6slJJ+bte5EN0AH/Oa+8a+lpi1B6qEf7cE+3z2FS
 Rn/aJK9zGP8QVza1m6quGmMzMq11k0RCDUxCdAP9ux8IriUFc17VfsPDusiTzF/IUNBZ1e
 tL6eABivp9J4WTy2k6cQFK0zjsd9SCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-eZ1NOBUWMBaKGGq1oDLFrA-1; Thu, 13 Feb 2020 09:04:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB0C8010F2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:04:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1A2B77921;
 Thu, 13 Feb 2020 14:04:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2A71F11385C9; Thu, 13 Feb 2020 15:04:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 7/8] multifd: Add multifd-zstd-level parameter
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-8-quintela@redhat.com>
 <20200211184749.GI2751@work-vm>
Date: Thu, 13 Feb 2020 15:04:43 +0100
In-Reply-To: <20200211184749.GI2751@work-vm> (David Alan Gilbert's message of
 "Tue, 11 Feb 2020 18:47:49 +0000")
Message-ID: <87wo8q4m84.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: eZ1NOBUWMBaKGGq1oDLFrA-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/migration.c | 15 +++++++++++++++
>>  monitor/hmp-cmds.c    |  4 ++++
>>  qapi/migration.json   | 29 ++++++++++++++++++++++++++---
>>  3 files changed, 45 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3b081e8147..b690500545 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -91,6 +91,8 @@
>>  #define DEFAULT_MIGRATE_MULTIFD_METHOD MULTIFD_METHOD_NONE
>>  /*0: means nocompress, 1: best speed, ... 9: best compress ratio */
>>  #define DEFAULT_MIGRATE_MULTIFD_ZLIB_LEVEL 1
>> +/* 0: means nocompress, 1: best speed, ... 20: best compress ratio */
>> +#define DEFAULT_MIGRATE_MULTIFD_ZSTD_LEVEL 1
>> =20
>>  /* Background transfer rate for postcopy, 0 means unlimited, note
>>   * that page requests can still exceed this limit.
>> @@ -805,6 +807,8 @@ MigrationParameters *qmp_query_migrate_parameters(Er=
ror **errp)
>>      params->multifd_method =3D s->parameters.multifd_method;
>>      params->has_multifd_zlib_level =3D true;
>>      params->multifd_zlib_level =3D s->parameters.multifd_zlib_level;
>> +    params->has_multifd_zstd_level =3D true;
>> +    params->multifd_zstd_level =3D s->parameters.multifd_zstd_level;
>
> Do we really want different 'multifd_...._level's or just one
> 'multifd_compress_level' - or even just reuse the existing
> 'compress-level' parameter.

compress-level, multifd-zlib-level, and multifd-zstd-level apply
"normal" live migration compression, multifd zlib live migration
compression, and multifd zstd live migration compression, respectively.

Any live migration can only use one of the three compressions.

Correct?

> The only tricky thing about combining them is how to handle
> the difference in allowed ranges;  When would the right time be
> to check it?
>
> Markus/Eric: Any idea?

To have an informed opinion, I'd have to dig through the migration
code.

Documentation of admissible range will become a bit awkward, too.

Too many migration parameters...


