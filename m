Received: from eggs.gnu.org ([2001:4830:134:3::10]:37789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkwkU-0000gZ-AC
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkwkP-0002Rw-AG
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:20:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkwkP-0002RX-2e
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:20:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1284381DF9
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 18:20:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1503384739-17207-1-git-send-email-armbru@redhat.com>
	<da7c1a48-9c9e-c416-8b25-2f9a53a417b4@redhat.com>
Date: Thu, 24 Aug 2017 20:20:48 +0200
In-Reply-To: <da7c1a48-9c9e-c416-8b25-2f9a53a417b4@redhat.com> (Eric Blake's
	message of "Thu, 24 Aug 2017 10:23:07 -0500")
Message-ID: <87bmn4esjj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qobject: Explain how QNum works, and why
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 08/22/2017 01:52 AM, Markus Armbruster wrote:
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/qmp/qnum.h | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>> 
>> diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
>> index 09d745c..9182129 100644
>> --- a/include/qapi/qmp/qnum.h
>> +++ b/include/qapi/qmp/qnum.h
>> @@ -23,6 +23,27 @@ typedef enum {
>>      QNUM_DOUBLE
>>  } QNumKind;
>>  
>> +/*
>> + * QNum encapsulates how our dialect of JSON fills in the blanks left
>> + * by the JSON specification (RFC 7159) regarding numbers.
>> + *
>> + * Conceptually, we treat number as an abstract type with three
>> + * concrete subtypes: floating-point, signed integer, unsigned
>> + * integer.  QNum implements this a discriminated union of double,
>
> s/this/this as/
>
>> + * int64_t, uint64_t.
>> + *
>> + * The JSON parser picks the subtype as follows.  If the number has a
>> + * decimal point or an exponent, it is floating-point.  Else if it
>> + * fits into int64_t, it's signed integer.  Else if it first into
>
> s/first/fits/
>
>> + * uint64_t, it's unsigned integer.  Else it's floating-point.
>> + *
>> + * Any number can serve as double: qnum_get_double() converts under
>> + * the hood.
>> + *
>> + * An integer can serve as signed / unsigned integer as long as it is
>> + * in range: qnum_get_try_int() / qnum_get_try_uint() check range and
>> + * convert under the hood.
>> + */
>>  typedef struct QNum {
>>      QObject base;
>>      QNumKind kind;
>> 

Fixed.  Thanks!
