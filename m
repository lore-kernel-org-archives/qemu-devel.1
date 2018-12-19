Received: from eggs.gnu.org ([2001:4830:134:3::10]:59108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZYpf-0005LX-HE
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:12:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZYpc-0006hq-Bm
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:12:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZYpc-0006hC-5A
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:12:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181211095057.14623-1-fli@suse.com>
	<20181211095057.14623-7-fli@suse.com>
	<87y38tc2fb.fsf@dusky.pond.sub.org>
	<3645fb54-3651-f63b-c416-b22634e1f992@suse.com>
	<1b13b511-af92-c0ad-8db1-abe14313c27d@suse.com>
Date: Wed, 19 Dec 2018 11:11:56 +0100
In-Reply-To: <1b13b511-af92-c0ad-8db1-abe14313c27d@suse.com> (Fei Li's message
	of "Tue, 18 Dec 2018 20:40:06 +0800")
Message-ID: <87va3pkeqb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v8 6/7] qemu_thread_create:
 propagate the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: David Gibson <dgibson@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Fei Li <fli@suse.com> writes:

> On 12/17/2018 03:29 PM, Fei Li wrote:
>>
>>
>> On 12/13/2018 03:26 PM, Markus Armbruster wrote:
>>> There's a question for David Gibson inline.=C2=A0 Please search for /pp=
c/.
>>>
>>> Fei Li <fli@suse.com> writes:
>>>
>>>> Make qemu_thread_create() return a Boolean to indicate if it succeeds
>>>> rather than failing with an error. And add an Error parameter to hold
>>>> the error message and let the callers handle it.
>>> The "rather than failing with an error" is misleading.=C2=A0 Before the
>>> patch, we report to stderr and abort().=C2=A0 What about:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu-thread: Make qemu_thread_create() handle =
errors properly
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_thread_create() abort()s on error.=C2=A0 =
Not nice.=C2=A0 Give it a
>>> =C2=A0=C2=A0=C2=A0=C2=A0 return value and an Error ** argument, so it c=
an return success /
>>> =C2=A0=C2=A0=C2=A0=C2=A0 failure.
>> A nice commit-amend! Thanks!
>>> Still missing from the commit message then: how you update the callers.
>> Yes, agree. I think the-how should also be noted here, like
>> - propagating the err to callers whose call trace already have the
>> Error paramater;
>> - just add an &error_abort for qemu_thread_create() and make it a
>> "TODO: xxx";
>>> Let's see below.
> According to your below comment and suggestion, I make a summary for
> the second paragraph for the commit message, please help to review,
> thanks. :)
>
> /* ...The first paragraph and the middle blank... */
> And let's update qemu_thread_create()'s callers by
> - setting an error on qemu_thread_create() failure for callers that
> =C2=A0 set an error on failure;
> - reporting the error and returning failure for callers that return
> =C2=A0 an error code on failure;
> - reporting the error and setting some state for callers that just
> =C2=A0 report errors and choose not to continue on.
> - passing &error_abort for qemu_thread_create() for callers that
> =C2=A0 can't return failure, and marking a "TODO: " for further change.
>
> Have a nice day
> Fei

If you split the patch so that the first part makes all callers pass
&error_abort, the first part's commit message becomes much simpler, and
the subsequent parts' commit messages should be pretty simple to write,
too.
