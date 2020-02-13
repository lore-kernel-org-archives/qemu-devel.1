Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A087CC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4812168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jqv97aKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4812168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2LIM-0000q9-MQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 15:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2LHA-0000D0-UM
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:39:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2LH9-0000IT-Ap
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:39:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25217
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2LH9-0000E2-19
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:39:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581626393;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSKoiknNpKea2AgcJImaOmmEzmIyNeOhQm/8X/SyHcw=;
 b=Jqv97aKx7Ku0buHxQU0fJeqRebjnfOtgd7G9s73wu81ZvPEze0oSq/1RTEsq7VRsv8wLeP
 f/Rt4reIMy7k4nXGRW3BehFK6ylcXRtUDZ8DVw9BI/69eIWFaOMJZRC9L/9siyHq0H4Gvc
 2nij9+kex4Z/dEtIVRv6hiqhNd+Q9us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-O5MWiyUuPa-8BbVjLMwFjQ-1; Thu, 13 Feb 2020 15:39:50 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F1F11B18BC0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 20:39:50 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A96215C1BB;
 Thu, 13 Feb 2020 20:39:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 8/8] multifd: Add zstd compression multifd support
In-Reply-To: <20200211200151.GJ2751@work-vm> (David Alan Gilbert's message of
 "Tue, 11 Feb 2020 20:01:51 +0000")
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-9-quintela@redhat.com>
 <20200211200151.GJ2751@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 13 Feb 2020 21:39:45 +0100
Message-ID: <87mu9mjk6m.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: O5MWiyUuPa-8BbVjLMwFjQ-1
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
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  hw/core/qdev-properties.c    |   2 +-
>>  migration/Makefile.objs      |   1 +
>>  migration/migration.c        |   9 +
>>  migration/migration.h        |   1 +
>>  migration/multifd-zstd.c     | 337 +++++++++++++++++++++++++++++++++++
>>  migration/multifd.h          |   2 +-
>>  migration/ram.c              |   1 -
>>  qapi/migration.json          |   4 +-
>>  tests/qtest/migration-test.c |  10 ++
>>  9 files changed, 363 insertions(+), 4 deletions(-)
>>  create mode 100644 migration/multifd-zstd.c

>> +    res =3D ZSTD_initCStream(z->zcs, migrate_multifd_zstd_level());
>> +    if (ZSTD_isError(res)) {
>> +        ZSTD_freeCStream(z->zcs);
>> +        g_free(z);
>> +        error_setg(errp, "multifd %d: initCStream failed", p->id);
>
> It might be useful to print 'res' here - you seem to decode it on the
> receive side.

Fixed all callers.

>> @@ -163,6 +164,5 @@ typedef struct {
>>  } MultiFDMethods;
>> =20
>>  void multifd_register_ops(int method, MultiFDMethods *ops);
>> -
>
> Oddment.

oops.  Removed the chunk.
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks.


