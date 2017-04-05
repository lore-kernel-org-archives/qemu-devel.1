Received: from eggs.gnu.org ([2001:4830:134:3::10]:50493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Wu@ngc.com>) id 1cvs6r-0002jK-OY
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Wu@ngc.com>) id 1cvs6o-0003Q3-Hp
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:04:57 -0400
Received: from xspc0103.northgrum.com ([157.127.149.150]:12868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Wu@ngc.com>) id 1cvs6o-0003Ow-7v
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 17:04:54 -0400
From: "Wu, Michael Y [US] (MS)" <Michael.Wu@ngc.com>
Date: Wed, 5 Apr 2017 21:03:30 +0000
Message-ID: <7a623fb8d2284ee28ddbd6e1ccf277e0@XCGC3021.northgrum.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Emulating external registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,

I've been doing some bare metal programming using the powerpc system emulat=
or. I was able to run some of my code using the g3beige system emulation. I=
 am now currently trying emulate some external registers. Simply a powerpc =
address will be mapped to a register. My plan is to write a bare metal  C p=
rogram that will access the contents of a given powerpc address via pointer=
s.

My current approach is to create a new MemoryRegion in the init function of=
 the g3beige source code (mac_oldworld.c). My idea is to set up some mmio t=
o certain address to represent those registers. For now I only care about r=
eading and writing, but in the future I hope to add additional logic when t=
he registers are written.
I added the following lines:
MemoryRegion *reg =3D g_new(MemoryRegion, 1);
memory_region_init_alias(reg, NULL, "reg_mmio",
                            get_system_io(), 0, 0x00200000);
memory_region_add_subregion(sysmem, 0xfc000000, reg);

In my bare metal program I used the following lines to see  if it works usi=
ng GDB. The issue is that GDB hangs when the pointer is either read or writ=
ten. This makes me think I am doing something incorrectly.
volatile unsigned int  * const test =3D (unsigned int *) 0xFC000000;
  *test =3D 5640;

  //read from register to confirm
  if (5640 =3D=3D *test) //seems to pause as well...
  {
    breakpoint_hit();
  }

I have very little limited experience with emulators so I thought I would a=
sk to see if anyone has tips or suggestions.

Thanks!
