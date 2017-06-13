Received: from eggs.gnu.org ([2001:4830:134:3::10]:40839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKj95-0006WQ-JQ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKj94-0001HJ-Kl
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:33:59 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKj94-0001HE-F4
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:33:58 -0400
Received: by mail-wr0-x229.google.com with SMTP id q97so136469648wrb.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 03:33:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 11:33:36 +0100
Message-ID: <CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: KONRAD Frederic <fred.konrad@greensocs.com>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>

On 8 June 2017 at 08:54, KONRAD Frederic <fred.konrad@greensocs.com> wrote:
> Le 06/06/2017 =C3=A0 17:18, Peter Maydell a =C3=A9crit :
>> Some top-level review:

>> * qemu_clk_device_add_clock() does a g_strdup, but when is this freed?
>>   (consider devices which are hot-unpluggable)
>> * similarly, what if a device with a clock with a lot of child nodes
>>   is destroyed? how are the ClkList structs freed?
>> * interaction with migration -- how is the "this clock is at this rate"
>>   state intended to be migrated?

> Nice thanks for the feedback!
>
> Actually the hot unpluggable is a good question what can we do for that?
> Is that reasonable for a device which produce a clock to be hot
> unpluggable?

I don't know if it's very likely (but you might have a PCI device
for instance which uses clocks internally). But I think for a bit
of low-level infrastructure like clocktree it's worth getting the
details of the lifecycle right from the start.

> For the migration maybe we can refresh the whole clock tree at the end
> of the migration. Is that a good idea?

That seems kind of awkward -- where would this code that did a
clock tree refresh be? Also you're then reliant on all the
callback functions registered to not actually do anything that
affects device state when the refresh happens. It would be
cleaner if the qemu-clk objects managed their own internal
state migration (but can we do this without having to make
them be Device objects rather than just objects ?).

Cc'd Paolo who might have an opinion on these -- my opinion currently
is mostly "this doesn't really look right" rather than knowing what
the right approach is.

thanks
-- PMM
