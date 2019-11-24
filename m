Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF695C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 12:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7342067D
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 12:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5bsl9uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7342067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYqkZ-000375-0w
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 07:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYqjB-0002HS-2P
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 07:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYqj8-0001QP-Pa
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 07:10:57 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYqj8-0001Pp-G8
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 07:10:54 -0500
Received: by mail-ot1-x341.google.com with SMTP id w11so10209364ote.1
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2019 04:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Rkeg0wBXv8hltSbTmfq/zu3DcBbv9EJS4juMX4WPdvU=;
 b=R5bsl9uKXinAqwOiBLH0+HAtMyD8KNTJCN2LC7Rzf3/7V/eqyEYhANEp7saIG9dnVC
 8zrqq0x3E6XBiIy08cqGaXhhmg3khXYR5BqdlbR1XuNX5HF9j4SDKxMwZkQXpocrw+wC
 3hV53x2o+rdp6EeSKr09m7tUEcl2kv8SneSPsVB9Lp4/M5tFaqYrEQMG7IfBGhJBNK18
 GXfOQ1mC3PUm4U9rghE65RIN043GP7otHp4HBC1BmP2Q6e0Oys5AuWmomhbRR2EDH0Lm
 XCXZGUY7iqKmbo1j98lKLozSUALY+pV3yiHcAqSWlCmmTClZX5p9wDqxpEAMbAhtZBrR
 ghDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Rkeg0wBXv8hltSbTmfq/zu3DcBbv9EJS4juMX4WPdvU=;
 b=FApzKV9J8aB6G6gD5uHgIxCfh/odKFwoO2+2e7GBXp4xgbPnLREdQt389qYg+/ZCHu
 BAuV/WNyZ2oQ/zBLGH+qXVv2Pj9mk5Ovy9D7a1U1rTMUELhHqQwR2lmpaCdgCRyHGdJq
 GwXkiLNEvij8OKf8sCcz4iNI6bv9UgaSeTknfti1mFm3jM+DQ7pK1wuxA5iWL8ml0p1s
 cNA7i5cR4vcvhsvtjR2QNl6q5lR3kfG/czK3bdn5/XOfP1TSeC7HPcUgszIP1n0z7b1B
 9GVlZw419JqHq2hmsko1U154RcM0HRtrUbnkVNWESDgh93unqbEJ0KWvtSbNVhLx+hIh
 kRwg==
X-Gm-Message-State: APjAAAUzh5Y/KK0uLTtuZ10BqvrFxJlgk49xFFGqbkiCPlBjA/mC40hH
 IBP+kbiL4g2GnXxcbUZgsC8cWeMolzxNvGeL9b0=
X-Google-Smtp-Source: APXvYqwtZiKPskJJK53irEBegsIcifBdkc99k5nihBqGYXNsc6qJ6u9TuoH+zgP7Gvljp+AGqTpurIX46ZCavCalTO4=
X-Received: by 2002:a05:6830:1383:: with SMTP id
 d3mr16806751otq.306.1574597452910; 
 Sun, 24 Nov 2019 04:10:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 24 Nov 2019 04:10:52
 -0800 (PST)
In-Reply-To: <bc2a9dfb-cc5b-0916-38c7-6e07287b1080@gmx.de>
References: <20191121201448.GA3133@ls3530.fritz.box>
 <CAL1e-=ia9kmSUOztiGD=Mk4e8+r3oh2P3j_bAR2971FEGvAFyw@mail.gmail.com>
 <bc2a9dfb-cc5b-0916-38c7-6e07287b1080@gmx.de>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 24 Nov 2019 13:10:52 +0100
Message-ID: <CAL1e-=h1Os3YK=c1oStG1c0fBhvp4XX-SqfRMo3U0oxjBsg9_A@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Improve strace output for read() and getcwd()
To: Helge Deller <deller@gmx.de>
Content-Type: multipart/alternative; boundary="000000000000d854e70598168951"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d854e70598168951
Content-Type: text/plain; charset="UTF-8"

On Sunday, November 24, 2019, Helge Deller <deller@gmx.de> wrote:

> On 23.11.19 12:34, Aleksandar Markovic wrote:
> > On Thursday, November 21, 2019, Helge Deller <deller@gmx.de <mailto:
> deller@gmx.de>> wrote:
> >
> >     The strace functionality in qemu-user lacks the possibility to trace
> >     which real values get returned to pointers in userspace by syscalls.
> >
> >     For example, the read() and getcwd() syscalls currently only show the
> >     destination address where the syscalls should put the return values:
> >     2532 read(3,0xff80038c,512) = 512
> >     2532 getcwd(0x18180,4096) = 9
> >
> >     With the patch below, one now can specify in print_syscall_late()
> which
> >     syscalls should be executed first, before they get printed.
> >     After adding the read() and getcwd() syscalls, we now get this
> output in
> >     with strace instead:
> >     1708 read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04"...,512)
> = 512
> >     1708 getcwd("/usr/bin",4096) = 9
> >
> >     This patch adds just the framework with the respective
> implemenations for
> >     read() and getcwd(). If applied, more functions can be added easily
> later.
> >
> >
> > Great out-of-the-box idea! However, there are some things that are
> > not thought over yet. There is a good reason why strace happens
> > "early": if something crash-like happens during syscall translation,
> > we still have trace of original target syscall. In case of "late"
> > flavor, we don't have anything. Another potentially problematic
> > aspect is that end user certainly should know whether the trace was
> > done "early" or "late" - otherwise, there will be, for certain, cases
> > of misinterpretation / misleading / confusion of end users.
>
> Thanks for the feedback - I'm shortly sending a v2 version which
> prints the syscall name with an open parenthesis, e.g. "read(" or
> "getcwd(",
> before calling the syscall. That way you can see where it crashed/hangs...
>
>
... but I cannot see passed arguments (for example, whether NULL is passed,
or somrthing that looks like a real address)...



> Helge
>
> >
> > Yours,
> > Aleksandar
> >
> >
> >
> >
> >     Signed-off-by: Helge Deller <deller@gmx.de <mailto:deller@gmx.de>>
> >
> >     diff --git a/linux-user/strace.c b/linux-user/strace.c
> >     index de43238fa4..ff254732af 100644
> >     --- a/linux-user/strace.c
> >     +++ b/linux-user/strace.c
> >     @@ -61,6 +61,7 @@ UNUSED static void print_open_flags(abi_long, int);
> >      UNUSED static void print_syscall_prologue(const struct syscallname
> *);
> >      UNUSED static void print_syscall_epilogue(const struct syscallname
> *);
> >      UNUSED static void print_string(abi_long, int);
> >     +UNUSED static void print_encoded_string(abi_long addr, unsigned int
> maxlen, int last);
> >      UNUSED static void print_buf(abi_long addr, abi_long len, int last);
> >      UNUSED static void print_raw_param(const char *, abi_long, int);
> >      UNUSED static void print_timeval(abi_ulong, int);
> >     @@ -1204,6 +1205,37 @@ print_syscall_epilogue(const struct
> syscallname *sc)
> >          gemu_log(")");
> >      }
> >
> >     +#define MAX_ENCODED_CHARS 32
> >     +static void
> >     +print_encoded_string(abi_long addr, unsigned int maxlen, int last)
> >     +{
> >     +    unsigned int maxout;
> >     +    char *s, *str;
> >     +
> >     +    s = lock_user_string(addr);
> >     +    if (s == NULL) {
> >     +        /* can't get string out of it, so print it as pointer */
> >     +        print_pointer(addr, last);
> >     +        return;
> >     +    }
> >     +
> >     +    str = s;
> >     +    gemu_log("\"");
> >     +    maxout = MIN(maxlen, MAX_ENCODED_CHARS);
> >     +    while (maxout--) {
> >     +        unsigned char c = *str++;
> >     +        if (isprint(c)) {
> >     +            gemu_log("%c", c);
> >     +        } else {
> >     +            gemu_log("\\%o", (unsigned int) c);
> >     +        }
> >     +    }
> >     +    unlock_user(s, addr, 0);
> >     +
> >     +    gemu_log("\"%s%s", maxlen > MAX_ENCODED_CHARS ? "..." : "",
> >     +                    get_comma(last));
> >     +}
> >     +
> >      static void
> >      print_string(abi_long addr, int last)
> >      {
> >     @@ -1633,6 +1665,19 @@ print_futimesat(const struct syscallname
> *name,
> >      }
> >      #endif
> >
> >     +#ifdef TARGET_NR_getcwd
> >     +static void
> >     +print_getcwd(const struct syscallname *name,
> >     +    abi_long arg0, abi_long arg1, abi_long arg2,
> >     +    abi_long arg3, abi_long arg4, abi_long arg5)
> >     +{
> >     +    print_syscall_prologue(name);
> >     +    print_string(arg0, 0);
> >     +    print_raw_param("%u", arg1, 1);
> >     +    print_syscall_epilogue(name);
> >     +}
> >     +#endif
> >     +
> >      #ifdef TARGET_NR_settimeofday
> >      static void
> >      print_settimeofday(const struct syscallname *name,
> >     @@ -2428,6 +2473,20 @@ print_fstatat64(const struct syscallname
> *name,
> >      #define print_newfstatat    print_fstatat64
> >      #endif
> >
> >     +#ifdef TARGET_NR_read
> >     +static void
> >     +print_read(const struct syscallname *name,
> >     +    abi_long arg0, abi_long arg1, abi_long arg2,
> >     +    abi_long arg3, abi_long arg4, abi_long arg5)
> >     +{
> >     +    print_syscall_prologue(name);
> >     +    print_raw_param("%d", arg0, 0);
> >     +    print_encoded_string(arg1, arg2, 0);
> >     +    print_raw_param("%u", arg2, 1);
> >     +    print_syscall_epilogue(name);
> >     +}
> >     +#endif
> >     +
> >      #ifdef TARGET_NR_readlink
> >      static void
> >      print_readlink(const struct syscallname *name,
> >     diff --git a/linux-user/strace.list b/linux-user/strace.list
> >     index d49a1e92a8..220b1f4c46 100644
> >     --- a/linux-user/strace.list
> >     +++ b/linux-user/strace.list
> >     @@ -272,7 +272,7 @@
> >      { TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)", NULL, NULL },
> >      #endif
> >      #ifdef TARGET_NR_getcwd
> >     -{ TARGET_NR_getcwd, "getcwd" , "%s(%p,%d)", NULL, NULL },
> >     +{ TARGET_NR_getcwd, "getcwd" , NULL, print_getcwd, NULL },
> >      #endif
> >      #ifdef TARGET_NR_getdents
> >      { TARGET_NR_getdents, "getdents" , NULL, NULL, NULL },
> >     @@ -1080,7 +1080,7 @@
> >      { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
> >      #endif
> >      #ifdef TARGET_NR_read
> >     -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
> >     +{ TARGET_NR_read, "read" , NULL, print_read, NULL },
> >      #endif
> >      #ifdef TARGET_NR_readahead
> >      { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
> >     diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> >     index ce399a55f0..c0079ca2b7 100644
> >     --- a/linux-user/syscall.c
> >     +++ b/linux-user/syscall.c
> >     @@ -12069,6 +12069,21 @@ static abi_long do_syscall1(void *cpu_env,
> int num, abi_long arg1,
> >          return ret;
> >      }
> >
> >     +/*
> >     + * True if this syscall should be printed after having called the
> native
> >     + * syscall, so that values which are fed back to userspace gets
> printed.
> >     + */
> >     +static int print_syscall_late(int syscall)
> >     +{
> >     +    switch (syscall) {
> >     +    case TARGET_NR_getcwd:
> >     +    case TARGET_NR_read:
> >     +        return 1;
> >     +    default:
> >     +        return 0;
> >     +    }
> >     +}
> >     +
> >      abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
> >                          abi_long arg2, abi_long arg3, abi_long arg4,
> >                          abi_long arg5, abi_long arg6, abi_long arg7,
> >     @@ -12095,9 +12110,16 @@ abi_long do_syscall(void *cpu_env, int num,
> abi_long arg1,
> >                               arg2, arg3, arg4, arg5, arg6, arg7, arg8);
> >
> >          if (unlikely(do_strace)) {
> >     -        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> >     +        int late_printing;
> >     +        late_printing = print_syscall_late(num);
> >     +        if (!late_printing) {
> >     +            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> >     +        }
> >              ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> >                                arg5, arg6, arg7, arg8);
> >     +        if (late_printing) {
> >     +            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> >     +        }
> >              print_syscall_ret(num, ret);
> >          } else {
> >              ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> >
>
>

--000000000000d854e70598168951
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, November 24, 2019, Helge Deller &lt;<a href=3D"mailto:de=
ller@gmx.de">deller@gmx.de</a>&gt; wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>On 23.11.19 12:34, Aleksandar Markovic wrote:<br>
&gt; On Thursday, November 21, 2019, Helge Deller &lt;<a href=3D"mailto:del=
ler@gmx.de">deller@gmx.de</a> &lt;mailto:<a href=3D"mailto:deller@gmx.de">d=
eller@gmx.de</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The strace functionality in qemu-user lacks the pos=
sibility to trace<br>
&gt;=C2=A0 =C2=A0 =C2=A0which real values get returned to pointers in users=
pace by syscalls.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0For example, the read() and getcwd() syscalls curre=
ntly only show the<br>
&gt;=C2=A0 =C2=A0 =C2=A0destination address where the syscalls should put t=
he return values:<br>
&gt;=C2=A0 =C2=A0 =C2=A02532 read(3,0xff80038c,512) =3D 512<br>
&gt;=C2=A0 =C2=A0 =C2=A02532 getcwd(0x18180,4096) =3D 9<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0With the patch below, one now can specify in print_=
syscall_late() which<br>
&gt;=C2=A0 =C2=A0 =C2=A0syscalls should be executed first, before they get =
printed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0After adding the read() and getcwd() syscalls, we n=
ow get this output in<br>
&gt;=C2=A0 =C2=A0 =C2=A0with strace instead:<br>
&gt;=C2=A0 =C2=A0 =C2=A01708 read(3,&quot;\177ELF\1\2\1\3\0\0\0\<wbr>0\0\0\=
0\0\0\3\0\17\0\0\0\1\0\<wbr>2bl\0\0\04&quot;...,512) =3D 512<br>
&gt;=C2=A0 =C2=A0 =C2=A01708 getcwd(&quot;/usr/bin&quot;,4096) =3D 9<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0This patch adds just the framework with the respect=
ive implemenations for<br>
&gt;=C2=A0 =C2=A0 =C2=A0read() and getcwd(). If applied, more functions can=
 be added easily later.<br>
&gt;<br>
&gt;<br>
&gt; Great out-of-the-box idea! However, there are some things that are<br>
&gt; not thought over yet. There is a good reason why strace happens<br>
&gt; &quot;early&quot;: if something crash-like happens during syscall tran=
slation,<br>
&gt; we still have trace of original target syscall. In case of &quot;late&=
quot;<br>
&gt; flavor, we don&#39;t have anything. Another potentially problematic<br=
>
&gt; aspect is that end user certainly should know whether the trace was<br=
>
&gt; done &quot;early&quot; or &quot;late&quot; - otherwise, there will be,=
 for certain, cases<br>
&gt; of misinterpretation / misleading / confusion of end users.<br>
<br>
Thanks for the feedback - I&#39;m shortly sending a v2 version which<br>
prints the syscall name with an open parenthesis, e.g. &quot;read(&quot; or=
 &quot;getcwd(&quot;,<br>
before calling the syscall. That way you can see where it crashed/hangs...<=
br>
<br></blockquote><div><br></div><div>... but I cannot see passed arguments =
(for example, whether NULL is passed, or somrthing that looks like a real a=
ddress)...</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
Helge<br>
<br>
&gt;<br>
&gt; Yours,<br>
&gt; Aleksandar<br>
&gt;<br>
&gt;<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Helge Deller &lt;<a href=3D"mailto:d=
eller@gmx.de">deller@gmx.de</a> &lt;mailto:<a href=3D"mailto:deller@gmx.de"=
>deller@gmx.de</a>&gt;&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/linux-user/strace.c b/linux-user/strac=
e.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index de43238fa4..ff254732af 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/linux-user/strace.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/linux-user/strace.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -61,6 +61,7 @@ UNUSED static void print_open_fla=
gs(abi_long, int);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_syscall_prologue(con=
st struct syscallname *);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_syscall_epilogue(con=
st struct syscallname *);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_string(abi_long, int=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+UNUSED static void print_encoded_string(abi_long a=
ddr, unsigned int maxlen, int last);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_buf(abi_long addr, a=
bi_long len, int last);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_raw_param(const char=
 *, abi_long, int);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_timeval(abi_ulong, i=
nt);<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -1204,6 +1205,37 @@ print_syscall_epilogue(const=
 struct syscallname *sc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0gemu_log(&quot;)&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#define MAX_ENCODED_CHARS 32<br>
&gt;=C2=A0 =C2=A0 =C2=A0+static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0+print_encoded_string(abi_long addr, unsigned int m=
axlen, int last)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 unsigned int maxout;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 char *s, *str;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 s =3D lock_user_string(addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* can&#39;t get strin=
g out of it, so print it as pointer */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(addr, la=
st);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 str =3D s;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 gemu_log(&quot;\&quot;&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 maxout =3D MIN(maxlen, MAX_ENCODED_C=
HARS);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 while (maxout--) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char c =3D *s=
tr++;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isprint(c)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log=
(&quot;%c&quot;, c);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log=
(&quot;\\%o&quot;, (unsigned int) c);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 unlock_user(s, addr, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 gemu_log(&quot;\&quot;%s%s&quot;, ma=
xlen &gt; MAX_ENCODED_CHARS ? &quot;...&quot; : &quot;&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 get_comma(last));<br>
&gt;=C2=A0 =C2=A0 =C2=A0+}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0print_string(abi_long addr, int last)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -1633,6 +1665,19 @@ print_futimesat(const struct=
 syscallname *name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#endif<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#ifdef TARGET_NR_getcwd<br>
&gt;=C2=A0 =C2=A0 =C2=A0+static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0+print_getcwd(const struct syscallname *name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 abi_long arg0, abi_long arg1, abi_lo=
ng arg2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 abi_long arg3, abi_long arg4, abi_lo=
ng arg5)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_syscall_prologue(name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_string(arg0, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_raw_param(&quot;%u&quot;, arg1=
, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_syscall_epilogue(name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_settimeofday<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0print_settimeofday(const struct syscallname *=
name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -2428,6 +2473,20 @@ print_fstatat64(const struct=
 syscallname *name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#define print_newfstatat=C2=A0 =C2=A0 print_f=
statat64<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#endif<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#ifdef TARGET_NR_read<br>
&gt;=C2=A0 =C2=A0 =C2=A0+static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0+print_read(const struct syscallname *name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 abi_long arg0, abi_long arg1, abi_lo=
ng arg2,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 abi_long arg3, abi_long arg4, abi_lo=
ng arg5)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_syscall_prologue(name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_raw_param(&quot;%d&quot;, arg0=
, 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_encoded_string(arg1, arg2, 0);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_raw_param(&quot;%u&quot;, arg2=
, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_syscall_epilogue(name);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_readlink<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0print_readlink(const struct syscallname *name=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/linux-user/strace.list b/linux-user/st=
race.list<br>
&gt;=C2=A0 =C2=A0 =C2=A0index d49a1e92a8..220b1f4c46 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/linux-user/strace.list<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/linux-user/strace.list<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -272,7 +272,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{ TARGET_NR_getcpu, &quot;getcpu&quot; , &quo=
t;%s(%p,%d)&quot;, NULL, NULL },<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_getcwd<br>
&gt;=C2=A0 =C2=A0 =C2=A0-{ TARGET_NR_getcwd, &quot;getcwd&quot; , &quot;%s(=
%p,%d)&quot;, NULL, NULL },<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{ TARGET_NR_getcwd, &quot;getcwd&quot; , NULL, pri=
nt_getcwd, NULL },<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_getdents<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{ TARGET_NR_getdents, &quot;getdents&quot; , =
NULL, NULL, NULL },<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -1080,7 +1080,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{ TARGET_NR_quotactl, &quot;quotactl&quot; , =
NULL, NULL, NULL },<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_read<br>
&gt;=C2=A0 =C2=A0 =C2=A0-{ TARGET_NR_read, &quot;read&quot; , &quot;%s(%d,%=
#x,%d)&quot;, NULL, NULL },<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{ TARGET_NR_read, &quot;read&quot; , NULL, print_r=
ead, NULL },<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_readahead<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{ TARGET_NR_readahead, &quot;readahead&quot; =
, NULL, NULL, NULL },<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/linux-user/syscall.c b/linux-user/sysc=
all.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index ce399a55f0..c0079ca2b7 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/linux-user/syscall.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/linux-user/syscall.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -12069,6 +12069,21 @@ static abi_long do_syscall=
1(void *cpu_env, int num, abi_long arg1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * True if this syscall should be printed after ha=
ving called the native<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * syscall, so that values which are fed back to u=
serspace gets printed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+static int print_syscall_late(int syscall)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 switch (syscall) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 case TARGET_NR_getcwd:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 case TARGET_NR_read:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0abi_long do_syscall(void *cpu_env, int num, a=
bi_long arg1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0abi_long arg2, abi_long arg3, abi_long arg4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0abi_long arg5, abi_long arg6, abi_long arg7,<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -12095,9 +12110,16 @@ abi_long do_syscall(void *=
cpu_env, int num, abi_long arg1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arg2, arg3, arg4, arg5, arg6, arg=
7, arg8);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (unlikely(do_strace)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_syscall(num, arg=
1, arg2, arg3, arg4, arg5, arg6);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int late_printing;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 late_printing =3D prin=
t_syscall_late(num);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!late_printing) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_sy=
scall(num, arg1, arg2, arg3, arg4, arg5, arg6);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_syscal=
l1(cpu_env, num, arg1, arg2, arg3, arg4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg5, arg6, arg7, arg8);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (late_printing) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_sy=
scall(num, arg1, arg2, arg3, arg4, arg5, arg6);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_syscall_ret=
(num, ret);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_syscal=
l1(cpu_env, num, arg1, arg2, arg3, arg4,<br>
&gt;<br>
<br>
</blockquote>

--000000000000d854e70598168951--

