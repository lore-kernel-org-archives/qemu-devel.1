Received: from eggs.gnu.org ([2001:4830:134:3::10]:34808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhWJU-0000h8-2K
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dhWJQ-0003kK-0c
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:30:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dhWJP-0003jT-Nd
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:30:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
	<87valqw9x0.fsf@dusky.pond.sub.org>
	<CAKmqyKPA6v3RpZAFOibfNeOZVzai5phfXo2njDkD6PxsBgqVrw@mail.gmail.com>
Date: Tue, 15 Aug 2017 09:30:47 +0200
In-Reply-To: <CAKmqyKPA6v3RpZAFOibfNeOZVzai5phfXo2njDkD6PxsBgqVrw@mail.gmail.com>
	(Alistair Francis's message of "Mon, 14 Aug 2017 12:00:33 -0700")
Message-ID: <87lgmluw2g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Paolo, there's a Make puzzle for you below.

Alistair Francis <alistair.francis@xilinx.com> writes:

> On Mon, Aug 14, 2017 at 6:34 AM, Markus Armbruster <armbru@redhat.com> wrote:
>> PATCH 3/5 has the exact same subject.  Why are the two separate?
>
> You are right, that is a mess.
>
> This one doesn't check for newlines at the end while the earlier one
> checked for and removed new lines.
>
>>
>> Alistair Francis <alistair.francis@xilinx.com> writes:
[...]
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index 7af278db55..4886caf565 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -560,8 +560,8 @@ tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-obj-y)
>>>  tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
>>>  tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(test-crypto-obj-y)
>>>  tests/test-x86-cpuid$(EXESUF): tests/test-x86-cpuid.o
>>> -tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-util-obj-y)
>>> -tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o
>>> +tests/test-xbzrle$(EXESUF): tests/test-xbzrle.o migration/xbzrle.o migration/page_cache.o $(test-qom-obj-y)
>>> +tests/test-cutils$(EXESUF): tests/test-cutils.o util/cutils.o $(test-qom-obj-y)
>>
>> No.  What symbols exactly is the linker missing?
>
> Without the change, this is the error I see when running make check:
>
>   CC      tests/test-x86-cpuid.o
>   LINK    tests/test-x86-cpuid
>   GTESTER tests/test-x86-cpuid
>   CC      tests/test-xbzrle.o
>   LINK    tests/test-xbzrle
> libqemustub.a(monitor.o): In function `monitor_get_fd':
> /scratch/alistai/master-qemu/stubs/monitor.c:10: undefined reference
> to `error_setg_internal'
> collect2: error: ld returned 1 exit status
> /scratch/alistai/master-qemu/rules.mak:121: recipe for target
> 'tests/test-xbzrle' failed
> make: *** [tests/test-xbzrle] Error 1

The root cause is "obvious" ;-P

The linker searches each .a just once.  We link with

    test-util-obj-y = libqemuutil.a libqemustub.a

i.e. the linker first pulls whatever it needs out of libqemuutil.a, then
moves on to pull whatever it now needs out of libqemustub.a.  If
libqemustub.a needs something from libqemuutil.a that hasn't been pulled
already, linking fails.

The linker explains its doings (--print-map):

    Archive member included to satisfy reference by file (symbol)

    libqemuutil.a(cutils.o)       tests/test-xbzrle.o (uleb128_encode_small)
    libqemuutil.a(qemu-error.o)   libqemuutil.a(cutils.o) (warn_report)
    libqemustub.a(error-printf.o)
                                  libqemuutil.a(qemu-error.o) (error_vprintf)
    libqemustub.a(monitor.o)      libqemuutil.a(qemu-error.o) (cur_mon)

Let me explain the linker's explanation:

    test-xbzrle.o pulls in libqemuutil.a(cutils.o) for
    uleb128_encode_small
    
    libqemuutil.a(cutils.o) pulls in libqemuutil.a(qemu-error.o) for
    warn_report

    libqemuutil.a(qemu-error.o) pulls in libqemustub.a(error_printf.o)
    and libqemustub.a(monitor.o) for error_vprintf and cur_mon

    libqemuutil(monitor.o) references error_setg_internal, which can't
    be resolved.

The stupid fix is to repeat libraries until the link succeeds:

    test-util-obj-y = libqemuutil.a libqemustub.a libqemuutil.a

You may have seen this with -lX11 if you're old enough.

ld(1) suggests the linker can do it for us:

    -( archives -)
    --start-group archives --end-group
        The archives should be a list of archive files.  They may be either
        explicit file names, or -l options.

        The specified archives are searched repeatedly until no new
        undefined references are created.  Normally, an archive is searched
        only once in the order that it is specified on the command line.
        If a symbol in that archive is needed to resolve an undefined
        symbol referred to by an object in an archive that appears later on
        the command line, the linker would not be able to resolve that
        reference.  By grouping the archives, they all be searched
        repeatedly until all possible references are resolved.

        Using this option has a significant performance cost.  It is best
        to use it only when there are unavoidable circular references
        between two or more archives.

Sticking '-Wp,-(' and '-Wp,-)' into the command line I get from make V=1
doesn't work for me, though.

The smart solution is not to have .a reference each other.

Paolo, what do you think?

> If only the xbzrle change is made then I see this:
>
>   LINK    tests/test-xbzrle
>   GTESTER tests/test-xbzrle
>   CC      tests/test-vmstate.o
>   LINK    tests/test-vmstate
>   GTESTER tests/test-vmstate
>   CC      tests/test-cutils.o
>   LINK    tests/test-cutils
> util/cutils.o: In function `parse_debug_env':
> /scratch/alistai/master-qemu/util/cutils.c:605: undefined reference to
> `warn_report'
> collect2: error: ld returned 1 exit status
> /scratch/alistai/master-qemu/rules.mak:121: recipe for target
> 'tests/test-cutils' failed
> make: *** [tests/test-cutils] Error 1
