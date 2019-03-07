Received: from eggs.gnu.org ([209.51.188.92]:40755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1tg0-0005vf-NE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1tfz-0006tk-VP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:07:12 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:36310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1tfz-0006ri-Nf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:07:11 -0500
Date: Thu, 7 Mar 2019 15:07:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <201903070701.18037.randrianasulu@gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903071455330.53555@zero.eik.bme.hu>
References: <201903070701.18037.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, 7 Mar 2019, Andrew Randrianasulu wrote:
> distorted screen was when I tried 800x600 or 32 bpp ....

The screen resolution this binary tried to set was 640x480x16 but it used 
two screens, one at offset 0 which was not set up correctly due to flat 
panel registers not emulated and another for CRT at 0x5000000 which is 
outside VRAM. The window was switched to 640x480 but showed picture of the 
screen at 0 with wrong depth/stride so it showed at 4x size with dots 
instead of correct image. Maybe it could be fixed by emulating flat panel 
part of the chip but that's not used on the fulong2e so the pmon.bin 
should not set that up and should not put CRT outside of VRAM so I think 
config of this pmon was not correct for fulong2e.

> sha256sum /dev/shm/pmon-my/pmon/zloader.2edev/pmon.bin
> ecc82c621c33d140ac1ba01a70876f467e47a7cc9eb154a0647c227355d39e60  /dev/shm/pmon-my/pmon/zloader.2edev/pmon.bin

The one you've sent to me was:
$ sha256sum pmon.bin
4f2fdb964cb386a8ba5340b5b9999e7744c974b76b521ce940105c0c76c6387b  pmon.bin

> mac99 machine with your ati-vga device look like this (after upgrading X and r128 driver)
> https://ibin.co/4ZKLzg90dFZA.png
> note again, this is with NoAccel (while strangely overlay still around via xvinfo)

NoAccel just disables 2D but not overlay I think. Chip supports overlay 
but it's not emulated yet (plan to look at that after 2D) so any guest 
driver using it will probably not get picture for overlay (if it's not 
crashing due to unexpected data from device).

Regards,
BALATON Zoltan
