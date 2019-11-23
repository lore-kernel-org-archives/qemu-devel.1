Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48E3C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 11:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEA920714
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCMMcNnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEA920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYThv-0008EP-Ma
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 06:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYTgW-00078s-Op
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 06:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYTgU-0006wQ-Gn
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 06:34:40 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYTgU-0006vf-9c
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 06:34:38 -0500
Received: by mail-ot1-x341.google.com with SMTP id w11so8577883ote.1
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 03:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=PDcg7/uwRXT8meAtN38+aWQqpnEAipkWfKvAFOJkn2w=;
 b=CCMMcNnzezcHmXDErGs0oWuF92ozFdlUrQlVCCKVVAdDdGhLdT+KgzHUKg371yFmhU
 mBpZmhUTc+NhnEFqdlWiQ9QNqgqp7CEOiTk24J5dAfahmDEQqaeUbapmtVuJgiLyQi8h
 pi+t01PAUm8RZBsSd1O9+YlWkhWtC2KzcyiY5Dh7D9Qh03SJo+6BYyszGaIKEJ8fk4d6
 jfRBe2vcL4A3/6oAABbB09EG4WBIwiyGmfuI0AsturacCTnBXeCNCQQlf6fvIpibJGg3
 jjeWKIZOxTq+l85V3vZ+LS+vRdB5T6Th3mIa+/PHwezQmJh7fYIyyK4xkX2LUDH1OuSr
 Yr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=PDcg7/uwRXT8meAtN38+aWQqpnEAipkWfKvAFOJkn2w=;
 b=BmzzSNu24d6fVFFW2lyfx7Jde92SA/l++6BOT6doul2x60pHjbYO7LsFWMcBjQpynV
 9co92p2kuurM1l2kypYHcGLGNfHB+c9f7yBQxG1Y95q9l0JXhc7kvrToTxFUOEyFk2gl
 HeN6AG6tmdonSbS3BKdNPaVD/oQp2WHRM58wwFV6sVCRhSGi5ajci9D9hSrHUUpYkh3p
 4A8Z6bis7Hnt9zyNKOIcMuuQeTBcD8KAQBJ5p9L1RQi24xzt1voPVqylS0XdDykOW2c5
 ZgF7rUYU+b2PKlGJMqQan7nUgFvljSHVw9w4WHWSCPBkxfs4/0p/924hjyxgoDODoA05
 tgzQ==
X-Gm-Message-State: APjAAAURF2D/6zUoWrHB7OK/yxS3trUSn2E5tJ7nCm2VWsTnOqeOGGQT
 ZLDUIXdTpJabgsMq3sGaezRZLI76ru/JHT3Df4o=
X-Google-Smtp-Source: APXvYqx9VvH1PwdABImIuZkyzDWo0GVMUTr/OanT9yzQ1XBRGfasuf5Mm4NlRXQMCHtyeVRHrOMvxrOsVmJa8VZjEYQ=
X-Received: by 2002:a9d:1b3:: with SMTP id e48mr14527194ote.341.1574508877163; 
 Sat, 23 Nov 2019 03:34:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 23 Nov 2019 03:34:36
 -0800 (PST)
In-Reply-To: <20191121201448.GA3133@ls3530.fritz.box>
References: <20191121201448.GA3133@ls3530.fritz.box>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 23 Nov 2019 12:34:36 +0100
Message-ID: <CAL1e-=ia9kmSUOztiGD=Mk4e8+r3oh2P3j_bAR2971FEGvAFyw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Improve strace output for read() and getcwd()
To: Helge Deller <deller@gmx.de>
Content-Type: multipart/alternative; boundary="00000000000051b152059801ea89"
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

--00000000000051b152059801ea89
Content-Type: text/plain; charset="UTF-8"

On Thursday, November 21, 2019, Helge Deller <deller@gmx.de> wrote:

> The strace functionality in qemu-user lacks the possibility to trace
> which real values get returned to pointers in userspace by syscalls.
>
> For example, the read() and getcwd() syscalls currently only show the
> destination address where the syscalls should put the return values:
> 2532 read(3,0xff80038c,512) = 512
> 2532 getcwd(0x18180,4096) = 9
>
> With the patch below, one now can specify in print_syscall_late() which
> syscalls should be executed first, before they get printed.
> After adding the read() and getcwd() syscalls, we now get this output in
> with strace instead:
> 1708 read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04"...,512)
> = 512
> 1708 getcwd("/usr/bin",4096) = 9
>
> This patch adds just the framework with the respective implemenations for
> read() and getcwd(). If applied, more functions can be added easily later.
>
>
Great out-of-the-box idea! However, there are some things that are not
thought over yet. There is a good reason why strace happens "early": if
something crash-like happens during syscall translation, we still have
trace of original target syscall. In case of "late" flavor, we don't have
anything. Another potentially problematic aspect is that end user certainly
should know whether the trace was done "early" or "late" - otherwise, there
will be, for certain, cases of misinterpretation / misleading / confusion
of end users.

Yours,
Aleksandar




> Signed-off-by: Helge Deller <deller@gmx.de>
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index de43238fa4..ff254732af 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -61,6 +61,7 @@ UNUSED static void print_open_flags(abi_long, int);
>  UNUSED static void print_syscall_prologue(const struct syscallname *);
>  UNUSED static void print_syscall_epilogue(const struct syscallname *);
>  UNUSED static void print_string(abi_long, int);
> +UNUSED static void print_encoded_string(abi_long addr, unsigned int
> maxlen, int last);
>  UNUSED static void print_buf(abi_long addr, abi_long len, int last);
>  UNUSED static void print_raw_param(const char *, abi_long, int);
>  UNUSED static void print_timeval(abi_ulong, int);
> @@ -1204,6 +1205,37 @@ print_syscall_epilogue(const struct syscallname *sc)
>      gemu_log(")");
>  }
>
> +#define MAX_ENCODED_CHARS 32
> +static void
> +print_encoded_string(abi_long addr, unsigned int maxlen, int last)
> +{
> +    unsigned int maxout;
> +    char *s, *str;
> +
> +    s = lock_user_string(addr);
> +    if (s == NULL) {
> +        /* can't get string out of it, so print it as pointer */
> +        print_pointer(addr, last);
> +        return;
> +    }
> +
> +    str = s;
> +    gemu_log("\"");
> +    maxout = MIN(maxlen, MAX_ENCODED_CHARS);
> +    while (maxout--) {
> +        unsigned char c = *str++;
> +        if (isprint(c)) {
> +            gemu_log("%c", c);
> +        } else {
> +            gemu_log("\\%o", (unsigned int) c);
> +        }
> +    }
> +    unlock_user(s, addr, 0);
> +
> +    gemu_log("\"%s%s", maxlen > MAX_ENCODED_CHARS ? "..." : "",
> +                    get_comma(last));
> +}
> +
>  static void
>  print_string(abi_long addr, int last)
>  {
> @@ -1633,6 +1665,19 @@ print_futimesat(const struct syscallname *name,
>  }
>  #endif
>
> +#ifdef TARGET_NR_getcwd
> +static void
> +print_getcwd(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_string(arg0, 0);
> +    print_raw_param("%u", arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_settimeofday
>  static void
>  print_settimeofday(const struct syscallname *name,
> @@ -2428,6 +2473,20 @@ print_fstatat64(const struct syscallname *name,
>  #define print_newfstatat    print_fstatat64
>  #endif
>
> +#ifdef TARGET_NR_read
> +static void
> +print_read(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_encoded_string(arg1, arg2, 0);
> +    print_raw_param("%u", arg2, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_readlink
>  static void
>  print_readlink(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index d49a1e92a8..220b1f4c46 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -272,7 +272,7 @@
>  { TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getcwd
> -{ TARGET_NR_getcwd, "getcwd" , "%s(%p,%d)", NULL, NULL },
> +{ TARGET_NR_getcwd, "getcwd" , NULL, print_getcwd, NULL },
>  #endif
>  #ifdef TARGET_NR_getdents
>  { TARGET_NR_getdents, "getdents" , NULL, NULL, NULL },
> @@ -1080,7 +1080,7 @@
>  { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_read
> -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
> +{ TARGET_NR_read, "read" , NULL, print_read, NULL },
>  #endif
>  #ifdef TARGET_NR_readahead
>  { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ce399a55f0..c0079ca2b7 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12069,6 +12069,21 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>      return ret;
>  }
>
> +/*
> + * True if this syscall should be printed after having called the native
> + * syscall, so that values which are fed back to userspace gets printed.
> + */
> +static int print_syscall_late(int syscall)
> +{
> +    switch (syscall) {
> +    case TARGET_NR_getcwd:
> +    case TARGET_NR_read:
> +        return 1;
> +    default:
> +        return 0;
> +    }
> +}
> +
>  abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                      abi_long arg2, abi_long arg3, abi_long arg4,
>                      abi_long arg5, abi_long arg6, abi_long arg7,
> @@ -12095,9 +12110,16 @@ abi_long do_syscall(void *cpu_env, int num,
> abi_long arg1,
>                           arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>
>      if (unlikely(do_strace)) {
> -        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> +        int late_printing;
> +        late_printing = print_syscall_late(num);
> +        if (!late_printing) {
> +            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> +        }
>          ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
>                            arg5, arg6, arg7, arg8);
> +        if (late_printing) {
> +            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> +        }
>          print_syscall_ret(num, ret);
>      } else {
>          ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
>
>

--00000000000051b152059801ea89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, November 21, 2019, Helge Deller &lt;<a href=3D"mailto:=
deller@gmx.de">deller@gmx.de</a>&gt; wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">The strace functionality in qemu-user lacks the possibility to trace<br>
which real values get returned to pointers in userspace by syscalls.<br>
<br>
For example, the read() and getcwd() syscalls currently only show the<br>
destination address where the syscalls should put the return values:<br>
2532 read(3,0xff80038c,512) =3D 512<br>
2532 getcwd(0x18180,4096) =3D 9<br>
<br>
With the patch below, one now can specify in print_syscall_late() which<br>
syscalls should be executed first, before they get printed.<br>
After adding the read() and getcwd() syscalls, we now get this output in<br=
>
with strace instead:<br>
1708 read(3,&quot;\177ELF\1\2\1\3\0\0\0\<wbr>0\0\0\0\0\0\3\0\17\0\0\0\1\0\<=
wbr>2bl\0\0\04&quot;...,512) =3D 512<br>
1708 getcwd(&quot;/usr/bin&quot;,4096) =3D 9<br>
<br>
This patch adds just the framework with the respective implemenations for<b=
r>
read() and getcwd(). If applied, more functions can be added easily later.<=
br>
<br></blockquote><div><br></div><div>Great out-of-the-box idea! However, th=
ere are some things that are not thought over yet. There is a good reason w=
hy strace happens &quot;early&quot;: if something crash-like happens during=
 syscall translation, we still have trace of original target syscall. In ca=
se of &quot;late&quot; flavor, we don&#39;t have anything. Another potentia=
lly problematic aspect is that end user certainly should know whether the t=
race was done &quot;early&quot; or &quot;late&quot; - otherwise, there will=
 be, for certain, cases of misinterpretation / misleading / confusion of en=
d users.</div><div><br></div><div>Yours,</div><div>Aleksandar</div><div><br=
></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Signed-off-by: Helge Deller &lt;<a href=3D"mailto:deller@gmx.de">deller@gmx=
.de</a>&gt;<br>
<br>
diff --git a/linux-user/strace.c b/linux-user/strace.c<br>
index de43238fa4..ff254732af 100644<br>
--- a/linux-user/strace.c<br>
+++ b/linux-user/strace.c<br>
@@ -61,6 +61,7 @@ UNUSED static void print_open_flags(abi_long, int);<br>
=C2=A0UNUSED static void print_syscall_prologue(const struct syscallname *)=
;<br>
=C2=A0UNUSED static void print_syscall_epilogue(const struct syscallname *)=
;<br>
=C2=A0UNUSED static void print_string(abi_long, int);<br>
+UNUSED static void print_encoded_string(abi_long addr, unsigned int maxlen=
, int last);<br>
=C2=A0UNUSED static void print_buf(abi_long addr, abi_long len, int last);<=
br>
=C2=A0UNUSED static void print_raw_param(const char *, abi_long, int);<br>
=C2=A0UNUSED static void print_timeval(abi_ulong, int);<br>
@@ -1204,6 +1205,37 @@ print_syscall_epilogue(const struct syscallname *sc)=
<br>
=C2=A0 =C2=A0 =C2=A0gemu_log(&quot;)&quot;);<br>
=C2=A0}<br>
<br>
+#define MAX_ENCODED_CHARS 32<br>
+static void<br>
+print_encoded_string(abi_long addr, unsigned int maxlen, int last)<br>
+{<br>
+=C2=A0 =C2=A0 unsigned int maxout;<br>
+=C2=A0 =C2=A0 char *s, *str;<br>
+<br>
+=C2=A0 =C2=A0 s =3D lock_user_string(addr);<br>
+=C2=A0 =C2=A0 if (s =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* can&#39;t get string out of it, so print it=
 as pointer */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(addr, last);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 str =3D s;<br>
+=C2=A0 =C2=A0 gemu_log(&quot;\&quot;&quot;);<br>
+=C2=A0 =C2=A0 maxout =3D MIN(maxlen, MAX_ENCODED_CHARS);<br>
+=C2=A0 =C2=A0 while (maxout--) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char c =3D *str++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isprint(c)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log(&quot;%c&quot;, c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu_log(&quot;\\%o&quot;, (unsi=
gned int) c);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 unlock_user(s, addr, 0);<br>
+<br>
+=C2=A0 =C2=A0 gemu_log(&quot;\&quot;%s%s&quot;, maxlen &gt; MAX_ENCODED_CH=
ARS ? &quot;...&quot; : &quot;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_=
comma(last));<br>
+}<br>
+<br>
=C2=A0static void<br>
=C2=A0print_string(abi_long addr, int last)<br>
=C2=A0{<br>
@@ -1633,6 +1665,19 @@ print_futimesat(const struct syscallname *name,<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
+#ifdef TARGET_NR_getcwd<br>
+static void<br>
+print_getcwd(const struct syscallname *name,<br>
+=C2=A0 =C2=A0 abi_long arg0, abi_long arg1, abi_long arg2,<br>
+=C2=A0 =C2=A0 abi_long arg3, abi_long arg4, abi_long arg5)<br>
+{<br>
+=C2=A0 =C2=A0 print_syscall_prologue(name);<br>
+=C2=A0 =C2=A0 print_string(arg0, 0);<br>
+=C2=A0 =C2=A0 print_raw_param(&quot;%u&quot;, arg1, 1);<br>
+=C2=A0 =C2=A0 print_syscall_epilogue(name);<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#ifdef TARGET_NR_settimeofday<br>
=C2=A0static void<br>
=C2=A0print_settimeofday(const struct syscallname *name,<br>
@@ -2428,6 +2473,20 @@ print_fstatat64(const struct syscallname *name,<br>
=C2=A0#define print_newfstatat=C2=A0 =C2=A0 print_fstatat64<br>
=C2=A0#endif<br>
<br>
+#ifdef TARGET_NR_read<br>
+static void<br>
+print_read(const struct syscallname *name,<br>
+=C2=A0 =C2=A0 abi_long arg0, abi_long arg1, abi_long arg2,<br>
+=C2=A0 =C2=A0 abi_long arg3, abi_long arg4, abi_long arg5)<br>
+{<br>
+=C2=A0 =C2=A0 print_syscall_prologue(name);<br>
+=C2=A0 =C2=A0 print_raw_param(&quot;%d&quot;, arg0, 0);<br>
+=C2=A0 =C2=A0 print_encoded_string(arg1, arg2, 0);<br>
+=C2=A0 =C2=A0 print_raw_param(&quot;%u&quot;, arg2, 1);<br>
+=C2=A0 =C2=A0 print_syscall_epilogue(name);<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#ifdef TARGET_NR_readlink<br>
=C2=A0static void<br>
=C2=A0print_readlink(const struct syscallname *name,<br>
diff --git a/linux-user/strace.list b/linux-user/strace.list<br>
index d49a1e92a8..220b1f4c46 100644<br>
--- a/linux-user/strace.list<br>
+++ b/linux-user/strace.list<br>
@@ -272,7 +272,7 @@<br>
=C2=A0{ TARGET_NR_getcpu, &quot;getcpu&quot; , &quot;%s(%p,%d)&quot;, NULL,=
 NULL },<br>
=C2=A0#endif<br>
=C2=A0#ifdef TARGET_NR_getcwd<br>
-{ TARGET_NR_getcwd, &quot;getcwd&quot; , &quot;%s(%p,%d)&quot;, NULL, NULL=
 },<br>
+{ TARGET_NR_getcwd, &quot;getcwd&quot; , NULL, print_getcwd, NULL },<br>
=C2=A0#endif<br>
=C2=A0#ifdef TARGET_NR_getdents<br>
=C2=A0{ TARGET_NR_getdents, &quot;getdents&quot; , NULL, NULL, NULL },<br>
@@ -1080,7 +1080,7 @@<br>
=C2=A0{ TARGET_NR_quotactl, &quot;quotactl&quot; , NULL, NULL, NULL },<br>
=C2=A0#endif<br>
=C2=A0#ifdef TARGET_NR_read<br>
-{ TARGET_NR_read, &quot;read&quot; , &quot;%s(%d,%#x,%d)&quot;, NULL, NULL=
 },<br>
+{ TARGET_NR_read, &quot;read&quot; , NULL, print_read, NULL },<br>
=C2=A0#endif<br>
=C2=A0#ifdef TARGET_NR_readahead<br>
=C2=A0{ TARGET_NR_readahead, &quot;readahead&quot; , NULL, NULL, NULL },<br=
>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
index ce399a55f0..c0079ca2b7 100644<br>
--- a/linux-user/syscall.c<br>
+++ b/linux-user/syscall.c<br>
@@ -12069,6 +12069,21 @@ static abi_long do_syscall1(void *cpu_env, int num=
, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * True if this syscall should be printed after having called the native<b=
r>
+ * syscall, so that values which are fed back to userspace gets printed.<b=
r>
+ */<br>
+static int print_syscall_late(int syscall)<br>
+{<br>
+=C2=A0 =C2=A0 switch (syscall) {<br>
+=C2=A0 =C2=A0 case TARGET_NR_getcwd:<br>
+=C2=A0 =C2=A0 case TARGET_NR_read:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
=C2=A0abi_long do_syscall(void *cpu_env, int num, abi_long arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0abi_long arg2, abi_long arg3, abi_long arg4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0abi_long arg5, abi_long arg6, abi_long arg7,<br>
@@ -12095,9 +12110,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_lo=
ng arg1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 arg2, arg3, arg4, arg5, arg6, arg7, arg8);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (unlikely(do_strace)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_syscall(num, arg1, arg2, arg3, arg4, arg=
5, arg6);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int late_printing;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 late_printing =3D print_syscall_late(num);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!late_printing) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_syscall(num, arg1, arg2, a=
rg3, arg4, arg5, arg6);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_syscall1(cpu_env, num, arg1, a=
rg2, arg3, arg4,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0arg5, arg6, arg7, arg8);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (late_printing) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_syscall(num, arg1, arg2, a=
rg3, arg4, arg5, arg6);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_syscall_ret(num, ret);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_syscall1(cpu_env, num, arg1, a=
rg2, arg3, arg4,<br>
<br>
</blockquote>

--00000000000051b152059801ea89--

