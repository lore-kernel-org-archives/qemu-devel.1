Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBADC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 20:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86B32075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 20:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WicGHTIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86B32075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZLEm-0006Mo-Rk
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 15:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iZL9u-0005Ki-3R
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iZL9s-0000P1-0z
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:40:33 -0500
Received: from mout.gmx.net ([212.227.15.18]:51541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iZL9r-0000Lj-I6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 15:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574714428;
 bh=oelOXjborbYeqOkPwt2taoLRA8mnKXuLiNm0EvtIm50=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=WicGHTIwWzzUXjS1LDRLmuMeLogIOwVcezoZwVw2hGJgjyREIG2UxpIMBKecJQgyg
 FMT2PzZ2UZoy+miOgXBZmtPgAsMmvYQ4qWsI6qiwBU7Gtzbku+7QUeNslf+eS1l1/r
 mKpYbotQndzo3+spGCpvSFsh5v/edn+7NW/d3Eh8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.187.143]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1iO5gq3Tw7-00UWuD; Mon, 25
 Nov 2019 21:40:27 +0100
Subject: Re: [PATCH] linux-user: Improve strace output for read() and getcwd()
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20191121201448.GA3133@ls3530.fritz.box>
 <CAL1e-=ia9kmSUOztiGD=Mk4e8+r3oh2P3j_bAR2971FEGvAFyw@mail.gmail.com>
 <bc2a9dfb-cc5b-0916-38c7-6e07287b1080@gmx.de>
 <CAL1e-=h1Os3YK=c1oStG1c0fBhvp4XX-SqfRMo3U0oxjBsg9_A@mail.gmail.com>
 <e547f389-7281-4091-5bfb-a0aea265128d@gmx.de>
 <CAL1e-=ig8j+omFrdRGB1uf1mE8_9nJbt87=oAX3brbr34_cDMA@mail.gmail.com>
 <CAL1e-=hBvL0a8CDuD2Ok0U7vh8t0f-VQmi671OoudXnqLagFsg@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <d4815598-954b-4b4f-61cd-24611de04c56@gmx.de>
Date: Mon, 25 Nov 2019 21:40:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hBvL0a8CDuD2Ok0U7vh8t0f-VQmi671OoudXnqLagFsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pxhC8zSHFlLGIgnIqT7NzWr8DUq4nSYeyjVF1/Z/SGGjSkUnpoK
 tb79cC1I32MjvMggkXw4QtWxH/qW0ecLBoJXKLSr+EVBsj/odFm9S+bZhR513SzVot0gOXi
 F88/CUzmb2Y7tzoCvvDM9x17S+Zhm28dPz3e5QUHJfJztZtCIxaJXxnRcrpnh0zHl4zS8fA
 Tb+ZQhfmuGrydNc0l3+Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vFmwXZa9N44=:m6u29iv6jmRvz2Rtrgxu2K
 WKqMH4Or8ObkWUODMIEzrlNnVcHjFZkvDz33UfAkpwoQEi00jn0+9xPnCYtc8enUY7++XZB++
 t7aAVYAkN3/hx2TcUYlYdYXy/O688punX0SqbMrQpdWpIl32YLQu0xEmdAEZ1ChEL1X1o4qKr
 MFBZhGnFd3eZMer/ByEiVt/cl/94gRe83PmuJSDhx8/fjOjz2peuCO7XUMrjUtBn0klOykGpN
 B8wqtWb7l1qmt87hbKx2ssDxCpUv89K0mUed6G+Kzta5goQRMEFr1/NStb1Rr4c3VK6SznrZD
 6xV0cbQfdjCIyEl3YRZ3M7eKta8osjP5kZyy3eAtcM/7ENznSBMnXN/1B6iV1W8yb7FXp8Vow
 1Hs8/bSPzf8DZQSZJq1ORj8Snexl+AppMYGPpKFLc3ibxNErKZrrnpMGsMo9pxlC3UXpFGYj8
 FphyVeq/VZpySolTVScnw4nJuUIE9nvNuc82q37Pm/OZKymNQgrUcm8Ip5vxtHzOo/OJ15gyL
 Qooq22DB507i4Ojtv1ZGgMfbWQlIwXE8XyKNy6qyuksqVOs8iXSzkRzLqT8vnuNTUfj1W5oEI
 qL8fegCEWNg6Trwwd+FLC2y5IIpNWe+0WcZvpznE0GrUYCLdhn5Aqid+KB0A1rJU55pjDx/4N
 E45LZ0Quw+IH61qaqDxBDAbGG1Tn7xNhus41irG9mbg/V6BEzplqHWafX+IQQe6GuMK+RsCFh
 0ZApt9egLqp4xeZUClvQkANzyvbKVvRS349mavcgo0Fk35Qg1On15MCMiIT7V2eqgYeWmBiIh
 WAZiQxUYzjwMx1IKwJwHqyh9Nb8kl++bZUvwIdiyo5rR5q+IAgTsN5jPXSluxJz705g9GFmca
 QhVUT8tEGPr/OgLQhJt+pLUsyqM8aDlAxPxj7HtNP2yx7q2bU97xbrwFewCOKpzfd1imft815
 /481MwAF0YqdoxNf1maTiua97TzElkUBaRiscS6lptM4IXwNDp312r46CrMKPwtVe6YUY8EMZ
 R2XqeDptpBPZFCkMtfTZn6mOhsyc2LCS7twOZexw/9GOkf7OLkOrrGo4DX3BUQrPPgMxe5kDY
 BZpDzeJNCkdoyDOklcqVpnl0kG4GSwUxolf3yUk6JX5Se1ixEfnn+XXxL1tjnbvC3sT8fAJTG
 rpp61z1oQ7CrwR5v2lXddJJCs8tO0k0/BKHKsnzFte9EmeL9s/bhArpjE95Y+nuUbSdT++PPv
 XJbsJOcw5QksicOFd9z5W77+r0nqkwEw+sRb9+Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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

On 25.11.19 14:46, Aleksandar Markovic wrote:
> On Sun, Nov 24, 2019 at 2:31 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
>>
>>
>>
>> On Sunday, November 24, 2019, Helge Deller <deller@gmx.de> wrote:
>>>
>>> On 24.11.19 13:10, Aleksandar Markovic wrote:
>>>>
>>>>
>>>> On Sunday, November 24, 2019, Helge Deller <deller@gmx.de <mailto:del=
ler@gmx.de>> wrote:
>>>>
>>>>     On 23.11.19 12:34, Aleksandar Markovic wrote:
>>>>     > On Thursday, November 21, 2019, Helge Deller <deller@gmx.de <ma=
ilto:deller@gmx.de> <mailto:deller@gmx.de <mailto:deller@gmx.de>>> wrote:
>>>>     >
>>>>     >     The strace functionality in qemu-user lacks the possibility=
 to trace
>>>>     >     which real values get returned to pointers in userspace by =
syscalls.
>>>>     >
>>>>     >     For example, the read() and getcwd() syscalls currently onl=
y show the
>>>>     >     destination address where the syscalls should put the retur=
n values:
>>>>     >     2532 read(3,0xff80038c,512) =3D 512
>>>>     >     2532 getcwd(0x18180,4096) =3D 9
>>>>     >
>>>>     >     With the patch below, one now can specify in print_syscall_=
late() which
>>>>     >     syscalls should be executed first, before they get printed.
>>>>     >     After adding the read() and getcwd() syscalls, we now get t=
his output in
>>>>     >     with strace instead:
>>>>     >     1708 read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0=
\1\0\2bl\0\0\04"...,512) =3D 512
>>>>     >     1708 getcwd("/usr/bin",4096) =3D 9
>>>>     >
>>>>     >     This patch adds just the framework with the respective impl=
emenations for
>>>>     >     read() and getcwd(). If applied, more functions can be adde=
d easily later.
>>>>     >
>>>>     >
>>>>     > Great out-of-the-box idea! However, there are some things that =
are
>>>>     > not thought over yet. There is a good reason why strace happens
>>>>     > "early": if something crash-like happens during syscall transla=
tion,
>>>>     > we still have trace of original target syscall. In case of "lat=
e"
>>>>     > flavor, we don't have anything. Another potentially problematic
>>>>     > aspect is that end user certainly should know whether the trace=
 was
>>>>     > done "early" or "late" - otherwise, there will be, for certain,=
 cases
>>>>     > of misinterpretation / misleading / confusion of end users.
>>>>
>>>>     Thanks for the feedback - I'm shortly sending a v2 version which
>>>>     prints the syscall name with an open parenthesis, e.g. "read(" or=
 "getcwd(",
>>>>     before calling the syscall. That way you can see where it crashed=
/hangs...
>>>>
>>>>
>>>> ... but I cannot see passed arguments (for example, whether NULL is p=
assed, or somrthing that looks like a real address)...
>>>
>>> Right.
>>> And you won't see that in native strace either...
>>> If you have an idea, just let me know.
>>>
>>
>> Helge, I do have an idea how to amend your proposal that should give us=
, believe it or not, "best of both worlds", but let's wait few days, I don=
't have any dev setup ar hand at the moment to check it in action, and on =
top of that I am swamped with other unrelated tasks. In the meantime, mayb=
e other guys will say something too, or perhaps you would have something n=
ew as well.
>>
>> Still, by no means, I see this as a (potential) *huge* improvement of Q=
EMU strace. Thanks!
>>
>
> Helge, Laurent,
>
> I don't have time to experiment, but I will write down here my
> suggestion to extending Helge's system in a textual form, based on
> example from prevous Helge's patches:
>
> 1. CURRENT STATE:
>
> early: read(3,0xff80038c,512)
> late: =3D 512
>
> early: getcwd(0x18180,4096)
> late: =3D 9
>
> 2. HELGE'S PROPOSAL 1:
>
> late: read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0=
\04"...,512)
> =3D 512
> late: getcwd("/usr/bin",4096) =3D 9
>
> 3. HELGE'S PROPOSAL 2:
>
> early: read
> late: (3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04"=
...,512)
> =3D 512
> early: getcwd
> late: ("/usr/bin",4096) =3D 9

My v2 patch actually includes the opening parenthesis in the early part:
early: read(
late: 3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04"...=
,512) =3D 512

The open parenthesis should make it visible, that the call hasn't happened=
 yet.

> 4. NEW PROPOSAL :
>
> early: read(3,0xff80038c,512)
> late: =3D 512  [(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2=
bl\0\0\04"...,512)]
> early: getcwd(0x18180,4096)
> late: =3D 9  [("/usr/bin",4096)]
>
> In other words, we would print for (selected) system calls content of
> the parameters both before and after actual ioctl
> translation/execution.

I don't like this.
IMHO it just adds unnecessary noise and differs from what a native strace =
shows.

Helge


>>>>     >
>>>>     >     Signed-off-by: Helge Deller <deller@gmx.de <mailto:deller@g=
mx.de> <mailto:deller@gmx.de <mailto:deller@gmx.de>>>
>>>>     >
>>>>     >     diff --git a/linux-user/strace.c b/linux-user/strace.c
>>>>     >     index de43238fa4..ff254732af 100644
>>>>     >     --- a/linux-user/strace.c
>>>>     >     +++ b/linux-user/strace.c
>>>>     >     @@ -61,6 +61,7 @@ UNUSED static void print_open_flags(abi_l=
ong, int);
>>>>     >      UNUSED static void print_syscall_prologue(const struct sys=
callname *);
>>>>     >      UNUSED static void print_syscall_epilogue(const struct sys=
callname *);
>>>>     >      UNUSED static void print_string(abi_long, int);
>>>>     >     +UNUSED static void print_encoded_string(abi_long addr, uns=
igned int maxlen, int last);
>>>>     >      UNUSED static void print_buf(abi_long addr, abi_long len, =
int last);
>>>>     >      UNUSED static void print_raw_param(const char *, abi_long,=
 int);
>>>>     >      UNUSED static void print_timeval(abi_ulong, int);
>>>>     >     @@ -1204,6 +1205,37 @@ print_syscall_epilogue(const struct =
syscallname *sc)
>>>>     >          gemu_log(")");
>>>>     >      }
>>>>     >
>>>>     >     +#define MAX_ENCODED_CHARS 32
>>>>     >     +static void
>>>>     >     +print_encoded_string(abi_long addr, unsigned int maxlen, i=
nt last)
>>>>     >     +{
>>>>     >     +    unsigned int maxout;
>>>>     >     +    char *s, *str;
>>>>     >     +
>>>>     >     +    s =3D lock_user_string(addr);
>>>>     >     +    if (s =3D=3D NULL) {
>>>>     >     +        /* can't get string out of it, so print it as poin=
ter */
>>>>     >     +        print_pointer(addr, last);
>>>>     >     +        return;
>>>>     >     +    }
>>>>     >     +
>>>>     >     +    str =3D s;
>>>>     >     +    gemu_log("\"");
>>>>     >     +    maxout =3D MIN(maxlen, MAX_ENCODED_CHARS);
>>>>     >     +    while (maxout--) {
>>>>     >     +        unsigned char c =3D *str++;
>>>>     >     +        if (isprint(c)) {
>>>>     >     +            gemu_log("%c", c);
>>>>     >     +        } else {
>>>>     >     +            gemu_log("\\%o", (unsigned int) c);
>>>>     >     +        }
>>>>     >     +    }
>>>>     >     +    unlock_user(s, addr, 0);
>>>>     >     +
>>>>     >     +    gemu_log("\"%s%s", maxlen > MAX_ENCODED_CHARS ? "..." =
: "",
>>>>     >     +                    get_comma(last));
>>>>     >     +}
>>>>     >     +
>>>>     >      static void
>>>>     >      print_string(abi_long addr, int last)
>>>>     >      {
>>>>     >     @@ -1633,6 +1665,19 @@ print_futimesat(const struct syscall=
name *name,
>>>>     >      }
>>>>     >      #endif
>>>>     >
>>>>     >     +#ifdef TARGET_NR_getcwd
>>>>     >     +static void
>>>>     >     +print_getcwd(const struct syscallname *name,
>>>>     >     +    abi_long arg0, abi_long arg1, abi_long arg2,
>>>>     >     +    abi_long arg3, abi_long arg4, abi_long arg5)
>>>>     >     +{
>>>>     >     +    print_syscall_prologue(name);
>>>>     >     +    print_string(arg0, 0);
>>>>     >     +    print_raw_param("%u", arg1, 1);
>>>>     >     +    print_syscall_epilogue(name);
>>>>     >     +}
>>>>     >     +#endif
>>>>     >     +
>>>>     >      #ifdef TARGET_NR_settimeofday
>>>>     >      static void
>>>>     >      print_settimeofday(const struct syscallname *name,
>>>>     >     @@ -2428,6 +2473,20 @@ print_fstatat64(const struct syscall=
name *name,
>>>>     >      #define print_newfstatat    print_fstatat64
>>>>     >      #endif
>>>>     >
>>>>     >     +#ifdef TARGET_NR_read
>>>>     >     +static void
>>>>     >     +print_read(const struct syscallname *name,
>>>>     >     +    abi_long arg0, abi_long arg1, abi_long arg2,
>>>>     >     +    abi_long arg3, abi_long arg4, abi_long arg5)
>>>>     >     +{
>>>>     >     +    print_syscall_prologue(name);
>>>>     >     +    print_raw_param("%d", arg0, 0);
>>>>     >     +    print_encoded_string(arg1, arg2, 0);
>>>>     >     +    print_raw_param("%u", arg2, 1);
>>>>     >     +    print_syscall_epilogue(name);
>>>>     >     +}
>>>>     >     +#endif
>>>>     >     +
>>>>     >      #ifdef TARGET_NR_readlink
>>>>     >      static void
>>>>     >      print_readlink(const struct syscallname *name,
>>>>     >     diff --git a/linux-user/strace.list b/linux-user/strace.lis=
t
>>>>     >     index d49a1e92a8..220b1f4c46 100644
>>>>     >     --- a/linux-user/strace.list
>>>>     >     +++ b/linux-user/strace.list
>>>>     >     @@ -272,7 +272,7 @@
>>>>     >      { TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)", NULL, NULL },
>>>>     >      #endif
>>>>     >      #ifdef TARGET_NR_getcwd
>>>>     >     -{ TARGET_NR_getcwd, "getcwd" , "%s(%p,%d)", NULL, NULL },
>>>>     >     +{ TARGET_NR_getcwd, "getcwd" , NULL, print_getcwd, NULL },
>>>>     >      #endif
>>>>     >      #ifdef TARGET_NR_getdents
>>>>     >      { TARGET_NR_getdents, "getdents" , NULL, NULL, NULL },
>>>>     >     @@ -1080,7 +1080,7 @@
>>>>     >      { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
>>>>     >      #endif
>>>>     >      #ifdef TARGET_NR_read
>>>>     >     -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
>>>>     >     +{ TARGET_NR_read, "read" , NULL, print_read, NULL },
>>>>     >      #endif
>>>>     >      #ifdef TARGET_NR_readahead
>>>>     >      { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
>>>>     >     diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>>     >     index ce399a55f0..c0079ca2b7 100644
>>>>     >     --- a/linux-user/syscall.c
>>>>     >     +++ b/linux-user/syscall.c
>>>>     >     @@ -12069,6 +12069,21 @@ static abi_long do_syscall1(void *=
cpu_env, int num, abi_long arg1,
>>>>     >          return ret;
>>>>     >      }
>>>>     >
>>>>     >     +/*
>>>>     >     + * True if this syscall should be printed after having cal=
led the native
>>>>     >     + * syscall, so that values which are fed back to userspace=
 gets printed.
>>>>     >     + */
>>>>     >     +static int print_syscall_late(int syscall)
>>>>     >     +{
>>>>     >     +    switch (syscall) {
>>>>     >     +    case TARGET_NR_getcwd:
>>>>     >     +    case TARGET_NR_read:
>>>>     >     +        return 1;
>>>>     >     +    default:
>>>>     >     +        return 0;
>>>>     >     +    }
>>>>     >     +}
>>>>     >     +
>>>>     >      abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>>>>     >                          abi_long arg2, abi_long arg3, abi_long=
 arg4,
>>>>     >                          abi_long arg5, abi_long arg6, abi_long=
 arg7,
>>>>     >     @@ -12095,9 +12110,16 @@ abi_long do_syscall(void *cpu_env,=
 int num, abi_long arg1,
>>>>     >                               arg2, arg3, arg4, arg5, arg6, arg=
7, arg8);
>>>>     >
>>>>     >          if (unlikely(do_strace)) {
>>>>     >     -        print_syscall(num, arg1, arg2, arg3, arg4, arg5, a=
rg6);
>>>>     >     +        int late_printing;
>>>>     >     +        late_printing =3D print_syscall_late(num);
>>>>     >     +        if (!late_printing) {
>>>>     >     +            print_syscall(num, arg1, arg2, arg3, arg4, arg=
5, arg6);
>>>>     >     +        }
>>>>     >              ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3=
, arg4,
>>>>     >                                arg5, arg6, arg7, arg8);
>>>>     >     +        if (late_printing) {
>>>>     >     +            print_syscall(num, arg1, arg2, arg3, arg4, arg=
5, arg6);
>>>>     >     +        }
>>>>     >              print_syscall_ret(num, ret);
>>>>     >          } else {
>>>>     >              ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3=
, arg4,
>>>>     >
>>>>
>>>


