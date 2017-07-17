Received: from eggs.gnu.org ([2001:4830:134:3::10]:42620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX9wj-0003PR-JK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX9wi-0002IP-JH
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:36:37 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX9wi-0002Hi-Bi
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:36:36 -0400
Received: by mail-wr0-x236.google.com with SMTP id 12so10566424wrb.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:36:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
	<a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 18:36:14 +0100
Message-ID: <CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 18:29, Eric Blake <eblake@redhat.com> wrote:
> On 07/17/2017 11:46 AM, Dr. David Alan Gilbert wrote:
>
>>> +++ w/hw/usb/bus.c
>>> @@ -407,8 +407,9 @@ void usb_register_companion(const char *masterbus,
>>> USBPort *ports[],
>>>  void usb_port_location(USBPort *downstream, USBPort *upstream, int portnr)
>>>  {
>>>      if (upstream) {
>>> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
>>> -                 upstream->path, portnr);
>>> +        int l = snprintf(downstream->path, sizeof(downstream->path),
>>> "%s.%d",
>>> +                         upstream->path, portnr);
>>> +        assert(l < sizeof(downstream->path));
>>
>> You may find this doesn't help in some windows builds;  the assert
>> functions aren't always marked as noreturn (because they pop up a dialog
>> that asks you whether you want to run into a debugger etc).
>
> How would it not help?  Are we using gcc 7 on windows builds?

At some point in the future we are likely to, because my
w32/w64 test setups use the Ubuntu gcc-mingw-w64-x86-64
packages, and so as I upgrade my desktop they will move
forward to newer gcc versions. (More generally our users
may do so before me ;-))

We should be consistent -- if we can't trust assert() to
be marked nonreturn, as it seems we can't, then we shouldn't
write new code that assumes it always is, even if today
it doesn't happen to bite us on the compiler/host combinations
we're testing right now.

thanks
-- PMM
