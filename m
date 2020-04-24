Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA4BC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B350D206B9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dWJKL1lR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B350D206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS6HP-0001gh-LI
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS6B9-0007t3-7V
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS6B8-0003lF-1J
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:48:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:37025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jS6B7-0003kt-Cf
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1587764875;
 bh=PJjtPqkHTRQYrWdT0uPiO3vxL7Gfk8W8TGz4t5+PKOQ=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=dWJKL1lRmA0scQfMWEv4DEdzHkAmwCkh73zcFYTx0teQQRP1muooygPHrWEkLnFzE
 4RcxWlpzm2qKDi6JmT0b3oCsC3OCRCxjFnF2aWRT4oPRRfn+tIFofCkCSDag9miKIo
 H/kSFirLT291fOl7CfO6LWe8k1VkkNxgtOCmtNT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.144.192]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1j2LYz1d9a-011Nzo; Fri, 24
 Apr 2020 23:47:55 +0200
Subject: Re: [PATCH] linux-user: Drop unnecessary check in dup3 syscall
To: Eric Blake <eblake@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200424205755.GA26282@ls3530.fritz.box>
 <56bb3ce2-9b70-7470-d4f4-563b617849d2@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <86df80e9-c747-1854-d210-5856b71e2f7b@gmx.de>
Date: Fri, 24 Apr 2020 23:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <56bb3ce2-9b70-7470-d4f4-563b617849d2@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AHKZTYmAe8B0tbWONqSpeQfjcYCDhrme8g2iskUAwb5RIUYXZ24
 PKBL/gLw14sDUsyGaVwdqdU29z1RXEacPycoEHsup8EspFaM+C6F6zUkVV98g7bHrX5WYSH
 1j5SMdz9tGHezXapnyjJdsAzzbUfcRjGWs52qoBRyk1Gz4GBM+XgLtyHigMEyyaxLz+NNK8
 USrFdOI5fWVp5YY02GC4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d/FkAOi7Los=:JQgNkHGOH4YypqPYovJBXw
 uhLzAgIaOY75d6MtYl8GM/v0Z9J3Os1YS5oIRlZO5qvVerJNnDRojIWRx56zrhbkqGFEwjc62
 oWcuX4Mu0MVL6c32XYl+LBJKx5R1XBkSVAc+xaVV6hnLlkZrk1648rxn+J+TN5txySWI7HpX0
 pya291aj1sxkRC2KVWXSvcHhpEpubp8OGG+UkajBPv+XXLuN9EaPvtdDXdBWxQMB2ienRykTe
 Gjgre+ugO7rOSmL0THFZbNsKB99s9mZx9jSSmGp9CSKJU84mOpx8hFcCSIdxGJkDdF35RCK+e
 98M7UmD5kbJPKHZJVUz8ce6vDl/rYm19xbD6bFA3AD9bVpVnGm8er3zAvhcAnkGfTgF6mc55z
 4lhdQv8t9KTGOQxjwvPjS5hDgXaQZHFKeaIxc0REEfn6bDkZiZ2SghkvYNP7hya9+SPQG/Y71
 v6hyFZikA7Rn+77fQRDBLhFKHfLg/konHC9NzWYu7bfNpyfSaxSc6kTikeXVpqkYdV4wGGmol
 iigcgkkCjj19OZqt9XxuGWSD04QiMD2jXHoGIAKzHJnujjCum9OmiZemzx+jC7CwBJidGTI9N
 v1ucO4FSyXRfslMUKoUtIUY2W0oVXAKrWBsZjX7wqIrR9pLNxGG2Kh4TfPIsTAtmWOy7WFbnL
 n2mkiGyElEClk87WJhGqaJ8Jakc4bOwvWm5ClSOrBQ2gEMe3MC5D9VXq35fo5QkQ9pW3Bcx5b
 2J6o9ui6s0kzKyCui89bzDTDZAnb7/NXnjAaxh2r7W6IRuy6JyHDghgPdPTQ9b+H//Yl8l5Dj
 1l4V7CiscPkUxpvu6MkDrvtDjzqtkzUrzLq8qA2GWm+VOzZITJl/ZIrrUgfMAu9//lwHLg+CM
 D6RjAGMoY6sbcr9x+eN5ocUyRkOsrRreAWDdiFs2w1d1Cr8fiOFe1FE6L5Y6/A74yWJYVpq4F
 VWlot7B9aqU9dCz5hgsw3EuqQVP7/Q5E6D1eWyiDXI2yCkSJF0PBv7sfMx14XsePNDCiiDG6m
 HtV3v5gNw70La7X689WblclZZvarOVZIg4VtqdRj90XuSPow1qMUK4bjAaaITSu5FEZp//m5K
 slM9L6ewgeFemf0MaokuZW0BxUKY+2NyciVOsO4dksQwT6h7p+Fveibndt2WbYDefUBrdwYfo
 odsMoEKdWviZDGCabI57yrcmDu8NylhkkzIVJoCnRI3R8kulGLsih42cP80t8ry+HjUFQL662
 vXgJ+mYxkOfVmUfjp
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 16:58:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
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

On 24.04.20 23:32, Eric Blake wrote:
> On 4/24/20 3:57 PM, Helge Deller wrote:
>> Drop the extra check in dup3() if anything other than FD_CLOEXEC (aka
>> O_CLOEXEC) was given. Instead simply rely on any error codes returned b=
y
>> the host dup3() syscall.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 05f03919ff..ebf0d38321 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -8301,12 +8310,7 @@ static abi_long do_syscall1(void *cpu_env, int n=
um, abi_long arg1,
>> =A0 #if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
>> =A0=A0=A0=A0=A0 case TARGET_NR_dup3:
>> =A0=A0=A0=A0=A0 {
>> -=A0=A0=A0=A0=A0=A0=A0 int host_flags;
>> -
>> -=A0=A0=A0=A0=A0=A0=A0 if ((arg3 & ~TARGET_O_CLOEXEC) !=3D 0) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>> -=A0=A0=A0=A0=A0=A0=A0 }
>> -=A0=A0=A0=A0=A0=A0=A0 host_flags =3D target_to_host_bitmask(arg3, fcnt=
l_flags_tbl);
>> +=A0=A0=A0=A0=A0=A0=A0 int host_flags =3D target_to_host_bitmask(arg3, =
fcntl_flags_tbl);
>
> I don't think this is quite correct.  target_to_host_bitmask()
> silently ignores unknown bits, and a user that was relying on bit
> 0x40000000 to cause an EINVAL will not fail with this change (unless
> bit 0x40000000 happens to be one of the bits translated by
> fcntl_flags_tbl).

True.

> The open() syscall is notorious for ignoring unknown bits rather than
> failing with EINVAL, and it is has come back to haunt kernel
> developers; newer syscalls like dup3() learned from the mistake, and
> we really do want to catch unsupported bits up to make it easier for
> future kernels to define meanings to those bits without them being
> silently swallowed when run on older systems that did not know what
> those bits meant.
Ok, I wasn't aware that it's a design goal to manually find such
cases of wrong userspace applications. But in this case, you're right
that my patch shouldn't be applied.

While looking at the code I just noticed another bug too, which needs
fixing then:
>> -        if ((arg3 & ~TARGET_O_CLOEXEC) !=3D 0) {
>> -            return -EINVAL;
this needs to be:
>> -            return -TARGET_EINVAL;

Helge

