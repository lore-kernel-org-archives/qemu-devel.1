Received: from eggs.gnu.org ([2001:4830:134:3::10]:44395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fY9hW-0001o7-Kc
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fY9hS-0002tx-6e
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:37:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48674 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fY9hS-0002sR-1p
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:37:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBF6181A4EBC
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:37:28 +0000 (UTC)
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org> <20180627102043.GD30628@redhat.com>
	<8760248odg.fsf@dusky.pond.sub.org> <20180627120733.GD2516@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e9dc7aa-1d4e-ca9d-c551-eb0fb36e88b8@redhat.com>
Date: Wed, 27 Jun 2018 07:37:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180627120733.GD2516@xz-mi>
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
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 06/27/2018 07:07 AM, Peter Xu wrote:

>>> Worse than that - broadcasting to all monitors is categorically broken.
>>> Different monitors make use the same "id" formatting scheme, so if you
>>> broadcast COMMAND_DROPPED to a different monitor you might have clashing
>>> "id" and thus incorrectly tell a client its command was dropped when in
>>> fact it was processed. You'd have to be fairly unlucky in timing, but
>>> it could happen.
>>
>> Right.  Must fix bug.
> 

> 
> My current plan is that I can touch up scripts/qapi/events.py and
> related stuff to allow QMPEventFuncEmit to take a monitor parameter,
> then we pass in NULL when we want to send the event to all monitors.
> 
> Would that work?

Makes sense to me. Also, right now, ALL callers of qapi_event_send_* 
pass &error_abort as their final parameter. If you're refactoring 
everything anyways, you could get rid of that parameter on the 
presumption that it doesn't buy us anything.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
