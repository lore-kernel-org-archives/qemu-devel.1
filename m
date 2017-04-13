Received: from eggs.gnu.org ([2001:4830:134:3::10]:45104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyXa8-0005OC-Rk
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 01:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cyXa4-0005cV-19
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 01:46:12 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170412204641.GA15762@localhost.localdomain>
	<f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
	<20170412222251.GB15762@localhost.localdomain>
	<20170412235420.GB8607@lemon>
	<20170413011109.GC15762@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c74d2b7d-d185-53ba-9bf9-8cf976d8f684@redhat.com>
Date: Thu, 13 Apr 2017 13:45:55 +0800
MIME-Version: 1.0
In-Reply-To: <20170413011109.GC15762@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, John Snow <jsnow@redhat.com>



On 13/04/2017 09:11, Jeff Cody wrote:
>> It didn't make it into 2.9-rc4 because of limited time. :(
>>
>> Looks like there is no -rc5, we'll have to document this as a known issue.
>> Users should "block-job-complete/cancel" as soon as possible to avoid such a
>> hang.
>
> I'd argue for including a fix for 2.9, since this is both a regression, and
> a hard lock without possible recovery short of restarting the QEMU process.

It is a bit of a corner case (and jobs on I/O thread are relatively rare
too), so maybe it's not worth delaying 2.9.  It has been delayed already
quite a bit.  Another reason I think I prefer to wait is to ensure that
we have an entry in qemu-iotests to avoid the future regression.

Fam explained to me what happens, and the root cause is that bdrv_drain
never does a release/acquire pair in this case, so the I/O thread run
remains stuck in a callback that tries to acquire.  Ironically
reintroducing RFifoLock would probably fix this (not 100% sure).  Oops.

His solution is a bit hacky, but we will hopefully be able to revert it
in 2.10 or whenever aio_context_acquire/release will go away.

Thanks,

Paolo
