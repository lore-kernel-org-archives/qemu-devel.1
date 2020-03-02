Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF849C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5FB2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gltPvu8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5FB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pGu-0004Zm-LZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1j8pGG-00040D-TO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1j8pGF-0005Wi-87
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:53:48 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1j8pGF-0005WO-0e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:53:47 -0500
Received: by mail-oi1-x242.google.com with SMTP id l12so62485oil.9
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z0pWHW7knIsOeetOs1COzzneu5jxNQFT0A2QJ//4cdg=;
 b=gltPvu8XgI+dTQkP0RyTnze81xXtVEchX8ESuiO6fMgh2VbwoirW1dq9gjnrY2IO1k
 pkGTalxkI5vB52pdG2ifrOG1a2+Ha5bVlRmdtJt2rxohc0VhAQ/+7k9R0SsRdvoTYAPj
 JW+VWh+QhERnqmmIGW0xgqHwNdnMrqHXfkbARXiHsHAa/FxbU2Wwq1ZZcyIXacAgcG/c
 p9GkKFtqr3EALEiFdkb8q/MYk7wnY3Bf9DCYMBsEAbCsE7NCdkKLqS+4D5D/2X/dy848
 X8wcTAnBEhQPc+iCDD0HC9Ge4SalVG87V8DW9N9IrtrKPXwMUREpkMWC/UQrsUfPVl8J
 dxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z0pWHW7knIsOeetOs1COzzneu5jxNQFT0A2QJ//4cdg=;
 b=deZLOx4ZedzXzRj23iBSeS0Zm9IODI1dppUlglkcHpv4+MhIhqMCtG/ppcWvbrJIo0
 cTATjKcPTiZQ/rMmuUG8uepaQC3p8deDQn6enIO7vF6/LKrEcXbtbcoH7FgzyBcp0/Zh
 Wcr/8hq477YX3TzgINISGR7lhg/8PrJcuanitZeP0gtIchbnKzN/DPB8fhTbhmwvCVYH
 PMg6F/Mm9zUvSM4MyOrKH5OdL6xzagig2B9/yi+DP+0iPiF2ltByEBaYuoqXW3h7t8z+
 kz6DWlSjAsPUvOYVrkOG6rUs0goG0mn2taHB5Wlo5+XyHCKdN/Fs8Wz2E1GqICy1RfJ0
 K6fg==
X-Gm-Message-State: ANhLgQ0Ql3YTBvNqj/pkuJa7krhARlgMjFWj1qEdLazMyx5uDTZsFU3k
 f/37VfNpeObwg5cvbWtWHDMmyNlALl1ZMXu4urCKMA==
X-Google-Smtp-Source: ADFU+vtagp1nY8cL+pZIFjRPwt+kbNyGl3QFtvZ9UqAI+Uv0+5PtlOELwKqk1UnXKhYIEhMP9FPcRxm7YMaP4NqOuSk=
X-Received: by 2002:aca:100e:: with SMTP id 14mr215310oiq.88.1583171625330;
 Mon, 02 Mar 2020 09:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20200222010925.32858-1-yuanzi@google.com>
 <CADjx4CKoSuu2zWn7BRhpxLL3TaimR7fX99u_r41egctwA1LVTQ@mail.gmail.com>
 <553af2a0-2092-fe7f-ad7a-3b7ecebbe0a5@vivier.eu>
In-Reply-To: <553af2a0-2092-fe7f-ad7a-3b7ecebbe0a5@vivier.eu>
From: Lirong Yuan <yuanzi@google.com>
Date: Mon, 2 Mar 2020 09:53:34 -0800
Message-ID: <CADjx4CJSDkA3aDxhp2yZJBnKtUe4YntfpdEKp91VS0JiUhE+2Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add an argument QEMU_MMAP_BASE to set custom
 mmap base address in qemu user mode
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 2, 2020 at 6:56 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 29/02/2020 =C3=A0 01:43, Lirong Yuan a =C3=A9crit :
> > On Fri, Feb 21, 2020 at 5:09 PM Lirong Yuan <yuanzi@google.com> wrote:
> >>
> >> This change allows us to set custom base address for guest programs. I=
t is needed to allow qemu to work with Thread Sanitizer (TSan), which has s=
pecific boundary definitions for memory mappings on different platforms:
> >> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/=
rtl/tsan_platform.h
>
> Could you give more details and some examples?
>
> Thanks,
> Laurent
>
> >> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> >> ---
> >>  linux-user/main.c | 12 ++++++++++++
> >>  linux-user/mmap.c |  3 ++-
> >>  linux-user/qemu.h |  5 +++++
> >>  3 files changed, 19 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/linux-user/main.c b/linux-user/main.c
> >> index fba833aac9..c01af6bfee 100644
> >> --- a/linux-user/main.c
> >> +++ b/linux-user/main.c
> >> @@ -336,6 +336,16 @@ static void handle_arg_guest_base(const char *arg=
)
> >>      have_guest_base =3D 1;
> >>  }
> >>
> >> +static void handle_arg_mmap_base(const char *arg)
> >> +{
> >> +    int err =3D qemu_strtoul(arg, NULL, 0, &mmap_base);
> >> +    if (err) {
> >> +        fprintf(stderr, "Invalid mmap_base: %s, err: %d\n", arg, err)=
;
> >> +        exit(EXIT_FAILURE);
> >> +    }
> >> +    mmap_next_start =3D mmap_base;
> >> +}
> >> +
> >>  static void handle_arg_reserved_va(const char *arg)
> >>  {
> >>      char *p;
> >> @@ -440,6 +450,8 @@ static const struct qemu_argument arg_table[] =3D =
{
> >>       "uname",      "set qemu uname release string to 'uname'"},
> >>      {"B",          "QEMU_GUEST_BASE",  true,  handle_arg_guest_base,
> >>       "address",    "set guest_base address to 'address'"},
> >> +    {"mmap_base",  "QEMU_MMAP_BASE",   true,  handle_arg_mmap_base,
> >> +     "",           "begin allocating guest pages at this host address=
"},
> >>      {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_va,
> >>       "size",       "reserve 'size' bytes for guest virtual address sp=
ace"},
> >>      {"d",          "QEMU_LOG",         true,  handle_arg_log,
> >> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> >> index 8685f02e7e..3f35543acf 100644
> >> --- a/linux-user/mmap.c
> >> +++ b/linux-user/mmap.c
> >> @@ -189,6 +189,7 @@ static int mmap_frag(abi_ulong real_start,
> >>  # define TASK_UNMAPPED_BASE  0x40000000
> >>  #endif
> >>  abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
> >> +abi_ulong mmap_base =3D TASK_UNMAPPED_BASE;
> >>
> >>  unsigned long last_brk;
> >>
> >> @@ -299,7 +300,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong=
 size, abi_ulong align)
> >>
> >>              if ((addr & (align - 1)) =3D=3D 0) {
> >>                  /* Success.  */
> >> -                if (start =3D=3D mmap_next_start && addr >=3D TASK_UN=
MAPPED_BASE) {
> >> +                if (start =3D=3D mmap_next_start && addr >=3D mmap_ba=
se) {
> >>                      mmap_next_start =3D addr + size;
> >>                  }
> >>                  return addr;
> >> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> >> index 560a68090e..83c00cfea2 100644
> >> --- a/linux-user/qemu.h
> >> +++ b/linux-user/qemu.h
> >> @@ -161,6 +161,11 @@ void task_settid(TaskState *);
> >>  void stop_all_tasks(void);
> >>  extern const char *qemu_uname_release;
> >>  extern unsigned long mmap_min_addr;
> >> +/*
> >> + * mmap_base is minimum address to use when allocating guest pages. A=
ll guest
> >> + * pages will be allocated at this (guest) address or higher addresse=
s.
> >> + */
> >> +extern abi_ulong mmap_base;
> >>
> >>  /* ??? See if we can avoid exposing so much of the loader internals. =
 */
> >>
> >> --
> >> 2.25.0.265.gbab2e86ba0-goog
> >>
> >
> > Friendly ping~
> >
> > Link to the page for the patch on patchwork:
> > http://patchwork.ozlabs.org/patch/1242370/
> >
>

Hi Laurent,

Sure! We tried to run a program with TSAN enabled
(https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual)
in qemu, and got this error message:
"FATAL: ThreadSanitizer: unexpected memory mapping
0x004000000000-0x004000253000"

The root cause is that the default guest base address that qemu uses
is 0x4000000000 (1ul<<38), and does not align with TSAN's expectation:
https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b27c/=
linux-user/mmap.c#L187
https://github.com/llvm/llvm-project/blob/e7de00cf974a4e30d4900518ae8473a11=
7efbd6c/compiler-rt/lib/tsan/rtl/tsan_platform.h#L150

By setting QEMU_GUEST_BASE, we can place the guest program at a
different base address in the host program. However, the h2g function
(in |open_self_maps| in syscall.c) translates the address back to be
based at 0x4000000000. E.g. the base address
0x4000000000+QEMU_GUEST_BASE will be converted to 0x4000000000 with
function h2g:
https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b27c/=
linux-user/syscall.c#L7076

One solution then, is to update |open_self_maps| in syscall.c to not
use h2g. However this changes the meaning of QEMU_GUEST_BASE and could
break existing programs that set non-zero QEMU_GUEST_BASE.

So, how did qemu pick the base address 0x4000000000 then? Looking at
the blame output in github, one recent change for the base address was
committed 10 years ago:
https://github.com/qemu/qemu/c|open_self_maps| in
syscall.commit/14f24e1465edc44b9b4d89fbbea66e06088154e1

Another one was committed 12 years ago:
https://github.com/qemu/qemu/commit/a03e2d421e7f33316750d6b7396d1a7e14b18d5=
3

The description of the first change is "place the default mapping base
for 64-bit guests (on 64-bit hosts) outside the low 4G". It would seem
that minimum requirements for the base address are:
1) addr >=3D 4G (for 64-bit)
2) addr < lowest address used by the host qemu program by some margin

Given that
1) only TSAN explicitly check for the validity of addresses
2) 0x4000000000 is not a valid address for programs on aarch64
(according to TSAN)
3) different architectures have different valid addresses,
it would seem that adding an argument for changing the hard-coded base
address is a viable solution.

Thanks!

