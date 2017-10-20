Received: from eggs.gnu.org ([2001:4830:134:3::10]:58871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5RSJ-0005wu-2d
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5RSF-0001GE-R1
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:10:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e5RSF-0001Fn-Kr
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 03:10:51 -0400
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171018224518.GA28532@flamenco>
	<5381cf3d-00c9-1c05-c973-5934311d654d@redhat.com>
	<20171019201149.GA15218@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64241d68-b526-3dc1-a264-fa9e6d634527@redhat.com>
Date: Fri, 20 Oct 2017 09:10:38 +0200
MIME-Version: 1.0
In-Reply-To: <20171019201149.GA15218@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/50] tcg tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 19/10/2017 22:11, Emilio G. Cota wrote:
> On Thu, Oct 19, 2017 at 15:05:17 +0200, Paolo Bonzini wrote:
>> On 19/10/2017 00:45, Emilio G. Cota wrote:
>>> I have just pushed a branch on top of this series that includes
>>> 10 patches that further pave the way for the removal of tb_lock:
>>>
>>>   https://github.com/cota/qemu/tree/multi-tcg-v6-plus
>>
>> I started reviewing those,
> 
> Nice, thanks!
> 
>> I have a few questions:
>>
>> 1) why is tcg_region_tree separate from tcg_region_state?  Would it make
>> sense to prepare a linked list of tcg_region_state structs, and reuse
>> the region lock for the region tree?
> 
> I think the naming here might be confusing; "tcg_region_state" should be
> understood as "tcg_region_global_state". IOW, there is no per-region struct.
> 
> That said, the array of per-region trees could be embedded in this global
> struct. I was hesitant to do so because then one could think that
> region_state.lock and rt.lock are somehow related; they are not.

Ok, this is clearer now.

>> 2) in tb_for_each_tagged_safe, could the "prev" argument instead be
>> "next", like
> 
> Is this just to make them closer to the macros in queue.h?
> 
> In this case tracking *prev in the loop (rather than next) is
> useful because it makes removing the "current" element very simple:

This actually makes a lot of sense.  Maybe we should change queue.h the
other way. ;)

Can you rename "prev" to "pprev" though?

Paolo
