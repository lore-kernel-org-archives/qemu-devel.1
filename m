Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6640C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71489223D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOzxNtOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71489223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNzC-0006UH-Hs
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iXNxo-0005cN-GJ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iXNxk-0005EW-OD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:15:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iXNxk-0005DK-JG
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574248555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PR8m2SO4fnVa017ElZk4lMTFCozB5FQwf/2c1yxPaZY=;
 b=dOzxNtObJXGb1k1LUSFt46D99oE5TSr4vPzsFHomAO6O9mD21PKok4Cei+Bm1/O4sTZAha
 5ZFXCMI6zOVLvfZ2HJwpb0FaI1NUO6bv3O6mF0GPYl9cLiEe6dAFiRhfAR4X+9FQf4NnyJ
 M/J8k+5uTc2EhkQ0yzBHHn5LG0Wtf7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-nZ-85HWmPzGviMKYsjNeCQ-1; Wed, 20 Nov 2019 06:15:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 974991802CFC;
 Wed, 20 Nov 2019 11:15:51 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13B8460493;
 Wed, 20 Nov 2019 11:15:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] Fix incorrect int->float conversions caught by clang
 -Wimplicit-int-float-conversion
In-Reply-To: <87tv6z7vb0.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Tue, 19 Nov 2019 16:14:11 +0100")
References: <20191116010731.3jdxozzfpsqsrcc4@google.com>
 <87tv6z7vb0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 20 Nov 2019 12:15:46 +0100
Message-ID: <87pnhmol25.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nZ-85HWmPzGviMKYsjNeCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fangrui Song <i@maskray.me>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> wrote:
> Fangrui Song <i@maskray.me> writes:
>
>> The warning will be enabled by default in clang 10. It is not
>> available for clang <=3D 9.
>>
>> qemu/migration/migration.c:2038:24: error: implicit conversion from
>> 'long' to 'double' changes value from 9223372036854775807 to
>> 9223372036854775808 [-Werror,-Wimplicit-int-float-conversion]
>> ...
>> qemu/util/cutils.c:245:23: error: implicit conversion from 'unsigned
>> long' to 'double' changes value from 18446744073709550592 to
>> 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
>>
>> Signed-off-by: Fangrui Song <i@maskray.me>
>> ---
>>   migration/migration.c | 4 ++--
>>   util/cutils.c         | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 354ad072fa..ac3ea2934a 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -53,6 +53,7 @@
>>   #include "monitor/monitor.h"
>>   #include "net/announce.h"
>>   #include "qemu/queue.h"
>> +#include <math.h>
>>  =20
>>   #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed thro=
ttling */
>>  =20
>> @@ -2035,11 +2036,10 @@ void qmp_migrate_set_downtime(double value, Erro=
r **errp)
>         if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
>             error_setg(errp, "Parameter 'downtime_limit' expects an integ=
er in "
>                              "the range of 0 to %d seconds",
>                              MAX_MIGRATE_DOWNTIME_SECONDS);
>             return;
>>       }
>
> @value is now in [0,2000].
>
>>  =20
>>       value *=3D 1000; /* Convert to milliseconds */
>
> @value is in [0,2000000]
>
>> -    value =3D MAX(0, MIN(INT64_MAX, value));
>
> This does nothing.
>
>>  =20
>>       MigrateSetParameters p =3D {
>>           .has_downtime_limit =3D true,
>> -        .downtime_limit =3D value,
>> +        .downtime_limit =3D (int64_t)fmin(value, nextafter(0x1p63, 0)),
>
> This does nothing and is hard to read :)
>
> Can we simply drop the offending line statement instead?

Agreed aboutdropping the whole bussines for migration.


>>       };
>>  =20
>>       qmp_migrate_set_parameters(&p, errp);
>> diff --git a/util/cutils.c b/util/cutils.c
>> index fd591cadf0..2b4484c015 100644
>> --- a/util/cutils.c
>> +++ b/util/cutils.c
>> @@ -239,10 +239,10 @@ static int do_strtosz(const char *nptr, const char=
 **end,
>>           goto out;
>>       }
>>       /*
>> -     * Values >=3D 0xfffffffffffffc00 overflow uint64_t after their tri=
p
>> +     * Values > nextafter(0x1p64, 0) overflow uint64_t after their trip
>>        * through double (53 bits of precision).
>>        */
>> -    if ((val * mul >=3D 0xfffffffffffffc00) || val < 0) {
>> +    if ((val * mul > nextafter(0x1p64, 0)) || val < 0) {
>>           retval =3D -ERANGE;
>>           goto out;
>>       }

This comment was really bad (it says the same that the code).
On the other hand, I can *kind of* understand what does 0xffff<more
f's here>.

But I am at a complete loss about what value is:

nextafter(0x1p64, 0).

Can we put what value is that instead?

Thanks, Juan.


