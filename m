Received: from eggs.gnu.org ([2001:4830:134:3::10]:57781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVSh-0007rz-0M
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVSd-0004CV-Tw
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:51:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYVSd-0004BQ-NO
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:51:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06FCE4001868
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 11:51:39 +0000 (UTC)
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org> <20180627115919.GC2516@xz-mi>
	<87po0b48i9.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <523d3ced-5527-6474-43d5-78ebde7f01a4@redhat.com>
Date: Thu, 28 Jun 2018 06:51:38 -0500
MIME-Version: 1.0
In-Reply-To: <87po0b48i9.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

On 06/28/2018 03:31 AM, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Tue, Jun 26, 2018 at 07:21:49PM +0200, Markus Armbruster wrote:
>>> I fooled around a bit, and I think there are a few lose ends.
> [...]
>>> Talking to a QMP monitor that supports OOB:
>>>
>>>      $ socat UNIX:test-qmp READLINE,history=$HOME/.qmp_history,prompt='QMP> '
>>>      {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": ["oob"]}}
>>>      QMP> { "execute": "qmp_capabilities", "arguments": { "oob": true } }
>>>      {"error": {"class": "GenericError", "desc": "Parameter 'oob' is unexpected"}}
>>>      QMP> { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
>>>      {"return": {}}
>>>      QMP> { "execute": "query-qmp-schema" }
>>>      {"error": {"class": "GenericError", "desc": "Out-Of-Band capability requires that every command contains an 'id' field"}}
>>>
>>> Why does every command require 'id'?
> 
> Why am I asking?  Requiring 'id' is rather onerous when you play with
> QMP by hand.
> 

> Possible solutions other than requiring "id":
> 
> 1. Make out-of-band responses recognizable
> 
>     Just like we copy "id" to the response, we could copy "run-oob", or
>     maybe "control".
> 
>     Solves the "match response to command" problem, doesn't solve the
>     "match COMMAND_DROPPED event to command" problem.
> 
>     Permit me a digression.  "control": { "run-oob": true } is awfully
>     verbose.  Back when we hashed out the OOB design, I proposed to use
>     "exec-oob" instead of "execute" to run a command OOB.  I missed when
>     that morphed into flag "run-oob" wrapped in object "control".  Was it
>     in response to reviewer feedback?  Can you give me a pointer?

It's not too late to change back.  Since OOB is still new to 3.0, we 
could indeed go with a shorter invocation of 'exec-oob' (and I'd 
actually be in favor of such a change).

> 
>     The counterpart to "exec-oob" would be "return-oob" and "error-oob".
>     Hmm.

In other words, the change in the keyword of the response will let you 
know that it is replying to the most recent oob command.  This works 
well if we guarantee that we never have more than one unprocessed oob 
command in the pipeline at a time; but fails if oob commands can be 
threaded against one another and start replying in a different order 
than original submission.  Or, we could state that if you use 
'exec-oob', then 'id' is mandatory (and 'id' in the 'return' or 'error' 
is then sufficient to tie it back); but when using plain 'execute', 'id' 
remains optional.

> 
> 2. Do nothing; it's the client's problem
> 
>     If the client needs to match responses and events to commands, it
>     should use the feature that was expressly designed for helping with
>     that: "id".
> 
>     Note that QMP's initial design assumed asynchronous commands,
>     i.e. respones that may arrive in any order.  Nevertheless, it did not
>     require "id".  Same reasoning: if the client needs to match, it can
>     use "id".
> 
> As so often when "do nothing" is a viable solution, it looks mighty
> attractive to me :)

Indeed, although the documentation should still be explicit on 
recommending the use of 'id' when oob is enabled.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
