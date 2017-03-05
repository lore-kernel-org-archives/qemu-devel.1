Received: from eggs.gnu.org ([2001:4830:134:3::10]:42489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRBH-0006UI-H4
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckRBE-0002EC-Cv
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:06:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ckRBE-0002Dw-45
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 03:06:12 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1694583F47
	for <qemu-devel@nongnu.org>; Sun,  5 Mar 2017 08:06:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-26-git-send-email-armbru@redhat.com>
	<82622f99-91d8-7ae0-2a38-53b49e200f72@redhat.com>
	<87zih2i1hn.fsf@dusky.pond.sub.org>
	<c88da759-43c8-483e-1c22-e6b82d1848e7@redhat.com>
Date: Sun, 05 Mar 2017 09:06:07 +0100
In-Reply-To: <c88da759-43c8-483e-1c22-e6b82d1848e7@redhat.com> (Eric Blake's
	message of "Fri, 3 Mar 2017 14:01:53 -0600")
Message-ID: <878tokcfm8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 25/28] qapi: Make input visitors detect
 unvisited list tails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 03/03/2017 01:50 PM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> On 03/03/2017 06:32 AM, Markus Armbruster wrote:
>>>> Fix the design flaw demonstrated in the previous commit: new method
>>>> check_list() lets input visitors report that unvisited input remains
>>>> for a list, exactly like check_struct() lets them report that
>>>> unvisited input remains for a struct or union.
>>>>
>>>> Implement the method for the qobject input visitor (straightforward),
>>>> and the string input visitor (less so, due to the magic list syntax
>>>> there).  The opts visitor's list magic is even more impenetrable, and
>>>> all I can do there today is a stub with a FIXME comment.  No worse
>>>> than before.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>
>>> Didn't I already review this one?
>>>
>>> Ah, there's my R-b:
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg07614.html
>> 
>
>>>> 
>>>> --- a/qapi/qobject-input-visitor.c
>>>> +++ b/qapi/qobject-input-visitor.c
>>>> @@ -51,7 +51,8 @@ static QObjectInputVisitor *to_qiv(Visitor *v)
>>>>      return container_of(v, QObjectInputVisitor, visitor);
>>>>  }
>>>>  
>>>> -static const char *full_name(QObjectInputVisitor *qiv, const char *name)
>>>> +static const char *full_name_nth(QObjectInputVisitor *qiv, const char *name,
>>>> +                                 int n)
>>>>  {
>
> No function comment, so the _nth and int n are guesses on their meaning...
>
>
>>> If I'm reading this right, your use of n-- in the loop followed by the
>>> post-condition is to assert that QSLIST_FOREACH() iterated n times, but
>>> lets see what callers pass for n:
>> 
>> At least @n times.
>
> Ah, as in 'use first available result' or 'iterate at least once', based
> on our callers, but could also mean 'iterate at least twice' for a
> caller that passes 2.
>
>
>>> the other passes 1.  No other calls.  Did we really need an integer,
>>> where we use n--, or would a bool have done as well?
>> 
>> Since I actually use only 0 and 1, a bool would do, but would it make
>> the code simpler?
>
> I don't know that a bool would be any simpler,
>
>> 
>>> At any rate, since I've already reviewed it once, you can add R-b, but
>>> we may want a followup to make it less confusing.
>> 
>> Would renaming the function to full_name_but_n() help?
>
> Or even keep the name unchanged, but add function comments describing
> what 'n' means.

Makes sense.  I'll do it on top to avoid delaying merge of this series
and the other stuff that depends on it.
