Received: from eggs.gnu.org ([2001:4830:134:3::10]:38645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPpPn-00060q-1f
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPpPj-0004Mt-UV
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:16:19 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPpPj-0004Mf-P3
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:16:15 -0400
Received: by mail-qt0-x244.google.com with SMTP id c20so3487239qte.0
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 05:16:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170623164557.11636-1-f4bug@amsat.org>
	<20170623194557.GD3038@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <149191aa-efce-fcc2-71f6-a029bfbbc042@amsat.org>
Date: Tue, 27 Jun 2017 09:16:10 -0300
MIME-Version: 1.0
In-Reply-To: <20170623194557.GD3038@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/core: minor fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Alistair Francis <alistair.francis@xilinx.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Eduardo,

On 06/23/2017 04:45 PM, Eduardo Habkost wrote:
> Do you have a simple way to trigger the error paths addressed by patches 1/3
> and 2/3?

For 1/3 "elf-loader: warn about invalid endianess":

$ wget -q 
https://people.debian.org/~aurel32/qemu/mips/vmlinux-3.2.0-4-4kc-malta

$ file vmlinux-3.2.0-4-4kc-malta
vmlinux-3.2.0-4-4kc-malta: ELF 32-bit MSB executable, MIPS, MIPS32 
version 1 (SYSV), statically linked, 
BuildID[sha1]=66b8748075269e8aedb91d363050f74af8a0ebdd, not stripped

$ qemu-system-mipsel -version
QEMU emulator version 2.8.1(Debian 1:2.8+dfsg-6)
Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developers

$ qemu-system-mipsel -kernel vmlinux-3.2.0-4-4kc-malta
qemu: could not load kernel 'vmlinux-3.2.0-4-4kc-malta'

Once applied:

$ mipsel-softmmu/qemu-system-mipsel -kernel vmlinux-3.2.0-4-4kc-malta
vmlinux-3.2.0-4-4kc-malta: wrong endianess
qemu: could not load kernel 'vmlinux-3.2.0-4-4kc-malta'

It could be more verbose/nicer.

I'm doing some dual endianness tests and sometimes it happened I only 
notice I'm stupid enough to load the wrong elf once stepping in gdb...


For 2/3 "fix missing return value in load_image_targphys_as()" I 
extracted it from a WiP branch "unify-arm-mips-loaders" think that if I 
never finish it, at least this one can still be useful for others.
No commits in this branch since 4months so I don't really remember how 
it happens, but looking at rom_add_file() I see:

         fprintf(stderr, "Could not open option rom '%s': %s\n",
                 rom->path, strerror(errno));
         goto err;
...
         fprintf(stderr, "rom: file %-20s: get size error: %s\n",
                 rom->name, strerror(errno));
         goto err;
...
         fprintf(stderr, "rom: file %-20s: read error: rc=%d (expected 
%zd)\n",
                 rom->name, rc, rom->datasize);
         goto err;

So my guess is again I missed something in the command line I used (used 
unfinished bash auto-complete which lead to a directory? use zipped 
rom?) and QEMU was still booting without using the specified rom.

I do remember single stepping there at least 2 times before realize 
again how stupid I was :)

Regards,

Phil.
