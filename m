Received: from eggs.gnu.org ([2001:4830:134:3::10]:56385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfiBz-0003k2-LC
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfiBv-0007VJ-ND
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:47:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfiBv-0007Uu-E3
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:47:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26BB83D944
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 07:47:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-16-eblake@redhat.com>
	<877eycoius.fsf@dusky.pond.sub.org>
	<63f6e8ad-6dd4-1ec8-7acb-306f6d957930@redhat.com>
Date: Thu, 10 Aug 2017 09:47:35 +0200
In-Reply-To: <63f6e8ad-6dd4-1ec8-7acb-306f6d957930@redhat.com> (Eric Blake's
	message of "Wed, 9 Aug 2017 11:35:43 -0500")
Message-ID: <87k22bj23s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 15/22] libqtest: Delete qtest_qmp()
 wrappers
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

> On 08/09/2017 10:34 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> None of our tests were directly using qtest_qmp() and friends;
>>> even tests like postcopy-test.c that manage multiple connections
>>> get along just fine changing global_qtest as needed (other than
>>> one callsite where it forgot to use the inlined form).  It's
>>> also annoying that we have qmp_async() but qtest_async_qmp(),
>>> with inconsistent naming for tracing through the wrappers.
>>>
>
>> What about all the other functions taking a QTestState?  Aren't they
>> just as silly?
>
> What's left after this patch:
>
> - qtest_init()
>   qtest_init_without_qmp_handshake()
>   qtest_quit()
> necessary for setting up parallel state.

"Necessary" is too strong, as you could use qtest_start(); save
global_qtest; qtest_start(); ... qtest_end(); restore global_qtest;
qtest_end().  But I could buy convenient.

> and then a lot of functions that have static inline wrappers (for
> example, qmp_receive(), inb(), ...).
>
> So yes, I could additionally get rid of more wrappers and have even more
> functions implicitly depend on global_qtest.
>
>> Having two of every function is tiresome, but consistent.
>> 
>> Having just one is easier to maintain, so if it serves our needs,
>> possibly with the occasional state switch, I like it.
>> 
>> What I don't like is a mix of the two.
>
> Okay, I'll prune even harder in the next revision.  Deleting cruft is fun!

Yes, please!

>>> +++ b/tests/libqtest.c
>>> @@ -233,9 +233,10 @@ QTestState *qtest_init(const char *extra_args)
>>>      QDict *greeting;
>>>
>>>      /* Read the QMP greeting and then do the handshake */
>>> -    greeting = qtest_qmp_receive(s);
>>> +    greeting = qmp_fd_receive(s->qmp_fd);
>> 
>> Why doesn't this become qmp_receive()?
>
> Because in THIS version of the patch, qmp_receive() is still a static
> inline wrapper that calls qtest_qmp_receive(global_qtest) - but
> global_qtest is not set here.  (If I delete qtest_qmp_receive() and have
> qmp_receive() not be static inline, then we STILL want to operate
> directly on the just-created s->qmp_fd rather than assuming that
> global_qtest == s, when in the body of qtest_init).
>
>>> @@ -446,7 +447,7 @@ QDict *qtest_qmp_receive(QTestState *s)
>>>   * Internal code that converts from interpolated JSON into a message
>>>   * to send over the wire, without waiting for a reply.
>>>   */
>>> -static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>>> +static void qtest_qmp_sendv(QTestState *s, const char *fmt, va_list ap)
>> 
>> Why this move in the other direction?
>
> Because it fixes the disparity you pointed out in 12/22 about
> qmp_fd_sendv() no longer being a sane pairing to qmp_fd_send(), AND
> because I needed the .../va_list pairing to work in order for...
>
>>> -char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
>>> +static char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
>>>  {
>>>      char *cmd;
>>>      QDict *resp;
>>>      char *ret;
>>>
>>>      cmd = g_strdup_vprintf(fmt, ap);
>>> -    resp = qtest_qmp(s, "{'execute': 'human-monitor-command',"
>>> -                     " 'arguments': {'command-line': %s}}",
>>> -                     cmd);
>>> +    qtest_qmp_send(s, "{'execute': 'human-monitor-command',"
>>> +                   " 'arguments': {'command-line': %s}}", cmd);
>>> +    resp = qtest_qmp_receive(s);
>
> ...this to work.  So now my sane pairing is
> qtest_qmp_send()/qtest_qmp_sendv() - although your argument that
> qtest_qmp_sendf() might have been a nicer name for the ... form may
> still have merit - at least any time the sendv() form is in a public
> header.  Then again, by the end of the series, I managed to get rid of
> all va_list in libqtest.h, needing it only in libqtest.c.

This is all quite confusing to me right now.  I trust I'll do better
with v2.

>>> @@ -889,7 +854,7 @@ void qmp_async(const char *fmt, ...)
>>>      va_list ap;
>>>
>>>      va_start(ap, fmt);
>>> -    qtest_async_qmpv(global_qtest, fmt, ap);
>>> +    qtest_qmp_sendv(global_qtest, fmt, ap);
>>>      va_end(ap);
>>>  }
>> 
>> Hmm.  Before this patch, qmp_async() is the ... buddy of va_list
>> qmp_fd_sendv().  If we keep qmp_fd_sendv(), they should be named
>> accordingly.
>
> What name to use, though?  By the end of the series, we have
> qmp_async(...) but no public va_list form.

Discussed later in the thread.
