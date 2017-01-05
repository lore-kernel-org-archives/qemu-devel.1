Received: from eggs.gnu.org ([2001:4830:134:3::10]:33631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cP5ZC-0005Wh-J3
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cP5ZB-0000EA-NR
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:46:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cP5ZB-0000Di-H3
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:46:41 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F9314E4FC
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 10:46:41 +0000 (UTC)
References: <20161223182641.2718-1-pbonzini@redhat.com>
	<20161223182641.2718-3-pbonzini@redhat.com>
	<20170104171823.GJ10541@redhat.com>
	<828473785.4444002.1483565184407.JavaMail.zimbra@redhat.com>
	<20170105102637.GD3292@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <edf6cdd7-8839-21a9-837b-cc07cbb2e7aa@redhat.com>
Date: Thu, 5 Jan 2017 11:46:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170105102637.GD3292@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org



On 05/01/2017 11:26, Daniel P. Berrange wrote:
>>>> +    if (condition == G_IO_IN) {
>>>> +        ioc->read_coroutine = qemu_coroutine_self();
>>>> +    } else if (condition == G_IO_OUT) {
>>>> +        ioc->write_coroutine = qemu_coroutine_self();
>>>> +    } else {
>>>> +        abort();
>>>> +    }
>>> Do we really need this to be an either/or/abort ? It looks like
>>> the qio_channel_set_fd_handlers() method is happy top have both
>>> read_coroutine & write_coroutine set.
>> The idea is that this would be called by a coroutine after a
>> recv or send that returns EAGAIN (with G_IO_IN for recv and
>> G_IO_OUT for send).  If not exclusive, you'd have to check
>> for ioc->read_coroutine == ioc->write_coroutine in the handler.
>> Not a big deal, I can do it, but it adds an edge case and I
>> didn't see a use for it.
> 
> Yep, it feels unlikely. Tht said, it looks similar to the case
> where you have two coroutines using the same channel, and one
> does a yield(G_IO_IN) and the other does a yield(G_IO_OUT) while
> the first is still waiting, which feels like a more plausible
> scenario that could actually happen. So perhaps we do need to
> consider it

Yes, it is possible to have both two conditions active at the same time
for two different coroutines and it does happen.  As in the
set_aio_context case, NBD has G_IO_IN pretty much always active to poll
for responses---and in the meanwhile a coroutine might send a request
and activate G_IO_OUT polling.  In this case, however, there would be
two qio_channel_yield calls.

The unlikely part is when a single coroutine wants to poll both conditions.

One improvement I can do here is to assert !ioc->read_coroutine if
condition is G_IO_IN and !ioc->write_coroutine if condition is G_IO_OUT.
 If this is not respected, the coroutine that yielded first would never
be called back again!

In any case, I'm happy that overall the API and the implementation look
sane to you.

Paolo
