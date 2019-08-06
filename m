Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38B1C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDCE2147A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrZESxNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDCE2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huwHJ-0002Hb-LG
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 06:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38581)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <superirishdonkey@gmail.com>) id 1huwGI-0001Bn-UJ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <superirishdonkey@gmail.com>) id 1huwGB-0007sx-05
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:00:08 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <superirishdonkey@gmail.com>)
 id 1huwGA-0007q1-LN
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:00:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so87377496wru.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eAMatdRhPpGm3SoliidzjEeBiCT5IFXrTsaOEo/XrlE=;
 b=mrZESxNcDWNAzt5QtNQsbLE4E5bG7No0z+fJC8uyYFCB4bEjdVFiGIpTbMw4nQt2LE
 0b3F9Fyf1f0yVp0iY4IQAx3QDTLiw0eZUeSTWSlHv+RHDAw9wPtqMpTtbNZhrygEHFmc
 dkWsAd52qiU1g2+4lULCBQEHx+BhDJHhKBJWUfO1N97qM4sadmRQKaP9++DjkAk6nBOK
 Ubgj+aCjHlTE8RAv2s/rTY54WVupfwSBY9st31KlLX4jQ6WQ/37kaq4kikbQHEME1C3B
 uc4LDqIEsOsXRU8EGhqoP4urnEOXIHalbcDvzlaJkgY4E8UDxBSkTqA1TMJ3Dr4+ujlq
 g1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eAMatdRhPpGm3SoliidzjEeBiCT5IFXrTsaOEo/XrlE=;
 b=J+HIn4mhbQOjMp2mMWk265xMkukjkEThcVUjLZOBqbCvKgygsV6q98ypUR9RTHrTxu
 rMJrnwzCwiSVO/V4rRCQoD4WUt4b3V0HZ61se/QH9q+VX/Bnh1Kr7wzCVoWHBvnTHLL4
 o0D2myh7vkGJpWvgNgzyImHyyf1CNw2gItpFRv7CIRWWYzhzNIHu80W6seU0wWhQ2HiB
 Nx4PLtkJqNmusPZECyQAi/ObLfPmVwIHXpO8a7tI+7P2TLrWrDLSbYdxFtv+3dZvD2/b
 NxkgRBPY6Eg/q01ardHAY045RGqQUg1+np36rkqaUSn04uvrJ/F4/REz+yEKXY797r9k
 5dRA==
X-Gm-Message-State: APjAAAVC+tsdl2C7DbQLuRBjfR9zvEtwm1i84fnPVLuWKmPOJ12GhKZw
 XQ2s8ncI1ISd6fzW8PsTsQPuSTEyFUY/S3uteDE=
X-Google-Smtp-Source: APXvYqzmB9r1SCERbzic0452Dh4YbhbzZpVR7DYalMlVVTs7+aN3tHW7P0VBcY3QPNoHwelHDfQa5hRXLLLup9ZtfBo=
X-Received: by 2002:adf:cd81:: with SMTP id q1mr3909767wrj.16.1565085600090;
 Tue, 06 Aug 2019 03:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190725032321.12721-1-alxndr@bu.edu>
In-Reply-To: <20190725032321.12721-1-alxndr@bu.edu>
From: jiade zhang <superirishdonkey@gmail.com>
Date: Tue, 6 Aug 2019 17:59:49 +0800
Message-ID: <CANFjbBZYT8Qs5Ztk3an5c578Dri8345ZNBRzf5bp6_-_huR2mg@mail.gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [RFC 00/19] Add virtual device fuzzing support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

it seems the code in blue in tests/fuzz/fuzz.c does not do anything, what
it supposed to be?

// TODO: Replace this with QEMU's built-in linked list
static void enum_memory(void)
{
    mtree_info(true, true, true);
    fuzz_memory_region *fmr =3D g_new0(fuzz_memory_region, 1);

    fmr->io =3D false;
    fmr->start =3D 0x100000;
    fmr->length =3D 0x10000;
    fmr->next =3D fuzz_memory_region_head;
    fuzz_memory_region_tail->next =3D fmr;
    fuzz_memory_region_tail =3D fmr;
    fmr =3D fuzz_memory_region_head;




*    while(true){        fmr =3D fmr->next;        if(fmr =3D=3D
fuzz_memory_region_head)            break;*
    }
}

Oleinik, Alexander <alxndr@bu.edu> =E4=BA=8E2019=E5=B9=B47=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8811:23=E5=86=99=E9=81=93=EF=BC=9A

> As part of Google Summer of Code 2019, I'm working on integrating
> fuzzing of virtual devices into QEMU [1]. This is a highly WIP patchset
> adding this functionality.
>
> Fuzzers provide random data to a program and monitor its execution for
> errors. Coverage-guided fuzzers also observe the parts of the program
> that are exercised by each input, and use this information to
> mutate/guide the inputs to reach additional parts of the program. They
> are quite effective for finding bugs in a wide range of software.
>
> Summary:
>  - The virtual-device fuzzers use libfuzzer [2] for coverage-guided
>    in-process fuzzing.
>  - To fuzz a device, create a new fuzz "target" - i.e. a function that
>    exercises QEMU based on inputs provided by the fuzzer.
>  - Fuzz targets rely on qtest and libqos to turn inputs into actions.
>  - Since libfuzzer does in-process fuzzing, the QEMU state needs to be
>    reset after each fuzz run. These patches provide three methods for
>    resetting state.
>  - There are currently few targets, but they have already helped
>    discover bugs in the console, and virtio-net, and have reproduced
>    previously-reported vulnerabilities.
>
> Here are some main implementation details:
>  - The fuzzing occurs within a single process. QTest and QOS are
>    modified so the QTest client and server coexist within the same
>    process. They communicate with each other through direct function
>    calls. Similar to qtest, the fuzzer uses a lightweight accelerator to
>    skip CPU emulation. The fuzzing target is responsible for manually
>    executing the main loop.
>  - Since the same process is reused for many fuzzing runs, QEMU state
>    needs to be reset at the end of each run. There are currently three
>    implemented options for resetting state:
>    1. Reboot the guest between runs.
>       Pros: Straightforward and fast for simple fuzz targets.
>       Cons: Depending on the device, does not reset all device state. If
>       the device requires some initialization prior to being ready for
>       fuzzing (common for QOS-based targets), this initialization needs
>       to be done after each reboot.
>       Example target: --virtio-net-ctrl-fuzz
>    2. vmsave the state to RAM, once, and restore it after each run.
>       Alternatively, only save the device state
>       (savevm.c:qemu_save_device_state)
>       Pros: Do not need to initialize devices prior to each run.
>       VMStateDescriptions often specify more state than the device
>       resetting functions called during reboots.
>       Cons: Restoring state is often slower than rebooting. There is
>       currently no way to save the QOS object state, so the objects
>       usually needs to be re-allocated, defeating the purpose of
>       one-time device initialization.
>       Example target: --qtest-fuzz
>    3. Run each test case in a separate forked process and copy the
>       coverage information back to the parent. This is fairly similar to
>       AFL's "deferred" fork-server mode [3]
>       Pros: Relatively fast. Devices only need to be initialized once.
>       No need to do slow reboots or vmloads.
>       Cons: Not officially supported by libfuzzer and the implementation
>       is very flimsy. Does not work well for devices that rely on
>       dedicated threads.
>       Example target: --qtest-fork-fuzz
>  - Fuzz targets are registered using QEMU's module system, similar to
>    QOS test cases. Base qtest targets are registed with fuzz_add_target
>    and QOS-based targets with fuzz_add_qos_target.
>  - There are two entry points for the fuzzer:
>     LLVMFuzzerInitialize: Run once, prior to fuzzing. Here, we set up
>    qtest/qos, register the fuzz targets and partially execute vl.c:main.
>    This is also where we would take a snapshot, if using the vmsave
>    approach to resetting.
>     LLVMFuzzerTestOneInput: Run for each fuzzing input. This function is
>    responsible for taking care of device initialization, calling the
>    actual fuzz target, and resetting state at the end of each run.
>    Both of these functions are defined in tests/fuzz/fuzz.c
>  - There are many libfuzzer flags which should be used to configure the
>    coverage metrics and storage of interesting fuzz inputs. [2] These
>    flags can also be helpful in evaluating fuzzing performance through
>    metrics such as inputs/seconds and line-coverage.
>
> Here are some key issues with the current state of the code:
>  - The patches change vl.c, main-loop.c, qtest.c, tests/libqtest.c,
>    savevm.c, memory.c. I wrapped the changes with #ifdef CONFIG_FUZZ,
>    but many of these changes can and should be avoided.
>  - tests/fuzz/qos_helpers.c is largely a copy of tests/qos-test.c.
>  - The fuzzer is not properly integrated into the build system.
>    Currently I simply added all of the necessary objects to
>    target/i386/Makefile.objs, but there should be a simple way to build
>    for other arches. The binary needs to be linked against libqemuutil,
>    libqtest, qos and the qos objects, and the requirements for softmmu
>    targets.
>  - Some of the fuzz targets leak memory during state-resetting that need
>    to be tracked down and fixed.
>  - As mentioned already, running each test in a separate process does
>    not seem to be supported by libfuzzer, and the implementation
>    reflects this (tests/fuzz/fuzzer_hooks.c)
>  - The existing fuzz targets should be cleaned up as they have issues
>    with memory alignment and contain redundant checks. The should also
>    use qtest's clock_step. The fork fuzz targets are dependant on
>    a hard-coded section size.
>
> Building and running:
> Libfuzzer requires clang.
>   $ CC=3Dclang-7 CXX=3Dclang++-7 ./configure --enable-fuzzing
>   $ make i386-softmmu/all
>   $ i386-softmmu/qemu-system-i386 --qtest-dma-fuzz -detect_leaks=3D0
>
> Here "qtest-dma-fuzz" is the fuzz target name. Running qemu-system-i386
> without any arguments should print all of the available fuzz targets.
> The -help=3D1 command prints out the available libfuzzer options.
>
> There are more details, including instructions for adding new fuzz
> targets in docs/devel/fuzzing.txt
>
> In the coming weeks I would like to fix the issues listed above, more
> fuzzing targets, and ideally work on getting QEMU into oss-fuzz[4],
> where it can be fuzzed continuously.
>
> I appreciate any feedback. Thanks
> -Alex
>
> [1] https://wiki.qemu.org/Internships/ProjectIdeas/QtestOssFuzz
> [2] Trophy Case section: http://lcamtuf.coredump.cx/afl/
> [3] https://llvm.org/docs/LibFuzzer.html
> [4] https://github.com/mirrorer/afl/blob/master/llvm_mode/README.llvm#L82
> [5] https://github.com/google/oss-fuzz
>
>
> Alexander Oleinik (19):
>   fuzz: add configure option and linker objects
>   fuzz: add FUZZ_TARGET type to qemu module system
>   fuzz: add fuzz accelerator
>   fuzz: Add qos support to fuzz targets
>   fuzz: expose qemu_savevm_state & skip state header
>   fuzz: Add ramfile for fast vmstate/vmload
>   fuzz: Modify libqtest to directly invoke qtest.c
>   fuzz: add shims to intercept libfuzzer init
>   fuzz: use mtree_info to find mapped addresses
>   fuzz: expose real_main (aka regular vl.c:main)
>   fuzz: add direct send/receive in qtest client
>   fuzz: hard-code all of the needed files for build
>   fuzz: add ctrl vq support to virtio-net in libqos
>   fuzz: hard-code a main-loop timeout
>   fuzz: add fuzz accelerator type
>   fuzz: add general fuzzer entrypoints
>   fuzz: add general qtest fuzz target
>   fuzz: Add virtio-net tx and ctrl fuzz targets
>   fuzz: Add documentation about the fuzzer to docs/
>
>  accel/fuzz.c                 |  47 ++++++
>  configure                    |  11 ++
>  docs/devel/fuzzing.txt       | 145 +++++++++++++++++
>  include/qemu/module.h        |   7 +-
>  include/sysemu/fuzz.h        |  15 ++
>  include/sysemu/qtest.h       |   7 +-
>  include/sysemu/sysemu.h      |   4 +
>  memory.c                     |  34 ++++
>  migration/savevm.c           |   8 +-
>  migration/savevm.h           |   3 +
>  qtest.c                      |  19 ++-
>  target/i386/Makefile.objs    |  19 +++
>  tests/fuzz/fuzz.c            | 262 +++++++++++++++++++++++++++++++
>  tests/fuzz/fuzz.h            |  96 ++++++++++++
>  tests/fuzz/fuzzer_hooks.c    | 106 +++++++++++++
>  tests/fuzz/fuzzer_hooks.h    |   9 ++
>  tests/fuzz/qos_fuzz.c        |  63 ++++++++
>  tests/fuzz/qos_fuzz.h        |  29 ++++
>  tests/fuzz/qos_helpers.c     | 295 +++++++++++++++++++++++++++++++++++
>  tests/fuzz/qos_helpers.h     |  17 ++
>  tests/fuzz/qtest_fuzz.c      | 261 +++++++++++++++++++++++++++++++
>  tests/fuzz/qtest_fuzz.h      |  38 +++++
>  tests/fuzz/ramfile.c         | 127 +++++++++++++++
>  tests/fuzz/ramfile.h         |  20 +++
>  tests/fuzz/virtio-net-fuzz.c | 226 +++++++++++++++++++++++++++
>  tests/libqos/virtio-net.c    |   2 +-
>  tests/libqtest.c             |  53 ++++++-
>  tests/libqtest.h             |   6 +
>  util/main-loop.c             |   3 +
>  vl.c                         |  21 ++-
>  30 files changed, 1945 insertions(+), 8 deletions(-)
>  create mode 100644 accel/fuzz.c
>  create mode 100644 docs/devel/fuzzing.txt
>  create mode 100644 include/sysemu/fuzz.h
>  create mode 100644 tests/fuzz/fuzz.c
>  create mode 100644 tests/fuzz/fuzz.h
>  create mode 100644 tests/fuzz/fuzzer_hooks.c
>  create mode 100644 tests/fuzz/fuzzer_hooks.h
>  create mode 100644 tests/fuzz/qos_fuzz.c
>  create mode 100644 tests/fuzz/qos_fuzz.h
>  create mode 100644 tests/fuzz/qos_helpers.c
>  create mode 100644 tests/fuzz/qos_helpers.h
>  create mode 100644 tests/fuzz/qtest_fuzz.c
>  create mode 100644 tests/fuzz/qtest_fuzz.h
>  create mode 100644 tests/fuzz/ramfile.c
>  create mode 100644 tests/fuzz/ramfile.h
>  create mode 100644 tests/fuzz/virtio-net-fuzz.c
>
> --
> 2.20.1
>
>
