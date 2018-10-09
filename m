Received: from eggs.gnu.org ([2001:4830:134:3::10]:38431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9rDw-0005K5-30
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9rDr-0001I6-Rj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:34:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9rDp-0001E2-Hy
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:34:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id 185-v6so1790542wmt.2
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 05:34:43 -0700 (PDT)
References: <20181008232756.30704-1-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181008232756.30704-1-cota@braap.org>
Date: Tue, 09 Oct 2018 13:34:40 +0100
Message-ID: <87murnmh7j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 0/5] Dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01146.html
>
> Changes since v1:

Hmm I'm seeing some qtest failures, for example:

  $ make check-qtest-alpha V=3D1
  ...
  QTEST_QEMU_BINARY=3Dalpha-softmmu/qemu-system-alpha QTEST_QEMU_IMG=3Dqemu=
-img MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} gte=
ster -k --verbose -m=3Dquick test
  s/boot-serial-test tests/qmp-test tests/qmp-cmd-test tests/device-introsp=
ect-test tests/cdrom-test tests/machine-none-test tests/qom-test tests/test=
-hmp
  TEST: tests/boot-serial-test... (pid=3D31091)
    /alpha/boot-serial/clipper:                                          Br=
oken pipe
  tests/libqtest.c:129: kill_qemu() detected QEMU death from signal 11 (Seg=
mentation fault) (core dumped)
  FAIL
  GTester: last random seed: R02S948c4a5112fd7682934f4d96e1aff38e
  (pid=3D31099)
  FAIL: tests/boot-serial-test


>
> - Add tlb_index and tlb_entry helpers from Richard
>
> - Introduce sizeof_tlb() and tlb_n_entries()
>
> - Extract tlb_mask as its own array in CPUArchState, as
>   suggested by Richard. For the associated helpers (tlb_index etc)
>   I tried several approaches, and performance-wise they're all
>   the same, so went for the simplest implementation.
>
> - Use uintptr_t for tlb_mask, as done in Richard's patch
>   + tcg/i386: use hrexw when reading tlb_mask
>   + Define tlbtype and tlbrexw solely based on TARGET_PAGE_BITS
>
> - Rename tlb_is_invalid to tlb_entry_is_empty, comparing all
>   fields (except .addend) against -1.
>
> - Rename CPUTLBDesc.used to .n_used_entries.
>
> - Drop the MIN/MAX CPU_TLB_BITS patches, defining instead
>   some values for MIN/MAX as well as a default.
>
> - Use new_size and old_size consistently in the resizing function,
>   as suggested by Richard.
>
> - Add an additional chart to the last patch, where softmmu
>   performance is compared against user-mode:
>     https://imgur.com/a/eXkjMCE
>
> You can fetch this series from:
>   https://github.com/cota/qemu/tree/tlb-dyn-v2
>
> Note that it applies on top of my tlb-lock-v4 series:
>   https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01421.html
>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
