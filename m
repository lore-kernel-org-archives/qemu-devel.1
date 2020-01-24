Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9722072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFlekW1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9722072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzC5-0000jt-63
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iuzB3-0008Ec-K3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iuzB1-0005bG-Gg
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:39:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iuzB1-0005TP-6k
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579873150;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knWg8VGBizn1dEm8LeKa3Ou6X9fX43IC2rdb4Dri1mU=;
 b=WFlekW1n9t5yYKj09W28opKgLVp3mwUsXam0V+lM6TOFPD+Xwi1yBX7Ploe1JYvD+Y/WCd
 NiZlG6zSno8brx0mWVzHH4fvT5LC2R2Zti+nRJ+MSS8FfP+glUUTqVSzML9kdZDkXlyKHY
 CerFwuqZwDMhFOuu+/VinvPl2jOCPR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-1ZRb4_zPOz2RFuFZ_1sKhQ-1; Fri, 24 Jan 2020 08:39:08 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7387F1800D48
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 13:39:07 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D55FB1001901;
 Fri, 24 Jan 2020 13:39:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 18/21] migration: Make no compression operations into
 its own structure
In-Reply-To: <20200124124729.GO2970@work-vm> (David Alan Gilbert's message of
 "Fri, 24 Jan 2020 12:47:29 +0000")
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-19-quintela@redhat.com>
 <20200124124729.GO2970@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 24 Jan 2020 14:39:04 +0100
Message-ID: <87eevp3rev.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 1ZRb4_zPOz2RFuFZ_1sKhQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
>> It will be used later.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>=20

>> +int migrate_multifd_method(void)
>> +{
>> +    MigrationState *s;
>> +
>> +    s =3D migrate_get_current();
>> +
>> +    return s->parameters.multifd_compress;
>> +}
>
> Shouldn't that be a MultifdCompress enum returned?

You are right here.
>> =20
>>  #define MULTIFD_FLAG_SYNC (1 << 0)
>> +#define MULTIFD_FLAG_NOCOMP (1 << 1)
>
> I don't think this should be a set of individual flags; in later patches
> you define a flag for zlib and another for zstd etc etc - but you can't
> combine them - you could never have FLAG_NOCOMP|FLAG_ZSTD|FLAG_ZLIB - so
> this should be a 3 or 4 bit field which contains a compression id (0
> being none).  The ID can't exactly be the migrate_multifd_method() enum
> value - because I don't think that's defined to be stable (?).

The idea is to catch up if we got an incorrect packet with an incorrect
flag.

But yes, I agree that it could be the same expecting a value here.
The problem is that I already have the flags field.

Would it be ok for you if I reserve 3 bits for this?  (right now 2
should be enough).

Thanks, Juan.


