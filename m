Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E392C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1B02168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ga+c7755"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1B02168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2L4E-0003de-An
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 15:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2L2t-0002eT-8e
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2L2s-0006cj-8c
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:25:11 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2L2s-0006at-4G
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581625509;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z91YD+wNqo4iSr/Tc2T/4xWPZtbIjpEjf+PHAmCyj/8=;
 b=Ga+c7755SNcqM7XHNoSBPc2zVhPP9Jse2wEbmPOC4VwFtS20qCiNWbrP45apQCvun4i/mt
 L/xxGh71Z5F0LcLlAVd/8gRKd8On8W2rsOfdmyZxmIBi2eXWkx33ohLciyWmPe9poxevnh
 cWvDAm6XnLCTX4xqp48fw9p4K5icGd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-Ff2mQTJIPi--aw2_yQ_AjQ-1; Thu, 13 Feb 2020 15:25:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3573800D4C
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 20:25:06 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80CAA8AC41;
 Thu, 13 Feb 2020 20:25:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 5/8] multifd: Add zlib compression multifd support
In-Reply-To: <20200211184332.GH2751@work-vm> (David Alan Gilbert's message of
 "Tue, 11 Feb 2020 18:43:32 +0000")
References: <20200129115655.10414-1-quintela@redhat.com>
 <20200129115655.10414-6-quintela@redhat.com>
 <20200211184332.GH2751@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 13 Feb 2020 21:24:59 +0100
Message-ID: <87tv3ujkv8.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Ff2mQTJIPi--aw2_yQ_AjQ-1
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
>>  migration/multifd-zlib.c     | 325 +++++++++++++++++++++++++++++++++++
>>  migration/multifd.c          |   6 +
>>  migration/multifd.h          |   4 +
>>  qapi/migration.json          |   3 +-
>>  tests/qtest/migration-test.c |   6 +
>>  9 files changed, 355 insertions(+), 2 deletions(-)
>>  create mode 100644 migration/multifd-zlib.c
>
> Coupld of really minor points below to fix up, but other than those:
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>>  }
>> =20
>> +int migrate_multifd_zlib_level(void)
>> +{
>> +    MigrationState *s;
>> +
>> +    s =3D migrate_get_current();
>> +
>> +    return s->parameters.multifd_zlib_level;
>> +}
>> +
>
> Does this belong in the previous patch?

It is used only here.  Should not make any difference.

Anyways, changing it.

>
>>  int migrate_use_xbzrle(void)
>>  {
>>      MigrationState *s;
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 3d23a0852e..95e9c196ff 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -301,6 +301,7 @@ bool migrate_use_multifd(void);
>>  bool migrate_pause_before_switchover(void);
>>  int migrate_multifd_channels(void);
>>  MultiFDMethod migrate_multifd_method(void);
>> +int migrate_multifd_zlib_level(void);
>> +        int flush =3D Z_NO_FLUSH;
>> +        unsigned long start =3D zs->total_out;
>> +
>> +        if (i =3D=3D used  - 1) {
>
> Note an extra space there.
>

Fixed, thanks.


