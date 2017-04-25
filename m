Received: from eggs.gnu.org ([2001:4830:134:3::10]:39761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2x7s-0005Vy-Rm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2x7o-0004WX-6E
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:51:16 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d2x7n-0004W2-Vu
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:51:12 -0400
Received: by mail-wr0-x243.google.com with SMTP id 6so10217718wrb.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 02:51:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170423223216.17856-1-aurelien@aurel32.net>
	<23a3da7d-d330-7cad-5bef-8e80c8d9f50c@suse.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <70dad7b4-f893-1af7-d0c9-7dbb10506b04@twiddle.net>
Date: Tue, 25 Apr 2017 11:51:08 +0200
MIME-Version: 1.0
In-Reply-To: <23a3da7d-d330-7cad-5bef-8e80c8d9f50c@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Philipp Kern <phil@philkern.de>

On 04/24/2017 10:25 AM, Alexander Graf wrote:
> 
> 
> On 24.04.17 00:32, Aurelien Jarno wrote:
>> From: Philipp Kern <phil@philkern.de>
>>
>> According to "CPU Signaling and Response", "Signal-Processor Orders",
>> the order field is bit position 56-63. Without this, the Linux
>> guest kernel is sometimes unable to stop emulation and enters
>> an infinite loop of "XXX unknown sigp: 0xffffffff00000005".
>>
>> Signed-off-by: Philipp Kern <phil@philkern.de>
>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>> ---
>>  target/s390x/misc_helper.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> This patch has been sent by Philipp Kern a lot of time ago, and it seems
>> has been lost. I am resending it, as it is still useful.
>>
>> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
>> index 3bf09ea222..4946b56ab3 100644
>> --- a/target/s390x/misc_helper.c
>> +++ b/target/s390x/misc_helper.c
>> @@ -534,7 +534,7 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t 
>> order_code, uint32_t r1,
>>      /* Remember: Use "R1 or R1 + 1, whichever is the odd-numbered register"
>>         as parameter (input). Status (output) is always R1. */
>>
>> -    switch (order_code) {
>> +    switch (order_code & 0xff) {
> 
> This definitely needs a comment above the mask. Ideally I'd love to just change 
> the function prototype to pass order_code as uint8_t, but I don't think that's 
> possible with the TCG glue.

Correct.  We'll need to leave the mask here.


r~
