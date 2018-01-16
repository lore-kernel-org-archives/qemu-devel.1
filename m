Received: from eggs.gnu.org ([2001:4830:134:3::10]:41230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebQ0a-0000my-11
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:06:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebQ0U-00059M-4G
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:06:27 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebQ0T-00058t-VL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:06:22 -0500
Received: by mail-oi0-x244.google.com with SMTP id u83so10421052oie.7
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 04:06:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
	<CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 12:06:00 +0000
Message-ID: <CAFEAcA9dsWKLitCfxy+HV66rBMruxX67Aq-n4Bpmx5b2QzC2YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/53] Misc changes for 2017-01-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 January 2018 at 11:58, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Hi
>
> On Tue, Jan 16, 2018 at 12:25 PM, Peter Maydell
> <peter.maydell@linaro.org> wrote:
>> On 15 January 2018 at 23:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75=
b9ff:
>>>
>>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2=
0180111' into staging (2018-01-11 14:34:41 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>
>>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>>
>>> for you to fetch changes up to ff9adba50bf8a4c080b8aee9be2314ef179a7b5f=
:
>>>
>>>   ucontext: annotate coroutine stack for ASAN (2018-01-12 15:21:14 +010=
0)
>>>
>>> ----------------------------------------------------------------
>>> * QemuMutex tracing improvements (Alex)
>>> * ram_addr_t optimization (David)
>>> * SCSI fixes (Fam, Stefan, me)
>>> * do {} while (0) fixes (Eric)
>>> * KVM fix for PMU (Jan)
>>> * memory leak fixes from ASAN (Marc-Andr=C3=A9)
>>> * migration fix for HPET, icount, loadvm (Maria, Pavel)
>>> * hflags fixes (me, Tao)
>>> * block/iscsi uninitialized variable (Peter L.)
>>> * full support for GMainContexts in character devices (Peter Xu)
>>> * more boot-serial-test (Thomas)
>>> * Memory leak fix (Zhecheng)
>>
>> Various build failures, I'm afraid:
>>
>
> damn, sorry..
>
>> x86-64/Linux/gcc:
>>
>> configure produces an error message:
>>
>> ERROR: ASAN build enabled, but ASAN header is too old.
>>        Without code annotation, the report may be inferior.
>>
>> even though this configure did not explicitly request ASAN.
>> Then configure seems to exit successfully anyway, since the
>> build proceeds.
>
> ASAN is enabled by default if available when --enable-debug. We could
> add more flags if that helps.

Configure switches should work like this:
 * default: use feature if present, but don't complain if not present
   or not usable
 * --enable-foo: use feature. if feature not present, complain and
   fail configure
 * --disable-foo: don't test for or use feature

>> For some reason the build creates config-target.h a lot:

> One per target no? (the build should be more silent than before)

Oh, I guess that makes sense. It's a bit odd that the message neither
gives the target part of the filename nor has those entering/leaving
directory messages...

>>
>> Then it runs configure again, this time without the ERROR message,
>> and eventually fails with:
>>
>>   CC      hw/display/exynos4210_fimd.o
>> /home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c: In
>> function =E2=80=98fimd_get_buffer_id=E2=80=99:
>> /home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c:1105:=
5:
>> error: case label does not reduce to an integer constant
>>      case FIMD_WINCON_BUF2_STAT:
>
> never saw that error, hmm interesting. This is related to
> -fsanitize=3Daddress ? Is this on Debian stable?

Ubuntu xenial (16.04.3 LTS). No idea if it's related to the
sanitizer or not.

>
>>      ^
>>
>> On sparc64 host configure fails:

> Hmm, I guess the check -fsanitize=3Daddress doesn't return an error
> unless -Werror is given. Perhaps it needs:
>
> diff --git a/configure b/configure
> index f5550f3289..ba68c550c9 100755
> --- a/configure
> +++ b/configure
> @@ -5190,7 +5190,7 @@ fi
>
>  have_asan=3Dno
>  write_c_skeleton
> -if compile_prog "-fsanitize=3Daddress" ""; then
> +if compile_prog "-Werror -fsanitize=3Daddress" ""; then
>      have_asan=3Dyes
>  fi
>
> @@ -5207,7 +5207,7 @@ int main(void) {
>    return 0;
>  }
>  EOF
> -if compile_prog "-fsanitize=3Daddress" "" ; then
> +if compile_prog "-Werror -fsanitize=3Daddress" "" ; then
>      have_asan_iface_fiber=3Dyes
>  fi
>

Looks plausible.

thanks
-- PMM
