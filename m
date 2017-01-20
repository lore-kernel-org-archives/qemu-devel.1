Received: from eggs.gnu.org ([2001:4830:134:3::10]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUbeE-00014d-5M
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUbeB-0003Vb-0F
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:02:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUbeA-0003V3-OV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:02:38 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87h94tn9qm.fsf@dusky.pond.sub.org>
	<CACXAS8AL_j-tqBNnx_92xASz5ZE2+9K3RFw51PYMPQ-vcXYagw@mail.gmail.com>
Date: Fri, 20 Jan 2017 17:02:34 +0100
In-Reply-To: <CACXAS8AL_j-tqBNnx_92xASz5ZE2+9K3RFw51PYMPQ-vcXYagw@mail.gmail.com>
	(Artyom Tarasenko's message of "Fri, 20 Jan 2017 15:19:38 +0100")
Message-ID: <87wpdpk9d1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] -M niagara -nodefaults crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Beniamino Galvani <b.galvani@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jia Liu <proljc@gmail.com>

Artyom Tarasenko <atar4qemu@gmail.com> writes:

> On Fri, Jan 20, 2017 at 2:26 PM, Markus Armbruster <armbru@redhat.com> wrote:
>> Watch this:
>>
>>     $ gdb --args bld/sparc64-softmmu/qemu-system-* -nodefaults -M niagara
>>     [...]
>>     (gdb) r
>>     Starting program: /work/armbru/qemu/bld/sparc64-softmmu/qemu-system-sparc64 -nodefaults -M niagara
>>     [Thread debugging using libthread_db enabled]
>>     Using host libthread_db library "/lib64/libthread_db.so.1".
>>     [New Thread 0x7fffce25d700 (LWP 17401)]
>>     [New Thread 0x7fffcb0c1700 (LWP 17402)]
>>     Could not open option rom 'nvram1': No such file or directory
>>     Could not open option rom '1up-md.bin': No such file or directory
>>     Could not open option rom '1up-hv.bin': No such file or directory
>>     Could not open option rom 'reset.bin': No such file or directory
>>     Could not open option rom 'q.bin': No such file or directory
>>     Could not open option rom 'openboot.bin': No such file or directory
>>
>>     Thread 1 "qemu-system-spa" received signal SIGSEGV, Segmentation fault.
>>     qemu_chr_fe_init (b=b@entry=0x5555566bea60, s=0x0,
>>         errp=0x555556497e68 <error_abort>) at /work/armbru/qemu/qemu-char.c:897
>>     897     if (s->is_mux) {
>>     (gdb) bt
>>     #0  0x0000555555833500 in qemu_chr_fe_init (b=b@entry=0x5555566bea60, s=0x0, errp=0x555556497e68 <error_abort>) at /work/armbru/qemu/qemu-char.c:897
>>     #1  0x0000555555890a0a in serial_mm_init (address_space=address_space@entry=0x55555653dbd0, base=base@entry=133412421632, it_shift=it_shift@entry=0, irq=irq@entry=0x0, baudbase=baudbase@entry=115200, chr=<optimized out>, end=
>>         DEVICE_BIG_ENDIAN) at /work/armbru/qemu/hw/char/serial.c:995
>>     #2  0x00005555558107e2 in niagara_init (machine=0x55555653bf80)
>>         at /work/armbru/qemu/hw/sparc64/niagara.c:149
>>     #3  0x00005555557726ea in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /work/armbru/qemu/vl.c:4544
>>
>> In other code that's similarly stuck in the pre-qdev world, the call to
>> serial_mm_init() is conditional on serial_hds[0].
>
> Will add a check. A -nodefaults with -M niagara makes currenlty a
> little sense though: there is no any known firmware which can use any
> other configuration. Do we have any machines in qemu which don't
> support -nodefaults ?

If the machine doesn't support a certain configuration, it should reject
it, not crash.  The following machines crash in my testing:

* aarch64/arm cubieboard
* microblaze/microblazeel petalogix-ml605
* or32 or32-sim
* ppc/ppc64/ppcemb virtex-ml507
* sparc64 niagara

Reproducer:

    echo -e 'q' | QEMU_AUDIO_DRV=none $q -nodefaults -S -display none -M $m,accel=qtest -monitor stdio

Maintainers cc'ed.
