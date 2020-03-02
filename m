Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F084C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16222086A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 19:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSncIyps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16222086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8r74-0001p6-2F
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 14:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1j8r6P-0001EJ-TR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1j8r6O-0005xZ-4g
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:51:45 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1j8r6N-0005wz-U5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 14:51:44 -0500
Received: by mail-oi1-x241.google.com with SMTP id q81so516641oig.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 11:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CPU6WXksZG4f0bISEHl6i4goefrQl7QPIiINsl5Ddj0=;
 b=ZSncIyps0jtinPpotZkfVkN3NpaPsG5FJR1WqJSgTbXRyv8CLAwosQ3YxA4OSkVOna
 rZBDmums2TxTRdlQq90PM6J2JFL0mjtJUsZ1TcbHFvtOrezx0LlOj1k8KdxVcglmiBHz
 YX/Edi4E344xmGRgO7CVf1KDaClZo8lab3pPMLZOTEdHfyoGmRIx4RCDpR79Iam3qofa
 ZaPaJF5s1Re06/SllM3QJ6vUg2cb7EFZ+5Q4BrHPRG2tc9WBx0YgIsMFh9Nv95m8dDCl
 bTTD4ZoOjwAs4I+Chl59N37CLbPePwQ+5232DYcAC9Tdi2NFwxkj+VRh1AckVUZq+04M
 fMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CPU6WXksZG4f0bISEHl6i4goefrQl7QPIiINsl5Ddj0=;
 b=tT3vAvU6cRHPsO6wPIKPNrAxAiy/viBtIGajCIrxd7sTQCI1P19SE3zuIb77QRyGuf
 k2igd+ixoj+ijeKt2yexyHdS0Pn+SZMKqfDmyHv/KwbueIonei++yXBWMwbqNorNu4X6
 ElybdAMFOPfD0aqx/mCA0b8JBumOIqpLwGw1Fm22PzJxOXuYHa7En1d1zhuzw/aF4DEk
 cuHUyv3rO4PTnf7eUZDkPOC/46PHBHr43qV+YUZ1TEGLz5NDw31fVnC948azQLYsvmUq
 fYWCE/X+2iY3nTDRIBXOvoOMxe4QE02dc72tVLoZCIjV/IjU+J5jerZciuupVe/lqeMZ
 uOwQ==
X-Gm-Message-State: ANhLgQ0WcER6NdgKLxZ4z/kYvg+umNBOu0Ccu+93LOIpoYyx3LF+m1+O
 nYeO9cAc4dkFFW3COvxC9Q6x3bCY58q0DlMLC9QeNA==
X-Google-Smtp-Source: ADFU+vse3nd+vQ1g6Ypt3pFh0h3S/gexGxK4mtFf2b64b8nXbCK9nuc+BGZ6TGRStNSgAtI+FMG6LDQZJPpRd7qhMds=
X-Received: by 2002:a05:6808:8:: with SMTP id u8mr44731oic.37.1583178702483;
 Mon, 02 Mar 2020 11:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20200222010925.32858-1-yuanzi@google.com>
 <CADjx4CKoSuu2zWn7BRhpxLL3TaimR7fX99u_r41egctwA1LVTQ@mail.gmail.com>
 <553af2a0-2092-fe7f-ad7a-3b7ecebbe0a5@vivier.eu>
 <CADjx4CJSDkA3aDxhp2yZJBnKtUe4YntfpdEKp91VS0JiUhE+2Q@mail.gmail.com>
 <0f138812-b036-f99b-3d50-b871863d22f2@vivier.eu>
In-Reply-To: <0f138812-b036-f99b-3d50-b871863d22f2@vivier.eu>
From: Lirong Yuan <yuanzi@google.com>
Date: Mon, 2 Mar 2020 11:51:31 -0800
Message-ID: <CADjx4CJ1Z7kbntP+QH6WOiZSSa7g0nU596e6iiHWWbCAqebP+A@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add an argument QEMU_MMAP_BASE to set custom
 mmap base address in qemu user mode
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Mon, Mar 2, 2020 at 10:39 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 02/03/2020 =C3=A0 18:53, Lirong Yuan a =C3=A9crit :
> > On Mon, Mar 2, 2020 at 6:56 AM Laurent Vivier <laurent@vivier.eu> wrote=
:
> >>
> >> Le 29/02/2020 =C3=A0 01:43, Lirong Yuan a =C3=A9crit :
> >>> On Fri, Feb 21, 2020 at 5:09 PM Lirong Yuan <yuanzi@google.com> wrote=
:
> >>>>
> >>>> This change allows us to set custom base address for guest programs.=
 It is needed to allow qemu to work with Thread Sanitizer (TSan), which has=
 specific boundary definitions for memory mappings on different platforms:
> >>>> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsa=
n/rtl/tsan_platform.h
> >>
> >> Could you give more details and some examples?
> >>
> >> Thanks,
> >> Laurent
> >>
> >>>> Signed-off-by: Lirong Yuan <yuanzi@google.com>
> >>>> ---
> >>>>  linux-user/main.c | 12 ++++++++++++
> >>>>  linux-user/mmap.c |  3 ++-
> >>>>  linux-user/qemu.h |  5 +++++
> >>>>  3 files changed, 19 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/linux-user/main.c b/linux-user/main.c
> >>>> index fba833aac9..c01af6bfee 100644
> >>>> --- a/linux-user/main.c
> >>>> +++ b/linux-user/main.c
> >>>> @@ -336,6 +336,16 @@ static void handle_arg_guest_base(const char *a=
rg)
> >>>>      have_guest_base =3D 1;
> >>>>  }
> >>>>
> >>>> +static void handle_arg_mmap_base(const char *arg)
> >>>> +{
> >>>> +    int err =3D qemu_strtoul(arg, NULL, 0, &mmap_base);
> >>>> +    if (err) {
> >>>> +        fprintf(stderr, "Invalid mmap_base: %s, err: %d\n", arg, er=
r);
> >>>> +        exit(EXIT_FAILURE);
> >>>> +    }
> >>>> +    mmap_next_start =3D mmap_base;
> >>>> +}
> >>>> +
> >>>>  static void handle_arg_reserved_va(const char *arg)
> >>>>  {
> >>>>      char *p;
> >>>> @@ -440,6 +450,8 @@ static const struct qemu_argument arg_table[] =
=3D {
> >>>>       "uname",      "set qemu uname release string to 'uname'"},
> >>>>      {"B",          "QEMU_GUEST_BASE",  true,  handle_arg_guest_base=
,
> >>>>       "address",    "set guest_base address to 'address'"},
> >>>> +    {"mmap_base",  "QEMU_MMAP_BASE",   true,  handle_arg_mmap_base,
> >>>> +     "",           "begin allocating guest pages at this host addre=
ss"},
> >>>>      {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_v=
a,
> >>>>       "size",       "reserve 'size' bytes for guest virtual address =
space"},
> >>>>      {"d",          "QEMU_LOG",         true,  handle_arg_log,
> >>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> >>>> index 8685f02e7e..3f35543acf 100644
> >>>> --- a/linux-user/mmap.c
> >>>> +++ b/linux-user/mmap.c
> >>>> @@ -189,6 +189,7 @@ static int mmap_frag(abi_ulong real_start,
> >>>>  # define TASK_UNMAPPED_BASE  0x40000000
> >>>>  #endif
> >>>>  abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
> >>>> +abi_ulong mmap_base =3D TASK_UNMAPPED_BASE;
> >>>>
> >>>>  unsigned long last_brk;
> >>>>
> >>>> @@ -299,7 +300,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulo=
ng size, abi_ulong align)
> >>>>
> >>>>              if ((addr & (align - 1)) =3D=3D 0) {
> >>>>                  /* Success.  */
> >>>> -                if (start =3D=3D mmap_next_start && addr >=3D TASK_=
UNMAPPED_BASE) {
> >>>> +                if (start =3D=3D mmap_next_start && addr >=3D mmap_=
base) {
> >>>>                      mmap_next_start =3D addr + size;
> >>>>                  }
> >>>>                  return addr;
> >>>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> >>>> index 560a68090e..83c00cfea2 100644
> >>>> --- a/linux-user/qemu.h
> >>>> +++ b/linux-user/qemu.h
> >>>> @@ -161,6 +161,11 @@ void task_settid(TaskState *);
> >>>>  void stop_all_tasks(void);
> >>>>  extern const char *qemu_uname_release;
> >>>>  extern unsigned long mmap_min_addr;
> >>>> +/*
> >>>> + * mmap_base is minimum address to use when allocating guest pages.=
 All guest
> >>>> + * pages will be allocated at this (guest) address or higher addres=
ses.
> >>>> + */
> >>>> +extern abi_ulong mmap_base;
> >>>>
> >>>>  /* ??? See if we can avoid exposing so much of the loader internals=
.  */
> >>>>
> >>>> --
> >>>> 2.25.0.265.gbab2e86ba0-goog
> >>>>
> >>>
> >>> Friendly ping~
> >>>
> >>> Link to the page for the patch on patchwork:
> >>> http://patchwork.ozlabs.org/patch/1242370/
> >>>
> >>
> >
> > Hi Laurent,
> >
> > Sure! We tried to run a program with TSAN enabled
> > (https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual)
> > in qemu, and got this error message:
> > "FATAL: ThreadSanitizer: unexpected memory mapping
> > 0x004000000000-0x004000253000"
> >
> > The root cause is that the default guest base address that qemu uses
> > is 0x4000000000 (1ul<<38), and does not align with TSAN's expectation:
> > https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b=
27c/linux-user/mmap.c#L187
> > https://github.com/llvm/llvm-project/blob/e7de00cf974a4e30d4900518ae847=
3a117efbd6c/compiler-rt/lib/tsan/rtl/tsan_platform.h#L150
> >
> > By setting QEMU_GUEST_BASE, we can place the guest program at a
> > different base address in the host program. However, the h2g function
> > (in |open_self_maps| in syscall.c) translates the address back to be
> > based at 0x4000000000. E.g. the base address
> > 0x4000000000+QEMU_GUEST_BASE will be converted to 0x4000000000 with
> > function h2g:
> > https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b=
27c/linux-user/syscall.c#L7076
> >
> > One solution then, is to update |open_self_maps| in syscall.c to not
> > use h2g. However this changes the meaning of QEMU_GUEST_BASE and could
> > break existing programs that set non-zero QEMU_GUEST_BASE.
> >
> > So, how did qemu pick the base address 0x4000000000 then? Looking at
> > the blame output in github, one recent change for the base address was
> > committed 10 years ago:
> > https://github.com/qemu/qemu/c|open_self_maps| in
> > syscall.commit/14f24e1465edc44b9b4d89fbbea66e06088154e1
> >
> > Another one was committed 12 years ago:
> > https://github.com/qemu/qemu/commit/a03e2d421e7f33316750d6b7396d1a7e14b=
18d53
> >
> > The description of the first change is "place the default mapping base
> > for 64-bit guests (on 64-bit hosts) outside the low 4G". It would seem
> > that minimum requirements for the base address are:
> > 1) addr >=3D 4G (for 64-bit)
> > 2) addr < lowest address used by the host qemu program by some margin
> >
> > Given that
> > 1) only TSAN explicitly check for the validity of addresses
> > 2) 0x4000000000 is not a valid address for programs on aarch64
> > (according to TSAN)
> > 3) different architectures have different valid addresses,
> > it would seem that adding an argument for changing the hard-coded base
> > address is a viable solution.
>
> Thank you for the detailed explanation.
>
> Could you show me an example of the QEMU command line you use?
>
> I'm wondering if hardcoding directly the good value would be a better
> solution?
>
> Richard, do you have some thoughts on this?
>
> Thanks,
> Laurent

Sure! First we compile a simple race program with TSAN enabled:
( Simple race program is here:
https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual#usage
)
$ clang++ simple_race.cc -fsanitize=3Dthread -fPIE -pie -g -o simple_race

Next we run a script for executing the program, and it exports
environment variables:
QEMU_CPU=3Dmax
QEMU_MMAP_BASE=3D0x0000005500000000

And runs the QEMU program:
$ qemu-aarch64 simple_race

I changed the default value for all other programs that I am working
with, and so far we haven't seen any problems.
For the patch, it might be better to err on the safe side and not
change the hard-coded value, as it might cause potential breakages for
other users.
Though I don't know much about how the default value might be used or
depended on by other programs, so if you see no concerns for updating
the value, I'd be happy to change it too.

