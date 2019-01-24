Received: from eggs.gnu.org ([209.51.188.92]:36868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gmfZ6-0004Rf-2H
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gmfYv-00046P-Fu
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:01:07 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:49201
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1gmfYv-00043Y-46
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:00:57 -0500
References: <1548334069-9158-1-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA8UeNa-EAZO70CJKoCBDoM+pSAa5USqBwZ1FexGNZGePw@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <de32bf2d-ff5e-bf1a-2d90-d9519342744b@adacore.com>
Date: Thu, 24 Jan 2019 15:00:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8UeNa-EAZO70CJKoCBDoM+pSAa5USqBwZ1FexGNZGePw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gdbstub: shutdown guest when the target is
 killed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@wdc.com>, Luc Michel <luc.michel@greensocs.com>



Le 1/24/19 =C3=A0 2:04 PM, Peter Maydell a =C3=A9crit=C2=A0:
> On Thu, 24 Jan 2019 at 12:47, KONRAD Frederic
> <frederic.konrad@adacore.com> wrote:
>>
>> Under MinGW when the target is killed no "W00" packet are received by =
GDB
>> because gdbstub takes the "exit(0)" path.
>=20
> Why is this a problem? The gdb protocol documentation for the 'k'
> packet says:
>=20
> # If the target system immediately closes the connection in response to=
 'k',
> # GDB does not consider the lack of packet acknowledgment to be an erro=
r,
> # and assumes the kill was successful.
>=20
> So it shouldn't matter whether we send the W00 packet or not.
> (In fact it's not clear to me that it's right to send the W00
> packet unconditionally -- W00 is a "stop reply packet" so it's
> only correct to send it on QEMU exit if the stub was currently
> executing one of the continue/run commands, not if the guest CPU
> was already stopped.)

Ah yes good point.. I didn't found this doc when I wrote this patch.. So =
maybe
there is something odd with my GDB...

>=20
> This also isn't specific to mingw as far as I can see -- we behave
> the same on all hosts for system emulation.

Yes I wondered the same.. I'm not sure how the CharBackend behave when ca=
lling
exit(..) under Windows though and I think I already had issue with some b=
uffer
not beeing flushed correctly.

>=20
>> So replace the "exit(0)" call by
>> a normal guest shutdown so the "W00" packet has a chance to be sent in
>> "gdb_cleanup".
>=20
> On the other hand I think that triggering a clean shutdown in
> system emulation mode is arguably a more reasonable choice than
> just bailing out immediately. I'm just not clear on what the
> problem is that you're trying to solve with the change...

True.. I can just make this commit has a cleanup commit if you like..

Thanks,
Fred

>=20
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   gdbstub.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index bfc7afb..c91a909 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -1389,7 +1389,12 @@ static int gdb_handle_packet(GDBState *s, const=
 char *line_buf)
>>       case 'k':
>>           /* Kill the target */
>>           error_report("QEMU: Terminated via GDBstub");
>=20
> I think we could usefully expand the comment.
>      /*
>       * Kill the target. The protocol does not specify the exact effect
>       * of this packet, but notes that usually for a single-process tar=
get
>       * it will kill the process, and for a bare-metal target it may
>       * power-cycle or reset the system, so we follow that suggestion.
>       * Note that this packet has no reply.
>       */
>=20
>> +#ifdef CONFIG_USER_ONLY
>>           exit(0);
>> +#else
>> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> +#endif
>> +        break;
>>       case 'D':
>>           /* Detach packet */
>>           pid =3D 1;
>=20
> thanks
> -- PMM
>=20
