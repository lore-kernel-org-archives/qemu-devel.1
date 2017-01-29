Received: from eggs.gnu.org ([2001:4830:134:3::10]:44743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cXpOh-0001H4-VT
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 08:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cXpOg-0006ve-Ut
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 08:19:59 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cXpOg-0006vM-QA
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 08:19:58 -0500
Received: by mail-ot0-x241.google.com with SMTP id 73so35687630otj.1
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 05:19:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170129140329.3646dee3@bahia.lan>
References: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
	<20170128194157.0c82cc8a@bahia.lan>
	<CAC2QTZZaaMgiiJbXgnLzBF+02=XnzKsofP7fwK7oF56maXY8Gg@mail.gmail.com>
	<20170129140329.3646dee3@bahia.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sun, 29 Jan 2017 18:49:57 +0530
Message-ID: <CAC2QTZZA53iu0q09D+WA9Sn4q9K2pFXmT0CiU9a4=TPiMM9EzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] migrate: Migration aborts abruptly for
 machine "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Sun, Jan 29, 2017 at 6:33 PM, Greg Kurz <groug@kaod.org> wrote:
> On Sun, 29 Jan 2017 01:06:47 +0530
> Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
>
>> On Sun, Jan 29, 2017 at 12:11 AM, Greg Kurz <groug@kaod.org> wrote:
>> > On Thu, 26 Jan 2017 14:46:52 +0530
>> > Ashijeet Acharya <ashijeetacharya@gmail.com> wrote:
>> >
>> >> Migration of a "none" machine with no RAM crashes abruptly as
>> >> bitmap_new() fails and thus aborts. Instead, place a check for
>> >> last_ram_offset() being '0' at the start of ram_save_setup() and
>> >> error out with a meaningful error message.
>> >>
>> >> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> >> ---
>> >
>>
>> cc'ing Paolo in : I had an IRC chat with him and he has a very
>> interesting twist in the tale to add here.
>>
>> > Maybe a naive question: why a "none" machine with zero RAM should fail to
>> > migrate ?
>>
>> Assuming you are referring to why its failing ATM; it fails because
>
> My question was more: why deciding to fail migration instead of fixing the
> crash ? One would naively think that no RAM is *just* less state to
> migrate... but maybe the current code assumes that a machine always has
> RAM.

Actually, I think, the current code does assume that the machine
always has RAM which is why it crashes here. I am not aware if we can
also boot machines other than 'none'  with zero RAM so I have not
tested that case.
Also, Paolo has a similar opinion to yours that we should fix it
instead of blocking it. He suggests to migrate only the device states
and skip all the RAM related stuff. Maybe he can explain it better
when he is available.

I have had mixed opinions on this one which is why I am waiting until
we reach a common ground.

Ashijeet
>
>> g_try_malloc0() inside bitmap_try_new() returns a NULL pointer for
>> zero bits and thus the check for NULL inside bitmap_new() becomes true
>> and it aborts. Check bitmap_new() for convenience.
>>
>> Ignore the noise if you already knew this! :-)
>>
>
> I hadn't checked, thanks for the details.
>
> Cheers.
>
> --
> Greg
>
>> Ashijeet
>
