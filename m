Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D648C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A852076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjSVxPxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A852076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjNG-0008Q0-0r
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 10:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOjKi-000523-Q9
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOjKh-0000fT-Qa
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:48:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20686
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOjKh-0000f5-My
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586962087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zP9Z3B8JvTq+b1V+eUToNDDbWgPVV/+wxYPK8bvFJ5s=;
 b=gjSVxPxdtWzKKqSC5u6Boll0643uD6/BxVAc9nPcoIm4mCnm/RZTbm16FKRayrt7qIjbrV
 Z5D2quqxEelZqJjIIayPYp5THBNmeWAyg7MCIZV/CgnJabo/s/vPbF9nXmfToCEotHD+ei
 VLQS/DSBEp9Xat6mfmlBmFiyRNo357E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-9v17FBSBOuubaoMJQQd6Sg-1; Wed, 15 Apr 2020 10:48:05 -0400
X-MC-Unique: 9v17FBSBOuubaoMJQQd6Sg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 254AA1083E82;
 Wed, 15 Apr 2020 14:48:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C8FB271A3;
 Wed, 15 Apr 2020 14:48:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5473A11385C8; Wed, 15 Apr 2020 16:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-5.1 4/5] qobject: Eliminate qdict_iter(),
 use qdict_first(), qdict_next()
References: <20200415083048.14339-1-armbru@redhat.com>
 <20200415083048.14339-5-armbru@redhat.com>
 <4574d8dc-0892-ff10-1823-697bff10f0b0@redhat.com>
Date: Wed, 15 Apr 2020 16:48:02 +0200
In-Reply-To: <4574d8dc-0892-ff10-1823-697bff10f0b0@redhat.com> (Eric Blake's
 message of "Wed, 15 Apr 2020 07:34:20 -0500")
Message-ID: <87h7xkg5zx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/15/20 3:30 AM, Markus Armbruster wrote:
>> qdict_iter() has just three uses and no test coverage.  Replace by
>> qdict_first(), qdict_next() for more concise code and less type
>> punning.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qapi/qmp/qdict.h     |  3 --
>>   qapi/qobject-input-visitor.c | 21 +++++++-------
>>   qobject/qdict.c              | 19 -------------
>>   qobject/qjson.c              | 54 +++++++++++++-----------------------
>>   util/qemu-option.c           | 10 ++++++-
>>   5 files changed, 40 insertions(+), 67 deletions(-)
>>
>
>>   static const QListEntry *qobject_input_push(QObjectInputVisitor *qiv,
>>                                               const char *name,
>>                                               QObject *obj, void *qapi)
>>   {
>>       GHashTable *h;
>>       StackObject *tos =3D g_new0(StackObject, 1);
>> +    QDict *qdict =3D qobject_to(QDict, obj);
>> +    QList *qlist =3D qobject_to(QList, obj);
>> +    const QDictEntry *entry;
>>         assert(obj);
>>       tos->name =3D name;
>>       tos->obj =3D obj;
>>       tos->qapi =3D qapi;
>>   -    if (qobject_type(obj) =3D=3D QTYPE_QDICT) {
>> +    if (qdict) {
>>           h =3D g_hash_table_new(g_str_hash, g_str_equal);
>> -        qdict_iter(qobject_to(QDict, obj), qdict_add_key, h);
>> +        for (entry =3D qdict_first(qdict);
>> +             entry;
>> +             entry =3D qdict_next(qdict, entry)) {
>> +            g_hash_table_insert(h, (void *)qdict_entry_key(entry), NULL=
);
>
> Is the cast to void* necessary?

It casts away const.

> Otherwise,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


