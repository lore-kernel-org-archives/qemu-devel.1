Received: from eggs.gnu.org ([2001:4830:134:3::10]:55710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dFzKB-0006ns-IK
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dFzKA-0003SV-88
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:49:51 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-OQyy-puuGb=tJTA6a4CQgTo3Bj5PB=bUGOcHmk9neJw@mail.gmail.com>
References: <20170507181940.25882-1-krzk@kernel.org>
	<CAFEAcA9QY253FP9mj6CfyHoxLJ8F-NrxGJOMKiM_yFN-RE2Syw@mail.gmail.com>
	<CAFEAcA-OQyy-puuGb=tJTA6a4CQgTo3Bj5PB=bUGOcHmk9neJw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 31 May 2017 10:49:41 +0200
Message-ID: <CAJKOXPd5fuEx7tteH2vv8Tqae+xvuNikTMwLPsMVaP6fM93MGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] hw/arm/exynos: QOM-ify the SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Tue, May 30, 2017 at 3:00 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 30 May 2017 at 13:07, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 7 May 2017 at 19:19, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> Hi,
>>>
>>> Changes since v1:
>>> =================
>>> 1. s/RAM/DRAM/ in commit msg of first patch (as suggested by Philippe).
>>> 2. Add Philippe's reviewed-by.
>>>
>>>
>>> Convert the Exynos4210 SoC driver into QOM model.
>>>
>>> No external dependencies, rebased on v2.9.0-363-g0de9191deb14.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>>
>>> Krzysztof Kozlowski (3):
>>>   hw/arm/exynos: Move DRAM initialization next boards
>>>   hw/arm/exynos: Declare local variables in some order
>>>   hw/arm/exynos: QOM-ify the SoC
>>
>>
>>
>> Applied to target-arm.next, thanks
>
> ...unfortunately I've just found that patch 3 breaks "make check":
> tests/device-introspect-test subtest /arm/device/introspect/concrete
> segfaults due to memory corruption. Running it under valgrind:
>
> (cd build/x86 && QTEST_QEMU_BINARY="valgrind --vgdb-error=1
> arm-softmmu/qemu-system-arm" QTEST_QEMU_IMG=qemu-img
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM % 255 + 1))} gtester -k
> --verbose -m=quick tests/device-introspect-test -p
> /arm/device/introspect/concrete)
> TEST: tests/device-introspect-test... (pid=8506)
>   /arm/device/introspect/concrete:
> ==8508== Memcheck, a memory error detector
> ==8508== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
> ==8508== Using Valgrind-3.11.0 and LibVEX; rerun with -h for copyright info
> [etc etc]
> ==8508== Thread 2:
> ==8508== Invalid read of size 8
> ==8508==    at 0x394333: memory_region_unref (memory.c:1540)
> ==8508==    by 0x3908D9: flatview_destroy (memory.c:288)
> ==8508==    by 0x390951: flatview_unref (memory.c:302)
> ==8508==    by 0x8F9F9A: call_rcu_thread (rcu.c:272)
> ==8508==    by 0x1DF6E6B9: start_thread (pthread_create.c:333)
> ==8508==    by 0x1E28A82C: clone (clone.S:109)
> ==8508==  Address 0x2d400668 is 10,952 bytes inside a block of size
> 12,512 free'd
> ==8508==    at 0x4C2EDEB: free (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==8508==    by 0x7D7EDE: object_finalize (object.c:472)
> ==8508==    by 0x7D8DD5: object_unref (object.c:903)
> ==8508==    by 0x53A71B: qmp_device_list_properties (qmp.c:580)
> ==8508==    by 0x52B42E: qmp_marshal_device_list_properties (qmp-marshal.c:1355)
> ==8508==    by 0x8CE2B5: do_qmp_dispatch (qmp-dispatch.c:104)
> ==8508==    by 0x8CE3ED: qmp_dispatch (qmp-dispatch.c:131)
> ==8508==    by 0x3847E9: handle_qmp_command (monitor.c:3824)
> ==8508==    by 0x8D5812: json_message_process_token (json-streamer.c:105)
> ==8508==    by 0x90100C: json_lexer_feed_char (json-lexer.c:319)
> ==8508==    by 0x901154: json_lexer_feed (json-lexer.c:369)
> ==8508==    by 0x8D58B9: json_message_parser_feed (json-streamer.c:124)
> ==8508==  Block was alloc'd at
> ==8508==    at 0x4C2DB8F: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==8508==    by 0x1B7A5718: g_malloc (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
> ==8508==    by 0x7D7F34: object_new_with_type (object.c:483)
> ==8508==    by 0x7D7F90: object_new (object.c:494)
> ==8508==    by 0x53A5C6: qmp_device_list_properties (qmp.c:545)
> ==8508==    by 0x52B42E: qmp_marshal_device_list_properties (qmp-marshal.c:1355)
> ==8508==    by 0x8CE2B5: do_qmp_dispatch (qmp-dispatch.c:104)
> ==8508==    by 0x8CE3ED: qmp_dispatch (qmp-dispatch.c:131)
> ==8508==    by 0x3847E9: handle_qmp_command (monitor.c:3824)
> ==8508==    by 0x8D5812: json_message_process_token (json-streamer.c:105)
> ==8508==    by 0x90100C: json_lexer_feed_char (json-lexer.c:319)
> ==8508==    by 0x901154: json_lexer_feed (json-lexer.c:369)
> ==8508==
>
> This is because the TYPE_EXYNOS4310 device now creates and maps
> the exynos4220.chipid MemoryRegion into the system memory space
> in its instance_init method, but it doesn't have any code for
> unmapping it when the device is deleted. This test does a
> "create but don't realize; then delete it" for each device, so
> what happens is that the memory for the device is allocated on
> create, freed on object deletion, and then referenced because
> the MR is still in the system memory's flatview.
>
> For devices like this exynos one which are never going to really
> need to be deleted, the only requirement is that we can at least
> do a create-delete so we can introspect them for information
> about properties. This means that they shouldn't do things
> like adding MRs to the system memory space until the realize
> method. I think that should fix this problem.
>
> I'm dropping this patchset from my queue.

Thanks for hints, I'll fix it up and resend.

Best regards,
Krzysztof
