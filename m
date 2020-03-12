Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398E2C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A0A2072F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+Lwoc8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A0A2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCWRh-0000dm-3g
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuanzi@google.com>) id 1jCWQt-0008Vy-0W
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuanzi@google.com>) id 1jCWQq-0006lo-2E
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:36:02 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuanzi@google.com>) id 1jCWQp-0006jM-Os
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:36:00 -0400
Received: by mail-oi1-x243.google.com with SMTP id r7so7322454oij.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dxeGdg05yMpgRzKGB7JQyUg4NCnYx6sJGaPlvgrULUY=;
 b=C+Lwoc8uzxzlKQvFavOLPKHx5pUd6q8DD16nr/dzsFa5HNzi5xgUlCB4VpGZLhyQwP
 sjXRveUI0CULYB1GSEYrKUcYUTjngrg3RyVhct4HT6hokxKuem5Jfc6RpXPRR0CZUS1l
 EwzBNQLGtLAE5o0YEIIp+gFZceuYp5kDdVfaRAYyDUto49K2lygF4ORvbgO6RopJkCnC
 WI5yXxRZPnOK6d3PIWqQ7DQmPHFRNHelKKM5ZqzJWZ2qNN6oOhk53uN5wJbfljh8Q0FL
 XTY9keoGZ9NjeYGeftZHdvQ7uWKCwHME6aFbVv8bpLgiYRHuZg8pgnwI71o0LhR20bkm
 Awdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dxeGdg05yMpgRzKGB7JQyUg4NCnYx6sJGaPlvgrULUY=;
 b=qr6FdVaEwOlnEn0cuONv8470m22W45LF04J4nehJHuVhGrletVSb40EnGkzymj6GC+
 gwUT7kBagAfN2ILyI52jEkemdsxIPHzXOh1RaptD80sIJnkV2yzMmdu41J5HI3k0AZeq
 ZHJZak4OGMOxrVrmNCZvykl7L/YGuNa/z1wFsAfTXhpERxcEBYrr7h51lk9aCUYcRhfi
 BNpWhR+3r7mzkzhY7FFmlXzoURxq4J6urozPpCzFDkpG9oag41LuPFZLQml1hN3dujOa
 C9NfQ0JQfZMqMROE8Za4RYQwQwvGgveHJkw5JYeEshGtkZI+o80HggficE9KqmJjheGA
 9Whw==
X-Gm-Message-State: ANhLgQ0QyOV4Bv8JdKtzwV65UqvoLSSQAfBmnxSV7+XwMxu7S2He0xR/
 C7FLMktIxFSnXa1ELlUM5ix3vVFsgeheDRk/uyAwtQ==
X-Google-Smtp-Source: ADFU+vsveiUqhb5sxPLKj4SFTmpDC7aYPzgkLhwSMVDkGUcA1ods1vuy2SW6Xf4B7OKzpd2jHZDE/4+EtGhc6FTTbkE=
X-Received: by 2002:aca:df0b:: with SMTP id w11mr4468986oig.68.1584052557640; 
 Thu, 12 Mar 2020 15:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200222010925.32858-1-yuanzi@google.com>
 <CADjx4CKoSuu2zWn7BRhpxLL3TaimR7fX99u_r41egctwA1LVTQ@mail.gmail.com>
 <553af2a0-2092-fe7f-ad7a-3b7ecebbe0a5@vivier.eu>
 <CADjx4CJSDkA3aDxhp2yZJBnKtUe4YntfpdEKp91VS0JiUhE+2Q@mail.gmail.com>
 <0f138812-b036-f99b-3d50-b871863d22f2@vivier.eu>
 <CADjx4CJ1Z7kbntP+QH6WOiZSSa7g0nU596e6iiHWWbCAqebP+A@mail.gmail.com>
 <CADjx4C+wS-1dpTiJDULs09y1T8yYSLTBJ7E6LZYoUqZbW-cfxQ@mail.gmail.com>
 <19f04b9a-866f-9529-4f89-bf88cf487738@vivier.eu>
In-Reply-To: <19f04b9a-866f-9529-4f89-bf88cf487738@vivier.eu>
From: Lirong Yuan <yuanzi@google.com>
Date: Thu, 12 Mar 2020 15:35:46 -0700
Message-ID: <CADjx4CKQpFG7tRPauXt68Z0JPzRjFxa2rp2m20ZGqrp8jbsT4g@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Add an argument QEMU_MMAP_BASE to set custom
 mmap base address in qemu user mode
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>
Content-Type: multipart/alternative; boundary="0000000000000484b805a0affa0f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

--0000000000000484b805a0affa0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 1:42 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 09/03/2020 =C3=A0 19:07, Lirong Yuan a =C3=A9crit :
> >
> > On Mon, Mar 2, 2020 at 11:51 AM Lirong Yuan <yuanzi@google.com
> > <mailto:yuanzi@google.com>> wrote:
> >
> >     On Mon, Mar 2, 2020 at 10:39 AM Laurent Vivier <laurent@vivier.eu
> >     <mailto:laurent@vivier.eu>> wrote:
> >     >
> >     > Le 02/03/2020 =C3=A0 18:53, Lirong Yuan a =C3=A9crit :
> >     > > On Mon, Mar 2, 2020 at 6:56 AM Laurent Vivier <laurent@vivier.e=
u
> >     <mailto:laurent@vivier.eu>> wrote:
> >     > >>
> >     > >> Le 29/02/2020 =C3=A0 01:43, Lirong Yuan a =C3=A9crit :
> >     > >>> On Fri, Feb 21, 2020 at 5:09 PM Lirong Yuan <yuanzi@google.co=
m
> >     <mailto:yuanzi@google.com>> wrote:
> >     > >>>>
> >     > >>>> This change allows us to set custom base address for guest
> >     programs. It is needed to allow qemu to work with Thread Sanitizer
> >     (TSan), which has specific boundary definitions for memory mappings
> >     on different platforms:
> >     > >>>>
> >
> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl=
/tsan_platform.h
> >     > >>
> >     > >> Could you give more details and some examples?
> >     > >>
> >     > >> Thanks,
> >     > >> Laurent
> >     > >>
> >     > >>>> Signed-off-by: Lirong Yuan <yuanzi@google.com
> >     <mailto:yuanzi@google.com>>
> >     > >>>> ---
> >     > >>>>  linux-user/main.c | 12 ++++++++++++
> >     > >>>>  linux-user/mmap.c |  3 ++-
> >     > >>>>  linux-user/qemu.h |  5 +++++
> >     > >>>>  3 files changed, 19 insertions(+), 1 deletion(-)
> >     > >>>>
> >     > >>>> diff --git a/linux-user/main.c b/linux-user/main.c
> >     > >>>> index fba833aac9..c01af6bfee 100644
> >     > >>>> --- a/linux-user/main.c
> >     > >>>> +++ b/linux-user/main.c
> >     > >>>> @@ -336,6 +336,16 @@ static void handle_arg_guest_base(const
> >     char *arg)
> >     > >>>>      have_guest_base =3D 1;
> >     > >>>>  }
> >     > >>>>
> >     > >>>> +static void handle_arg_mmap_base(const char *arg)
> >     > >>>> +{
> >     > >>>> +    int err =3D qemu_strtoul(arg, NULL, 0, &mmap_base);
> >     > >>>> +    if (err) {
> >     > >>>> +        fprintf(stderr, "Invalid mmap_base: %s, err: %d\n",
> >     arg, err);
> >     > >>>> +        exit(EXIT_FAILURE);
> >     > >>>> +    }
> >     > >>>> +    mmap_next_start =3D mmap_base;
> >     > >>>> +}
> >     > >>>> +
> >     > >>>>  static void handle_arg_reserved_va(const char *arg)
> >     > >>>>  {
> >     > >>>>      char *p;
> >     > >>>> @@ -440,6 +450,8 @@ static const struct qemu_argument
> >     arg_table[] =3D {
> >     > >>>>       "uname",      "set qemu uname release string to
> 'uname'"},
> >     > >>>>      {"B",          "QEMU_GUEST_BASE",  true,
> >     handle_arg_guest_base,
> >     > >>>>       "address",    "set guest_base address to 'address'"},
> >     > >>>> +    {"mmap_base",  "QEMU_MMAP_BASE",   true,
> >     handle_arg_mmap_base,
> >     > >>>> +     "",           "begin allocating guest pages at this
> >     host address"},
> >     > >>>>      {"R",          "QEMU_RESERVED_VA", true,
> >     handle_arg_reserved_va,
> >     > >>>>       "size",       "reserve 'size' bytes for guest virtual
> >     address space"},
> >     > >>>>      {"d",          "QEMU_LOG",         true,  handle_arg_lo=
g,
> >     > >>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> >     > >>>> index 8685f02e7e..3f35543acf 100644
> >     > >>>> --- a/linux-user/mmap.c
> >     > >>>> +++ b/linux-user/mmap.c
> >     > >>>> @@ -189,6 +189,7 @@ static int mmap_frag(abi_ulong real_star=
t,
> >     > >>>>  # define TASK_UNMAPPED_BASE  0x40000000
> >     > >>>>  #endif
> >     > >>>>  abi_ulong mmap_next_start =3D TASK_UNMAPPED_BASE;
> >     > >>>> +abi_ulong mmap_base =3D TASK_UNMAPPED_BASE;
> >     > >>>>
> >     > >>>>  unsigned long last_brk;
> >     > >>>>
> >     > >>>> @@ -299,7 +300,7 @@ abi_ulong mmap_find_vma(abi_ulong start,
> >     abi_ulong size, abi_ulong align)
> >     > >>>>
> >     > >>>>              if ((addr & (align - 1)) =3D=3D 0) {
> >     > >>>>                  /* Success.  */
> >     > >>>> -                if (start =3D=3D mmap_next_start && addr >=
=3D
> >     TASK_UNMAPPED_BASE) {
> >     > >>>> +                if (start =3D=3D mmap_next_start && addr >=
=3D
> >     mmap_base) {
> >     > >>>>                      mmap_next_start =3D addr + size;
> >     > >>>>                  }
> >     > >>>>                  return addr;
> >     > >>>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> >     > >>>> index 560a68090e..83c00cfea2 100644
> >     > >>>> --- a/linux-user/qemu.h
> >     > >>>> +++ b/linux-user/qemu.h
> >     > >>>> @@ -161,6 +161,11 @@ void task_settid(TaskState *);
> >     > >>>>  void stop_all_tasks(void);
> >     > >>>>  extern const char *qemu_uname_release;
> >     > >>>>  extern unsigned long mmap_min_addr;
> >     > >>>> +/*
> >     > >>>> + * mmap_base is minimum address to use when allocating gues=
t
> >     pages. All guest
> >     > >>>> + * pages will be allocated at this (guest) address or highe=
r
> >     addresses.
> >     > >>>> + */
> >     > >>>> +extern abi_ulong mmap_base;
> >     > >>>>
> >     > >>>>  /* ??? See if we can avoid exposing so much of the loader
> >     internals.  */
> >     > >>>>
> >     > >>>> --
> >     > >>>> 2.25.0.265.gbab2e86ba0-goog
> >     > >>>>
> >     > >>>
> >     > >>> Friendly ping~
> >     > >>>
> >     > >>> Link to the page for the patch on patchwork:
> >     > >>> http://patchwork.ozlabs.org/patch/1242370/
> >     > >>>
> >     > >>
> >     > >
> >     > > Hi Laurent,
> >     > >
> >     > > Sure! We tried to run a program with TSAN enabled
> >     > > (
> https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual)
> >     > > in qemu, and got this error message:
> >     > > "FATAL: ThreadSanitizer: unexpected memory mapping
> >     > > 0x004000000000-0x004000253000"
> >     > >
> >     > > The root cause is that the default guest base address that qemu
> uses
> >     > > is 0x4000000000 (1ul<<38), and does not align with TSAN's
> >     expectation:
> >     > >
> >
> https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b27=
c/linux-user/mmap.c#L187
> >     > >
> >
> https://github.com/llvm/llvm-project/blob/e7de00cf974a4e30d4900518ae8473a=
117efbd6c/compiler-rt/lib/tsan/rtl/tsan_platform.h#L150
> >     > >
> >     > > By setting QEMU_GUEST_BASE, we can place the guest program at a
> >     > > different base address in the host program. However, the h2g
> >     function
> >     > > (in |open_self_maps| in syscall.c) translates the address back
> to be
> >     > > based at 0x4000000000. E.g. the base address
> >     > > 0x4000000000+QEMU_GUEST_BASE will be converted to 0x4000000000
> with
> >     > > function h2g:
> >     > >
> >
> https://github.com/qemu/qemu/blob/c81acb643a61db199b9198add7972d8a8496b27=
c/linux-user/syscall.c#L7076
> >     > >
> >     > > One solution then, is to update |open_self_maps| in syscall.c t=
o
> not
> >     > > use h2g. However this changes the meaning of QEMU_GUEST_BASE an=
d
> >     could
> >     > > break existing programs that set non-zero QEMU_GUEST_BASE.
> >     > >
> >     > > So, how did qemu pick the base address 0x4000000000 then?
> Looking at
> >     > > the blame output in github, one recent change for the base
> >     address was
> >     > > committed 10 years ago:
> >     > > https://github.com/qemu/qemu/c|open_self_maps|
> >     <https://github.com/qemu/qemu/c%7Copen_self_maps%7C> in
> >     > > syscall.commit/14f24e1465edc44b9b4d89fbbea66e06088154e1
> >     > >
> >     > > Another one was committed 12 years ago:
> >     > >
> >
> https://github.com/qemu/qemu/commit/a03e2d421e7f33316750d6b7396d1a7e14b18=
d53
> >     > >
> >     > > The description of the first change is "place the default
> >     mapping base
> >     > > for 64-bit guests (on 64-bit hosts) outside the low 4G". It
> >     would seem
> >     > > that minimum requirements for the base address are:
> >     > > 1) addr >=3D 4G (for 64-bit)
> >     > > 2) addr < lowest address used by the host qemu program by some
> >     margin
> >     > >
> >     > > Given that
> >     > > 1) only TSAN explicitly check for the validity of addresses
> >     > > 2) 0x4000000000 is not a valid address for programs on aarch64
> >     > > (according to TSAN)
> >     > > 3) different architectures have different valid addresses,
> >     > > it would seem that adding an argument for changing the
> >     hard-coded base
> >     > > address is a viable solution.
> >     >
> >     > Thank you for the detailed explanation.
> >     >
> >     > Could you show me an example of the QEMU command line you use?
> >     >
> >     > I'm wondering if hardcoding directly the good value would be a
> better
> >     > solution?
> >     >
> >     > Richard, do you have some thoughts on this?
> >     >
> >     > Thanks,
> >     > Laurent
> >
> >     Sure! First we compile a simple race program with TSAN enabled:
> >     ( Simple race program is here:
> >
> https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual#usage
> >     )
> >     $ clang++ simple_race.cc -fsanitize=3Dthread -fPIE -pie -g -o
> simple_race
> >
> >     Next we run a script for executing the program, and it exports
> >     environment variables:
> >     QEMU_CPU=3Dmax
> >     QEMU_MMAP_BASE=3D0x0000005500000000
> >
> >     And runs the QEMU program:
> >     $ qemu-aarch64 simple_race
> >
> >     I changed the default value for all other programs that I am workin=
g
> >     with, and so far we haven't seen any problems.
> >     For the patch, it might be better to err on the safe side and not
> >     change the hard-coded value, as it might cause potential breakages
> for
> >     other users.
> >     Though I don't know much about how the default value might be used =
or
> >     depended on by other programs, so if you see no concerns for updati=
ng
> >     the value, I'd be happy to change it too.
> >
> >
> > Friendly ping~
> >
> > Link to the page for the patch on patchwork:
> > http://patchwork.ozlabs.org/patch/1242370/
>
> I would prefer if you hardcode the value for aarch64 rather than adding
> a new parameter.
>
> Thanks,
> Laurent
>

For sure! I will send a patch shortly for hardcoding the value on aarch64.

Note that although the value has been working fine for our tests, we are
not sure that it won't break other tests on other systems.

Regards,
Lirong

--0000000000000484b805a0affa0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>On Thu, Mar 12, 2020 at 1:42 AM Laur=
ent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&g=
t; wrote:<br></div></div><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Le 09/03/2020 =C3=A0 19:07, Lirong Yuan a =C3=A9=
crit=C2=A0:<br>
&gt; <br>
&gt; On Mon, Mar 2, 2020 at 11:51 AM Lirong Yuan &lt;<a href=3D"mailto:yuan=
zi@google.com" target=3D"_blank">yuanzi@google.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:yuanzi@google.com" target=3D"_blank">yuan=
zi@google.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Mar 2, 2020 at 10:39 AM Laurent Vivier &lt;=
<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank">laurent@vivier.eu</a=
><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:laurent@vivier.eu" tar=
get=3D"_blank">laurent@vivier.eu</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Le 02/03/2020 =C3=A0 18:53, Lirong Yuan a =C3=
=A9crit :<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; On Mon, Mar 2, 2020 at 6:56 AM Laurent Vi=
vier &lt;<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank">laurent@viv=
ier.eu</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:laurent@vivier.eu" tar=
get=3D"_blank">laurent@vivier.eu</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt; Le 29/02/2020 =C3=A0 01:43, Lirong Yu=
an a =C3=A9crit :<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt; On Fri, Feb 21, 2020 at 5:09 PM L=
irong Yuan &lt;<a href=3D"mailto:yuanzi@google.com" target=3D"_blank">yuanz=
i@google.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:yuanzi@google.com" tar=
get=3D"_blank">yuanzi@google.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; This change allows us to set =
custom base address for guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0programs. It is needed to allow qemu to work with T=
hread Sanitizer<br>
&gt;=C2=A0 =C2=A0 =C2=A0(TSan), which has specific boundary definitions for=
 memory mappings<br>
&gt;=C2=A0 =C2=A0 =C2=A0on different platforms:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/llvm/llvm-project/blo=
b/master/compiler-rt/lib/tsan/rtl/tsan_platform.h" rel=3D"noreferrer" targe=
t=3D"_blank">https://github.com/llvm/llvm-project/blob/master/compiler-rt/l=
ib/tsan/rtl/tsan_platform.h</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt; Could you give more details and some =
examples?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt; Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt; Laurent<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; Signed-off-by: Lirong Yuan &l=
t;<a href=3D"mailto:yuanzi@google.com" target=3D"_blank">yuanzi@google.com<=
/a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:yuanzi@google.com" tar=
get=3D"_blank">yuanzi@google.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 linux-user/main.c | 12 =
++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 linux-user/mmap.c |=C2=
=A0 3 ++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 linux-user/qemu.h |=C2=
=A0 5 +++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 3 files changed, 19 ins=
ertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; diff --git a/linux-user/main.=
c b/linux-user/main.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; index fba833aac9..c01af6bfee =
100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; --- a/linux-user/main.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +++ b/linux-user/main.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; @@ -336,6 +336,16 @@ static v=
oid handle_arg_guest_base(const<br>
&gt;=C2=A0 =C2=A0 =C2=A0char *arg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 have_gues=
t_base =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +static void handle_arg_mmap_=
base(const char *arg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int err =3D qe=
mu_strtoul(arg, NULL, 0, &amp;mmap_base);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (err) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
fprintf(stderr, &quot;Invalid mmap_base: %s, err: %d\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0arg, err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
exit(EXIT_FAILURE);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 mmap_next_star=
t =3D mmap_base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 static void handle_arg_=
reserved_va(const char *arg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 char *p;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; @@ -440,6 +450,8 @@ static co=
nst struct qemu_argument<br>
&gt;=C2=A0 =C2=A0 =C2=A0arg_table[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&qu=
ot;uname&quot;,=C2=A0 =C2=A0 =C2=A0 &quot;set qemu uname release string to =
&#39;uname&#39;&quot;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 {&quot;B&=
quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;QEMU_GUEST_BASE&quot;,=C2=A0=
 true,=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0handle_arg_guest_base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&qu=
ot;address&quot;,=C2=A0 =C2=A0 &quot;set guest_base address to &#39;address=
&#39;&quot;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 {&quot;mmap_ba=
se&quot;,=C2=A0 &quot;QEMU_MMAP_BASE&quot;,=C2=A0 =C2=A0true,=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0handle_arg_mmap_base,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0&quot;&q=
uot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;begin allocating guest =
pages at this<br>
&gt;=C2=A0 =C2=A0 =C2=A0host address&quot;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 {&quot;R&=
quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;QEMU_RESERVED_VA&quot;, true=
,=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0handle_arg_reserved_va,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&qu=
ot;size&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;reserve &#39;size&#39; bytes=
 for guest virtual<br>
&gt;=C2=A0 =C2=A0 =C2=A0address space&quot;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 {&quot;d&=
quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;QEMU_LOG&quot;,=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0true,=C2=A0 handle_arg_log,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; diff --git a/linux-user/mmap.=
c b/linux-user/mmap.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; index 8685f02e7e..3f35543acf =
100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; --- a/linux-user/mmap.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +++ b/linux-user/mmap.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; @@ -189,6 +189,7 @@ static in=
t mmap_frag(abi_ulong real_start,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 # define TASK_UNMAPPED_=
BASE=C2=A0 0x40000000<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 #endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 abi_ulong mmap_next_sta=
rt =3D TASK_UNMAPPED_BASE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +abi_ulong mmap_base =3D TASK=
_UNMAPPED_BASE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 unsigned long last_brk;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; @@ -299,7 +300,7 @@ abi_ulong=
 mmap_find_vma(abi_ulong start,<br>
&gt;=C2=A0 =C2=A0 =C2=A0abi_ulong size, abi_ulong align)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if ((addr &amp; (align - 1)) =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Success.=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (start =3D=3D mmap_next_start &amp;&amp; add=
r &gt;=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0TASK_UNMAPPED_BASE) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (start =3D=3D mmap_next_start &amp;&amp; add=
r &gt;=3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0mmap_base) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_next_start =3D addr +=
 size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return addr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; diff --git a/linux-user/qemu.=
h b/linux-user/qemu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; index 560a68090e..83c00cfea2 =
100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; --- a/linux-user/qemu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +++ b/linux-user/qemu.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; @@ -161,6 +161,11 @@ void tas=
k_settid(TaskState *);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 void stop_all_tasks(voi=
d);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 extern const char *qemu=
_uname_release;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 extern unsigned long mm=
ap_min_addr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; + * mmap_base is minimum addr=
ess to use when allocating guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0pages. All guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; + * pages will be allocated a=
t this (guest) address or higher<br>
&gt;=C2=A0 =C2=A0 =C2=A0addresses.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; +extern abi_ulong mmap_base;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;=C2=A0 /* ??? See if we can av=
oid exposing so much of the loader<br>
&gt;=C2=A0 =C2=A0 =C2=A0internals.=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; --<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt; 2.25.0.265.gbab2e86ba0-goog<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt; Friendly ping~<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt; Link to the page for the patch on=
 patchwork:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt; <a href=3D"http://patchwork.ozlab=
s.org/patch/1242370/" rel=3D"noreferrer" target=3D"_blank">http://patchwork=
.ozlabs.org/patch/1242370/</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Hi Laurent,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Sure! We tried to run a program with TSAN=
 enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; (<a href=3D"https://github.com/google/san=
itizers/wiki/ThreadSanitizerCppManual" rel=3D"noreferrer" target=3D"_blank"=
>https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual</a>)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; in qemu, and got this error message:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; &quot;FATAL: ThreadSanitizer: unexpected =
memory mapping<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 0x004000000000-0x004000253000&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; The root cause is that the default guest =
base address that qemu uses<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; is 0x4000000000 (1ul&lt;&lt;38), and does=
 not align with TSAN&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0expectation:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/qemu/qemu/blob/c81acb=
643a61db199b9198add7972d8a8496b27c/linux-user/mmap.c#L187" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/qemu/qemu/blob/c81acb643a61db199b91=
98add7972d8a8496b27c/linux-user/mmap.c#L187</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/llvm/llvm-project/blo=
b/e7de00cf974a4e30d4900518ae8473a117efbd6c/compiler-rt/lib/tsan/rtl/tsan_pl=
atform.h#L150" rel=3D"noreferrer" target=3D"_blank">https://github.com/llvm=
/llvm-project/blob/e7de00cf974a4e30d4900518ae8473a117efbd6c/compiler-rt/lib=
/tsan/rtl/tsan_platform.h#L150</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; By setting QEMU_GUEST_BASE, we can place =
the guest program at a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; different base address in the host progra=
m. However, the h2g<br>
&gt;=C2=A0 =C2=A0 =C2=A0function<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; (in |open_self_maps| in syscall.c) transl=
ates the address back to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; based at 0x4000000000. E.g. the base addr=
ess<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 0x4000000000+QEMU_GUEST_BASE will be conv=
erted to 0x4000000000 with<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; function h2g:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/qemu/qemu/blob/c81acb=
643a61db199b9198add7972d8a8496b27c/linux-user/syscall.c#L7076" rel=3D"noref=
errer" target=3D"_blank">https://github.com/qemu/qemu/blob/c81acb643a61db19=
9b9198add7972d8a8496b27c/linux-user/syscall.c#L7076</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; One solution then, is to update |open_sel=
f_maps| in syscall.c to not<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; use h2g. However this changes the meaning=
 of QEMU_GUEST_BASE and<br>
&gt;=C2=A0 =C2=A0 =C2=A0could<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; break existing programs that set non-zero=
 QEMU_GUEST_BASE.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; So, how did qemu pick the base address 0x=
4000000000 then? Looking at<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; the blame output in github, one recent ch=
ange for the base<br>
&gt;=C2=A0 =C2=A0 =C2=A0address was<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; committed 10 years ago:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; <a href=3D"https://github.com/qemu/qemu/c=
%7Copen_self_maps%7C" rel=3D"noreferrer" target=3D"_blank">https://github.c=
om/qemu/qemu/c|open_self_maps|</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;<a href=3D"https://github.com/qemu/qemu/c%7Cope=
n_self_maps%7C" rel=3D"noreferrer" target=3D"_blank">https://github.com/qem=
u/qemu/c%7Copen_self_maps%7C</a>&gt; in<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; syscall.commit/14f24e1465edc44b9b4d89fbbe=
a66e06088154e1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Another one was committed 12 years ago:<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/qemu/qemu/commit/a03e=
2d421e7f33316750d6b7396d1a7e14b18d53" rel=3D"noreferrer" target=3D"_blank">=
https://github.com/qemu/qemu/commit/a03e2d421e7f33316750d6b7396d1a7e14b18d5=
3</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; The description of the first change is &q=
uot;place the default<br>
&gt;=C2=A0 =C2=A0 =C2=A0mapping base<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; for 64-bit guests (on 64-bit hosts) outsi=
de the low 4G&quot;. It<br>
&gt;=C2=A0 =C2=A0 =C2=A0would seem<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; that minimum requirements for the base ad=
dress are:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 1) addr &gt;=3D 4G (for 64-bit)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 2) addr &lt; lowest address used by the h=
ost qemu program by some<br>
&gt;=C2=A0 =C2=A0 =C2=A0margin<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Given that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 1) only TSAN explicitly check for the val=
idity of addresses<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 2) 0x4000000000 is not a valid address fo=
r programs on aarch64<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; (according to TSAN)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; 3) different architectures have different=
 valid addresses,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; it would seem that adding an argument for=
 changing the<br>
&gt;=C2=A0 =C2=A0 =C2=A0hard-coded base<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; address is a viable solution.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thank you for the detailed explanation.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Could you show me an example of the QEMU comma=
nd line you use?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m wondering if hardcoding directly the g=
ood value would be a better<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; solution?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Richard, do you have some thoughts on this?<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Thanks,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Laurent<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Sure! First we compile a simple race program with T=
SAN enabled:<br>
&gt;=C2=A0 =C2=A0 =C2=A0( Simple race program is here:<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://github.com/google/sanitizers/wik=
i/ThreadSanitizerCppManual#usage" rel=3D"noreferrer" target=3D"_blank">http=
s://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual#usage</a><br=
>
&gt;=C2=A0 =C2=A0 =C2=A0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ clang++ simple_race.cc -fsanitize=3Dthread -fPIE =
-pie -g -o simple_race<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Next we run a script for executing the program, and=
 it exports<br>
&gt;=C2=A0 =C2=A0 =C2=A0environment variables:<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMU_CPU=3Dmax<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMU_MMAP_BASE=3D0x0000005500000000<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0And runs the QEMU program:<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ qemu-aarch64 simple_race<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I changed the default value for all other programs =
that I am working<br>
&gt;=C2=A0 =C2=A0 =C2=A0with, and so far we haven&#39;t seen any problems.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0For the patch, it might be better to err on the saf=
e side and not<br>
&gt;=C2=A0 =C2=A0 =C2=A0change the hard-coded value, as it might cause pote=
ntial breakages for<br>
&gt;=C2=A0 =C2=A0 =C2=A0other users.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Though I don&#39;t know much about how the default =
value might be used or<br>
&gt;=C2=A0 =C2=A0 =C2=A0depended on by other programs, so if you see no con=
cerns for updating<br>
&gt;=C2=A0 =C2=A0 =C2=A0the value, I&#39;d be happy to change it too.<br>
&gt; <br>
&gt; <br>
&gt; Friendly ping~<br>
&gt; <br>
&gt; Link to the page for the patch on patchwork:<br>
&gt; <a href=3D"http://patchwork.ozlabs.org/patch/1242370/" rel=3D"noreferr=
er" target=3D"_blank">http://patchwork.ozlabs.org/patch/1242370/</a>=C2=A0<=
br>
<br>
I would prefer if you hardcode the value for aarch64 rather than adding<br>
a new parameter.<br>
<br>
Thanks,<br>
Laurent<br></blockquote><div><br></div>For sure! I will send a patch shortl=
y for hardcoding the value on aarch64.<div><br></div><div>Note that althoug=
h the value has been working fine for our tests, we are not sure that it wo=
n&#39;t break other tests on other systems.<br clear=3D"all"><div><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><br></div><div>Reg=
ards,<br></div></div></div></div></div><div>Lirong=C2=A0</div></div></div>

--0000000000000484b805a0affa0f--

