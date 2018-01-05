Received: from eggs.gnu.org ([2001:4830:134:3::10]:57708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eXOw7-0003t7-QX
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eXOw4-0004f4-LU
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:09:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eXOw4-0004dB-Fl
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 05:09:12 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<87tvw0k9am.fsf@dusky.pond.sub.org>
	<f0cc3ad6-ecdc-20f8-ed62-423477417ec1@redhat.com>
Date: Fri, 05 Jan 2018 11:09:07 +0100
In-Reply-To: <f0cc3ad6-ecdc-20f8-ed62-423477417ec1@redhat.com> (Paolo
	Bonzini's message of "Fri, 5 Jan 2018 10:22:22 +0100")
Message-ID: <874lo0ipmk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>, kraxel@redhat.com

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 05/01/2018 09:18, Markus Armbruster wrote:
>>>> Would it be possible to make this automatic?  Before I could tell people
>>>> "use -usbdevice braille to test braille", and now it would be
>>>> "use -chardev braille,chardev=foobar -device usb-braille,chardev=foobar"
>>> Maybe we can add "-braille" instead.  Something like this:
>> More sugar, ugh!
>> 
>> What about giving braille property chardev a sensible default?
>> Ideally in a self-documenting way, so that -device usb-braille,help
>> shows the default.
>
> That would mean automatically creating a back-end in a device's realize
> property.  I'd rather avoid that,

That's one way to do it.  A perhaps less odious way would be to make
qdev core support chardev defaults just like it supports integer
defaults.  For integers, we specify the default value as parameter for
DEFINE_PROP_INT64() & friends.  For chardevs, we'd can't specify the
value, but we could specify the option string to use for creating it.

One reason I like sane defaults better than sugar: users can more easily
grow from

    -device usb-braille

to

    -device usb-braille,chardev=braille-be -chardev id=braille-be,...

than from

    -braille

>                                   sugar is not bad per se.

Stirring a teaspoon of sugar into your tea may be of debatable taste,
but I certainly wouldn't call it bad per se.  However, we're already
closer to upending the sugar bowl, then raiding the pantry for more.
