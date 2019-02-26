Received: from eggs.gnu.org ([209.51.188.92]:51557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gyirV-00067O-Ae
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gyirR-0005Mu-9V
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:57:55 -0500
Received: from chuckie.co.uk ([82.165.15.123]:45639
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gyirN-0005Ep-LC
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:57:51 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20190215143115.28777-1-alex.bennee@linaro.org>
	<87d0nn6eoi.fsf@zen.linaroharston> <20190219182528.GA19925@flamenco>
	<01acc60d-5f00-20ed-4631-6da98ae4da7e@ilande.co.uk>
	<874l8qnbqt.fsf@zen.linaroharston>
	<04dc02ce-c217-d4e0-b0dd-e6dc233bc1b2@ilande.co.uk>
Message-ID: <71f7ba4d-602e-6feb-fdb8-f834aa6e3822@ilande.co.uk>
Date: Tue, 26 Feb 2019 19:57:34 +0000
MIME-Version: 1.0
In-Reply-To: <04dc02ce-c217-d4e0-b0dd-e6dc233bc1b2@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] softmmu demacro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 26/02/2019 19:03, Mark Cave-Ayland wrote:

> On 26/02/2019 09:24, Alex Bennée wrote:
> 
>>> Presumably the issue here is somehow related to the compiler incorrectly
>>> extending/reducing the shift when the larger type is involved? Also during my tests
>>> the visual corruption was only present for 32-bit accesses, but presumably all the
>>> access sizes will need a similar fix.
>>
>> So I did fix this in the third patch when I out of lined the unaligned
>> helpers so:
>>
>>      const tcg_target_ulong size_mask = MAKE_64BIT_MASK(0, size * 8);
>>
>> and
>>
>>      /* Big-endian combine.  */
>>      r2 &= size_mask;
>>
>> or
>>
>>      /* Little-endian combine.  */
>>      r1 &= size_mask;
>>
>> I guess I should also apply that to patch 1 for bisectability.
> 
> I've done that locally, and while things have improved with progress bars I'm still
> seeing some strange blank fills appearing on the display in MacOS. I'll have another
> dig further and see what's going on...

Okay I've found it: looks like you also need to apply size_mask to the final result
to keep within the number of bits represented by size:


diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7729254424..73710f9b9c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1274,11 +1274,11 @@ static tcg_target_ulong load_helper(CPUArchState *env,
target_ulong addr,
         if (big_endian) {
             /* Big-endian combine.  */
             r2 &= size_mask;
-            res = (r1 << shift) | (r2 >> ((size * 8) - shift));
+            res = ((r1 << shift) | (r2 >> ((size * 8) - shift))) & size_mask;
         } else {
             /* Little-endian combine.  */
             r1 &= size_mask;
-            res = (r1 >> shift) | (r2 << ((size * 8) - shift));
+            res = ((r1 >> shift) | (r2 << ((size * 8) - shift))) & size_mask;
         }
         return res;
     }


I've now incorporated this into your original patchset, rebased and pushed the result
to https://github.com/mcayland/qemu/tree/alex-softmmu for you to grab and test.
Hopefully this version will now pass Emilio's tests too: I don't have a benchmark
setup in place, so it's worth testing to make sure that my fixes haven't introduced
any performance regressions.

Something else I noticed is that patch 3 removes the extra victim TLB fill from the
unaligned access path in store_helper() but doesn't mention it in the commit message
- is this deliberate?


ATB,

Mark.
