Received: from eggs.gnu.org ([2001:4830:134:3::10]:37051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cUa2s-0002Ny-5p
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cUa2q-0007Ur-UN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:20:02 -0500
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:35726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cUa2q-0007Ts-QN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:20:00 -0500
Received: by mail-io0-x231.google.com with SMTP id j18so62271656ioe.2
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 06:19:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87h94tn9qm.fsf@dusky.pond.sub.org>
References: <87h94tn9qm.fsf@dusky.pond.sub.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 20 Jan 2017 15:19:38 +0100
Message-ID: <CACXAS8AL_j-tqBNnx_92xASz5ZE2+9K3RFw51PYMPQ-vcXYagw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] -M niagara -nodefaults crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Jan 20, 2017 at 2:26 PM, Markus Armbruster <armbru@redhat.com> wrote:
> Watch this:
>
>     $ gdb --args bld/sparc64-softmmu/qemu-system-* -nodefaults -M niagara
>     [...]
>     (gdb) r
>     Starting program: /work/armbru/qemu/bld/sparc64-softmmu/qemu-system-sparc64 -nodefaults -M niagara
>     [Thread debugging using libthread_db enabled]
>     Using host libthread_db library "/lib64/libthread_db.so.1".
>     [New Thread 0x7fffce25d700 (LWP 17401)]
>     [New Thread 0x7fffcb0c1700 (LWP 17402)]
>     Could not open option rom 'nvram1': No such file or directory
>     Could not open option rom '1up-md.bin': No such file or directory
>     Could not open option rom '1up-hv.bin': No such file or directory
>     Could not open option rom 'reset.bin': No such file or directory
>     Could not open option rom 'q.bin': No such file or directory
>     Could not open option rom 'openboot.bin': No such file or directory
>
>     Thread 1 "qemu-system-spa" received signal SIGSEGV, Segmentation fault.
>     qemu_chr_fe_init (b=b@entry=0x5555566bea60, s=0x0,
>         errp=0x555556497e68 <error_abort>) at /work/armbru/qemu/qemu-char.c:897
>     897     if (s->is_mux) {
>     (gdb) bt
>     #0  0x0000555555833500 in qemu_chr_fe_init (b=b@entry=0x5555566bea60, s=0x0, errp=0x555556497e68 <error_abort>) at /work/armbru/qemu/qemu-char.c:897
>     #1  0x0000555555890a0a in serial_mm_init (address_space=address_space@entry=0x55555653dbd0, base=base@entry=133412421632, it_shift=it_shift@entry=0, irq=irq@entry=0x0, baudbase=baudbase@entry=115200, chr=<optimized out>, end=
>         DEVICE_BIG_ENDIAN) at /work/armbru/qemu/hw/char/serial.c:995
>     #2  0x00005555558107e2 in niagara_init (machine=0x55555653bf80)
>         at /work/armbru/qemu/hw/sparc64/niagara.c:149
>     #3  0x00005555557726ea in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /work/armbru/qemu/vl.c:4544
>
> In other code that's similarly stuck in the pre-qdev world, the call to
> serial_mm_init() is conditional on serial_hds[0].

Will add a check. A -nodefaults with -M niagara makes currenlty a
little sense though: there is no any known firmware which can use any
other configuration. Do we have any machines in qemu which don't
support -nodefaults ?

Artyom

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
