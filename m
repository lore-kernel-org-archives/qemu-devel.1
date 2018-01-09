Received: from eggs.gnu.org ([2001:4830:134:3::10]:44108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYsXx-0007TK-Jx
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:58:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYsXw-00026T-Fb
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:58:25 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYsXw-00025U-9X
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:58:24 -0500
Received: by mail-ot0-x241.google.com with SMTP id x15so11122347ote.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 03:58:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <77a5aebb06185f4de234d720d220fa57@walle.cc>
References: <038DD9E8-EB5A-4575-BAF9-ED62D31700E0@gmail.com>
	<d29a9fe675f1faa36f8cb0fdb1b90aea@walle.cc>
	<4FE60F15-93AE-49AA-A909-66D8B9D058B8@gmail.com>
	<78CE661B-5A4B-4F93-A1FA-819F5CC4C02B@gmail.com>
	<77a5aebb06185f4de234d720d220fa57@walle.cc>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 11:58:02 +0000
Message-ID: <CAFEAcA-pjg34=bPe7EiYN6oYC_3xuMCyiucPwZrka2Fxxrk3DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] New documentation for the LatticeMicro32 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 18 July 2017 at 12:44, Michael Walle <michael@walle.cc> wrote:
> Am 2017-07-17 17:18, schrieb Programmingkid:
>> I just tried qemu-system-lm32 and it crashed.
>>
>> Command-line: qemu-system-lm32 -M milkymist -kernel flickernoise
>>
>> Error message: audio: Failed to create voice `mm_ac97.in'
>> **
>> ERROR: /accel/tcg/tcg-all.c:42:tcg_handle_interrupt: assertion failed:
>> (qemu_mutex_iothread_locked())
>> Abort trap: 6
>>
>> Host: Mac OS 10.12.5
>
>
> As I said before, I guess the BQL is missing here. Try the following patch:
>
> diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
> index 2177c8ad12..93b8d09794 100644
> --- a/target/lm32/op_helper.c
> +++ b/target/lm32/op_helper.c
> @@ -102,12 +102,16 @@ void HELPER(wcsr_dc)(CPULM32State *env, uint32_t dc)
>
>  void HELPER(wcsr_im)(CPULM32State *env, uint32_t im)
>  {
> +    qemu_mutex_lock_iothread();
>      lm32_pic_set_im(env->pic_state, im);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(wcsr_ip)(CPULM32State *env, uint32_t im)
>  {
> +    qemu_mutex_lock_iothread();
>      lm32_pic_set_ip(env->pic_state, im);
> +    qemu_mutex_unlock_iothread();
>  }
>
>  void HELPER(wcsr_jtx)(CPULM32State *env, uint32_t jtx)

I just fell over this, it looks like this fix never made it into master.

Michael, could you submit this as a full patch with a commit message
and signed-off-by, please? cc: qemu-stable@nongnu.org as well, since
it fixes a "breaks the board completely" bug.

thanks
-- PMM
