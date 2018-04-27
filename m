Received: from eggs.gnu.org ([2001:4830:134:3::10]:34936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fC1m1-0001dC-Hc
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fC1lw-0001bI-Lq
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:42:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fC1lw-0001aE-HG
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:42:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBF818DC4C
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 11:42:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-5-marcandre.lureau@redhat.com>
	<9254b6df-8840-183c-8854-0dfd892f11ad@redhat.com>
Date: Fri, 27 Apr 2018 13:42:37 +0200
In-Reply-To: <9254b6df-8840-183c-8854-0dfd892f11ad@redhat.com> (Eric Blake's
	message of "Thu, 19 Apr 2018 10:32:41 -0500")
Message-ID: <87po2kq3iq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
>> For convenience and clarity, make it possible to call qobject_ref() at
>> the time when the reference is associated with a variable, or
>> argument, by making qobject_ref() return the same pointer as given.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> You've made some substantial changes to the macro, I would have dropped
> R-b to ensure those changes get reviewed.  In particular,
>
>> ---
>
>> +++ b/include/qapi/qmp/qobject.h
>> @@ -72,11 +72,12 @@ static inline void qobject_init(QObject *obj, QType =
type)
>>      obj->base.type =3D type;
>>  }
>>=20=20
>> -static inline void qobject_ref_impl(QObject *obj)
>> +static inline void *qobject_ref_impl(QObject *obj)
>>  {
>>      if (obj) {
>>          obj->base.refcnt++;
>>      }
>> +    return obj;
>
> This hunk is now useless,
>
>> @@ -103,8 +104,15 @@ static inline void qobject_unref_impl(QObject *obj)
>>=20=20
>>  /**
>>   * qobject_ref(): Increment QObject's reference count
>> + *
>> + * Returns: the same @obj. The type of @obj will be propagated to the
>> + * return type.
>>   */
>> -#define qobject_ref(obj) qobject_ref_impl(QOBJECT(obj))
>> +#define qobject_ref(obj) ({                     \
>> +    typeof(obj) _o =3D (obj);                     \
>> +    qobject_ref_impl(QOBJECT(_o));              \
>> +    _o;                                         \
>
> since nothing ever uses the return value.
>
> But that said, I'm still okay with R-b with or without the useless hunk.

I intend to drop it on commit.
