Received: from eggs.gnu.org ([2001:4830:134:3::10]:48686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbY2c-0005qT-8b
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbY2b-0000je-B8
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:36:34 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbY2b-0000j9-2x
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 14:36:33 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r141so199202738wmg.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 11:36:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486582091.3641.32.camel@redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<CAFEAcA8+wfPQXXhoYZDv8LAOS6=4_P9kyaHONuMQcb7VmkVyxw@mail.gmail.com>
	<1486582091.3641.32.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Feb 2017 19:36:11 +0000
Message-ID: <CAFEAcA_txm4n6U1k3ZsTqb=91j5bm9H1i4FtzR92ybnFy-WJ_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Andrew Jones <drjones@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 8 February 2017 at 19:28, Andrea Bolognani <abologna@redhat.com> wrote:
> On Wed, 2017-02-08 at 18:32 +0000, Peter Maydell wrote:
>> What does nodefaults disable on the virt board?
>> (I've never looked into exactly what nodefaults does...)
>
> When -nodefaults is missing, a default virtio-net-pci
> plugged into 00:01.0 is automatically added.

Ah, right, default -net commands. Is that it?

> On the other hand, I just realized that I can add
>
>   [machine]
>     graphics = "off"
>
> to get rid of -nographic on the command line! \o/

-nographic is kind of odd if you're taking the
"use -nodefaults and specify everything manually"
because it wraps up a whole pile of default config
in one oddball legacy config switch. I would have
expected -display none and whatever other options
you wanted.

> [...]
>> > +[device "console"]
>> > +  driver = "virtconsole"
>> > +  chardev = "hostconsole"
>>
>> Won't most guests expect serial to be the default
>> PL011 UART ?
>
> Possibly. I'm using virtconsole here (and in q35*serial.cfg)
> mostly to have as much VirtIO as possible, but I also
> document the fact that you might want or need to use the
> native serial console instead.
>
> Moreover, something that I haven't been able to do on
> mach-virt (even though I could on q35, but again, I want the
> files to be as close as possible) is to configure the serial
> console from the configuration file.

If there's stuff we can fix in the virt board to make
this work the way it does on the PC model I'm happy
to make fixes to help.

> Seeing as we have an alternative, I'd rather keep it this
> way and minimize the number of command line arguments the
> user needs to specify.

The trouble with using virtconsole is that you have to
get quite a long way forward (probing and setting up
PCI, etc) before you can get any kind of console output.
"System doesn't boot and doesn't produce any output"
is a common and really annoying failure mode in the
ARM world, and I think that using virtconsole is
asking for that kind of thing to happen more rather
than less often. (Plus having two different serial
ports in the guest means that now the user has to
configure where both of them are supposed to output.)

thanks
-- PMM
