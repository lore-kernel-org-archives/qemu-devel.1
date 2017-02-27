Received: from eggs.gnu.org ([2001:4830:134:3::10]:40106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciE8R-0001ml-Vh
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciE8N-0005Mt-A5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:46:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ciE8N-0005Mk-4l
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 00:46:07 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C98761D0C
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:46:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-18-git-send-email-armbru@redhat.com>
	<6ab9e2cd-edbe-b167-8a16-bf9c00c110ac@redhat.com>
	<87bmtraaz8.fsf@dusky.pond.sub.org>
	<fdf01e1e-c903-b029-8785-0c9f341d7d06@redhat.com>
Date: Mon, 27 Feb 2017 06:46:04 +0100
In-Reply-To: <fdf01e1e-c903-b029-8785-0c9f341d7d06@redhat.com> (Eric Blake's
	message of "Sat, 25 Feb 2017 15:16:33 -0600")
Message-ID: <87d1e4nq3n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 17/21] qapi: Drop unused non-strict qobject
 input visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/24/2017 09:02 AM, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 23/02/2017 22:45, Markus Armbruster wrote:
>>>> The split between tests/test-qobject-input-visitor.c and
>>>> tests/test-qobject-input-strict.c now makes less sense than ever.  The
>>>> next commit will take care of that.
>>>
>>> I'm actually adding a use for non-strict visitors (and one that makes
>>> sense IMHO, with comments, testcases and all that :)).  See
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg432069.html.
>> 
>> I replied.
>
> Hmm. Right now, we implement strict checking by populating a hash table
> in parallel to the QObject being visited, then checking if it gets
> emptied.  I wonder if it would be any simpler to clone the QObject and
> then remove keys, rather than tracking a separate hash table.  In fact,
> you could then turn strict checking into an after-the-fact item:
> creating the visitor passes in a QObject, then after the visit you check
> whether the QObject has been emptied.  But that's not something that has
> to be solved for 2.9.

Only dictionaries need to be cloned, everything else can be shared.

But cloning is still slow.

If QDict was an association list rather than an array, we could use a
bit vector to record visits.

Association list could well be better anyway.  I suspect most QDicts
have few keys.  Measurements needed to confirm.

>>> For what it's worth, however, I believe that even non-strict visits
>>> should detect unvisited list tails.
>> 
>> Bit of an asymmetry.  Not sure it matters, because to not visit list
>> tails, you have to put in some effort.
