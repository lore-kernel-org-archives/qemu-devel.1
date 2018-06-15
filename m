Received: from eggs.gnu.org ([2001:4830:134:3::10]:59402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTk0c-00082j-KW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTk0b-0000p8-FN
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:23:02 -0400
References: <1529045897-25260-1-git-send-email-thuth@redhat.com>
	<20180615095752.536f4642.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4cc50226-8510-4343-8913-538d8f35c543@redhat.com>
Date: Fri, 15 Jun 2018 10:22:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180615095752.536f4642.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] loader: Check access size when calling
 rom_ptr() to avoid crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org

On 15.06.2018 09:57, Cornelia Huck wrote:
> On Fri, 15 Jun 2018 08:58:17 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The rom_ptr() function allows direct access to the ROM blobs that we
>> load during startup. However, there are currently no checks for the
>> size of the accesses, so it's currently possible to crash QEMU for
>> example with:
>>
>> $ echo "Insane in the mainframe" > /tmp/test.txt
>> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
>> Segmentation fault (core dumped)
>> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
>> Segmentation fault (core dumped)
> 
> It seems nobody managed to trigger the other places yet?

mips_malta.c already seems to check bios_size, so it's not affected as
far as I can tell.

But you can crash sparc64 like this:

$ echo -n HdrS > /tmp/test.txt
$ sparc64-softmmu/qemu-system-sparc64 -kernel /tmp/test.txt \
                                      -initrd /tmp/test.txt
Segmentation fault (core dumped)

I was not able to crash sparc32 in the same way, but you can see the bad
access with valgrind there:

$ valgrind sparc-softmmu/qemu-system-sparc -kernel /tmp/test.txt -initrd
/tmp/test.txt
==14301== Memcheck, a memory error detector
==14301== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==14301== Using Valgrind-3.13.0 and LibVEX; rerun with -h for copyright info
==14301== Command: sparc-softmmu/qemu-system-sparc -kernel /tmp/test.txt
-initrd /tmp/test.txt
==14301==
==14301== Invalid write of size 4
==14301==    at 0x2C8477: memcpy (string3.h:51)
==14301==    by 0x2C8477: stl_he_p (bswap.h:342)
==14301==    by 0x2C8477: stl_be_p (bswap.h:449)
==14301==    by 0x2C8477: sun4m_load_kernel (sun4m.c:277)
==14301==    by 0x2C8477: sun4m_hw_init (sun4m.c:992)
==14301==    by 0x3272F9: machine_run_board_init (machine.c:830)
==14301==    by 0x23F809: main (vl.c:4477)
==14301==  Address 0x2702fac0 is 12 bytes after a block of size 4 alloc'd
==14301==    at 0x4C2B955: calloc (vg_replace_malloc.c:711)
==14301==    by 0x77B5F55: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5400.2)
==14301==    by 0x3282A8: rom_add_file (loader.c:950)
==14301==    by 0x3285EB: load_image_targphys_as (loader.c:153)
==14301==    by 0x2C8BDD: sun4m_load_kernel (sun4m.c:253)
==14301==    by 0x2C8BDD: sun4m_hw_init (sun4m.c:992)
==14301==    by 0x3272F9: machine_run_board_init (machine.c:830)
==14301==    by 0x23F809: main (vl.c:4477)
==14301==
==14301== Invalid write of size 4
==14301==    at 0x2C847E: memcpy (string3.h:51)
==14301==    by 0x2C847E: stl_he_p (bswap.h:342)
==14301==    by 0x2C847E: stl_be_p (bswap.h:449)
==14301==    by 0x2C847E: sun4m_load_kernel (sun4m.c:278)
==14301==    by 0x2C847E: sun4m_hw_init (sun4m.c:992)
==14301==    by 0x3272F9: machine_run_board_init (machine.c:830)
==14301==    by 0x23F809: main (vl.c:4477)
==14301==  Address 0x2702fac4 is 16 bytes after a block of size 4 alloc'd
==14301==    at 0x4C2B955: calloc (vg_replace_malloc.c:711)
==14301==    by 0x77B5F55: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.5400.2)
==14301==    by 0x3282A8: rom_add_file (loader.c:950)
==14301==    by 0x3285EB: load_image_targphys_as (loader.c:153)
==14301==    by 0x2C8BDD: sun4m_load_kernel (sun4m.c:253)
==14301==    by 0x2C8BDD: sun4m_hw_init (sun4m.c:992)
==14301==    by 0x3272F9: machine_run_board_init (machine.c:830)
==14301==    by 0x23F809: main (vl.c:4477)
==14301==

 Thomas
