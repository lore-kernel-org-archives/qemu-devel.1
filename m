Received: from eggs.gnu.org ([2001:4830:134:3::10]:38993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebSqX-0003aE-Iu
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebSqT-0008K3-OW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:08:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebSqT-0008Ix-Iq
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:08:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE3885B31F
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 15:08:12 +0000 (UTC)
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-9-git-send-email-pbonzini@redhat.com>
	<20180116144311.GG1521@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ef14eac-b5ea-1cc5-6c24-b490efc916d6@redhat.com>
Date: Tue, 16 Jan 2018 16:07:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180116144311.GG1521@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 08/51] chardev: introduce
 qemu_chr_timeout_add_ms()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

On 16/01/2018 15:43, Daniel P. Berrange wrote:
>>
>> It's a replacement of g_timeout_add[_seconds]() for chardevs.  Chardevs
>> now can have dedicated gcontext, we should always bind chardev tasks
>> onto those gcontext rather than the default main context.  Since there
>> are quite a few of g_timeout_add[_seconds]() callers, a new function
>> qemu_chr_timeout_add_ms() is introduced.
> FYI the point of using g_timeout_add_seconds() is that it allow the
> glib event loop to be more efficient. It ensures that all timers
> which second granularity are dispatched on the same iteration of
> the main loop. IOW, if you have 10 timers registered with
> g_timeout_add_seconds() the main loop wakes up once a second and
> runs all 10 of them. If you have 10 timers registered with g_timeout_add
> the main loop wakes up 10 times a second, at a different time for each
> timer.

Yes, that can be added back later.  In our case, it may even hurt to
synchronize all timeouts at the same time (if there are many of them)
because the BQL can introduce jitter.  But it is difficult to say
without measuring.

Paolo
