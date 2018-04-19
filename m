Received: from eggs.gnu.org ([2001:4830:134:3::10]:49621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f92je-0004Pt-1Z
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f92ja-0001NY-TA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:07:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f92ja-0001N4-Nw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:07:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07460EAEAB
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:07:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-2-marcandre.lureau@redhat.com>
	<ea5c5be8-2e0f-ed00-8ce1-aee6d6e117d4@redhat.com>
	<87po2wsbu6.fsf@dusky.pond.sub.org>
	<444fc8f7-b86a-6b5b-f49d-34b9608164e6@redhat.com>
Date: Thu, 19 Apr 2018 08:07:37 +0200
In-Reply-To: <444fc8f7-b86a-6b5b-f49d-34b9608164e6@redhat.com> (Eric Blake's
	message of "Wed, 18 Apr 2018 12:04:01 -0500")
Message-ID: <87fu3rybiu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/5] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 04/18/2018 11:45 AM, Markus Armbruster wrote:
>
>>> Might also be worth mentioning that this explicitly guarantees that
>>> existing casts work correctly (even though we'd prefer to get rid of
>>> such casts in any location except the qobject.h macros); Markus pointed out:
>>>
>>>>> Uh, there's another reason: existing type casts from QObject * to
>>>>> subtypes.  I just spotted one in tests/check-qdict.c:
>>>>>
>>>>>     dst = (QDict *)qdict_crumple(src, &error_abort);
>> 
>> As far as I'm concerned, that's the real reason.  The simplification
>> plus the check to make it safe seems like a wash.
>> 
>> The cast I spotted appears to be the only one, though:
>> 
>>     $ git-grep '(Q[A-Z][a-z]* \*)'
>>     hmp.c:    qmp_device_add((QDict *)qdict, NULL, &err);
>>     include/qapi/qmp/qobject.h:        return (QObject *)obj;
>>     qobject/qobject.c:static void (*qdestroy[QTYPE__MAX])(QObject *) = {
>>     tests/check-qdict.c:    dst = (QDict *)qdict_crumple(src, &error_abort);
>> 
>> The first two cast away const, the third isn't a type cast.  The fourth
>> one should use qobject_to() instead, regardless of this patch.
>> 
>> Do we want to force base to come first anyway?
>> 
>> Where does PATCH 2 exploit "base first"?
>
> It doesn't, but PATCH 4 does:
>
>>  /**
>>   * qobject_ref(): Increment QObject's reference count
>> + *
>> + * Returns: the same @obj. The type of @obj will be propagated to the
>> + * return type.
>>   */
>> -#define qobject_ref(obj) qobject_ref_impl(QOBJECT(obj))
>> +#define qobject_ref(obj) ((typeof(obj)) qobject_ref_impl(QOBJECT(obj)))

Easy enough to fix:

    #define qobject_ref(obj) ({                     \
        typeof(obj) _obj = obj;                     \
        qobject_ref_impl(QOBJECT(_obj));            \
        _obj;                                       \
    })

Look ma, no type casts!
