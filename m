Received: from eggs.gnu.org ([2001:4830:134:3::10]:55801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDwrV-0006Jn-6V
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDwrU-0001lY-DO
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 12:15:33 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20161202173454.19179-1-alex.bennee@linaro.org>
	<8737i21vl8.fsf@linaro.org>
	<b6c3b949-ef2a-31f4-ce86-712ce7b64a3f@twiddle.net>
	<87twaiz4r6.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <90d8b147-209b-adb2-de81-f3c02c381d26@twiddle.net>
Date: Mon, 5 Dec 2016 09:15:25 -0800
MIME-Version: 1.0
In-Reply-To: <87twaiz4r6.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: stefanha@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, cota@braap.org, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 12/05/2016 09:04 AM, Alex Bennée wrote:
>> It's not trying to be "clever", it's trying to be correct, giving an atomic
>> 64-bit load.
> 
> Ahh right I see. What happens if the backend is 32bit, will it issue two
> loads anyway?

Yes.  I did bring this up when the atomics patch set went in.

In principal there's no reason we can't handle this like the 128-bit path, with
a special helper for a 32-bit host using __atomic_load_64 if available, which
it would be for i686 (via fpu) and armv7 (via ldrexd), or
gen_helper_exit_atomic if not.

But it's nasty and slow, and work that's unnecessary if we simply decide that
32-bit hosts cannot run mttcg.

> I don't know how often these load-exclusive paired operations are used
> in real code but I think we should at least fix it so the values are
> loaded properly for 2.8 and do the proper atomic fix for 2.9.

Yep.


r~
