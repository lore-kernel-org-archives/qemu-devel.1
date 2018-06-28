Received: from eggs.gnu.org ([2001:4830:134:3::10]:56011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVKN-0005Ca-0k
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVKK-0004jW-6E
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:43:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYVKK-0004iK-1S
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 07:43:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D04FF407529E
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 11:43:02 +0000 (UTC)
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org> <20180627102043.GD30628@redhat.com>
	<8760248odg.fsf@dusky.pond.sub.org> <20180627120733.GD2516@xz-mi>
	<877emj5rij.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae282736-b3bd-d1ac-142e-d7394b5efbb6@redhat.com>
Date: Thu, 28 Jun 2018 06:43:01 -0500
MIME-Version: 1.0
In-Reply-To: <877emj5rij.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] monitor: enable OOB by default
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

On 06/28/2018 01:55 AM, Markus Armbruster wrote:

> Changing an existing event from broadcast to unicast is an observable
> change in existing behavior.  Compatibility break unless we can show
> nobody can use / uses the observation.

And no one could have been relying on the broadcast COMMAND_DROPPED 
event semantics, since OOB was previously experimental and since we just 
proved that they are wrong if not limited to one monitor.

> 
> Creating a new event is not a compatibility break by itself[*],
> regardless of broadcast vs. unicast.
> 
>> My current plan is that I can touch up scripts/qapi/events.py and
>> related stuff to allow QMPEventFuncEmit to take a monitor parameter,
>> then we pass in NULL when we want to send the event to all monitors.
>>
>> Would that work?
> 
> Think so.
> 
> Alternatively, a pair of functions:
> 
>      void qapi_event_bcast_EVENT(... event params ..., Error **errp);
>      void qapi_event_send_EVENT(Monitor *mon, ... event params ..., Error **errp);
> 
> Slightly more compact in the broadcast case, might be a bit easier to
> read.

Also, fewer NULL arguments to add into existing call sites (although 
existing call sites would change to use the _bcast_ form, so you're 
already touching all call sites, which brings back the topic from the 
other mail on dropping useless errp while at it).

> 
> 
> [*] In the case of COMMAND_DROPPED, the compatibility break is dropping
> commands (the event's trigger), caused by the command queuing feature.
> That's why command queuing has to be opt-in.  Details discussed
> elsewhere in this thread.

Indeed, and I thought the conclusion there was that we DO promise that 
COMMAND_DROPPED (and dropped commands in general) won't happen unless 
you negotiate oob at initial connection.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
