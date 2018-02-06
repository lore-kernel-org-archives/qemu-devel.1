Received: from eggs.gnu.org ([2001:4830:134:3::10]:49804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej5m5-0001Iy-Vo
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej5lz-0000Us-Rt
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 11:07:13 -0500
References: <20171207155102.66622-4-vsementsov@virtuozzo.com>
	<74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
	<7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
	<d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
	<4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
	<79e5851b-f35e-23ea-4842-cc3b1d1e30ee@virtuozzo.com>
	<1e2fd96e-5d07-3c52-33df-cf31490eb6ca@redhat.com>
	<eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
	<1298bc3d-c2bd-6fd5-5d3d-dabcae434874@redhat.com>
	<2e145d8b-855f-9060-1b81-feb515067293@virtuozzo.com>
	<20180126150511.GG2610@work-vm>
	<ac366ae3-d7e0-db65-d5ee-d276a42320da@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <665b0973-1cf4-8926-1a53-cb392684ba36@redhat.com>
Date: Tue, 6 Feb 2018 10:06:36 -0600
MIME-Version: 1.0
In-Reply-To: <ac366ae3-d7e0-db65-d5ee-d276a42320da@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

On 02/06/2018 09:29 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> most of commands, ported to hmp are done in same style: they just call
>>> corresponding qmp command.
>>> Isn't it better to provide common interface for calling qmp commands 
>>> through
>>> HMP monitor, to never
>>> create hmp versions of new commands? they will be available 
>>> automatically.
>> It would be nice to do that, but they're not that consistent in how they
>> convert parameters and options, but I occasionally wonder if we could
>> automate more of it.
> 
> 
> What about allowing some new syntax in hmp, directly mapped to qmp?
> 
> something like
> 
>  >>> blockdev-add id disk driver qcow2 cache {writeback true direct 
> true} aio native discard unmap file {driver file filename /tmp/somedisk}
> 

Personally, if I'm testing blockdev-add, I'll use QMP directly (or even 
scripts/qmp/qmp-shell or virsh qemu-monitor-command), not an HMP wrapper 
where I have to learn a new syntax of how to write something that will 
convert to QMP.  We already have enough different ways to write things 
that I don't need to learn yet another syntax wrapper.  Or maybe what 
I'm saying is that instead of inventing a new syntax, that if you DO add 
an HMP command that forwards to QMP, please reuse an existing syntax 
(whether direct JSON as used by QMP, or the syntax used by qmp-shell).

If you think writing a new HMP command is worth it, I won't stop you 
from writing it.  But at this point, our current approach of writing a 
manual wrapper per command as we have interest, rather than a generic 
wrap-anything, has worked for the cases that HMP users have cared about. 
  Remember, QMP is the interface that MUST work, while HMP is only for 
convenience, and if it is not trivial to make HMP do everything that QMP 
can do, it is no real loss.

> ?
> 
> Or it may be realized as a separate hmp command "qmp" (looks more safe 
> as a first step, however, I think previous variant (direct call) is 
> better):
> 
>  >>> qmp blockdev-add id disk driver qcow2 cache {writeback true direct 
> true} aio native discard unmap file {driver file filename /tmp/somedisk}
> 
> what do think? This looks simple to implement and should be useful.

Up to you if you want to tackle anything like that, but it would be a 
new thread (a generic way to invoke QMP from HMP is independent of 
nbd-server-remove).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
