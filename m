Received: from eggs.gnu.org ([2001:4830:134:3::10]:51604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dPkY4-0007Jq-K7
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 03:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dPkY1-0007lG-FW
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 03:04:32 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:43952
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dPkY1-0007l0-5M
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 03:04:29 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
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
Message-ID: <530511c2-072c-8c1f-3944-cc724fc6e4a4@adacore.com>
Date: Tue, 27 Jun 2017 09:04:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86P19ur+MUDMEYheZziKoYmnayOcn-5LmPFRXvR=aZvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <fred.konrad@greensocs.com>



Le 06/23/2017 =C3=A0 03:58 PM, Peter Maydell a =C3=A9crit :
> On 23 June 2017 at 14:07, KONRAD Frederic <frederic.konrad@adacore.com>=
 wrote:
>> Le 06/23/2017 =C3=A0 02:47 PM, Peter Maydell a =C3=A9crit :
>>> Each device "owns" its output clock objects, but input
>>> clocks are just pointers to the clock object owned by the
>>> device at the other end. In the board you wire up CI1 to C1,
>>> and CI2 to C2 (using link properties I guess).
>>> Then in device C you can implement the clock switching by
>>> some kind of bind(s->CI1, &s->C3) call because you have
>>> pointers to all the relevant clock objects.
>>>
>>> As I understand it your current implementation makes not
>>> just the output clocks C1 C2 C2 be clock objects, but also
>>> the inputs CI1 CI2, so effectively each link from a clock
>>> source to a clock sink has two objects involved.
>=20
>> Yes that makes sense but you won't have the name.
>=20
> I don't think that's a big deal.
>=20
>> And one other thing I wanted to have is beeing able to refresh
>> the clock tree without refreshing everything. If you start a
>> refresh from the "pointer" and it is bind to other things you
>> will refresh the other devices as well. Maybe we don't care or we
>> can workaround that but..
>=20
> The pointer is for your clock inputs -- when would you
> want to start a refresh from that? I would expect
> refreshes to only ever go downstream -- you update
> the config of your clock outputs and things downstream
> of them will update in turn.

I started with the goal in mind that the binding + the callback
can refresh themself without user intervention.

So actually the user only have to change the binding in case of a
clock selector.. Everything else is done by the framework.

For example if we want to change a multiplier through a register:

void register_write(..)
{
   /* Refresh related clock input. */
}

void clock_cb(..)
{
   return register_value * rate_in;
}

If we drop the clock first possibility:

void register_write(..)
{
   /* refresh all depending clock with
    * rate_in * register value.
    * Either this can be tricky as we need to know exactly which
    * clock need to be refreshed or we need to refresh everybody.
    * On the device example in the patch-set this can become a
    * mess.
    */
}

void clock_cb(..)
{
   return register_value * rate_in;
}

Second possibility:

void register_write(..)
{
   /* refresh the clock which is referenced as input.
    * This is easy BUT it will refresh all other devices bound to
    * this clock.
    */
}

void clock_cb(..)
{
   return register_value * rate_in;
}

Thanks,
Fred

>=20
> thanks
> -- PMM
>=20
