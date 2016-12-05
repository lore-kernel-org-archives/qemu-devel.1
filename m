Received: from eggs.gnu.org ([2001:4830:134:3::10]:42731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDvPt-0001vW-PN
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:42:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDvPs-0002Xu-SW
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:42:57 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20161202173454.19179-1-alex.bennee@linaro.org>
	<8737i21vl8.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b6c3b949-ef2a-31f4-ce86-712ce7b64a3f@twiddle.net>
Date: Mon, 5 Dec 2016 07:42:50 -0800
MIME-Version: 1.0
In-Reply-To: <8737i21vl8.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.8] target-arm/translate-a64: fix
 gen_load_exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, stefanha@redhat.com, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 12/05/2016 03:09 AM, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> While testing rth's latest TCG patches with risu I found ldaxp was
>> broken. Investigating further I found it was broken by 1dd089d0 when
>> the cmpxchg atomic work was merged.
> 
> CC'ing Paolo/Richard
> 
> Do you guys have any final TCG fixes planned for 2.8 that can take this
> fix for the ldaxp regression?

I don't have any pending patchs for 2.8, no.

>> As part of that change the code
>> attempted to be clever by doing a single 64 bit load and then shuffle
>> the data around to set the two 32 bit registers.

It's not trying to be "clever", it's trying to be correct, giving an atomic
64-bit load.

The fact that we didn't attempt an atomic 128-bit load here for the 64-bit pair
is a bug.  We have support for that in helper_atomic_ldo_le_mmu; I'm not sure
why I didn't use that here.

>> As I couldn't quite follow the endian magic I've simply partially
>> reverted the change to the original code gen_load_exclusive code. This
>> doesn't affect the cmpxchg functionality as that is all done on in
>> gen_store_exclusive part which is untouched.

We'll have to fix it properly eventually.  But perhaps 2.9 is soon enough,
since that's when mttcg will go in.


r~
