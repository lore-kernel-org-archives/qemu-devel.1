Received: from eggs.gnu.org ([2001:4830:134:3::10]:45391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFdZt-0005zl-MR
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFdZq-0000Yj-HI
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:36:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFdZq-0000YR-B0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:36:34 -0400
References: <20170526075246.20265-1-famz@redhat.com>
	<20170530091939.GF11362@stefanha-x1.localdomain>
	<20170530093328.GC20514@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b287344-9ff8-8145-fe69-4d36f79d3557@redhat.com>
Date: Tue, 30 May 2017 11:36:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170530093328.GC20514@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/22] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 30/05/2017 11:33, Fam Zheng wrote:
> On Tue, 05/30 10:19, Stefan Hajnoczi wrote:
>> On Fri, May 26, 2017 at 03:52:24PM +0800, Fam Zheng wrote:
>>> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:
>>>
>>>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/famz/qemu.git tags/docker-and-block-pull-request
>>>
>>> for you to fetch changes up to 77269bba94ef97de99ae61fdc98629a8704ae2ed:
>>>
>>>   block: make accounting thread-safe (2017-05-26 09:25:30 +0800)
>>>
>>> ----------------------------------------------------------------
>>>
>>> For Paolo's block layer thread safety part I and my docker testing
>>> enhancements.
>>
>> Please fix the checkpatch issues.
> 
> Paolo, could you provide the comments that can be added to the memory barriers?

It's a false positive.  The comments are just a couple lines above:

        /* We have to set low before high, just like stat64_max reads
         * high before low.  The value may become lower temporarily, but
         * stat64_get does not notice (it takes the lock) and the only ill
         * effect on stat64_max is that the slow path may be triggered
         * unnecessarily.
         */
        atomic_set(&s->low, (uint32_t)value);
        smp_wmb();
        atomic_set(&s->high, value >> 32);

Paolo
