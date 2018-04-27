Received: from eggs.gnu.org ([2001:4830:134:3::10]:53468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBzEe-0006WW-Mn
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBzEZ-0008Uj-0D
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:00:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBzEY-0008UU-T5
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:00:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 715AB41662E0
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 09:00:02 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-4-marcandre.lureau@redhat.com>
	<97a758db-dee1-7c23-27db-8b58d6f5d22e@redhat.com>
Date: Fri, 27 Apr 2018 10:59:58 +0200
In-Reply-To: <97a758db-dee1-7c23-27db-8b58d6f5d22e@redhat.com> (Eric Blake's
	message of "Thu, 19 Apr 2018 10:27:18 -0500")
Message-ID: <87fu3hqb1t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/5] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
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
>> Now that we can safely call QOBJECT() on QObject * as well as its
>> subtypes, we can have macros qobject_ref() / qobject_unref() that work
>> everywhere instead of having to use QINCREF() / QDECREF() for QObject
>> and qobject_incref() / qobject_decref() for its subtypes.
>>=20
>> Note that the new macros evaluate their argument exactly once, thus no
>> need to shout them.
>
> It's still useful information to include in the commit message that you
> did the substitution by sed, then fixed up compiler warnings that
> resulted from the new macro implementation being slightly more
> type-safe, as well as fixing up a long line.  That way, if someone
> backports this patch, they know how to resolve conflicts and/or check
> that they are not missing a conversion.

What about inserting

   The replacement is mechanical, except I broke a long line, and added
   a cast in monitor_qmp_cleanup_req_queue_locked().  Unlike
   qobject_decref(), qobject_unref() doesn't accept void *.

The justification sounds awkward because it is.  qobject_unref() turns
out to be less function-like than it looks on first glance.  The actual
culprit is QOBJECT().

> Writing good commit messages is an art form - but in general, if
> something was questioned during review of a previous revision, then it's
> never a bad idea to beef up the commit message to answer that question
> in advance for the next reviewer.
>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
