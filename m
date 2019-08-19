Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C23C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D772E2082C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qW8zxANk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D772E2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhyY-0002NQ-D6
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hzhx8-0001SL-Dh
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hzhx5-0002Mh-Ta
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:44:06 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:42248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hzhx5-0002M9-Gn; Mon, 19 Aug 2019 09:44:03 -0400
Received: by mail-oi1-x22f.google.com with SMTP id o6so1305732oic.9;
 Mon, 19 Aug 2019 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yEIg4sZeE2rmjyAamDhFgL2XgQStKw3yhEchrtK0x54=;
 b=qW8zxANkpb22fJaG8aUiOhhEZeQH3AAHj+9854X2RRTX+eGH1XHscLrEK4raS7sucM
 japXwEqJRLhekbwgnuzzs8PYclDoL6maMDYrEuu3NONzD3DS/cKuuz8MXnQTvCUG1Uej
 /iS/9Np4xHjPx6VVEy84FKviYZUE2cnATU/VrMvSbtF4+NZ0ihe9pMDUHQUbFveSieq9
 +d4/en1s9mcPQNSBJ5kfC0q0EOt5CzoLE2MwhpDe3FRueZQwYLhrJbwbzVwlWTERn3Xl
 M/ZUCGbyO4dksMNUYKOpdDD3S0qjv7VW416P0fi2ggj4eNc0rfrTqMDw5pYZHckeSQIs
 8SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yEIg4sZeE2rmjyAamDhFgL2XgQStKw3yhEchrtK0x54=;
 b=Pf7CjBtdNoZCcCVX8dh76VQC+Ck0Nqvj7Qz4Fa2Y0ovT6OcH9zHn3mwJO07lDEwWW0
 xN02PWd2es92IumuwlwZGROj25zg8LlbUW+JgJ/OvWiAgs9pYOWG5QRNH6Chq9OyJick
 KuYsBsgItFL4Az1DPL8biwfMRibwbrQQ0wezDC6Ta/gi9Mrezh3UL6JLlgdTMdVwD3RU
 O0It8mzlXrP92hGLtB9R/GgupBfYQELFxMjwEHVj/QvQjqRFlrfVqlHyov/AcjEY8fX5
 Qf+NGzaYUjb4bqVek03jCbwf1PF55gJso1BbXypoOt79mGhaA7qo4cm3W7ZcCk3g5crC
 DkoQ==
X-Gm-Message-State: APjAAAXPylLmepXigoF/ccp9GmtsUn3adKwvwPYNLiAmpq8D4DBAW3r+
 R044P/3rfp0NUkFIP4fIaaRjSwbLdGwHcGeku5Q=
X-Google-Smtp-Source: APXvYqxsq83r2OzXf4mrlWYXUw8ICTTZbxsZTqnEyuiJiGBiPyGXmP/BFteSNzt+zO1zYYbiW9Q4eRU0mZGUwNCQr0w=
X-Received: by 2002:aca:4083:: with SMTP id n125mr7282540oia.106.1566222242652; 
 Mon, 19 Aug 2019 06:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <8fb538f3-dfdd-b427-727a-2e7c2120da09@gmail.com>
 <20e800e8-846b-a9c3-f840-826238b0818f@redhat.com>
 <CAFEAcA9xbPGSezS60cg6WzqpDR1u38aE0bXL_6pLs+H1TK3Ddw@mail.gmail.com>
 <dff44ac1-10e7-285e-467d-8dfe8c7a469b@redhat.com>
 <CAL1e-=hD03RDSHhaBK1BVScKSRsrkXy-dJCvUFzfpJCbYSVe9w@mail.gmail.com>
In-Reply-To: <CAL1e-=hD03RDSHhaBK1BVScKSRsrkXy-dJCvUFzfpJCbYSVe9w@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 19 Aug 2019 15:43:51 +0200
Message-ID: <CAL1e-=jT4r79st+oqR=Zc_Fh62Tp31iUZSX7DLjy0fnysEvy1A@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000069d9a805907888b3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [qemu-s390x] linux-user: s390x issue on Fedora 30
 (dynamic library loader?)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000069d9a805907888b3
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 19, 2019 at 3:34 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> Hi, David.
>
> I can't repro the problem either, but I do have a patch authored by an
> engineer that left the company a while ago that seems to be at least
> related to your scenario. May I ask you to test it (just apply it to QEMU
> ToT and rerun the scenario to see if it changes the outcome) (feel free to
> experiment and modify the changes)? I never managed to understand the
> purpose of that patch (I lost the contact with the former engineer, and the
> patch is without any comment), so I never dared to send it to the list, but
> I hope your scenario may actually explain the purpose and the origin of the
> patch.
>
> I am attaching the patch both as a file and inline.
>
>
In the patch I had sent in my previous mail, TARGET_ENONET should be
replaced by TARGET_ENOENT. I made a mistake while doing speedy rebasing.
Though, both ENONET and ENOENT compile, and perhaps the error code value is
not crucial. I am attaching the updated/corrected patch.

Aleksandar


> Yours,
> Aleksandar
>
>
> From 377f99e807f4aa42ece9f0cd437f50af11611b4c Mon Sep 17 00:00:00 2001
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> Date: Mon, 19 Aug 2019 15:20:29 +0200
> Subject: [PATCH] linux-user: Special case /etc/ld.cache.so and pretend it
> does
>  not exist
>
> Prevent target executables from opening host ld.so.cache.
> ---
>  linux-user/syscall.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb1..f5bae6e 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8820,6 +8820,10 @@ static abi_long do_syscall1(void *cpu_env, int num,
> abi_long arg1,
>          if (!(p = lock_user_string(arg1))) {
>              return -TARGET_EFAULT;
>          }
> +        if (strcmp("/etc/ld.so.cache", path(p)) == 0) {
> +            unlock_user(p, arg1, 0);
> +            return -TARGET_ENONET;
> +        }
>          ret = get_errno(statfs(path(p), &stfs));
>          unlock_user(p, arg1, 0);
>      convert_statfs:
> @@ -8859,6 +8863,10 @@ static abi_long do_syscall1(void *cpu_env, int num,
> abi_long arg1,
>          if (!(p = lock_user_string(arg1))) {
>              return -TARGET_EFAULT;
>          }
> +        if (strcmp("/etc/ld.so.cache", path(p)) == 0) {
> +            unlock_user(p, arg1, 0);
> +            return -TARGET_ENONET;
> +        }
>          ret = get_errno(statfs(path(p), &stfs));
>          unlock_user(p, arg1, 0);
>      convert_statfs64:
> @@ -9059,6 +9067,10 @@ static abi_long do_syscall1(void *cpu_env, int num,
> abi_long arg1,
>          if (!(p = lock_user_string(arg1))) {
>              return -TARGET_EFAULT;
>          }
> +        if (strcmp("/etc/ld.so.cache", path(p)) == 0) {
> +            unlock_user(p, arg1, 0);
> +            return -TARGET_ENONET;
> +        }
>          ret = get_errno(stat(path(p), &st));
>          unlock_user(p, arg1, 0);
>          goto do_stat;
> @@ -9068,6 +9080,10 @@ static abi_long do_syscall1(void *cpu_env, int num,
> abi_long arg1,
>          if (!(p = lock_user_string(arg1))) {
>              return -TARGET_EFAULT;
>          }
> +        if (strcmp("/etc/ld.so.cache", path(p)) == 0) {
> +            unlock_user(p, arg1, 0);
> +            return -TARGET_ENONET;
> +        }
>          ret = get_errno(lstat(path(p), &st));
>          unlock_user(p, arg1, 0);
>          goto do_stat;
> @@ -10268,6 +10284,10 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          if (!(p = lock_user_string(arg1))) {
>              return -TARGET_EFAULT;
>          }
> +        if (strcmp("/etc/ld.so.cache", path(p)) == 0) {
> +            unlock_user(p, arg1, 0);
> +            return -TARGET_ENONET;
> +        }
>          ret = get_errno(stat(path(p), &st));
>          unlock_user(p, arg1, 0);
>          if (!is_error(ret))
> @@ -10279,6 +10299,10 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          if (!(p = lock_user_string(arg1))) {
>              return -TARGET_EFAULT;
>          }
> +        if (strcmp("/etc/ld.so.cache", path(p)) == 0) {
> +            unlock_user(p, arg1, 0);
> +            return -TARGET_ENONET;
> +        }
>          ret = get_errno(lstat(path(p), &st));
>          unlock_user(p, arg1, 0);
>          if (!is_error(ret))
> @@ -10319,6 +10343,10 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>              if (p == NULL) {
>                  return -TARGET_EFAULT;
>              }
> +            if (strcmp("/etc/ld.so.cache", path(p)) == 0) {
> +                unlock_user(p, arg1, 0);
> +                return -TARGET_ENONET;
> +            }
>  #if defined(__NR_statx)
>              {
>                  /*
> --
> 2.7.4
>
>
> On Mon, Aug 19, 2019 at 3:08 PM David Hildenbrand <david@redhat.com>
> wrote:
>
>> On 19.08.19 14:11, Peter Maydell wrote:
>> > On Sat, 17 Aug 2019 at 17:14, David Hildenbrand <david@redhat.com>
>> wrote:
>> >>
>> >> On 17.08.19 17:59, David Hildenbrand wrote:
>> >>> Hi everybody,
>> >>>
>> >>> I was just trying to run qemu-s390x (linux-user) with a very simple
>> >>> binary (gzip + lib/ld64.so.1, compiled under Fedora 27). This used to
>> >>> work just fine a while ago (especially when I was working on vector
>> >>> instructions using QEMU v3.1). However, now I can't get past a
>> SEGFAULT
>> >>> in the dynamic library loader (I assume it is trying to locate
>> glibc). I
>> >>> tried a couple of other binaries that definitely used to work (from
>> >>> Fedora 30).
>> >>>
>> >>> I checked QEMU v4.1, v4.0 and v3.1. All are broken for me. Which is
>> >>> weird - because it used to work :/
>> >>>
>> >>> I remember that I was running Fedora 29 the last time I had it
>> running,
>> >>> so my gut feeling is that this is related to some other system library
>> >>> (but which?). I am running on an up-to-date Fedora 30 x86-64 now.
>> >>>
>> >>> Any ideas? Has this been reported already? (not sure if this is a
>> Fedora
>> >>> 30 issue)
>> >
>> > I'm pretty sure the problem you've run into is a long standing
>> > bug in the glibc dynamic loader. It cannot cope with the ld.so.cache
>> > being for the wrong endianness. (Correct endianness but incorrect
>> > architecture it correctly detects and ignores). The result is that
>> > running a linux-user QEMU dynamic binary for big-endian on little-endian
>> > like this will crash in the dynamic loader unless you arrange that it
>> can't
>> > find the host's ld.so.cache somehow, eg:
>> >  (a) run inside a chroot
>> >  (b) create an empty /etc/ld.so.cache file inside the -L directory
>> >
>> > The ideal fix would be if somebody cared enough to track down
>> > and fix the ld.so bug.
>> >
>> > Compare:
>> > https://bugs.launchpad.net/qemu/+bug/1701798
>> > https://bugs.launchpad.net/qemu/+bug/1835693
>> >
>> > thanks
>> > -- PMM
>> >
>>
>> Thanks, running
>>
>> "ldconfig -c etc/ld.so.cache -r ."
>>
>> Seems to fix the issue for me. So you are sure the bug resides in glic
>> and not in the qemu-user pieces of the library loader?
>>
>> --
>>
>> Thanks,
>>
>> David / dhildenb
>>
>>

--00000000000069d9a805907888b3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-linux-user-Special-case-etc-ld.cache.so-and-pretend-.patch"
Content-Disposition: attachment; 
	filename="0001-linux-user-Special-case-etc-ld.cache.so-and-pretend-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jzig90d30>
X-Attachment-Id: f_jzig90d30

RnJvbSA2MTQ2NDUzZWNiYmVjYTI2ZTY0YTZlZDZhYTg2YjM1OTAzMmQzMmJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGVrc2FuZGFyIE1hcmtvdmljIDxhbWFya292aWNAd2F2ZWNv
bXAuY29tPgpEYXRlOiBNb24sIDE5IEF1ZyAyMDE5IDE1OjIwOjI5ICswMjAwClN1YmplY3Q6IFtQ
QVRDSF0gbGludXgtdXNlcjogU3BlY2lhbCBjYXNlIC9ldGMvbGQuY2FjaGUuc28gYW5kIHByZXRl
bmQgaXQgZG9lcwogbm90IGV4aXN0CgpQcmV2ZW50IHRhcmdldCBleGVjdXRhYmxlcyBmcm9tIG9w
ZW5pbmcgaG9zdCBsZC5zby5jYWNoZS4KLS0tCiBsaW51eC11c2VyL3N5c2NhbGwuYyB8IDI4ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9zeXNjYWxsLmMgYi9saW51eC11c2VyL3N5c2Nh
bGwuYwppbmRleCA4MzY3Y2IxLi45ODNjNmU3IDEwMDY0NAotLS0gYS9saW51eC11c2VyL3N5c2Nh
bGwuYworKysgYi9saW51eC11c2VyL3N5c2NhbGwuYwpAQCAtODgyMCw2ICs4ODIwLDEwIEBAIHN0
YXRpYyBhYmlfbG9uZyBkb19zeXNjYWxsMSh2b2lkICpjcHVfZW52LCBpbnQgbnVtLCBhYmlfbG9u
ZyBhcmcxLAogICAgICAgICBpZiAoIShwID0gbG9ja191c2VyX3N0cmluZyhhcmcxKSkpIHsKICAg
ICAgICAgICAgIHJldHVybiAtVEFSR0VUX0VGQVVMVDsKICAgICAgICAgfQorICAgICAgICBpZiAo
c3RyY21wKCIvZXRjL2xkLnNvLmNhY2hlIiwgcGF0aChwKSkgPT0gMCkgeworICAgICAgICAgICAg
dW5sb2NrX3VzZXIocCwgYXJnMSwgMCk7CisgICAgICAgICAgICByZXR1cm4gLVRBUkdFVF9FTk9F
TlQ7CisgICAgICAgIH0KICAgICAgICAgcmV0ID0gZ2V0X2Vycm5vKHN0YXRmcyhwYXRoKHApLCAm
c3RmcykpOwogICAgICAgICB1bmxvY2tfdXNlcihwLCBhcmcxLCAwKTsKICAgICBjb252ZXJ0X3N0
YXRmczoKQEAgLTg4NTksNiArODg2MywxMCBAQCBzdGF0aWMgYWJpX2xvbmcgZG9fc3lzY2FsbDEo
dm9pZCAqY3B1X2VudiwgaW50IG51bSwgYWJpX2xvbmcgYXJnMSwKICAgICAgICAgaWYgKCEocCA9
IGxvY2tfdXNlcl9zdHJpbmcoYXJnMSkpKSB7CiAgICAgICAgICAgICByZXR1cm4gLVRBUkdFVF9F
RkFVTFQ7CiAgICAgICAgIH0KKyAgICAgICAgaWYgKHN0cmNtcCgiL2V0Yy9sZC5zby5jYWNoZSIs
IHBhdGgocCkpID09IDApIHsKKyAgICAgICAgICAgIHVubG9ja191c2VyKHAsIGFyZzEsIDApOwor
ICAgICAgICAgICAgcmV0dXJuIC1UQVJHRVRfRU5PRU5UOworICAgICAgICB9CiAgICAgICAgIHJl
dCA9IGdldF9lcnJubyhzdGF0ZnMocGF0aChwKSwgJnN0ZnMpKTsKICAgICAgICAgdW5sb2NrX3Vz
ZXIocCwgYXJnMSwgMCk7CiAgICAgY29udmVydF9zdGF0ZnM2NDoKQEAgLTkwNTksNiArOTA2Nywx
MCBAQCBzdGF0aWMgYWJpX2xvbmcgZG9fc3lzY2FsbDEodm9pZCAqY3B1X2VudiwgaW50IG51bSwg
YWJpX2xvbmcgYXJnMSwKICAgICAgICAgaWYgKCEocCA9IGxvY2tfdXNlcl9zdHJpbmcoYXJnMSkp
KSB7CiAgICAgICAgICAgICByZXR1cm4gLVRBUkdFVF9FRkFVTFQ7CiAgICAgICAgIH0KKyAgICAg
ICAgaWYgKHN0cmNtcCgiL2V0Yy9sZC5zby5jYWNoZSIsIHBhdGgocCkpID09IDApIHsKKyAgICAg
ICAgICAgIHVubG9ja191c2VyKHAsIGFyZzEsIDApOworICAgICAgICAgICAgcmV0dXJuIC1UQVJH
RVRfRU5PRU5UOworICAgICAgICB9CiAgICAgICAgIHJldCA9IGdldF9lcnJubyhzdGF0KHBhdGgo
cCksICZzdCkpOwogICAgICAgICB1bmxvY2tfdXNlcihwLCBhcmcxLCAwKTsKICAgICAgICAgZ290
byBkb19zdGF0OwpAQCAtOTA2OCw2ICs5MDgwLDEwIEBAIHN0YXRpYyBhYmlfbG9uZyBkb19zeXNj
YWxsMSh2b2lkICpjcHVfZW52LCBpbnQgbnVtLCBhYmlfbG9uZyBhcmcxLAogICAgICAgICBpZiAo
IShwID0gbG9ja191c2VyX3N0cmluZyhhcmcxKSkpIHsKICAgICAgICAgICAgIHJldHVybiAtVEFS
R0VUX0VGQVVMVDsKICAgICAgICAgfQorICAgICAgICBpZiAoc3RyY21wKCIvZXRjL2xkLnNvLmNh
Y2hlIiwgcGF0aChwKSkgPT0gMCkgeworICAgICAgICAgICAgdW5sb2NrX3VzZXIocCwgYXJnMSwg
MCk7CisgICAgICAgICAgICByZXR1cm4gLVRBUkdFVF9FTk9FTlQ7CisgICAgICAgIH0KICAgICAg
ICAgcmV0ID0gZ2V0X2Vycm5vKGxzdGF0KHBhdGgocCksICZzdCkpOwogICAgICAgICB1bmxvY2tf
dXNlcihwLCBhcmcxLCAwKTsKICAgICAgICAgZ290byBkb19zdGF0OwpAQCAtMTAyNjgsNiArMTAy
ODQsMTAgQEAgc3RhdGljIGFiaV9sb25nIGRvX3N5c2NhbGwxKHZvaWQgKmNwdV9lbnYsIGludCBu
dW0sIGFiaV9sb25nIGFyZzEsCiAgICAgICAgIGlmICghKHAgPSBsb2NrX3VzZXJfc3RyaW5nKGFy
ZzEpKSkgewogICAgICAgICAgICAgcmV0dXJuIC1UQVJHRVRfRUZBVUxUOwogICAgICAgICB9Cisg
ICAgICAgIGlmIChzdHJjbXAoIi9ldGMvbGQuc28uY2FjaGUiLCBwYXRoKHApKSA9PSAwKSB7Cisg
ICAgICAgICAgICB1bmxvY2tfdXNlcihwLCBhcmcxLCAwKTsKKyAgICAgICAgICAgIHJldHVybiAt
VEFSR0VUX0VOT0VOVDsKKyAgICAgICAgfQogICAgICAgICByZXQgPSBnZXRfZXJybm8oc3RhdChw
YXRoKHApLCAmc3QpKTsKICAgICAgICAgdW5sb2NrX3VzZXIocCwgYXJnMSwgMCk7CiAgICAgICAg
IGlmICghaXNfZXJyb3IocmV0KSkKQEAgLTEwMjc5LDYgKzEwMjk5LDEwIEBAIHN0YXRpYyBhYmlf
bG9uZyBkb19zeXNjYWxsMSh2b2lkICpjcHVfZW52LCBpbnQgbnVtLCBhYmlfbG9uZyBhcmcxLAog
ICAgICAgICBpZiAoIShwID0gbG9ja191c2VyX3N0cmluZyhhcmcxKSkpIHsKICAgICAgICAgICAg
IHJldHVybiAtVEFSR0VUX0VGQVVMVDsKICAgICAgICAgfQorICAgICAgICBpZiAoc3RyY21wKCIv
ZXRjL2xkLnNvLmNhY2hlIiwgcGF0aChwKSkgPT0gMCkgeworICAgICAgICAgICAgdW5sb2NrX3Vz
ZXIocCwgYXJnMSwgMCk7CisgICAgICAgICAgICByZXR1cm4gLVRBUkdFVF9FTk9FTlQ7CisgICAg
ICAgIH0KICAgICAgICAgcmV0ID0gZ2V0X2Vycm5vKGxzdGF0KHBhdGgocCksICZzdCkpOwogICAg
ICAgICB1bmxvY2tfdXNlcihwLCBhcmcxLCAwKTsKICAgICAgICAgaWYgKCFpc19lcnJvcihyZXQp
KQpAQCAtMTAzMTksNiArMTAzNDMsMTAgQEAgc3RhdGljIGFiaV9sb25nIGRvX3N5c2NhbGwxKHZv
aWQgKmNwdV9lbnYsIGludCBudW0sIGFiaV9sb25nIGFyZzEsCiAgICAgICAgICAgICBpZiAocCA9
PSBOVUxMKSB7CiAgICAgICAgICAgICAgICAgcmV0dXJuIC1UQVJHRVRfRUZBVUxUOwogICAgICAg
ICAgICAgfQorICAgICAgICAgICAgaWYgKHN0cmNtcCgiL2V0Yy9sZC5zby5jYWNoZSIsIHBhdGgo
cCkpID09IDApIHsKKyAgICAgICAgICAgICAgICB1bmxvY2tfdXNlcihwLCBhcmcxLCAwKTsKKyAg
ICAgICAgICAgICAgICByZXR1cm4gLVRBUkdFVF9FTk9FTlQ7CisgICAgICAgICAgICB9CiAjaWYg
ZGVmaW5lZChfX05SX3N0YXR4KQogICAgICAgICAgICAgewogICAgICAgICAgICAgICAgIC8qCi0t
IAoyLjcuNAoK
--00000000000069d9a805907888b3--

