Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C61C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 04:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6E402074D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 04:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaKdlyBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E402074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCytY-0003hW-Uf
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 00:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCysx-0003Eh-DX
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 00:58:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCysw-0005Ac-BH
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 00:58:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCysw-00058B-7c
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 00:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584161933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hO19XwpqbzNIobHjoy1JqicILhvrbLo1g785yakQntQ=;
 b=JaKdlyBFZ6QrWnjlA8zsA52/dz3+ltXODpl9joMtT8XmWPFUsyjnOQvAdLP7CPwLBHjwjc
 wg9jFposPRvDSIJDeRQoDuawV32H0aAbEkuyBFV0txyzJfdPgDNSBPwNewpArl1h7Na1YZ
 nixle4a6bAYT5ubCdUALUuV5xrOawAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-5OyolCleO-CTUjUhmmSRbA-1; Sat, 14 Mar 2020 00:58:49 -0400
X-MC-Unique: 5OyolCleO-CTUjUhmmSRbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09570100550E;
 Sat, 14 Mar 2020 04:58:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7021660E3E;
 Sat, 14 Mar 2020 04:58:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E43E111386A6; Sat, 14 Mar 2020 05:58:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH 1/3] Use &error_abort instead of separate assert()
References: <20200313170517.22480-1-armbru@redhat.com>
 <20200313170517.22480-2-armbru@redhat.com>
 <20200313173745.2cwlwbkt4fc7nmpc@mozz.bu.edu>
Date: Sat, 14 Mar 2020 05:58:45 +0100
In-Reply-To: <20200313173745.2cwlwbkt4fc7nmpc@mozz.bu.edu> (Alexander
 Bulekov's message of "Fri, 13 Mar 2020 13:37:45 -0400")
Message-ID: <878sk3cz22.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 ashijeetacharya@gmail.com, paul.durrant@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alexander Bulekov <alxndr@bu.edu> writes:

> On 200313 1805, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>
>> index 1a99277d60..aa9eee6ebf 100644
>> --- a/tests/qtest/fuzz/qos_fuzz.c
>> +++ b/tests/qtest/fuzz/qos_fuzz.c
>> @@ -57,8 +57,7 @@ static void qos_set_machines_devices_available(void)
>>      QList *lst;
>>      Error *err =3D NULL;
> Can this err declaration be removed? Don't think it's used anywhere
> else.

Will do.

>> -    qmp_marshal_query_machines(NULL, &response, &err);
>> -    assert(!err);
>> +    qmp_marshal_query_machines(NULL, &response, &error_abort);
>>      lst =3D qobject_to(QList, response);
>>      apply_to_qlist(lst, true);
>> =20
>> @@ -70,8 +69,7 @@ static void qos_set_machines_devices_available(void)
>>      qdict_put_bool(args, "abstract", true);
>>      qdict_put_obj(req, "arguments", (QObject *) args);
>> =20
>> -    qmp_marshal_qom_list_types(args, &response, &err);
>> -    assert(!err);
>> +    qmp_marshal_qom_list_types(args, &response, &error_abort);
>>      lst =3D qobject_to(QList, response);
>>      apply_to_qlist(lst, false);
>>      qobject_unref(response);
>> --=20
>> 2.21.1
>>=20
> Thanks!
>
> Acked-by: Alexander Bulekov <alxndr@bu.edu>

Thanks!


