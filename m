Received: from eggs.gnu.org ([2001:4830:134:3::10]:49031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eykQE-0003vr-Vm
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eykQB-0004d9-42
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:33:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eykQA-0004cw-VV
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:33:19 -0400
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-15-peterx@redhat.com>
	<CAJ+F1C+3f9RAC86YxRuvGWbX1tegA01iaY760yLOB2W5OyHaNA@mail.gmail.com>
	<20180321200933.GB3466@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e0a2365-a90e-3798-2c73-70ef2df67977@redhat.com>
Date: Wed, 21 Mar 2018 15:33:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180321200933.GB3466@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/21/2018 03:09 PM, Dr. David Alan Gilbert wrote:

>>>
>>> So the parsing job and the dispatching job is isolated now.  It gives us
>>> a chance in following up patches to totally move the parser outside.
>>>
>>> The isolation is done using one QEMUBH. Only one dispatcher QEMUBH is
>>> used for all the monitors.
>>>

>>> +
>>> +    /*
>>> +     * If OOB is not enabled on current monitor, we'll emulate the old
>>> +     * behavior that we won't process current monitor any more until
>>> +     * it is responded.  This helps make sure that as long as OOB is
>>> +     * not enabled, the server will never drop any command.
>>> +     */
>>> +    if (!qmp_oob_enabled(mon)) {
>>> +        monitor_suspend(mon);
>>> +        req_obj->need_resume = true;
>>> +    }
>>> +
>>> +    /*
>>> +     * Put the request to the end of queue so that requests will be
>>> +     * handled in time order.  Ownership for req_obj, req, id,
>>
>> I think the order is not respected if subsequent messages have errors
>> (in either json parsing, dispatch_check_obj, oob_check). So if I
>> enable oob, and queue a few command, then send a bad command/message,
>> I won't be able to tell for which command.
> 
> Doesn't OOB insist on having an ID field with the command?

OOB insists on an id field - but there is the situation that SOME errors 
occur even before the id field has been encountered (for example, if you 
send non-JSON, the parser gets all confused - it has to emit SOME error, 
but that error can't refer to an id because it wasn't able to parse one 
yet).  A well-formed client will never do this, but we MUST be robust 
even in the face of a malicious client (or even a well-intentioned 
client but a noisy communication medium that manages to corrupt bytes). 
I'm not sure if the testsuite adequately covers what happens in this 
scenario.  Peter?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
