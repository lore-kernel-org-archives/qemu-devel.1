Received: from eggs.gnu.org ([208.118.235.92]:38368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgaM-0005xi-Uz
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fzgaH-00047T-S0
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:11:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fzgaH-00046s-M1
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 07:11:53 -0400
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-2-cota@braap.org>
	<e0055fc2-778d-c9cd-c157-29032085e2e7@redhat.com>
	<20180910154442.GD19941@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e743312c-4b76-8728-f7fd-b634a97c8483@redhat.com>
Date: Tue, 11 Sep 2018 13:11:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180910154442.GD19941@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] qsp: drop atomics when using the
 seqlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/09/2018 17:44, Emilio G. Cota wrote:
> On Mon, Sep 10, 2018 at 01:32:15 +0200, Paolo Bonzini wrote:
>> On 03/09/2018 19:18, Emilio G. Cota wrote:
>>> Using atomics here is a mistake since they're not guaranteed
>>> to compile.
>>
>> But isn't it technically a C11 data race if you don't use atomics?
> 
> Yes, it's undefined behaviour.
> 
>> Could we make nocheck read/set degrade to just a volatile access when
>> used on a variable that is bigger than pointers, or perhaps always
>> except when using tsan?
> 
> But volatile wouldn't save you from undefined behaviour, would it?

Yeah, but 1) only on those hosts that cannot do CONFIG_ATOMIC64 2) we
pretty much already define what we expect from volatile.

Paolo

> A simpler and definitely correct alternative is to just use a
> spinlock instead of the seqlock also for reads when !CONFIG_ATOMIC64.
> We don't care about scalability on those rare hosts anyway, so
> I'd go with that.
> 
> Thanks,
> 
> 		Emilio
> 
