Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C7C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2369B20721
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McS6e7ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2369B20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWEAy-0004DO-82
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 03:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWE9z-0003Jp-78
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:08:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25618
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWE9x-0006m3-9M
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588748879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DrM3bqdcNsxiCSwpbe+mgP5f7U5sIYYsCBpW4I1wnk=;
 b=McS6e7ch4Sko6KBti17Em2RxTM1YD48HHR7GBmgmGSg47tvPNrpJhffBRsXAE28ykQudZK
 i48lpbPv2tln7xz0LZ2gK+01YQSn+DirMRF480woZcdegrNYQ7SdCKWxLMvDUaEPCo/JyQ
 +zmrMQ7hyfocvEXo2MXGZFDmJgD1kQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-aST7fUM_MgylhYd5MmRFZw-1; Wed, 06 May 2020 03:07:58 -0400
X-MC-Unique: aST7fUM_MgylhYd5MmRFZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C15461
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 07:07:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F12D525277;
 Wed,  6 May 2020 07:07:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 83DE311358BC; Wed,  6 May 2020 09:07:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 04/18] qom: Simplify object_property_get_enum()
References: <20200505152926.18877-1-armbru@redhat.com>
 <20200505152926.18877-5-armbru@redhat.com>
 <fb6ea8af-ca83-661b-d708-4648acb3afc5@redhat.com>
Date: Wed, 06 May 2020 09:07:55 +0200
In-Reply-To: <fb6ea8af-ca83-661b-d708-4648acb3afc5@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 May 2020 17:59:34
 +0200")
Message-ID: <87mu6l4k38.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:33:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/5/20 5:29 PM, Markus Armbruster wrote:
>> Reuse object_property_get_str().  Switches from the string to the
>> qobject visitor under the hood.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qom/object.c | 11 ++---------
>>   1 file changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index 3d65658059..b374af302c 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -1521,8 +1521,6 @@ typedef struct EnumProperty {
>>   int object_property_get_enum(Object *obj, const char *name,
>>                                const char *typename, Error **errp)
>>   {
>> -    Error *err =3D NULL;
>> -    Visitor *v;
>>       char *str;
>>       int ret;
>>       ObjectProperty *prop =3D object_property_find(obj, name, errp);
>> @@ -1541,15 +1539,10 @@ int object_property_get_enum(Object *obj, const =
char *name,
>>         enumprop =3D prop->opaque;
>>   -    v =3D string_output_visitor_new(false, &str);
>> -    object_property_get(obj, v, name, &err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -        visit_free(v);
>> +    str =3D object_property_get_str(obj, name, errp);
>> +    if (!str) {
>
> Patch looks good but I'm not confident enough to add a R-b tag :)

Teaching opportunity!

>>           return 0;
>>       }
>> -    visit_complete(v, &str);
>> -    visit_free(v);
>>         ret =3D qapi_enum_parse(enumprop->lookup, str, -1, errp);
>>       g_free(str);
>>

The core function for getting properties is object_property_get().  To
be used like this:

        v =3D ... new output visitor of your choice ...
        object_property_get(obj, v, name, &err);
        if (!err) {
            visit_complete(v, &ret);
        }
        visit_free(v);

Delivers the result in @ret and @err.

The type of @ret depends on the visitor.  It typically needs to be
converted to the appropriate C type.

Life's too short to write that much code every time you want to get a
property value.  So we provide two levels of common helpers.

Level 1: the output visitor commonly used is the QObject output
visitor.  Combining object_property_get() with it yields

    QObject *object_property_get_qobject(Object *obj, const char *name,
                                         Error **errp)
    {
        QObject *ret =3D NULL;
        Error *local_err =3D NULL;
        Visitor *v;

        v =3D qobject_output_visitor_new(&ret);
        object_property_get(obj, v, name, &local_err);
        if (!local_err) {
            visit_complete(v, &ret);
        }
        error_propagate(errp, local_err);
        visit_free(v);
        return ret;
    }

The use I showed above becomes

    ret =3D object_property_get_qobject(obj, name, &err);

Again, result is in @ret and @err.  You commonly need to convert @ret
from QObject to the property's C type, and handle conversion errors.

Still too much code, so we provide convenience functions for common
types.  Here's the one for strings:

    char *object_property_get_str(Object *obj, const char *name,
                                  Error **errp)
    {
        QObject *ret =3D object_property_get_qobject(obj, name, errp);
        char *retval;

        if (!ret) {
            return NULL;
        }

        retval =3D g_strdup(qobject_get_try_str(ret));
        if (!retval) {
            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "string");
        }

        qobject_unref(ret);
        return retval;
    }

Now back to my patch.  Before the patch, object_property_get_enum() is
odd: it uses the string output visitor.  Works, but why do it by hand
when we can simply reuse existing object_property_get_str()?  All we
need is the (checked) conversion from string to enum.

Clearer now?

Bonus: one fewer use of a string visitor.  These need to die, but that's
another story.


