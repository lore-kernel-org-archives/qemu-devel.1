Received: from eggs.gnu.org ([2001:4830:134:3::10]:53328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ciFlL-0006T4-P8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ciFlG-0006g8-Td
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:30:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ciFlG-0006fl-NT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:30:22 -0500
References: <20170225231653.14942-1-mmarek@suse.com>
	<20170225233845.25828-1-mmarek@suse.com>
	<41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
	<f0b31c30-6b3e-fe9e-5f60-7a117456b595@suse.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ae4dba44-c634-062c-d412-201d1f10be32@redhat.com>
Date: Mon, 27 Feb 2017 08:30:16 +0100
MIME-Version: 1.0
In-Reply-To: <f0b31c30-6b3e-fe9e-5f60-7a117456b595@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Marek <mmarek@suse.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Eric Bischoff <ebischoff@suse.com>, Miroslav Benes <mbenes@suse.cz>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>

On 26.02.2017 19:57, Michal Marek wrote:
> Dne 26.2.2017 v 12:22 Thomas Huth napsal(a):
>> On 26.02.2017 00:38, Michal Marek wrote:
>>> The implementation is partially cargo cult based, but it works for the
>>> linux kernel use case.
>>>
>>> Signed-off-by: Michal Marek <mmarek@suse.com>
>>> ---
>>> v3:
>>>  - Initialize the buffer in do_stfle()
>>> v2:
>>>  - STFLE is not a privileged instruction, go through the MMU to store the
>>>    result
>>>  - annotate the stfl helper with TCG_CALL_NO_RWG
>>>  - Use a large enough buffer to hold the feature bitmap
>>>  - Fix coding style of the stfle helper
>>> ---
>>>  target/s390x/cpu_features.c |  6 ++++--
>>>  target/s390x/cpu_features.h |  2 +-
>>>  target/s390x/helper.h       |  2 ++
>>>  target/s390x/insn-data.def  |  2 ++
>>>  target/s390x/misc_helper.c  | 36 ++++++++++++++++++++++++++++++++++++
>>>  target/s390x/translate.c    | 17 +++++++++--------
>>>  6 files changed, 54 insertions(+), 11 deletions(-)
[...]
>>> +uint64_t HELPER(stfle)(CPUS390XState *env, uint64_t a0, uint64_t r0)
>>> +{
>>> +    int need, len = r0 & 0xff;
>>
>> According to the POP spec, the address "must be designated on a
>> doubleword boundary; otherwise, a specification exception is recognized."
>> Could you please add this check here (or in translate.c)?
> 
> Dumb question, but how do I signal a specification exception?
> s390_cpu_do_interrupt() does not seem to be prepared for it.

Not sure, but I think something like

 program_interrupt(env, PGM_SPECIFICATION, 4);

should do the job here.

 Thomas
