Received: from eggs.gnu.org ([209.51.188.92]:45827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1grRjs-0003Wc-0J
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1grRjr-00018H-3r
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:15:59 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:48525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1grRjq-000172-N7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:15:59 -0500
Date: Wed, 6 Feb 2019 19:15:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190206173157.GB12331@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1902061849110.77733@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1902061736310.58711@zero.eik.bme.hu>
	<20190206173157.GB12331@redhat.com>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.9999.1902061857370.77733@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] 07333e1ca (kbd-state: use state tracker for sdl2)
 breaks keyboard input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Wed, 6 Feb 2019, Daniel P. Berrang=E9 wrote:
> On Wed, Feb 06, 2019 at 05:41:22PM +0100, BALATON Zoltan wrote:
>> Hello,
>>
>> The commit 07333e1ca breaks keyboard input in bios console with SDL2 U=
I. To
>> reproduce: start qemu-system-i386 without any options, press Ctrl-B wh=
en
>> prompted to get an IPXE command line and type. Key presses are doubled=
.
>
> This isn't related to the IPXE BIOS - it is broken in general in fact.

Yes I probably did not make it clear but the IPXE prompt was just an easy=
=20
way to reproduce and show it. In fact I've found this with other guest an=
d=20
I meant to report the general problem. Sorry if this caused confusion.

>> (Besides this the output window mixup when something is output to seri=
al
>> window I've reported earlier is still present. I'd appreciate if these=
 could
>> be fixed now that the working SDL1 alternative was completely removed.=
)
>
> AFAIR, we determined there was something related to the nvidia binary
> only drivers that was breaking this and needed to know if using nouveau
> drivers would fix it.

I'm not sure. All I know that both me and Howard who had the same issue=20
were seeing it with nvidia binary driver but not sure if it was reproduce=
d=20
with other drivers. I've first reported this almost a year ago in last=20
March and the last time we discused it again we've found it could also be=
=20
reproduced with pc and mac99 emulation:

http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05112.html

Can you try this sith SDL2 UI and confirm you don't see a problem:

1. start qemu-system-i386 -M graphics=3Doff -S
2. Press Ctrl-Alt-2 to open console window
3. Press Ctrl-Alt-3 to open serial window
4. type continue in console window to start guest and wait until output=20
appears in serial window
5. now close serial window and then try to open it with Ctrl-Alt-3 again,=
=20
for me an empty window is opening at this point
6. type in the console window, the content that should be in serial windo=
w=20
flashes in the console window on every keypress here

In case that's relevant I'm using Window Maker window manager and also se=
e=20
that app icon is not displayed correctly and stays around after QEMU is=20
closed. This is usually a sign of not correctly setting X window class=20
and/or window group leader hints. This wasn't a problem with SDL1 UI. The=
=20
sdl2 version that comes with my distro is 2.0.9 in case that matters.

Regards,
BALATON Zoltan
