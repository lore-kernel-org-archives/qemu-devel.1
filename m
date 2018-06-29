Received: from eggs.gnu.org ([2001:4830:134:3::10]:47192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYvVs-0004le-4n
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYvVr-00060N-6S
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:40:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50746 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYvVq-0005zk-Tb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:40:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 78CF581AB337
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 15:40:42 +0000 (UTC)
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org> <20180627115919.GC2516@xz-mi>
	<87po0b48i9.fsf@dusky.pond.sub.org> <20180628120044.GF3513@redhat.com>
	<20180629095718.GJ2455@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0fd5f819-f565-7f4b-8901-33ce6ee1dabc@redhat.com>
Date: Fri, 29 Jun 2018 10:40:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180629095718.GJ2455@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] your mail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 06/29/2018 04:57 AM, Peter Xu wrote:

>>>     Permit me a digression.  "control": { "run-oob": true } is awfully
>>>     verbose.  Back when we hashed out the OOB design, I proposed to use
>>>     "exec-oob" instead of "execute" to run a command OOB.  I missed when
>>>     that morphed into flag "run-oob" wrapped in object "control".  Was it
>>>     in response to reviewer feedback?  Can you give me a pointer?
> 
> It's me who proposed this, not from any reviewer's feedback.  It just
> happened that no one was against it.

Only because I didn't notice the difference, and was helping clear the 
QAPI backlog before the release.  You've now had both the maintainer and 
the backup express a desire for the shorter form.

> 
>>>
>>>     The counterpart to "exec-oob" would be "return-oob" and "error-oob".
>>>     Hmm.
>>
>> I do prefer the less verbose proposal too.
> 
> But frankly speaking I still prefer current way.  QMP is majorly for
> clients (computer programs) rather than users to use it.  Comparing to
> verbosity, I would care more about coherency for how we define the
> interface.  Say, OOB execution is still one way to execute a command,
> so naturally it should still be using the same way that we execute a
> QMP command, we just need some extra fields to tell the server that
> "this message is more urgent than the other ones".

Code-wise, it's actually simpler for libvirt to write:

if (oob) {
     virJSONValueObjectCreate(&cmd, "s:exec-oob", cmdname, ...);
} else {
     virJSONValueObjectCreate(&cmd, "s:execute", cmdname, ...);
}

that it is to write:

virJSONValueObjectCreate(&cmd, "s:execute", cmdname, ...);
if (oob) {
     virJSONValuePtr control;
     virJSONValueObjectCreate(&control, "b:run-oob", true, NULL);
     virJSONValueObjectAppend(&cmd, "control", control);
}

(plus error-checking that I omitted).

In short, adding extra fields is MORE work than just using the command 
name AS the additional bit of information.

> 
> If we are discussing HMP interfaces, I'll have the same preference
> with both of you to consider more about whether it's user-friendly or
> not.  But now we are talking about QMP, then I'll prefer "control".

If you don't want to write the patch, then probably Markus or I will.

> 
> In the future, it's also possible to add some more sub-fields into the
> "control" field.  When that happens, do we want to introduce another
> standalone wording for that?  I would assume the answer is no.

We may add a "control" field at that time, and may even offer 
convenience syntax to allow "exec-oob" to behave as if a "control" field 
were passed.  But the addition of new control features is rare, so I'd 
rather deal with that when we have something to actually add, rather 
than making us suffer with unneeded verbosity for potentially years 
waiting for that next control field to materialize.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
