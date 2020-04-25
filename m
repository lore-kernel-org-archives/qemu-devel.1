Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE30C54FCB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 21:55:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB6C20714
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 21:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QHcy4Chb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB6C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSSlR-0008Bp-8n
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 17:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jSSfK-000750-Q7
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 17:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jSSfJ-0002A3-O5
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 17:48:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:52009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jSSfJ-0001s4-2L
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 17:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1587851318;
 bh=xPRzfUY6UR0+nipgQZDLUXMKknzrpMvhKXjVLROYD5Y=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=QHcy4ChbZg2lJnox0vK69AL3F1Eh5sTrn2Hw0C9wxI0PG0V6jSWnCia/+VOx/1gMj
 WYb4XIeQxeoPMVkh5WURhxjo6LlUfUQX0EVcc57zZp60FF9ZQKoa1cqPMreAOgB+So
 RhimWlpE2cl+4UH5ymGiF51dVRcvuHTuKXBOWDbY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.179.136]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1jR2wX2jRD-00GFlo; Sat, 25
 Apr 2020 23:48:38 +0200
Subject: Re: [PATCH] linux-user: Drop unnecessary check in signalfd4 syscall
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
References: <20200424210422.GB26282@ls3530.fritz.box>
 <c9f3644e-21c8-600b-4bf6-d55e6c52153f@vivier.eu>
 <2703086a-d283-e780-a427-ce84ed31f852@gmx.de>
 <67496bb6-1734-ff27-c734-aa01a7a670a4@vivier.eu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <abaef8b0-e23e-56ba-503e-720c3c827750@gmx.de>
Date: Sat, 25 Apr 2020 23:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <67496bb6-1734-ff27-c734-aa01a7a670a4@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5iJVXZ+7cW/d/+8UgRBJ19Qj8JlEI+7BAlcRDE/H7L6arSQ1NG6
 3tbjjmVEI61WHQ0RG8HOsl+oZbI/nu/MIdejNMp6SBWhjKyCszYiTefeGphQwe+9C7chbPB
 718xp71Ls04MZ9+1PuDA+pofNJ76sn6rDYsYPKR1otAOuNuQkYPLpYTTxmV94UNC9RAK/ce
 0o42wKLFofIrk18zbV5wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+AIzhOPQ6V4=:jYdYcgWXhmJlII9r4dw4Fr
 qkHEXP5kPSmIscWt79XP+cko1y3xRZhl+w8zQXEmKhtNx1XVuQKL4rhKq6v8+WmzVcU9HYF7w
 TopImAtNZqOpImNmfelCS0jS4GNqSzpo+TNlDylDL8iIRp6u36DwSiCtgk0hm7MOTeucBx8Iq
 49UyUqohHQcMrwDyHaY9lNMa4ZOdheX/JKxwdiP7B/u3gAmTrAWL8Eq3HadSEqtPUnhsfT3IF
 0UokVH5HlPDbbLkkiDVV1nZpEUQ5kXQ+MJpz1IX3Bjl371saVj/iTisBjGfbpwIBl56BDGc6w
 evSk+gS1EquYlC/3OPIZ/Tr/7vqiB7tDlka3HlDuJ7yLPaX+8KEDOW6P2D1D2L6sCMFfn1N8g
 zhnsS0wEp7KVYB+lrd1KgQDHKcYRqLEWx0y/hWCSIjymJX+IloLaY29yt/+oJvmY+V02MWYGR
 t4rUg84FWiMybBD7jUv216vCCS4spswKx0Sh2FuggBjEdzK3lRyDEbHQYIeJ3j9QKPkAISwyY
 eFlfgkkbyxbKcO+igRuHMzdwGbnQZl/N4kOw8eZmXtWTqiMJvhgH+1gK3ayU/HsB5/x/uJf12
 MVni8UQUNwnLTdZhpLJMtiHhWA/fIbdusp8o0lvalkBAIQuTwFZjdouAkxFJDlyTTd3J6e0xY
 iWHvCjYFX789HCWc1VGTK8bil75JB3BblHIjyR6h685/X05809pu/MPPd2J6NVqZKqyPlaCQa
 M7udWWttfkHTRbh6Jejj2QnyKFI1oB1ytL8XdgDosTEqTyI1G81chdNphN7TnhndD3sLBdZYq
 NFmOPVkYurJXXg+A/7ED85mFselgqCAcuKICymSgLesfvYvL2xRa97kqbB6UsLLPzcAvvVToC
 1JH3IZ/vlgKoPa314sN4FTgFgDstuix5Hx2oPLIdCrobp6hTtkx/0g7TZwUBoOvxZ8nNOIuMQ
 rE/j994YR8S3w0mcotiIaVt2xDcAo2DB2vRMCHegnXjw5ObBmcjRvKmTW5b+1P+4afN3ldF/m
 Pog3vOnXcjBiFcXNqBCtqfG0SJ5b9/PTNqFtCBddCZY9fR6NuUgni2byt5EPBMCDZGiUCxhMf
 1HnvXTDA8alKhZXPvcUwoxw3sUKmAvDrdvfFG7vltUjtgsO/WLcdgmqx0Smbgyj3vZlisWtRZ
 LTM7AVcP/0000HPxfGog6pzHnOTO/D4tikMmPXiOAydEYe7c5TLIe8iAPQc8R7tYlivtZHF4E
 1HJxh9aCkOp7JKRZi
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 17:48:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.21
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

On 25.04.20 12:03, Laurent Vivier wrote:
> Le 25/04/2020 =C3=A0 11:24, Helge Deller a =C3=A9crit=C2=A0:
>> On 25.04.20 10:39, Laurent Vivier wrote:
>>> Le 24/04/2020 =C3=A0 23:04, Helge Deller a =C3=A9crit=C2=A0:
>>>> The signalfd4() syscall takes optional O_NONBLOCK and O_CLOEXEC fcntl
>>>> flags.  If the user gave any other invalid flags, the host syscall wi=
ll
>>>> return correct error codes, so simply drop the extra check here.
>>>>
>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>
>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>> index 05f03919ff..ebf0d38321 100644
>>>> --- a/linux-user/syscall.c
>>>> +++ b/linux-user/syscall.c
>>>> @@ -7176,9 +7176,6 @@ static abi_long do_signalfd4(int fd, abi_long m=
ask, int flags)
>>>>      sigset_t host_mask;
>>>>      abi_long ret;
>>>>
>>>> -    if (flags & ~(TARGET_O_NONBLOCK | TARGET_O_CLOEXEC)) {
>>>> -        return -TARGET_EINVAL;
>>>> -    }
>>>>      if (!lock_user_struct(VERIFY_READ, target_mask, mask, 1)) {
>>>>          return -TARGET_EFAULT;
>>>>      }
>>>>
>>>
>>> Perhaps we want to trigger the TARGET_EINVAL before the TARGET_EFAULT =
if
>>> we have both cases?
>>>
>>> But I've checked the kernel, and the kernel does a copy_from_user()
>>> before checking the flags, but it returns EINVAL rather than EFAULT.
>>
>> That's not the full picture, since the kernel is not consistent here!
>> In the compat-case (32bit userspace on 64bit kernel) it returns correct=
ly
>> EINVAL and EFAULT:
>>         if (sigsetsize !=3D sizeof(compat_sigset_t))
>>                 return -EINVAL;
>>         if (get_compat_sigset(&mask, user_mask))
>>                 return -EFAULT;
>> while in the non-compat case it returns EINVAL only:
>>         if (sizemask !=3D sizeof(sigset_t) ||
>>             copy_from_user(&mask, user_mask, sizeof(mask)))
>>                 return -EINVAL;
>>
>> I think the kernel should be fixed here...
>>
>>> We can remove the flags checking but we should also change TARGET_EFAU=
LT
>>> by TARGET_EINVAL.
>>
>> According to the different behaviour of the kernel mentioned above
>> you won't get it correct either way.
>
> If we refer to manpage, EFAULT is not one of possible errors.

The manpage doesn't mention any error code for a bad mask address, and
IMHO the manpage should reflect the real coding, not vice versa.
I've just sent a RFC patch to the kernel mailing list.
It's not a critical problem, but it would be nice to be at least consisten=
t
across the implementations. Either both should return always EINVAL,
or both should return EFAULT. If it gets accepted I'll send a patch
to correct the manpage accordingly afterwards, and then we can adjust
qemu.

Helge

