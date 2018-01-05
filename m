Received: from eggs.gnu.org ([2001:4830:134:3::10]:45971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eXNIf-0006w5-Pl
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eXNIc-0002LW-Jf
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:24:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eXNIc-0002Kt-Dy
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:24:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<20180104152402.fv52umjmlb2g22wc@var.youpi.perso.aquilenet.fr>
	<b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
	<20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
	<bb6eae87-85b2-4bf2-ad36-26fa95816315@redhat.com>
	<9b392599-a318-90c5-daa8-89ade40c64e5@redhat.com>
	<CAFEAcA9nfws8295Ay2n3CjS-h1=LOsLizRejbnfQaeX9sqvRHg@mail.gmail.com>
Date: Fri, 05 Jan 2018 09:24:17 +0100
In-Reply-To: <CAFEAcA9nfws8295Ay2n3CjS-h1=LOsLizRejbnfQaeX9sqvRHg@mail.gmail.com>
	(Peter Maydell's message of "Thu, 4 Jan 2018 15:52:11 +0000")
Message-ID: <87po6ok91q.fsf@dusky.pond.sub.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 4 January 2018 at 15:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The point of deprecation is not to make the interface simpler, it is to
>> avoid cases where one option is doing too much and/or crossing
>> abstraction boundaries, for example -net creating both a device and a
>> hub port.
>>
>> "-serial" is okay because it only creates the front-end, it's the board
>> that decides how to attach it to the back-end.
>>
>> -usbdevice creating both a front-end and a back-end is not a problem per
>> se.  The issue with -usbdevice is just that it's too much code.
>>
>> However, adding magic to "-device usb-braille" that creates both a
>> front-end and a back-end is completely the opposite of sane...
>
> Agreed with this.
>
> Is there any mileage in considering the idea of a generic bit
> in the option-parsing code that has a table of mappings from
> legacy-style-simple-option to complex-set-of-device-etc options,
> so we can retain userfriendliness without per-kind-of-thing
> special casing, or is that too simplistic to work ?

The idea is great, and I wish all syntactic sugar would get expanded
that way.  However, a static table won't work when the expansion depends
on other settings, such as the machine type.  Extra fun when an
expansion exists only for some machine types, say the ones where the
devices to be created are qdevified.
