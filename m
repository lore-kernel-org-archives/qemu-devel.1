Received: from eggs.gnu.org ([2001:4830:134:3::10]:51427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fT8Wd-0000E1-E6
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fT8Wc-000408-14
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:21:35 -0400
MIME-Version: 1.0
In-Reply-To: <431f487d-71f0-a766-eea4-7f3369984a7f@redhat.com>
References: <20180612104430.25745-1-kraxel@redhat.com>
	<20180612104430.25745-5-kraxel@redhat.com>
	<431f487d-71f0-a766-eea4-7f3369984a7f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Jun 2018 18:21:30 +0200
Message-ID: <CAJ+F1CK3R7ap=mEd5pDQzKcU2g9z1v3LzutHx4ibxj=Rk9uUCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 4/8] bus: do not unref the added child bus
 on realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>, "open list:ARM" <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>

Hi

On Wed, Jun 13, 2018 at 6:05 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 12/06/2018 12:44, Gerd Hoffmann wrote:
>>
>> When the parent bus removes the child property, it takes care of
>> removing the added reference, in object_finalize_child_property().
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Message-id: 20180531195119.22021-2-marcandre.lureau@redhat.com
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  hw/core/bus.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/core/bus.c b/hw/core/bus.c
>> index 4651f24486..ad0c9df335 100644
>> --- a/hw/core/bus.c
>> +++ b/hw/core/bus.c
>> @@ -102,7 +102,6 @@ static void qbus_realize(BusState *bus, DeviceState =
*parent, const char *name)
>>          QLIST_INSERT_HEAD(&bus->parent->child_bus, bus, sibling);
>>          bus->parent->num_child_bus++;
>>          object_property_add_child(OBJECT(bus->parent), bus->name, OBJEC=
T(bus), NULL);
>> -        object_unref(OBJECT(bus));
>
> This is wrong.  object_finalize_child_property()'s unref balances the
> ref in object_property_add_child().  qbus_realize's unref balances the
> ref that was initially placed by object_new/object_initialize.
>
> So you're introducing a leak.

Oops, too bad you didn't review earlier. Hmm.. I vote for reverting
the 4 patches.



--=20
Marc-Andr=C3=A9 Lureau
