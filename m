Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AD3C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 13:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B632073F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 13:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="k060qCMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B632073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYrdE-00065X-3K
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 08:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iYrZU-0005Q2-R5
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 08:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iYrZR-0007u4-Dv
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 08:05:00 -0500
Received: from mout.gmx.net ([212.227.15.19]:49355)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iYrZR-0007ra-2f
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 08:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1574600694;
 bh=V3LM8dp9xAjQJQ9/+fwjzU8hCm+3qYZrh9I5ivUyac8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=k060qCMbSG0h3gLDuOIx1yRTO3xV3LSTocwyCqvv3PCuQBRjZotNcXv5XhnXzqWwQ
 ZsVr7viNfY7v/bKTVAMgM184WfTIB5+qYcKZ+QM54pinXcfmYWkm9/nyDHOhNNh+6U
 e/9UF8LTe5IW2kFhtOrqa+0lD2ex55qZnyhHrqjE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.140.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvvT-1huXwB2IQP-00hQiF; Sun, 24
 Nov 2019 14:04:54 +0100
Subject: Re: [PATCH] linux-user: Improve strace output for read() and getcwd()
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191121201448.GA3133@ls3530.fritz.box>
 <CAL1e-=ia9kmSUOztiGD=Mk4e8+r3oh2P3j_bAR2971FEGvAFyw@mail.gmail.com>
 <bc2a9dfb-cc5b-0916-38c7-6e07287b1080@gmx.de>
 <CAL1e-=h1Os3YK=c1oStG1c0fBhvp4XX-SqfRMo3U0oxjBsg9_A@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <e547f389-7281-4091-5bfb-a0aea265128d@gmx.de>
Date: Sun, 24 Nov 2019 14:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=h1Os3YK=c1oStG1c0fBhvp4XX-SqfRMo3U0oxjBsg9_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5pWxZWQRNNqECw7Wb5dK9hVMe2dWGfRVZ8R3oYmjQlB18O+PDD0
 XCv4RCwLzHDhEalTW7OokYScEu9nRO5uA3KNUM+rcTXVv9e36p5ZDRJFPeMnj0/lHshrJjy
 7QgK58IohDvYwJpHE7YgvhYgAPVsru9TzQYNhf2NdLXD+e8T39vhKBHE/VcLO+H1W2O81MA
 nfSZbbAWCs2v73YR6fTPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7rPOoLUIwA0=:FpgOCdxnUDNWjZL/mONd9W
 +UxHtT2QEATkgoCtKpBBQvG7eJuMh6KSvnddQA8EATFLn6d2Qk0CDcmfuUH3r2281Rju5mcDs
 BSvbgEHdtJpkoIbvY3lCMT/W57CapOMA9mxk1Lho66p4pA7TrxChXhtcve8VdkRpjAziST7Eo
 XDFT/vt87Q8xw86+OWzsSpolzPBn0ouspCbrxJo8Rr09f3Rx6AgmCw5b7JfyVV0pS2PyNlsdU
 W38vZLiemHZJG5ifQroTfOg5qgXWyTU8l8O4ix0jFF/qim9ayY3KOyw/3pQ67o12CUUDGZ60O
 2O+JCkoqQX75S9uV89ElK6NDYepXan4K/0SB1EBuo7yLGu4tub/rjmj/A8PImeYKXyIZt1WTL
 VmW3e6f6K9wXoAW1NhYqO+1etEu7hLwYTlQSMjg8rhDVa492XXyuNC+++x4TerXN1EL6VdfbK
 FOH852scTQyCy6lj7L8+1UVWAeTBykP72wGVF8Reu4YQjO2v79zARjUiS0DAE4zYe0wuJo5d7
 o0dwXu86FfrlBi/u7A4PdRnNjmawgZ+TskLGNsWfnIk8lf8wahD71c/OaCTuuAcah4NMSOcXX
 cbSWV4GFx9DFTmplzr+UWblDd+s9vf7DhPlwUt2j5TRPXqBEcSTTjLPyuyXrmYHah5lcJtCoJ
 HQgQbWnTfcz9u+CPItmzhFzagb6iL8txaxheUSDZ0Na6RqwcVs0edjmaPd/9cC4x52/HSy/dB
 v5I/8pPwnhxRxr2iOZuSb3+bJei4DjaHo2fXMEZLMcw6hDJ1dZFBfhZc7O5jhDx4xf5xzp3e0
 OYVoK0cW52kaCX5Og1ibEsh4mCNkLeIez17WgYlrwV53ml53tTEGdC3DQJ+hSphc4AsFsU8wG
 o7b+kKnGXeKiFStkm8WPMT7EJJkRF1+vgaYeVZLbV5K3I6bGRsMAEcnFaNgqfKOj8Jozinbt0
 w5pAUYBVR1XdpBeOmRLEs3mcSV7nTh4voYWvvT7CqwFZMpxGBzXUTD3Y4VOEjKrea4TGfp0mr
 kOz9ChRfAFWDXKxnlHIg3vo2bXmPU5og5EeUibOe2/lF308ncgBSXVYXDs7CCCb1FSkvbbwE+
 RLTfstdHq11Koa4Hz47Sdj73tHRFqVkg17tiT8T7oRoTjw/nXyVnHRAi0sS5srT+SSJnfCTkp
 kZHy10zqwzwybm7Im8+FlZlL17tZbj+Y/m/+3xZ4whV8qIMxbJvhMEVLxiaq4hA6UzVcSv1FO
 xIeUR2cQCIWZt8YOiye/k+38WcYm3l98QvGatWA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.19
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

On 24.11.19 13:10, Aleksandar Markovic wrote:
>
>
> On Sunday, November 24, 2019, Helge Deller <deller@gmx.de <mailto:deller=
@gmx.de>> wrote:
>
>     On 23.11.19 12:34, Aleksandar Markovic wrote:
>     > On Thursday, November 21, 2019, Helge Deller <deller@gmx.de <mailt=
o:deller@gmx.de> <mailto:deller@gmx.de <mailto:deller@gmx.de>>> wrote:
>     >
>     >=C2=A0 =C2=A0 =C2=A0The strace functionality in qemu-user lacks the=
 possibility to trace
>     >=C2=A0 =C2=A0 =C2=A0which real values get returned to pointers in u=
serspace by syscalls.
>     >
>     >=C2=A0 =C2=A0 =C2=A0For example, the read() and getcwd() syscalls c=
urrently only show the
>     >=C2=A0 =C2=A0 =C2=A0destination address where the syscalls should p=
ut the return values:
>     >=C2=A0 =C2=A0 =C2=A02532 read(3,0xff80038c,512) =3D 512
>     >=C2=A0 =C2=A0 =C2=A02532 getcwd(0x18180,4096) =3D 9
>     >
>     >=C2=A0 =C2=A0 =C2=A0With the patch below, one now can specify in pr=
int_syscall_late() which
>     >=C2=A0 =C2=A0 =C2=A0syscalls should be executed first, before they =
get printed.
>     >=C2=A0 =C2=A0 =C2=A0After adding the read() and getcwd() syscalls, =
we now get this output in
>     >=C2=A0 =C2=A0 =C2=A0with strace instead:
>     >=C2=A0 =C2=A0 =C2=A01708 read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\=
3\0\17\0\0\0\1\0\2bl\0\0\04"...,512) =3D 512
>     >=C2=A0 =C2=A0 =C2=A01708 getcwd("/usr/bin",4096) =3D 9
>     >
>     >=C2=A0 =C2=A0 =C2=A0This patch adds just the framework with the res=
pective implemenations for
>     >=C2=A0 =C2=A0 =C2=A0read() and getcwd(). If applied, more functions=
 can be added easily later.
>     >
>     >
>     > Great out-of-the-box idea! However, there are some things that are
>     > not thought over yet. There is a good reason why strace happens
>     > "early": if something crash-like happens during syscall translatio=
n,
>     > we still have trace of original target syscall. In case of "late"
>     > flavor, we don't have anything. Another potentially problematic
>     > aspect is that end user certainly should know whether the trace wa=
s
>     > done "early" or "late" - otherwise, there will be, for certain, ca=
ses
>     > of misinterpretation / misleading / confusion of end users.
>
>     Thanks for the feedback - I'm shortly sending a v2 version which
>     prints the syscall name with an open parenthesis, e.g. "read(" or "g=
etcwd(",
>     before calling the syscall. That way you can see where it crashed/ha=
ngs...
>
>
> ... but I cannot see passed arguments (for example, whether NULL is pass=
ed, or somrthing that looks like a real address)...

Right.
And you won't see that in native strace either...
If you have an idea, just let me know.

Helge

>
> =C2=A0
>
>     Helge
>
>     >
>     > Yours,
>     > Aleksandar
>     >
>     >
>     > =C2=A0
>     >
>     >=C2=A0 =C2=A0 =C2=A0Signed-off-by: Helge Deller <deller@gmx.de <mai=
lto:deller@gmx.de> <mailto:deller@gmx.de <mailto:deller@gmx.de>>>
>     >
>     >=C2=A0 =C2=A0 =C2=A0diff --git a/linux-user/strace.c b/linux-user/s=
trace.c
>     >=C2=A0 =C2=A0 =C2=A0index de43238fa4..ff254732af 100644
>     >=C2=A0 =C2=A0 =C2=A0--- a/linux-user/strace.c
>     >=C2=A0 =C2=A0 =C2=A0+++ b/linux-user/strace.c
>     >=C2=A0 =C2=A0 =C2=A0@@ -61,6 +61,7 @@ UNUSED static void print_open=
_flags(abi_long, int);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_syscall_prologue=
(const struct syscallname *);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_syscall_epilogue=
(const struct syscallname *);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_string(abi_long,=
 int);
>     >=C2=A0 =C2=A0 =C2=A0+UNUSED static void print_encoded_string(abi_lo=
ng addr, unsigned int maxlen, int last);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_buf(abi_long add=
r, abi_long len, int last);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_raw_param(const =
char *, abi_long, int);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0UNUSED static void print_timeval(abi_ulon=
g, int);
>     >=C2=A0 =C2=A0 =C2=A0@@ -1204,6 +1205,37 @@ print_syscall_epilogue(c=
onst struct syscallname *sc)
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0gemu_log(")");
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0}
>     >
>     >=C2=A0 =C2=A0 =C2=A0+#define MAX_ENCODED_CHARS 32
>     >=C2=A0 =C2=A0 =C2=A0+static void
>     >=C2=A0 =C2=A0 =C2=A0+print_encoded_string(abi_long addr, unsigned i=
nt maxlen, int last)
>     >=C2=A0 =C2=A0 =C2=A0+{
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 unsigned int maxout;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 char *s, *str;
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 s =3D lock_user_string(addr);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s =3D=3D NULL) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* can't get strin=
g out of it, so print it as pointer */
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(addr=
, last);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 str =3D s;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 gemu_log("\"");
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 maxout =3D MIN(maxlen, MAX_ENCOD=
ED_CHARS);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 while (maxout--) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char c =
=3D *str++;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isprint(c)) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu=
_log("%c", c);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gemu=
_log("\\%o", (unsigned int) c);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 unlock_user(s, addr, 0);
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 gemu_log("\"%s%s", maxlen > MAX_=
ENCODED_CHARS ? "..." : "",
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 get_comma(last));
>     >=C2=A0 =C2=A0 =C2=A0+}
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0static void
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0print_string(abi_long addr, int last)
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0{
>     >=C2=A0 =C2=A0 =C2=A0@@ -1633,6 +1665,19 @@ print_futimesat(const st=
ruct syscallname *name,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0}
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#endif
>     >
>     >=C2=A0 =C2=A0 =C2=A0+#ifdef TARGET_NR_getcwd
>     >=C2=A0 =C2=A0 =C2=A0+static void
>     >=C2=A0 =C2=A0 =C2=A0+print_getcwd(const struct syscallname *name,
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 abi_long arg0, abi_long arg1, ab=
i_long arg2,
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 abi_long arg3, abi_long arg4, ab=
i_long arg5)
>     >=C2=A0 =C2=A0 =C2=A0+{
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_syscall_prologue(name);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_string(arg0, 0);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_raw_param("%u", arg1, 1);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_syscall_epilogue(name);
>     >=C2=A0 =C2=A0 =C2=A0+}
>     >=C2=A0 =C2=A0 =C2=A0+#endif
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_settimeofday
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0static void
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0print_settimeofday(const struct syscallna=
me *name,
>     >=C2=A0 =C2=A0 =C2=A0@@ -2428,6 +2473,20 @@ print_fstatat64(const st=
ruct syscallname *name,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#define print_newfstatat=C2=A0 =C2=A0 pri=
nt_fstatat64
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#endif
>     >
>     >=C2=A0 =C2=A0 =C2=A0+#ifdef TARGET_NR_read
>     >=C2=A0 =C2=A0 =C2=A0+static void
>     >=C2=A0 =C2=A0 =C2=A0+print_read(const struct syscallname *name,
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 abi_long arg0, abi_long arg1, ab=
i_long arg2,
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 abi_long arg3, abi_long arg4, ab=
i_long arg5)
>     >=C2=A0 =C2=A0 =C2=A0+{
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_syscall_prologue(name);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_raw_param("%d", arg0, 0);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_encoded_string(arg1, arg2,=
 0);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_raw_param("%u", arg2, 1);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 print_syscall_epilogue(name);
>     >=C2=A0 =C2=A0 =C2=A0+}
>     >=C2=A0 =C2=A0 =C2=A0+#endif
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_readlink
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0static void
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0print_readlink(const struct syscallname *=
name,
>     >=C2=A0 =C2=A0 =C2=A0diff --git a/linux-user/strace.list b/linux-use=
r/strace.list
>     >=C2=A0 =C2=A0 =C2=A0index d49a1e92a8..220b1f4c46 100644
>     >=C2=A0 =C2=A0 =C2=A0--- a/linux-user/strace.list
>     >=C2=A0 =C2=A0 =C2=A0+++ b/linux-user/strace.list
>     >=C2=A0 =C2=A0 =C2=A0@@ -272,7 +272,7 @@
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0{ TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)=
", NULL, NULL },
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#endif
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_getcwd
>     >=C2=A0 =C2=A0 =C2=A0-{ TARGET_NR_getcwd, "getcwd" , "%s(%p,%d)", NU=
LL, NULL },
>     >=C2=A0 =C2=A0 =C2=A0+{ TARGET_NR_getcwd, "getcwd" , NULL, print_get=
cwd, NULL },
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#endif
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_getdents
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0{ TARGET_NR_getdents, "getdents" , NULL, =
NULL, NULL },
>     >=C2=A0 =C2=A0 =C2=A0@@ -1080,7 +1080,7 @@
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0{ TARGET_NR_quotactl, "quotactl" , NULL, =
NULL, NULL },
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#endif
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_read
>     >=C2=A0 =C2=A0 =C2=A0-{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NU=
LL, NULL },
>     >=C2=A0 =C2=A0 =C2=A0+{ TARGET_NR_read, "read" , NULL, print_read, N=
ULL },
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#endif
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef TARGET_NR_readahead
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0{ TARGET_NR_readahead, "readahead" , NULL=
, NULL, NULL },
>     >=C2=A0 =C2=A0 =C2=A0diff --git a/linux-user/syscall.c b/linux-user/=
syscall.c
>     >=C2=A0 =C2=A0 =C2=A0index ce399a55f0..c0079ca2b7 100644
>     >=C2=A0 =C2=A0 =C2=A0--- a/linux-user/syscall.c
>     >=C2=A0 =C2=A0 =C2=A0+++ b/linux-user/syscall.c
>     >=C2=A0 =C2=A0 =C2=A0@@ -12069,6 +12069,21 @@ static abi_long do_sys=
call1(void *cpu_env, int num, abi_long arg1,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0return ret;
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0}
>     >
>     >=C2=A0 =C2=A0 =C2=A0+/*
>     >=C2=A0 =C2=A0 =C2=A0+ * True if this syscall should be printed afte=
r having called the native
>     >=C2=A0 =C2=A0 =C2=A0+ * syscall, so that values which are fed back =
to userspace gets printed.
>     >=C2=A0 =C2=A0 =C2=A0+ */
>     >=C2=A0 =C2=A0 =C2=A0+static int print_syscall_late(int syscall)
>     >=C2=A0 =C2=A0 =C2=A0+{
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 switch (syscall) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 case TARGET_NR_getcwd:
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 case TARGET_NR_read:
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 default:
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0+}
>     >=C2=A0 =C2=A0 =C2=A0+
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0abi_long do_syscall(void *cpu_env, int nu=
m, abi_long arg1,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_long arg2, abi_long arg3, abi_long arg4=
,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_long arg5, abi_long arg6, abi_long arg7=
,
>     >=C2=A0 =C2=A0 =C2=A0@@ -12095,9 +12110,16 @@ abi_long do_syscall(vo=
id *cpu_env, int num, abi_long arg1,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arg2, arg3, arg4, arg5, arg6=
, arg7, arg8);
>     >
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (unlikely(do_strace)) {
>     >=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 print_syscall(num,=
 arg1, arg2, arg3, arg4, arg5, arg6);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int late_printing;
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 late_printing =3D =
print_syscall_late(num);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!late_printing=
) {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prin=
t_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_sy=
scall1(cpu_env, num, arg1, arg2, arg3, arg4,
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg5, arg6, arg7, arg8=
);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (late_printing)=
 {
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prin=
t_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>     >=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_syscall=
_ret(num, ret);
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0} else {
>     >=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D do_sy=
scall1(cpu_env, num, arg1, arg2, arg3, arg4,
>     >
>


