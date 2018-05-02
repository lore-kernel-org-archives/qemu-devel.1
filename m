Received: from eggs.gnu.org ([2001:4830:134:3::10]:42387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDroY-0001YY-TO
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDroV-0007UZ-M3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:28:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fDroV-0007UM-GO
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:28:55 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 744603188CCD
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 13:28:54 +0000 (UTC)
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-5-marcandre.lureau@redhat.com>
	<9254b6df-8840-183c-8854-0dfd892f11ad@redhat.com>
	<87po2kq3iq.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <80ad8147-903b-7a14-9f47-0a4bd435b6f7@redhat.com>
Date: Wed, 2 May 2018 08:28:46 -0500
MIME-Version: 1.0
In-Reply-To: <87po2kq3iq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

On 04/27/2018 06:42 AM, Markus Armbruster wrote:

>>> +++ b/include/qapi/qmp/qobject.h
>>> @@ -72,11 +72,12 @@ static inline void qobject_init(QObject *obj, QType type)
>>>       obj->base.type = type;
>>>   }
>>>   
>>> -static inline void qobject_ref_impl(QObject *obj)
>>> +static inline void *qobject_ref_impl(QObject *obj)
>>>   {
>>>       if (obj) {
>>>           obj->base.refcnt++;
>>>       }
>>> +    return obj;
>>
>> This hunk is now useless,
>>

>>> -#define qobject_ref(obj) qobject_ref_impl(QOBJECT(obj))
>>> +#define qobject_ref(obj) ({                     \
>>> +    typeof(obj) _o = (obj);                     \
>>> +    qobject_ref_impl(QOBJECT(_o));              \
>>> +    _o;                                         \
>>
>> since nothing ever uses the return value.
>>
>> But that said, I'm still okay with R-b with or without the useless hunk.
> 
> I intend to drop it on commit.

It's still there on your qapi-next tree; did you forget to remove it?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
