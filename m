Received: from eggs.gnu.org ([2001:4830:134:3::10]:52472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDsWJ-0002u7-MV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:14:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDsWE-0004WZ-42
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:14:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fDsWD-0004WK-U7
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:14:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A8334022909
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 14:14:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-5-marcandre.lureau@redhat.com>
	<9254b6df-8840-183c-8854-0dfd892f11ad@redhat.com>
	<87po2kq3iq.fsf@dusky.pond.sub.org>
	<80ad8147-903b-7a14-9f47-0a4bd435b6f7@redhat.com>
Date: Wed, 02 May 2018 16:14:01 +0200
In-Reply-To: <80ad8147-903b-7a14-9f47-0a4bd435b6f7@redhat.com> (Eric Blake's
	message of "Wed, 2 May 2018 08:28:46 -0500")
Message-ID: <87po2eywk6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 4/5] qobject: modify qobject_ref() to
 return obj
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

> On 04/27/2018 06:42 AM, Markus Armbruster wrote:
>
>>>> +++ b/include/qapi/qmp/qobject.h
>>>> @@ -72,11 +72,12 @@ static inline void qobject_init(QObject *obj, QType type)
>>>>       obj->base.type = type;
>>>>   }
>>>>   -static inline void qobject_ref_impl(QObject *obj)
>>>> +static inline void *qobject_ref_impl(QObject *obj)
>>>>   {
>>>>       if (obj) {
>>>>           obj->base.refcnt++;
>>>>       }
>>>> +    return obj;
>>>
>>> This hunk is now useless,
>>>
>
>>>> -#define qobject_ref(obj) qobject_ref_impl(QOBJECT(obj))
>>>> +#define qobject_ref(obj) ({                     \
>>>> +    typeof(obj) _o = (obj);                     \
>>>> +    qobject_ref_impl(QOBJECT(_o));              \
>>>> +    _o;                                         \
>>>
>>> since nothing ever uses the return value.
>>>
>>> But that said, I'm still okay with R-b with or without the useless hunk.
>>
>> I intend to drop it on commit.
>
> It's still there on your qapi-next tree; did you forget to remove it?

Thanks for reminding me.  It's gone now.
