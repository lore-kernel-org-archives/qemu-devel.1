Received: from eggs.gnu.org ([2001:4830:134:3::10]:51747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfhuC-0008TD-Iq
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfhu9-0002OZ-8d
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:29:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfhu8-0002Nt-Vo
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:29:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 988706F1A6
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 07:29:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-14-eblake@redhat.com>
	<87inhwokot.fsf@dusky.pond.sub.org>
	<08e17b38-5137-2986-b85f-7fc6f140f275@redhat.com>
Date: Thu, 10 Aug 2017 09:29:13 +0200
In-Reply-To: <08e17b38-5137-2986-b85f-7fc6f140f275@redhat.com> (Eric Blake's
	message of "Wed, 9 Aug 2017 10:18:49 -0500")
Message-ID: <87valvj2ye.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 13/22] libqtest: Add qmp_raw()
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

> On 08/09/2017 09:54 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> The majority of calls into libqtest's qmp() and friends are passing
>>> a JSON object that includes a command name; we can prove this by
>>> adding an assertion.  The only outlier is qmp-test, which is testing
>>> appropriate error responses to protocol violations and id support,
>>> by sending raw strings, where those raw strings don't need
>>> interpolation anyways.
>>>
>>> Adding a new entry-point makes a clean separation of which input
>>> needs interpolation, so that upcoming patches can refactor qmp()
>>> to be more like the recent additions to test-qga in taking the
>>> command name separately from the arguments for an overall
>>> reduction in testsuite boilerplate.
>>>
>>> This change also lets us move the workaround for the QMP parser
>>> limitation of not ending a parse until } or newline: all calls
>>> through qmp() are passing an object ending in }, so only the
>>> few callers of qmp_raw() have to worry about a trailing newline.
>>> +++ b/tests/libqtest.c
>>> @@ -451,7 +451,7 @@ static void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
>>>      QString *qstr;
>>>      const char *str;
>>>
>>> -    assert(*fmt);
>>> +    assert(strstr(fmt, "execute"));
>> 
>> I doubt this assertion is worthwhile.
>
> Indeed, and it disappears later in the series.  But it was useful in the
> interim, to prove that ALL callers through this function are passing a
> command name (and therefore my later patches to rewrite qmp() to take a
> command name aren't overlooking any callers).
>
>> 
>> One , qmp_fd_sendv() works just fine whether you include an 'execute' or
>> not.  Two, there are zillions of other ways to send nonsense with
>> qmp_fd_sendv().  If you do, your test doesn't work, so you fix it.
>> 
>> Rejecting nonsensical QMP input is QEMU's job, not libqtest's.
>
> I'm fine omitting the assertions in the next spin, even if they proved
> useful in this revision for making sure I converted everything.

Omitting them is fine.

Keeping them temporarily with a comment why would also be fine, but more
work.

>>>
>>>      /* Test command failure with 'id' */
>>> -    resp = qmp("{ 'execute': 'human-monitor-command', 'id': 2 }");
>>> +    resp = qmp_raw("{ 'execute': 'human-monitor-command', 'id': 2 }");
>>>      g_assert_cmpstr(get_error_class(resp), ==, "GenericError");
>>>      g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
>>>      QDECREF(resp);
>> 
>> I'm afraid I don't like this patch.  All the extra function buys us is
>> an assertion that isn't even tight, and the lifting of a newline out of
>> a place where it shouldn't be.
>
> Maybe you'll change your mind by the end of the series, once you see the
> changes to make qmp() shorter (and where those changes necessitate a
> qmp_raw() as the backdoor for anything that is not a normal
> command+arguments).

It's a big series.  I may not see the forest for the trees right now.  A
v2 taking care of the uncontroversial improvements should improve my
view some.
