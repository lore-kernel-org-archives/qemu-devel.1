Received: from eggs.gnu.org ([2001:4830:134:3::10]:45332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqHe7-0007Nk-ER
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqHe4-0001UD-6m
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:44:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqHdz-0001Pq-IP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:44:52 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-6-armbru@redhat.com>
	<36518ac8-f022-c54d-2e57-6a709b3678ce@redhat.com>
	<87d0uqmiq9.fsf@dusky.pond.sub.org>
	<b1ad880a-7561-f784-b47e-ca3ea6d7b524@redhat.com>
Date: Thu, 16 Aug 2018 14:44:43 +0200
In-Reply-To: <b1ad880a-7561-f784-b47e-ca3ea6d7b524@redhat.com> (Eric Blake's
	message of "Fri, 10 Aug 2018 09:06:07 -0500")
Message-ID: <87o9e2bhvo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/56] qmp-test: Cover syntax and lexical
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/10/2018 08:52 AM, Markus Armbruster wrote:
>
>>>> +    /* lexical error: impossible byte outside string */
>>>> +    qtest_qmp_send_raw(qts, "{\xFF");
>>>
>>> \xff is an impossible byte inside a string as well; plus it has
>>> special meaning to at least QMP for commanding a parser reset. Is a
>>> better byte more appropriate (maybe \x7f), either in replacement to
>>> \xff or as an additional test?
>>
>> \xFF is documented to have special meaning for QGA, but as far as the
>> code's concerned, it's a lexical error like any other.  I'm fixing the
>> documentation in PATCH 56.  Want me to move that patch to the front of
>> the series?
>
> Might not hurt. We also have a potential design decision to make: for
> most lexical errors, we report the error (with QGA, the user then
> requests that the first valid command after the client's induced
> lexical error also include an 0xff reply byte so that the client can
> easily skip over all the line noise, including said error reports).
> Thus, we COULD decide to make our parser specifically accept 0xff as a
> new token, different from the lexical error token, so that it inhibits
> wasted error messages to the client on the grounds that the client
> sent it on purpose, differently from all other ways the client can use
> a lexical error to cause a reset.

I don't think that's worthwhile.  Let me explain.

I see one and a half use cases.

The full use case is of course QGA synchronization.  Why is that even
necessary?  I believe it's a work-around for transports that fail to
provide proper connection semantics, such as virtio-serial.

When a transport provides it (sockets do), every connection starts with
a clean slate.  The only way it can get de-synchronized is either peer
getting confused enough to send garbage, and then it's probably best to
close the session and start over.  Evidence: we don't bother with
synchronization for QMP, which commonly uses socket transports.

I guess the problem for QGA is reconnecting with virtio-serial.  The
slate isn't clean then.  If the previous connection left some of the
peer's output unread, you'll get that before your own, and it may not be
valid JSON.  Same for the other direction.

To reset the peer's parser, we provoke a lexical error by sending \xFF.

We still have to read and ignore stale peer output.  We do that with the
help of command guest-sync-delimited.  Whether lexical error caused by
\xFF are suppressed or not makes no appreciable difference.

I therefore think suppressing it is not worth the bother.  What we have
seems good enough.

The half use case is human interactive use.  It's fairly easy to
miscount parenthesis and get the peer into some unresponsive state.
Provoking a lexical error lets me start over.  However, I'd rather not
use \xFF to provoke it, because how do you type that?  Sending a
suitable ASCII control character is easier, and will do the trick after
PATCH 17 fixes our JSON parser.
