Received: from eggs.gnu.org ([2001:4830:134:3::10]:51687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyAF5-0002hb-4K
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyAF1-00018w-Tj
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:27:43 -0400
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
	<5c204531-2e59-4166-0325-745e4aa98531@redhat.com>
	<CAFEAcA-Auwy1Mp=L89VYB4xoCG1BFdCWyUjhA4HHFiGmycBjzg@mail.gmail.com>
	<c2d69fb0-fc47-e145-3b24-c7eb6c9cea45@redhat.com>
	<507bad9d-61fc-c513-e023-674836eb72a1@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4fa06493-e79b-79f2-ba7c-920de9dc51b2@redhat.com>
Date: Fri, 7 Sep 2018 08:27:33 +0200
MIME-Version: 1.0
In-Reply-To: <507bad9d-61fc-c513-e023-674836eb72a1@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] scsi: remove lsi53c895a_create() and
 lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2018-09-06 19:15, Mark Cave-Ayland wrote:
> On 06/09/18 17:40, Thomas Huth wrote:
[...]
> Amusingly the main reason I need to expose the LSIState at all is to be
> able to call scsi_bus_legacy_handle_cmdline() on the SCSI bus object
> itself. I guess you could say that this is an argument in favour of the
> existing approach, but then you're effectively moving back to the
> equivalent of _init() functions for this one particular case which thes=
e
> days are considered to be bad.

If you mind that the "init" function creates the object, too, then
simply remove the two "lsi53c*_create" functions and provide a function
that looks like this instead:

void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev)
{
    LSIState *s =3D LSI53C895A(lsi_dev);

    scsi_bus_legacy_handle_cmdline(&s->bus);
}

Then you can create the device from another .c file and simply call this
new function instead of scsi_bus_legacy_handle_cmdline() in that other
.c file.

In the long run, I think we should maybe also rather get rid of
scsi_bus_legacy_handle_cmdline() and either remove -drive if=3Dscsi or
provide another more generic solution instead (e.g. some code that scans
the qdev tree for SCSI controllers and attaches the devices declared
with -drive if=3Dscsi automatically there).

> My feeling is that since the pattern of a separate header with struct
> and QOM macros (or "modern" style) is used throughout the rest of the
> codebase, why should we make an exception for this one particular case?

I don't mind too much, so if you post your series again, I won't object
again. But still, even if it's a little bit more work for you now, if we
reconsider in a couple of years that information hiding would be a good
idea, it very likely way more work to make the struct private again, so
I'd really prefer if you could keep it private now if possible.

 Thomas
