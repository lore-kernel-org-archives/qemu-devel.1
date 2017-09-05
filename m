Received: from eggs.gnu.org ([2001:4830:134:3::10]:60604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpFHU-00069H-4z
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpFHK-0005Pm-LM
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:56:48 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:38252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpFHK-0005PS-Df
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:56:38 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 108so9287381wra.5
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 07:56:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170831035306.29170-1-f4bug@amsat.org>
References: <20170831035306.29170-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 15:56:16 +0100
Message-ID: <CAFEAcA9cK2UEJGY9=Y5z8+d14MTF7n84rVgwjTDu_1f6BD0hzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] serial: add serial_chr_nonnull()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

On 31 August 2017 at 04:52, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Hi,
>
> This series add the serial_chr_nonnull() which connect to the "null" char=
dev
> backend if none is provided.
>
> Inspired by Peter's suggestion:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05987.html
> which also refers to this issue:
> http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03546.html
>
> Some boards still check serial_hds[x] non null before calling serial_mm_i=
nit(),
> this check could now be removed on the SoC which always have an UART mapp=
ed.

I think this is definitely an area we need to sort out,
so thanks for sending this patchset. I have two major comments
on it:

(1) I don't think we should be using serial_chr_nonnull() in the
board and SoC code (your patches 3 and 4 here). I think the design
principle we should be aiming for is:
 * devices which accept a Chardev should cope with being passed
   a NULL pointer, and so their users never need to care

serial_mm_init() is basically a device (though it has never been
QOMified), so it is correct that it should change to handle NULL.

Patch 4 (malta) : we should just delete the entire for() loop,
ideally, but this runs into awkwardness because serial_hds_isa_init()
then won't create uart 0 and 1. Maybe leave it alone for the moment.

In patch 5, exynos4210_uart_create() is code that uses a device,
not code that implements it, so it should be able to simplify to
just doing chr =3D serial_hds[channel]; .
(there is scope for further cleanup here because there are only
4 callsites for this utility function, which really ought to
just always take a Chardev* and not support the 'or pass an
integer channel number' stuff. I'd leave that for a different
patchset though.)

Patches 6 and 7 look OK.


On to point (2): is creating a dummy null chardev the right
way to arrange for devices to handle a NULL chardev pointer?
Most of the qemu_chr_fe_*() functions have checks for
"if we are passed a CharBackend with a NULL Chardev pointer
do nothing", which suggests that the design intent here is
that char devices should be able to just work without having
to special case NULL. If that can generally be done without
char device authors having to think too hard then I feel
like we should continue with that approach. It's only
if it looks like that's too error-prone that the "create
a dummy null chardev" approach makes sense, I think (and in
that case maybe we can drop all those NULL pointer checks
in the fe functions?)

What is going wrong in the serial_mm_init() case that's
causing it to fail when the chardev pointer is NULL ?

thanks
-- PMM
