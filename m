Received: from eggs.gnu.org ([2001:4830:134:3::10]:44446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc5vy-0007IO-P4
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc5vv-0005Xk-Kf
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dc5vv-0005Wv-BT
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:20:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52842D5972
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 08:20:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-4-eblake@redhat.com>
	<87y3r8jtu5.fsf@dusky.pond.sub.org>
	<fed09f84-2112-73e2-5541-603a77fe746d@redhat.com>
Date: Mon, 31 Jul 2017 10:20:03 +0200
In-Reply-To: <fed09f84-2112-73e2-5541-603a77fe746d@redhat.com> (Eric Blake's
	message of "Fri, 28 Jul 2017 14:00:17 -0500")
Message-ID: <87wp6p9fws.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 03/12] qtest: Document calling
 conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/28/2017 01:32 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> We have two flavors of vararg usage in qtest; make it clear that
>>> qmp() has different semantics than hmp(), and let the compiler
>>> enforce that hmp() is used correctly. However, qmp() (and friends)
>>> only accept a subset of printf flags look-alikes (namely, those
>>> that our JSON parser understands), and what is worse, qmp("true")
>>> (the JSON keyword 'true') is different from qmp("%s", "true")
>>> (the JSON string '"true"'), and we have some intermediate cleanup
>>> patches to do before we can mark those as printf-like.
>> 
>> It's not "worse", it's just different :)
>> 
>> Suggest:
>> 
>>   We have two flavors of vararg usage in qtest: qtest_hmp() etc. work
>>   like sprintf(), and qtest_qmp() etc. work like qobject_from_jsonf().
>>   Spell that out in the comments.
>> 
>>   Also add GCC_FMT_ATTR() to qtest_hmp() etc. so that the compiler can
>>   flag incorrect use.
>> 
>>   We have some cleanup work to do before we can do the same for
>>   qtest_qmp() etc.  This will get us the same better-than-nothing
>>   checking we already have for qobject_from_jsonf(): common incorrect
>>   uses of supported conversion specifications will be flagged
>>   (e.g. passing a double for %d), but use of unsupported ones won't.
>
> "Mikey likes it" (no idea if that pop culture reference from my
> childhood has broader range than the US)

'fraid I'm out of range :)

>>> @@ -134,19 +140,19 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
>>>  /**
>>>   * qtest_hmp:
>>>   * @s: #QTestState instance to operate on.
>>> - * @fmt...: HMP command to send to QEMU
>>> + * @fmt...: HMP command to send to QEMU, formats arguments like vsprintf().
>> 
>> Like sprintf().
>
> Hmm, you asked me to use vsprintf on the last one.  Oh, I finally see -
> you're trying to get me to match: vsprintf if it is 'va_list', sprintf
> if it is '...'.  Yeah, that makes sense.

Correct.  I should've explained that from the start.

>> With the comment fixed, and preferably with an improved commit message:
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks for the reviews and suggestions.

You're welcome!
