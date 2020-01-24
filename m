Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68FBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335B02072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfCPwRUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335B02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv42D-0001uD-5N
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iv41T-0001PF-B8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iv41S-0000FA-7v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:49:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iv41S-0000F3-4I
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579891777;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYf5Fi8zjoIT5gVwxgcuyu02LNqxiVkNrN4WN67HhtA=;
 b=DfCPwRUu7MFrOqY3cz/OODK0v30ZdmusEAeHR1C5jcIZD55uttfNIDMIkGaUsVSVnwuqyA
 R4MN+D+32rarg0lDtIjMdOeN/5fpya30UXehqzHuPxFjJqWdboQskK9xGXWhEs/wgNcOVe
 1+WQFcohmzLWXLADVFXSUa0pLsJ+2ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-NnqKJKz0PvGG8dESE2TH-A-1; Fri, 24 Jan 2020 13:49:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAC018017CC
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 18:49:34 +0000 (UTC)
Received: from redhat.com (ovpn-116-111.ams2.redhat.com [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2473760BEC;
 Fri, 24 Jan 2020 18:49:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 21/21] migration: Add zstd compression multifd support
In-Reply-To: <ac07802b-9e4c-d993-3fc9-a7d2951bce1f@redhat.com> (Eric Blake's
 message of "Fri, 24 Jan 2020 10:18:11 -0600")
References: <20200123115831.36842-1-quintela@redhat.com>
 <20200123115831.36842-22-quintela@redhat.com>
 <ac07802b-9e4c-d993-3fc9-a7d2951bce1f@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 24 Jan 2020 19:49:31 +0100
Message-ID: <875zh04rlw.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: NnqKJKz0PvGG8dESE2TH-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 "Daniel P. =?utf-8?Q?Ber?= =?utf-8?Q?rang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> wrote:
> On 1/23/20 5:58 AM, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   hw/core/qdev-properties.c    |   2 +-
>>   migration/Makefile.objs      |   1 +
>>   migration/migration.c        |   6 +
>>   migration/multifd-zstd.c     | 304 +++++++++++++++++++++++++++++++++++
>>   migration/multifd.h          |  20 +++
>>   migration/ram.c              |   1 -
>>   qapi/migration.json          |   2 +-
>>   tests/qtest/migration-test.c |  10 ++
>>   8 files changed, 343 insertions(+), 3 deletions(-)
>>   create mode 100644 migration/multifd-zstd.c
>>
>
>> +++ b/migration/Makefile.objs
>> @@ -9,6 +9,7 @@ common-obj-y +=3D qjson.o
>>   common-obj-y +=3D block-dirty-bitmap.o
>>   common-obj-y +=3D multifd.o
>>   common-obj-y +=3D multifd-zlib.o
>> +common-obj-$(CONFIG_ZSTD) +=3D multifd-zstd.o

Hi

> zstd support is conditional...

yeap.

>> +++ b/qapi/migration.json
>> @@ -499,7 +499,7 @@
>>   #
>>   ##
>>   { 'enum': 'MultifdCompress',
>> -  'data': [ 'none', 'zlib' ] }
>> +  'data': [ 'none', 'zlib', 'zstd' ] }
>
> ...so I would expect an 'if' conditional here when declaring the
> enum. It also needs documentation.

I fully agree about the documentation part.

But if you are setting zstd, and zstd is compiled out, we are giving the
error showed in the code shown below.

I am open to do anyother way.  I don't speak qapi natively O:-)

Later, Juan.



diff --git a/migration/migration.c b/migration/migration.c
index d25fdb3e6b..f0d5ade1df 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1256,6 +1256,12 @@ static bool migrate_params_check(MigrationParameters=
 *params, Error **errp)
                    "is invalid, it must be in the range of 1 to 10000 ms")=
;
        return false;
     }
+    if (params->has_multifd_compress &&
+       params->multifd_compress =3D=3D MULTIFD_COMPRESS_ZSTD &&
+       !multifd_compress_zstd_is_enabled()) {
+        error_setg(errp, "The multifd compression method zstd is compiled =
out");
+        return false;
+    }
     return true;
 }
=20


