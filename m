Received: from eggs.gnu.org ([208.118.235.92]:55503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS6AO-0001cI-GT
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS6AL-0005zV-4T
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:06:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eS6AK-0005wX-Jh
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:06:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 00DD2285D0
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 19:05:58 +0000 (UTC)
References: <20171221132717.30284-1-berrange@redhat.com>
	<20171221132717.30284-3-berrange@redhat.com>
	<87mv2cuiut.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11c497d0-6e59-c836-7e73-74b617673d8e@redhat.com>
Date: Thu, 21 Dec 2017 13:05:54 -0600
MIME-Version: 1.0
In-Reply-To: <87mv2cuiut.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] char: allow passing pre-opened
 socket file descriptor at startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 12/21/2017 10:49 AM, Markus Armbruster wrote:
> QAPI schema review only.
> 

>> @@ -123,10 +124,16 @@
>>   #
>>   # @unix:  Unix domain socket
>>   #
>> +# @vsock: VSOCK socket
>> +#
>> +# @fd: socket file descriptor passed over monitor
>> +#
> 
> Indepedent doc fix.  I'd put it in a separate patch.

Missed in v2, so we still need that.

> 
> One inaccuracy: @fd is *not* a file descriptor, it's the *name* of a
> file descriptor.  Please fix.
> 
>> +# @fdset: socket file descriptor passed via CLI (since 2.12)
>> +#
> 
> I gather we have to ways to pass file descriptors.  One way identifies
> them by name (member @fd), the other by numeric ID (member @fdset).

Yes, sort of.

> 
> 0. This is disgusting.  Is there any way to unify the two, and deprecate
> the loser (hopefully the numeric one)?

v2 went with the numeric one for the CLI, as it is less verbose.

> 
> 1. What makes the second one a *set*?

We have two existing mechanisms for fd passing:

a) HMP and QMP have the older 'getfd' command since 0.14, which 
associates a single fd (via SCM_RIGHTS) with a name (which cannot start 
with a digit).  This does not scale - every command that wants to use an 
fd like this has to be updated to take an explicit fd argument; and you 
can't alter permissions on the fd after the fact.

b) QMP added the newer 'add-fd' in 1.2, which allows the association of 
multiple fds (via SCM_RIGHTS) with a set number (the set is then 
accessed via the magic prefix /dev/fdset/NNN.  This was also exposed via 
the command line, via '--add-fd', at the same time.  It also scales 
better, in that any command that already takes a filename now operates 
on fdsets as needed; also, you can associate multiple fds to the set 
(one that is read-only, another that is read-write), and qemu will 
alternate between fds according to permissions needed at the time.

New code targetting QMP should use only 'add-fd'; particularly since 
-addfd is the only version that works via CLI, even if there is only one 
fd in the set.  But it is more verbose, so having CLI shorthand that 
takes just an fd number is sometimes acceptable.

> 
> 2. What ties the second one to the CLI?  Accidents of implementation or
> something deeper?
> 

At this point, more history than anything else.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
