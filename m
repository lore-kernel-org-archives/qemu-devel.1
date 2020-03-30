Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9512BC2D0EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EC920781
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBmCGdey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EC920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvjh-0000X8-Fx
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 10:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIviu-0008Vo-2D
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIvis-0004Bx-Ox
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:49:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24161)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIvis-0004BX-LV
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585579746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rg7swnQ6/9ZAVR+PcNppVJxVV6HZOaAiZlO7vioByPM=;
 b=BBmCGdeyIJU0HsT3AlVQRxWg4Vgl//e1eSnLXrDY5gkMsIQpVcCQjJZ8pwoLJ4AtbZQSUR
 y5iBBrJYgNAnhUjD6/iYNX2Tr+7lzadmJq7b4Fj1kLs5eEDB2kGHI1V1YqUsVI8SFKhrX4
 hvkKmI36PeWzK1dHF+VOqg6oVWq7sN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-LhEPoEIfPTeRGjk8fAHsTA-1; Mon, 30 Mar 2020 10:49:04 -0400
X-MC-Unique: LhEPoEIfPTeRGjk8fAHsTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF7B619251A0;
 Mon, 30 Mar 2020 14:49:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D955010002A9;
 Mon, 30 Mar 2020 14:49:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 847C411385E2; Mon, 30 Mar 2020 16:48:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-5.0 3/3] object-add: don't create return value if
 failed
References: <20200325184723.2029630-1-marcandre.lureau@redhat.com>
 <20200325184723.2029630-4-marcandre.lureau@redhat.com>
 <c408ed09-3740-bc5d-2e39-318bb5beff3f@redhat.com>
Date: Mon, 30 Mar 2020 16:48:59 +0200
In-Reply-To: <c408ed09-3740-bc5d-2e39-318bb5beff3f@redhat.com> (Paolo
 Bonzini's message of "Thu, 26 Mar 2020 10:42:08 +0100")
Message-ID: <87wo71ucdg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/03/20 19:47, Marc-Andr=C3=A9 Lureau wrote:
>> If object-add failed, no need to create a return value that may later
>> be leaked.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  qom/qom-qmp-cmds.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
>> index 435193b036..6bd137ccbf 100644
>> --- a/qom/qom-qmp-cmds.c
>> +++ b/qom/qom-qmp-cmds.c
>> @@ -287,8 +287,8 @@ void qmp_object_add(QDict *qdict, QObject **ret_data=
, Error **errp)
>>      visit_free(v);
>>      if (obj) {
>>          object_unref(obj);
>> +        *ret_data =3D QOBJECT(qdict_new());
>>      }
>> -    *ret_data =3D QOBJECT(qdict_new());
>>  }
>> =20
>>  void qmp_object_del(const char *id, Error **errp)
>>=20
>
> It can be slightly simplified:
>
> ------------------- 8< ----------------------
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] object-add: don't create return value if failed
>    =20
> No need to return an empty value from object-add (it would also leak
> if the command failed).  While at it, remove the "if" around object_unref
> since object_unref handles NULL arguments just fine.
>    =20
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
> index 435193b036..e47ebe8ed1 100644
> --- a/qom/qom-qmp-cmds.c
> +++ b/qom/qom-qmp-cmds.c
> @@ -285,10 +285,7 @@ void qmp_object_add(QDict *qdict, QObject **ret_data=
, Error **errp)
>      v =3D qobject_input_visitor_new(QOBJECT(qdict));
>      obj =3D user_creatable_add_type(type, id, qdict, v, errp);
>      visit_free(v);
> -    if (obj) {
> -        object_unref(obj);
> -    }
> -    *ret_data =3D QOBJECT(qdict_new());
> +    object_unref(obj);
>  }
> =20
>  void qmp_object_del(const char *id, Error **errp)

Yes, that's better.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

> I queued this patch and your other two.  Thanks,
>
> Paolo


