Received: from eggs.gnu.org ([2001:4830:134:3::10]:41501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez0DM-0003Kt-W6
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez0DH-0001IW-3a
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:25:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ez0DG-0001Hf-Tk
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:25:03 -0400
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-15-peterx@redhat.com>
	<CAJ+F1C+3f9RAC86YxRuvGWbX1tegA01iaY760yLOB2W5OyHaNA@mail.gmail.com>
	<20180321200933.GB3466@work-vm>
	<3e0a2365-a90e-3798-2c73-70ef2df67977@redhat.com>
	<CAJ+F1C+mcAxMVGXzYhbOoh932rKkEue22rk0ApqMHuOqbDDNGg@mail.gmail.com>
	<20180322050002.GF32362@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <95dcaa7a-fe49-02b1-a5e9-4e0583668e80@redhat.com>
Date: Thu, 22 Mar 2018 08:24:37 -0500
MIME-Version: 1.0
In-Reply-To: <20180322050002.GF32362@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 14/23] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/22/2018 12:00 AM, Peter Xu wrote:

>>>> Doesn't OOB insist on having an ID field with the command?
>>>
>>>
>>> OOB insists on an id field - but there is the situation that SOME errors
>>> occur even before the id field has been encountered (for example, if you
>>> send non-JSON, the parser gets all confused - it has to emit SOME error, but
>>> that error can't refer to an id because it wasn't able to parse one yet).  A
>>> well-formed client will never do this, but we MUST be robust even in the
>>> face of a malicious client (or even a well-intentioned client but a noisy
>>> communication medium that manages to corrupt bytes). I'm not sure if the
>>> testsuite adequately covers what happens in this scenario.  Peter?
>>
>> I think a solution would be to queue the error reply (the reply only)
>> instead of replying directly.
> 
> IMHO this should be fine.

Seems reasonable - conceptually, the error reply comes no sooner than 
pre-patch (the client wouldn't see a parse error message until after all 
earlier successful parsed messages completed), making a parse error a 
sort of synchronization barrier (if the client gets one, then all 
outstanding message prior to the parse error have finished sending 
replies to the client, and nothing after the parse error has been 
processed at the time the error message was sent).

> 
> Note that to be compatible with existing QMP we'll suspend the monitor
> if OOB is not enabled in the session on receiving the first command.
> It means even if another faulty command is sent after the good one,
> it'll not be read by QMP parser until the first one is fully complete.
> 
> Since I'm working on some test patches after all, I'll try to add a
> test case for this to see whether Eric would like them too.

Yes, these are the sorts of bug fixes and test suite coverage that we 
want to include during freeze, for better robustness.

> 
>>
>> Another problem I see with the current solution is that pending
>> commands are not discarded when a new client connects. So I suppose a
>> new client can receive replies for commands it didn't make, with id
>> namespace that may conflict with its own. breaking ordering etc. A
>> possible solution is to mark the pending request to not send the reply
>> somehow?
> 
> Yeah, to be simpler - maybe we can even drop the commands that have
> not yet been dispatched?
> 
> I'll treat a command as "complete" only until the client receives a
> response, otherwise if a client disconnects before receiving a reply
> then I think it's fine the behavior is undefined - IMHO it's fine
> either the QMP server executes the command or not (and no matter what,
> we drop the responses).  Would that work?

If a client disconnects before receiving a reply, I'm fine with either 
approach (the command gets discarded from the queue and never run - 
which matches if the client disconnect raced with the server actually 
getting the command, or the command ran but the response is dropped - 
which matches pre-patch behavior), while agreeing that sending the 
response to the next client is probably not a good idea (clients are 
supposed to ignore unknown id's, but we can't guarantee an 'id' 
collision will not confuse the client).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
