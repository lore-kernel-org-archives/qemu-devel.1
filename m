Received: from eggs.gnu.org ([2001:4830:134:3::10]:35557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkern@vsrv.kern.pm>) id 1d2yXg-0003Nn-Rk
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkern@vsrv.kern.pm>) id 1d2yXe-0006Lk-6U
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:22:00 -0400
Received: from vsrv.kern.pm ([138.201.172.171]:45154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pkern@vsrv.kern.pm>) id 1d2yXd-0006DR-QF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:21:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Apr 2017 13:21:42 +0200
From: Philipp Kern <phil@philkern.de>
In-Reply-To: <70dad7b4-f893-1af7-d0c9-7dbb10506b04@twiddle.net>
References: <20170423223216.17856-1-aurelien@aurel32.net>
	<23a3da7d-d330-7cad-5bef-8e80c8d9f50c@suse.de>
	<70dad7b4-f893-1af7-d0c9-7dbb10506b04@twiddle.net>
Message-ID: <51aa9f42dd0bb04e36dd67b02b226287@mail.kern.pm>
Sender: www-data <phil@philkern.de>
Subject: Re: [Qemu-devel] [PATCH] target-s390x: Mask the SIGP order_code to
 8bit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org, Richard Henderson <rth7680@gmail.com>

On 2017-04-25 11:51, Richard Henderson wrote:
> On 04/24/2017 10:25 AM, Alexander Graf wrote:
>> On 24.04.17 00:32, Aurelien Jarno wrote:
>>> From: Philipp Kern <phil@philkern.de>
>>> 
>>> According to "CPU Signaling and Response", "Signal-Processor Orders",
>>> the order field is bit position 56-63. Without this, the Linux
>>> guest kernel is sometimes unable to stop emulation and enters
>>> an infinite loop of "XXX unknown sigp: 0xffffffff00000005".
>>> 
>>> Signed-off-by: Philipp Kern <phil@philkern.de>
>>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>> ---
>>>  target/s390x/misc_helper.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> This patch has been sent by Philipp Kern a lot of time ago, and it 
>>> seems
>>> has been lost. I am resending it, as it is still useful.
>>> 
>>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>>> index 3bf09ea222..4946b56ab3 100644
>>> --- a/target/s390x/misc_helper.c
>>> +++ b/target/s390x/misc_helper.c
>>> @@ -534,7 +534,7 @@ uint32_t HELPER(sigp)(CPUS390XState *env, 
>>> uint64_t order_code, uint32_t r1,
>>>      /* Remember: Use "R1 or R1 + 1, whichever is the odd-numbered 
>>> register"
>>>         as parameter (input). Status (output) is always R1. */
>>> 
>>> -    switch (order_code) {
>>> +    switch (order_code & 0xff) {
>> 
>> This definitely needs a comment above the mask. Ideally I'd love to 
>> just change the function prototype to pass order_code as uint8_t, but 
>> I don't think that's possible with the TCG glue.
> 
> Correct.  We'll need to leave the mask here.

I shall point out that Alexander merged it into the s390-next tree when 
I first sent it but that was never merged into qemu proper. I don't 
think there's a problem in adding a comment that says what the commit 
description says right there, like this:

/* sigp contains the order code in bit positions 56-63, mask it here. */

Kind regards
Philipp Kern
