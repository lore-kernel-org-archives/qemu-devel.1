Received: from eggs.gnu.org ([2001:4830:134:3::10]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb7Pv-0000q1-Bk
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb7Ps-0006Xs-81
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:47:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fb7Ps-0006XC-3G
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:47:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9580340778C4
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 16:47:35 +0000 (UTC)
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-6-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46055729-f81c-e687-4a97-b2b242b0b063@redhat.com>
Date: Thu, 5 Jul 2018 11:47:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180704084507.14560-6-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] monitor: suspend monitor instead of
 send CMD_DROP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 07/04/2018 03:45 AM, Peter Xu wrote:
> When we received too many qmp commands, previously we'll send
> COMMAND_DROPPED events to monitors, then we'll drop the requests.  It
> can only solve the flow control of the request queue, however it'll not
> really work since we might queue unlimited events in the response queue
> which is a potential risk.
> 
> Now instead of sending such an event, we stop consuming the client input
> when we noticed that the queue is reaching its limitation before hand.
> Then after we handled commands, we'll try to resume the monitor when
> needed.

Is this the right thing to be doing?

If there is some event that we forgot to rate limit, and the client 
isn't consuming the output queue fast enough to keep up with events, we 
are making it so the client can't even send an OOB command that might 
otherwise stop the flood of events.  Refusing to parse input when the 
client isn't parsing output makes sense when the output is a result of 
the input, but when the output is the result of events unrelated to the 
input, it might still be nice to be responsive (even if with 
COMMAND_DROPPED events) to OOB input.  Then again, if events are not 
being parsed quickly by the client, it's debatable whether the client 
will parse COMMAND_DROPPED any sooner (even if COMMAND_DROPPED jumps the 
queue ahead of other events).

So I don't have a strong opinion on whether this patch is right or 
wrong, so much as voicing a potential concern to make sure I'm not 
overlooking something.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
