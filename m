Received: from eggs.gnu.org ([2001:4830:134:3::10]:36187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ez72M-0003HC-DH
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 16:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ez72J-0007NM-Ag
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 16:42:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180315133441.24149-1-peter.maydell@linaro.org>
	<20180322142343.jvc6pxxvl5zhfjgy@hawk.localdomain>
	<CAFEAcA8Vti8NnrQK4U4kLuk=nNMC5=KiKjc6wT7cLDnCHFj-8w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48f559bd-9f54-bcdd-1f3c-f6fafccfc54e@amsat.org>
Date: Thu, 22 Mar 2018 17:42:02 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Vti8NnrQK4U4kLuk=nNMC5=KiKjc6wT7cLDnCHFj-8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12] hw/intc/arm_gicv3: Fix
 secure-GIC NS ICC_PMR and ICC_RPR accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

Hi Peter,

On 03/22/2018 03:29 PM, Peter Maydell wrote:
> On 22 March 2018 at 14:23, Andrew Jones <drjones@redhat.com> wrote:
>> On Thu, Mar 15, 2018 at 01:34:41PM +0000, Peter Maydell wrote:
>>> If the GIC has the security extension support enabled, then a
>>> non-secure access to ICC_PMR must take account of the non-secure
>>> view of interrupt priorities, where real priorities 0..0x7f
>>> are secure-only and not visible to the non-secure guest, and
>>> priorities 0x80..0xff are shown to the guest as if they were
>>> 0x00..0xff. We had the logic here wrong:
>>
>> 0x00..0x7f
> 
> I think 0x00..0xff is correct.

I guess Andrew only suggested to correct the hex prefix in your comment:
- ... where real priorities 0..0x7f
+ ... where real priorities 0x00..0x7f

> The conversion from actual
> priority value to the NS-view is
>    if (prio & 0x80 == 0) {
>        nsview = 0;
>    } else {
>        nsview = (prio << 1) & 0xff;
>    }
> 
> so:
>    real priority     NS view
>     0x80              0x00
>     0x90              0x20
>     0xa0              0x40
>     0xb0              0x60
>     0xc0              0x80
>     0xd0              0xa0
>     0xe0              0xc0
>     0xf0              0xe0
> 
> the NS view covers the whole 0x00..0xff range, but more sparsely.
> (OK, technically you can't ever read 0xff, only 0xfe.)
