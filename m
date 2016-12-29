Received: from eggs.gnu.org ([2001:4830:134:3::10]:43379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cMf2w-0002ra-3H
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 13:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cMf2s-0002DU-RR
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 13:03:22 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:35211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cMf2s-0002DK-Lh
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 13:03:18 -0500
Received: by mail-io0-x243.google.com with SMTP id f73so46343528ioe.2
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 10:03:18 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <c299a5a4-c27e-b6f8-1d6c-c91f96c97a57@redhat.com>
Date: Thu, 29 Dec 2016 13:03:15 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B66A5C6-AF5D-4D7D-AFB0-E4FF682433E8@gmail.com>
References: <E14D0C7B-2C4B-4D29-AC31-A651AB7573DE@gmail.com>
	<c299a5a4-c27e-b6f8-1d6c-c91f96c97a57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: add Speed menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Dec 29, 2016, at 12:35 PM, Eric Blake wrote:

> On 12/29/2016 11:24 AM, Programmingkid wrote:
>> Programs running inside of QEMU can sometimes use more CPU time than =
is really
>> needed. To solve this problem, we just need to throttle the virtual =
CPU. This
>> feature will stop laptops from burning up.=20
>>=20
>> This patch adds a menu called Speed that has menu items from 10 to 1. =
They
>> represent the speed options. 10 is full speed and 1 is slowest.
>=20
> Why not make it a type-in box where the user specifies a percentage, =
up
> to 100 (unthrottled)?

It wouldn't feel right. The user would have to use both the keyboard and =
the
mouse to use that feature. It would be tedious. But then again, I could =
add
a scrollbar to the window, so that is a possibility.

> Is this feature present in the other GUIs, such as the gtk view?  I'm
> reluctant to invent features for the less-tested cocoa interface that
> are not FIRST present on other interfaces.

I would talk to the maintainer of GTK about adding this feature to it,
but getting a hold of him is hard. Maybe my emails aren't reaching him.
Or he just doesn't have the time to talk. Would you know of anyone else
except Gerd Hoffmann who could help with that?

>=20
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>> ui/cocoa.m | 56 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 56 insertions(+)
>=20
>>=20
>> +/* Used by the Speed menu items */
>> +- (void)adjustSpeed:(id)sender
>> +{
>> +    /* 10 has two digits in it - plus the NULL termination at the =
end */
>> +    const int max_title_size =3D 3;
>> +    char menu_item_title[max_title_size];
>> +    int speed, menu_number, count, item;
>> +    NSMenu *menu;
>> +    NSArray *itemArray;
>> +
>> +    // uncheck all the menu items in the Speed menu
>> +    menu =3D [sender menu];
>> +	if(menu !=3D nil)
>> +	{
>> +		count =3D [[menu itemArray] count];
>=20
> TAB damage.

I am surprise the checkpatch program didn't see this.

>=20
>> +		itemArray =3D [menu itemArray];
>> +		for(item =3D 0; item < count; item++)  // unselect each =
item
>=20
> Space after 'for'.

Checkpatch.pl should have seen this. Something must be wrong with it.

>=20
>> +			[[itemArray objectAtIndex: item] setState: =
NSOffState];
>> +	}
>> +
>> +    // check the menu item
>> +    [sender setState: NSOnState];
>> +
>> +    // get the menu number
>> +    snprintf(menu_item_title, max_title_size, "%s", [[sender title] =
cStringUsingEncoding: NSASCIIStringEncoding]);
>> +    sscanf(menu_item_title, "%d", &menu_number);
>=20
> Eew. That just feels fragile.

I agree. I will use another method that doesn't depend on menu item =
title.
That way, if this program is translated into another language, it will =
still work.

>=20
>> +
>> +     /* Calculate the speed */
>> +    // inverse relationship between menu item number and speed
>> +    speed =3D -1 * menu_number + 10;
>> +    speed =3D speed * 10;
>> +    cpu_throttle_set(speed);
>> +    COCOA_DEBUG("cpu throttling at %d%c\n", =
cpu_throttle_get_percentage(), '%');
>=20
> Again, I think that '100%' makes more intuitive sense than '10' for
> knowing that my VM is running unthrottled.  The amount of math you =
have
> to do to transform the menu numbers into the cpu_throttle_set() call =
is
> a sign that your mapping is rather complex compared to a more =
intuitive
> setup.

If the cocoa.m maintainer preferred I stay with the menu items, would =
this be
more to your liking:

Speed
-------
100%
90%
80%
70%
60%
50%
40%
30%
20%
10%
1%

>=20
>> +}
>> +
>> @end
>>=20
>>=20
>> @@ -1316,6 +1353,25 @@ int main (int argc, const char * argv[]) {
>>     [menuItem setSubmenu:menu];
>>     [[NSApp mainMenu] addItem:menuItem];
>>=20
>> +    // Speed menu
>> +    menu =3D [[NSMenu alloc] initWithTitle:@"Speed"];
>> +    menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"10 (fastest)" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease];
>> +    [menuItem setState: NSOnState];
>> +    [menu addItem: menuItem];
>> +    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"9" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
>> +    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"8" =
action:@selector(adjustSpeed:) keyEquivalent:@""] autorelease]];
>=20
> And this adds a LOT of menu items, compared to what you could get if a
> single menu item opens up a dialog box for typing in a number that is
> validated to be between 1 and 100.

Trying to code a dialog box with an editable text field and a scrollbar =
in cocoa would take a ton more lines of code. Just look at the code for =
the make_about_window method in cocoa.m. It only displays a picture and =
some text and it is around 80 lines long.

If someone else comes and says they would prefer a dialog box in place =
of the menu items,=20
then I will make that patch.

Thank you for reviewing my patch.=
