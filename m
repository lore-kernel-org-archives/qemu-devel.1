Received: from eggs.gnu.org ([2001:4830:134:3::10]:34929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej52v-0000c5-53
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej52r-00010y-5T
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:20:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ej52q-0000yo-UX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:20:29 -0500
References: <1516369485-5374-1-git-send-email-zhangckid@gmail.com>
	<1516369485-5374-11-git-send-email-zhangckid@gmail.com>
	<87zi4qf4yi.fsf@dusky.pond.sub.org>
	<CAK3tnvLsUp8CdpThNMSXR62JRSd1D+wGGZowixJF04CQ6e858g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <812d3335-30d3-28ed-ca9e-7f5b1b9caaca@redhat.com>
Date: Tue, 6 Feb 2018 09:20:17 -0600
MIME-Version: 1.0
In-Reply-To: <CAK3tnvLsUp8CdpThNMSXR62JRSd1D+wGGZowixJF04CQ6e858g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 10/16] qmp event: Add COLO_EXIT event to
 notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 02/05/2018 09:13 PM, Zhang Chen wrote:

>>> +##
>>> +{ 'event': 'COLO_EXIT',
>>> +  'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
>>
>> Standard question when I see a new event: is there a way to poll for the
>> event's information?  If not, why don't we need one?
>>
>>
> Your means is we'd better print the information to a log file or something
> like that for all qemu events?
> CC  Eric Blake <eblake@redhat.com>
> any idea about this?

Nothing to add, Markus is right - implementing a new mechanism that logs 
all events as they are issued, and teaching libvirt to parse that log at 
startup, is more work than just implementing a query-foo command that 
libvirt already knows how to use to query current state on first connect 
(and based on that query, make an intelligent decision on whether at 
least one event was missed during downtime).  So far, no one has come up 
with an event that is so important it must be logged, when compared to 
the working alternative of just having events be ways to optimize 
performance so that the query- command doesn't have to be polled all the 
time, but no severe loss if the event is missed because the query- can 
be used in its place.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
