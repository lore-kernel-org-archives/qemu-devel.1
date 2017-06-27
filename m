Received: from eggs.gnu.org ([2001:4830:134:3::10]:58444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPmtL-0000nn-VT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPmtK-0000X8-RZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:34:39 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPmtK-0000X0-Kq
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 05:34:38 -0400
Received: by mail-wr0-x22e.google.com with SMTP id c11so156232109wrc.3
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 02:34:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <530511c2-072c-8c1f-3944-cc724fc6e4a4@adacore.com>
References: <1488276185-31168-1-git-send-email-fred.konrad@greensocs.com>
	<b690a50d-4ab3-830c-93a3-5f2b4b027448@greensocs.com>
	<CAFEAcA94RykH0U33F0aGEYRs_FXF_NNuwQAX_mOf4wVde0s9BQ@mail.gmail.com>
	<1db78209-e426-03b5-9a19-592da96adaee@greensocs.com>
	<CAFEAcA-pmVW-fnu6ZT=PeRcSf-U5UVsyYsJkzh2c_BFKDTU5kg@mail.gmail.com>
	<d0a7ebb7-9f3d-5b3c-692e-344f4a980c05@redhat.com>
	<CAFEAcA_BkOaRCs1tm2dv+mYZj4yaNTg7VhR2C-NAQGAhw1wazA@mail.gmail.com>
	<20170615145742.GF4859@toto>
	<CAFEAcA-zhur3vO8G_CPQuyEU3p7e81cixiZ58sFs96e+av4Mbg@mail.gmail.com>
	<20170615151530.GC12347@toto>
	<CAFEAcA-ZzVGJ+ueZXLuhtkMk=42QGhpJiu5PNZ7DAGXJf3hvXA@mail.gmail.com>
	<209d2c8f-fd46-0a6f-17ac-b4f53f47c43e@adacore.com>
	<CAFEAcA9VtPd72=HW3uMvdc5xzv+zLj_KS=WDBjau563iT9UHNA@mail.gmail.com>
	<3871c989-d00e-c2fb-4e62-18624114ada4@adacore.com>
	<CAFEAcA86P19ur+MUDMEYheZziKoYmnayOcn-5LmPFRXvR=aZvg@mail.gmail.com>
	<530511c2-072c-8c1f-3944-cc724fc6e4a4@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 10:34:16 +0100
Message-ID: <CAFEAcA9y5Enbi+tP2aaUP_OUy53DtpH9XeW7b0TLTKEZy8YvUw@mail.gmail.com>
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
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <fred.konrad@greensocs.com>

On 27 June 2017 at 08:04, KONRAD Frederic <frederic.konrad@adacore.com> wro=
te:
> Le 06/23/2017 =C3=A0 03:58 PM, Peter Maydell a =C3=A9crit :
>> The pointer is for your clock inputs -- when would you
>> want to start a refresh from that? I would expect
>> refreshes to only ever go downstream -- you update
>> the config of your clock outputs and things downstream
>> of them will update in turn.
>
>
> I started with the goal in mind that the binding + the callback
> can refresh themself without user intervention.
>
> So actually the user only have to change the binding in case of a
> clock selector.. Everything else is done by the framework.

I agree you only need to change the bindings for clock selectors,
that should be true whatever approach we take.

> For example if we want to change a multiplier through a register:
>
> void register_write(..)
> {
>   /* Refresh related clock input. */
> }
>
> void clock_cb(..)
> {
>   return register_value * rate_in;
> }
>
> If we drop the clock first possibility:
>
> void register_write(..)
> {
>   /* refresh all depending clock with
>    * rate_in * register value.
>    * Either this can be tricky as we need to know exactly which
>    * clock need to be refreshed or we need to refresh everybody.
>    * On the device example in the patch-set this can become a
>    * mess.
>    */
> }
>
> void clock_cb(..)
> {
>   return register_value * rate_in;
> }
>
> Second possibility:
>
> void register_write(..)
> {
>   /* refresh the clock which is referenced as input.
>    * This is easy BUT it will refresh all other devices bound to
>    * this clock.
>    */

If this device can change the multiplier for a clock
then it must be changing the multiplier for one of
its *output* clocks. The input clock is owned by
whatever device controls that clock. (In hardware,
a device can't change the frequency of a clock signal
that is an input to it.)

Eg you might have a fixed clock (output) representing
the system clock, and a PLL device which takes that
clock as an input, and has one or more output clocks
at various rates whose multipliers can be changed.
Changing the multiplier value in a register in the
PLL device should make it change and refresh the
relevant output clock. (If a device has a builtin
clock divider then you'd model that as it having an
input clock, plus an "output" clock which it doesn't
actually expose to the rest of the world but just
consumes internally. The builtin divider would
change the settings on the 'output' clock.)

thanks
-- PMM
