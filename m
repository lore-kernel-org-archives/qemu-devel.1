Received: from eggs.gnu.org ([2001:4830:134:3::10]:58744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKKB-0000ad-Vt
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKK7-0003bC-VP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:15:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1emKK7-0003aq-Ol
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:15:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBBCB40287E0
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:15:42 +0000 (UTC)
References: <20180213142102.14450-1-stefanha@redhat.com>
	<20180213142102.14450-2-stefanha@redhat.com>
	<73eb771d-ddcd-42e6-5895-23e6024ccc80@redhat.com>
	<20180214140647.GC7545@stefanha-x1.localdomain>
	<8894e9fa-8e3d-ecfe-07f4-61a465f4bf57@redhat.com>
	<20180215092730.GA23321@stefanha-x1.localdomain>
	<20180215101257.GC4575@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b12474e6-f1e1-c714-da61-43397d5c41b0@redhat.com>
Date: Thu, 15 Feb 2018 08:15:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180215101257.GC4575@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: extract AIO_WAIT_WHILE()
 from BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

On 02/15/2018 04:12 AM, Kevin Wolf wrote:
>> Having acquired the AioContext does not make this function return true.
>> The semantics are:
>> 1. Current thread is the IOThread that runs the AioContext
>> 2. Current thread is the main loop and the AioContext is the global
>>     AioContext.
>>
>> The function tests whether the current thread is the "native" or "home"
>> thread for this AioContext.  Perhaps we could also call it the "poller"
>> thread because only that thread is allowed to call aio_poll(ctx, true).
>>
>>    if (aio_context_in_native_thread(ctx)) {
>>        ...
>>    } else {
>>        ...
>>    }
>>
>> What do you think?
> 
> "home" or "native" both work for me. Or if we want to keep the name
> short, maybe just changing the order and s/iothread/thread/ would be
> enough: bool in_aio_context_thread(AioContext *ctx) - do you think that
> would still be prone to misunderstandings?

in_aio_context_home_thread() sounds slightly better than 
in_aio_context_thread(), but swapping the verb makes a nice difference 
where either name is better than what we currently have.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
