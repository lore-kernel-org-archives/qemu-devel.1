Received: from eggs.gnu.org ([2001:4830:134:3::10]:59292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1enniB-0000kQ-6w
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1enni6-0005Bp-9c
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:50:39 -0500
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:45393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1enni6-0005BP-33
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 10:50:34 -0500
Received: by mail-io0-x22c.google.com with SMTP id p188so11701294ioe.12
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 07:50:33 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20180219085444.ndyga5fgwkc6kfqm@sirius.home.kraxel.org>
Date: Mon, 19 Feb 2018 10:50:30 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <C9EC16AC-7B51-4413-9B67-7CD165FA5DF6@gmail.com>
References: <20180216203856.8645-1-programmingkidx@gmail.com>
	<20180219085444.ndyga5fgwkc6kfqm@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v7] ui/cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org


> On Feb 19, 2018, at 3:54 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>> +/* Sends any keys that were delayed because they were part of the =
ungrab set */
>> +static void send_key_if_delayed(Set *the_set, int keycode)
>> +{
>> +    if (contains_number(the_set, keycode)) {
>> +        qemu_input_event_send_key_qcode(dcl->con, keycode, true);
>> +        qemu_input_event_send_key_qcode(dcl->con, keycode, false);
>> +    }
>> +}
>=20
>>         case NSEventTypeKeyUp:
>>             keycode =3D cocoa_keycode_to_qemu([event keyCode]);
>>=20
>> +            if (are_sets_equal(ungrab_set, key_set)) {
>> +                [self ungrabMouse];
>> +                clear_set(key_set);
>> +                return;
>> +            }
>> +            send_key_if_delayed(key_set, keycode);
>> +            remove_number(key_set, keycode);
>=20
> This doesn't maintain the event ordering.

I need more clearifiction.

If the ungrab keys are 1-2-3, and the user does this:
down: 2
down: 3
down: 4

The only input that is sent to the guest is the 4. The 2 and 3 are =
forgotten about. You want the 2 and the 3 sent to the guest in the order =
they were pushed?

Is there another condition that needs work.
