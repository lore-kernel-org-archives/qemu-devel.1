Received: from eggs.gnu.org ([2001:4830:134:3::10]:53236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGkqd-0004y7-FL
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGkqX-0007rd-Ib
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:06:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eGkqX-0007rM-CS
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:06:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5605FC0587E7
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 12:06:40 +0000 (UTC)
Date: Mon, 20 Nov 2017 10:06:36 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171120120636.GJ3037@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] "make -C roms lgplvgabios" broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Hi,

It looks like "make -C roms lgplvgabios" is broken since 2014
(commit 7a4dfd1e "virtio-vga: add vgabios configuration"):

  [roms]$ make lgplvgabios
  make -C vgabios vgabios-stdvga.bin vgabios-cirrus.bin vgabios-vmware.bin vgabios-qxl.bin vgabios.bin vgabios-virtio.bin
  make[1]: Entering directory '/home/ehabkost/rh/proj/virt/qemu/roms/vgabios'
  gcc -o vbetables-gen vbetables-gen.c
  ./vbetables-gen > vbetables.h
  gcc -o biossums biossums.c
  gcc -E -P vgabios.c  -DVBE -DPCIBIOS -DPCI_VID=0x1234 -DPCI_DID=0x1111 "-DVGABIOS_DATE=\"`date '+%d %b %Y'`\"" > _vgabios-stdvga_.c
  bcc -o vgabios-stdvga.s -C-c -D__i86__ -S -0 _vgabios-stdvga_.c
  sed -e 's/^\.text//' -e 's/^\.data//' vgabios-stdvga.s > _vgabios-stdvga_.s
  as86 _vgabios-stdvga_.s -b vgabios-stdvga.bin -u -w- -g -0 -j -O -l vgabios-stdvga.txt
  rm -f _vgabios-stdvga_.s _vgabios-stdvga_.c vgabios-stdvga.s
  mv vgabios-stdvga.bin VGABIOS-lgpl-latest.stdvga.bin
  ./biossums VGABIOS-lgpl-latest.stdvga.bin
  
  [...]
  
  Bios checksum at:   0x9DFF
  Current checksum:     0x00
  Calculated checksum:  0x6D  Setting checksum.
  ls -l VGABIOS-lgpl-latest.bin
  -rw-rw-r--. 1 ehabkost ehabkost 40448 nov 20 09:20 VGABIOS-lgpl-latest.bin
  gcc -E -P vgabios.c   "-DVGABIOS_DATE=\"`date '+%d %b %Y'`\"" > _vgabios-virtio_.c
  bcc -o vgabios-virtio.s -C-c -D__i86__ -S -0 _vgabios-virtio_.c
  sed -e 's/^\.text//' -e 's/^\.data//' vgabios-virtio.s > _vgabios-virtio_.s
  as86 _vgabios-virtio_.s -b vgabios-virtio.bin -u -w- -g -0 -j -O -l vgabios-virtio.txt
  rm -f _vgabios-virtio_.s _vgabios-virtio_.c vgabios-virtio.s
  mv vgabios-virtio.bin
  mv: missing destination file operand after 'vgabios-virtio.bin'
  Try 'mv --help' for more information.
  make[1]: *** [Makefile:82: vgabios-virtio.bin] Error 1
  make[1]: Leaving directory '/home/ehabkost/rh/proj/virt/qemu/roms/vgabios'
  make: *** [Makefile:104: build-lgplvgabios] Error 2
  [roms]$ 

Do we still care enough about lgplvgabios to try to fix that, or
should we just remove the lgplvgabios rules and the roms/vgabios
submodule?  The last commit in our vgabios.git submodule was 7
years ago.

Related to that, pc-bios/README seems to be outdated, as it says
the VGA BIOS come from lgplvgabios, which doesn't seem to be the
case anymore.

-- 
Eduardo
