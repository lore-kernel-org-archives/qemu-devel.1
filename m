Received: from eggs.gnu.org ([2001:4830:134:3::10]:35403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fwpsb-0007zy-Lr
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fwpsY-0007Lz-E1
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:31:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fwpsY-0007Ix-7Y
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 10:30:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 58359402243B
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 14:30:57 +0000 (UTC)
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-5-peterx@redhat.com>
	<87a7oz9g1y.fsf@dusky.pond.sub.org>
	<20180903101606.GB14774@xz-x1> <87k1o2671t.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <55829207-b0f7-0869-6ec7-90bc2fb67e3a@redhat.com>
Date: Mon, 3 Sep 2018 09:30:52 -0500
MIME-Version: 1.0
In-Reply-To: <87k1o2671t.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/7] qapi: remove COMMAND_DROPPED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 09/03/2018 08:31 AM, Markus Armbruster wrote:

> Example:
> 
>      client sends in-band command #1
>      QEMU reads and queues
>      QEMU dequeues in-band command #1
>      in-band command #1 starts executing, but it's slooow
>      client sends in-band command #2
>      QEMU reads and queues
>      ...
>      client sends in-band command #8
>      QEMU reads, queues and suspends the monitor
>      client sends out-of-band command
> --> time passes...
>      in-band command #1 completes, QEMU sends reply
>      QEMU dequeues in-band command #2, resumes the monitor
>      in-band command #2 starts executing
>      QEMU reads and executes out-of-band command
>      out-of-band command completes, QEMU sends reply
>      in-band command #2 completes, QEMU sends reply
>      ... same for remaining in-band commands ...
> 
> The out-of-band command gets stuck behind the in-band commands.
> 
> The client can avoid this by managing the flow of in-band commands: have
> no more than 7 in flight, so the monitor never gets suspended.
> 
> This is a potentially useful thing to do for clients, isn't it?
> 
> Eric, Daniel, is it something libvirt would do?

Right now, libvirt serializes commands - it never sends a QMP command 
until the previous command's response has been processed. But that may 
not help much, since libvirt does not send OOB commands.

I guess when we are designing what libvirt should do, and deciding WHEN 
it should send OOB commands, we have the luxury of designing libvirt to 
enforce how many in-flight in-band commands it will ever have pending at 
once (whether the current 'at most 1', or even if we make it more 
parallel to 'at most 7'), so that we can still be ensured that the OOB 
command will be processed without being stuck in the queue of suspended 
in-band commands.  If we never send more than one in-band at a time, 
then it's not a concern how deep the qemu queue is; but if we do want 
libvirt to start parallel in-band commands, then you are right that 
having a way to learn the qemu queue depth is programmatically more 
precise than just guessing the maximum depth.  But it's also hard to 
argue we need that complexity if we don't have an immediate use 
envisioned for it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
