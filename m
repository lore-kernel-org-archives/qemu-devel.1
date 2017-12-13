Received: from eggs.gnu.org ([2001:4830:134:3::10]:48560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePCYS-0005lh-DZ
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ePCYO-0004ie-2q
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:18:56 -0500
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:45734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ePCYN-0004iF-Tc
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:18:51 -0500
Received: by mail-it0-x230.google.com with SMTP id z6so5476947iti.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 11:18:51 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <alpine.BSF.2.21.1712131914560.26243@zero.eik.bme.hu>
Date: Wed, 13 Dec 2017 14:18:49 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <99BD2069-929C-402A-B38A-778DAB427449@gmail.com>
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
	<20171212143421.GD26971@redhat.com>
	<11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
	<20171213091458.GA28379@redhat.com>
	<7D487247-C5DA-4902-A21E-B16861F763C8@gmail.com>
	<alpine.BSF.2.21.1712131914560.26243@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] Adding more function keys support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


> On Dec 13, 2017, at 1:22 PM, BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>=20
> On Wed, 13 Dec 2017, Programmingkid wrote:
>>> On Dec 13, 2017, at 4:14 AM, Daniel P. Berrange =
<berrange@redhat.com> wrote:
>>>=20
>>> On Tue, Dec 12, 2017 at 12:49:34PM -0500, Programmingkid wrote:
>>>>=20
>>>>> On Dec 12, 2017, at 9:34 AM, Daniel P. Berrange =
<berrange@redhat.com> wrote:
>>>>>=20
>>>>> On Sun, Dec 10, 2017 at 02:10:41AM -0500, Programmingkid wrote:
>>>>>> On Macintosh keyboards there is a key called fn that is used to =
give the
>>>>>> function keys more functionality. Does this key exist in the =
keyboard keys
>>>>>> database?
>>>>>=20
>>>>> When you say "Macintosh keyboards" are you talking about the old =
style
>>>>> keyboards with Apple's custom ADB connector, or simply Apple =
branded
>>>>> USB keyboards ?
>>>>=20
>>>> USB keyboards.
>>>>=20
>>>>>=20
>>>>> If its the latter (USB), then please plug it into a Linux machine, =
and
>>>>> in a text console (ie not X11) run 'showkey' and press this 'fn' =
key on
>>>>> its own and tell me what (if any) hex code gets printed.
>>>>=20
>>>> There was no response to the fn key.
>>>=20
>>> Doh, I made a mistake - you need to run   'showkey -s'  to get raw =
scancodes.
>>> Can you try this again, pressing 'fn' on its own, and also press =
'fn' in
>>> combination with some function keys.
>>=20
>> Sorry but showkey still did not register the fn key being pushed.
>=20
> I don't know how the fn key is handled but the Linux driver knows =
about it so maybe it could help to understand:
>=20
> https://github.com/torvalds/linux/blob/master/drivers/hid/hid-apple.c
>=20
> Regards,
> BALATON Zoltan

Thank you BALATON for the file. One thing that caught my eye in this =
file is this:

static int hidinput_apple_event(struct hid_device *hid, struct input_dev =
*input,
		struct hid_usage *usage, __s32 value)
{
	struct apple_sc *asc =3D hid_get_drvdata(hid);
	const struct apple_key_translation *trans, *table;

	if (usage->code =3D=3D KEY_FN) {
		asc->fn_on =3D !!value;

Why would they need the double !?=20

I think the input_event() function is what sends key input to the =
applications. It appears that the function key is not sent to =
input_event().

This key is usable with QEMU on Mac OS X. The NSEventTypeFlagsChanged =
event is what detects it in the cocoa.m file. Currently the code does =
not account for this key. I will make a patch to add support for the =
function key soon.=
