Received: from eggs.gnu.org ([2001:4830:134:3::10]:36398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYSLI-0002Xg-2P
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fYSLE-00063N-4k
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:31:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fYSLD-0005yP-UD
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 157688A9EF
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:31:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org> <20180627115919.GC2516@xz-mi>
Date: Thu, 28 Jun 2018 10:31:42 +0200
In-Reply-To: <20180627115919.GC2516@xz-mi> (Peter Xu's message of "Wed, 27 Jun
	2018 19:59:19 +0800")
Message-ID: <87po0b48i9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] your mail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jun 26, 2018 at 07:21:49PM +0200, Markus Armbruster wrote:
>> I fooled around a bit, and I think there are a few lose ends.
[...]
>> Talking to a QMP monitor that supports OOB:
>> 
>>     $ socat UNIX:test-qmp READLINE,history=$HOME/.qmp_history,prompt='QMP> '
>>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": ["oob"]}}
>>     QMP> { "execute": "qmp_capabilities", "arguments": { "oob": true } }
>>     {"error": {"class": "GenericError", "desc": "Parameter 'oob' is unexpected"}}
>>     QMP> { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
>>     {"return": {}}
>>     QMP> { "execute": "query-qmp-schema" }
>>     {"error": {"class": "GenericError", "desc": "Out-Of-Band capability requires that every command contains an 'id' field"}}
>> 
>> Why does every command require 'id'?

Why am I asking?  Requiring 'id' is rather onerous when you play with
QMP by hand.

> The COMMAND_DROPPED event is one reason, as you mentioned in the other
> thread. Meanwhile as long as we have OOB command it means that we can
> have more than one commands running in parallel, then it's a must that
> we can mark that out in the response to mark out which command we are
> replying to.

Without OOB, the client can match response to command, because it'll
receive responses in command issue order.

Example 1: after sending

    { "execute": "cmd1", ... }
    { "execute": "cmd2", ... }
    { "execute": "cmd3", ... }

the client will receive three responses, first one is cmd1's, second one
is cmd2's, third one is cmd3's.

With OOB, we have to independent command streams, in-band and
out-of-band.  Each separate stream's responses arrive in-order, but the
two streams may be interleaved.

Example 2: after sending

    { "execute": "cmd1", ... }
    { "execute": "cmd2", ... }
    { "execute": "cmd3", ... }
    { "execute": "oob1", "control": { "run-oob": true }, ... }
    { "execute": "oob2", "control": { "run-oob": true }, ... }
    { "execute": "oob3", "control": { "run-oob": true }, ... }

the client will receive six responses: cmd1's before cmd2's before
cmd3's, and oob1's before oob2's before oob3's.

If the client sends "id" with each command, it can match responses to
commands by id.

But that's not the only way to match.  Imagine the client had a perfect
oracle to tell it whether a response is in-band or out-of-band.  Then
matching can work pretty much as in example 1: the first in-band
response is cmd1's, the second one is cmd2's, and the third one is
cmd3's; the first out-of-band response is oob1's, the second one is
oob2's and the third one is oob3's.

Possible solutions other than requiring "id":

1. Make out-of-band responses recognizable

   Just like we copy "id" to the response, we could copy "run-oob", or
   maybe "control".

   Solves the "match response to command" problem, doesn't solve the
   "match COMMAND_DROPPED event to command" problem.

   Permit me a digression.  "control": { "run-oob": true } is awfully
   verbose.  Back when we hashed out the OOB design, I proposed to use
   "exec-oob" instead of "execute" to run a command OOB.  I missed when
   that morphed into flag "run-oob" wrapped in object "control".  Was it
   in response to reviewer feedback?  Can you give me a pointer?

   The counterpart to "exec-oob" would be "return-oob" and "error-oob".
   Hmm.

2. Do nothing; it's the client's problem

   If the client needs to match responses and events to commands, it
   should use the feature that was expressly designed for helping with
   that: "id".

   Note that QMP's initial design assumed asynchronous commands,
   i.e. respones that may arrive in any order.  Nevertheless, it did not
   require "id".  Same reasoning: if the client needs to match, it can
   use "id".

As so often when "do nothing" is a viable solution, it looks mighty
attractive to me :)

[...]
