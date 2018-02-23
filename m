Received: from eggs.gnu.org ([2001:4830:134:3::10]:34019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHql-0006uN-7B
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1epHqg-0002tg-8k
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:13:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52588 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1epHqg-0002tP-2e
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:13:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180212072207.9367-1-armbru@redhat.com>
	<20180212072207.9367-15-armbru@redhat.com>
	<CAMxuvaxFtRUrzJsgyG+sF+ZyppB=dZx_UW=Jjw6tuWpj1O92sw@mail.gmail.com>
Date: Fri, 23 Feb 2018 19:13:16 +0100
In-Reply-To: <CAMxuvaxFtRUrzJsgyG+sF+ZyppB=dZx_UW=Jjw6tuWpj1O92sw@mail.gmail.com>
	(Marc-Andre Lureau's message of "Wed, 14 Feb 2018 16:28:47 +0100")
Message-ID: <87muzzingj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 14/14] qapi: Add #if conditions to
 commands, events, types, visitors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: marcandre <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andre Lureau <mlureau@redhat.com> writes:

> Hi
>
> On Mon, Feb 12, 2018 at 8:22 AM, Markus Armbruster <armbru@redhat.com> wrote:
>> Example change to generated code:
>>
>>     diff -rup test-qapi-events.h.old test-qapi-events.h
>>     --- test-qapi-events.h.old  2018-02-12 07:02:45.672737544 +0100
>>     +++ test-qapi-events.h      2018-02-12 07:03:01.128517669 +0100
>>     @@ -30,8 +30,10 @@ void qapi_event_send_event_e(UserDefZero
>>      void qapi_event_send_event_f(UserDefAlternate *arg, Error **errp);
>>
>>      void qapi_event_send___org_qemu_x_event(__org_qemu_x_Enum __org_qemu_x_member1, const char *__org_qemu_x_member2, bool has_q_wchar_t, int64_t q_wchar_t, Error **errp);
>>     +#if defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)
>>
>>      void qapi_event_send_testifevent(TestIfStruct *foo, Error **errp);
>>     +#endif /* defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT) */
>>
>>      typedef enum test_QAPIEvent {
>>          TEST_QAPI_EVENT_EVENT_A = 0,
>>
>> TODO nice blank lines before #if and after #endif
>> FIXME unclean access of protected members in commands.py
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> I reviewed the RFC series, and your approach to visit ifcond instead
> of having them as attribute argument for the visitor (something you
> suggested me initially iirc).

I think I tossed out the idea, no more.

> I think the approach is interesting but that single patch shows the
> complexity involved. The decorator approach still looks cleaner and
> simpler to me.

De gustibus...

For what it's worth, I disliked the decorator magic enough to write this
series.

>                Furthermore, I don't fancy much having to redo and tune
> the generation *again* to fix the inden, extra-spaces etc that were
> fixed after several revisions (it takes hours to get there, it's
> boring). Can't we go first with my approach and then look at replacing
> it? Can't one add a "FIXME: replace the decorator with something less
> magic" at ifcond_decorator definition for now? Is this code so
> critical that it has to be the way you want in the first place? The
> approach to take it first and improve it worked very well for
> qapi2texi, it just took a few more days for you (and reviewers) to
> improve it. I'd suggest we work that way instead of having me rewrite
> and rewrite until you are happy (which is something I can't do right
> without many painful iterations for you and me).

This is up to the backup QAPI maintainer now :)
