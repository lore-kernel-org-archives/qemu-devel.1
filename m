Received: from eggs.gnu.org ([2001:4830:134:3::10]:49271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1dL84T-0004RR-Cx
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1dL84O-0004UA-Dd
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:10:53 -0400
Received: from greensocs.com ([193.104.36.180]:43921)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1dL84O-0004TD-0K
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:10:48 -0400
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
	<CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
	<d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
From: KONRAD Frederic <fred.konrad@greensocs.com>
Message-ID: <79847843-5891-307a-2d9d-d896a05011da@greensocs.com>
Date: Wed, 14 Jun 2017 15:10:40 +0200
MIME-Version: 1.0
In-Reply-To: <d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/10] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>



Le 14/06/2017 =C3=A0 13:54, Paolo Bonzini a =C3=A9crit :
> On 13/06/2017 12:33, Peter Maydell wrote:
>>> For the migration maybe we can refresh the whole clock tree at the en=
d
>>> of the migration. Is that a good idea?
>> That seems kind of awkward -- where would this code that did a
>> clock tree refresh be? Also you're then reliant on all the
>> callback functions registered to not actually do anything that
>> affects device state when the refresh happens. It would be
>> cleaner if the qemu-clk objects managed their own internal
>> state migration (but can we do this without having to make
>> them be Device objects rather than just objects ?).
>>
>> Cc'd Paolo who might have an opinion on these -- my opinion currently
>> is mostly "this doesn't really look right" rather than knowing what
>> the right approach is.
>
> Same here. :)
>
> I think the various bindings and rates could be refreshed as devices ar=
e
> migrated.
 > "This assumes that the device migration order is okay"

I think it's the real problem here?

> according to the clock tree, that is if you have three devices X/Y/Z an=
d
> five clocks a/b/c/d/e/f:
>
>   fixed-clock
>     |     |
>    X:a   X:b
>     |     |    \
>    Y:c   Y:d      Z:e
>           |
>          Z:f
>
> you could do this:
>
> - migrate X
>   - retrieve the PLL ratios for a and b's bound clocks (if the ratio
>     is variable, otherwise no need for this)
>   - in the post_load callback, bind a and b to the fixed-clock
>     (if the binding is variable, otherwise no need for this)
> - migrate Y
>   - retrieve the PLL ratio for d's bound clocks (if the ratio
>     is variable, otherwise no need for this)
>   - in the post_load callback, bind c and d to a and b respectively
>     (if the binding is variable, otherwise no need for this)
> - migrate Z
>   - in the post_load callback, bind e and f to b and d respectively
>     (if the binding is variable, otherwise no need for this)
>

So for you the migration of the clock tree will be done by the device?
I think this is OK :).

Fred

> Paolo
>
