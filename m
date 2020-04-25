Return-Path: <SRS0=p7gi=6J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03C1C55185
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 09:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D3320700
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2020 09:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NRxxAfxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D3320700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSH9L-0006wa-J9
	for qemu-devel@archiver.kernel.org; Sat, 25 Apr 2020 05:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jSH2g-0004Ih-1K
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 05:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jSH2f-0002L6-4d
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 05:24:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:55515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jSH2e-0002Ju-Er
 for qemu-devel@nongnu.org; Sat, 25 Apr 2020 05:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1587806645;
 bh=xytjJRSjIfdjxNKXlPzGzgoyxTH05XpuKItKJeKQuJs=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=NRxxAfxxsibNgXBJtoAWS7dUHVHt1sM7itVng2E3gGR8suXDLwzRsiUIZ7acOLmRb
 pLVQXE7Xm0JmVIyhupPj25ayUzvxhzHFTRYWmDzlicf6vDoPPxznpVGEcuNya9amED
 gW/X+qNUYm+kp+HmqtIFdXdt434izJatAJ+GgtLE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.179.136]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QWA-1jWgsu47Gq-004WsG; Sat, 25
 Apr 2020 11:24:05 +0200
Subject: Re: [PATCH] linux-user: Drop unnecessary check in signalfd4 syscall
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
References: <20200424210422.GB26282@ls3530.fritz.box>
 <c9f3644e-21c8-600b-4bf6-d55e6c52153f@vivier.eu>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <2703086a-d283-e780-a427-ce84ed31f852@gmx.de>
Date: Sat, 25 Apr 2020 11:24:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c9f3644e-21c8-600b-4bf6-d55e6c52153f@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qobe+sW5/1ordntAz6PyG7DLsYY4L8YXOBd1zhGV/hONuRMRb43
 Bc3Ma8iLyDO759Gf/D37cWjPmecP+xz/pnHxTRQ800yz20rhzWPH+QTynb17aJd+7E6F8WS
 Ifv9c6io4UlhbERY9PLsxpLqfpkcoSbEbt8WwQf7IipGzckfdKL7AS+dZoDK7BkkcVk6UWc
 bDuXNYb8JuXDmMBnQRhYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lYZpSkszBw0=:s5hj9RSSRT9MIAtmD8DvT/
 +iwvGr8bDb5GcEnd/sMYP0Wa7lTgrP33zyGMGgBIWGnxOqi5DtNZx+97ugafZhV0X2VxSD9HQ
 oIgCDe0R/NIH4BqNI8GJaN8MPuhxlfNm9L0Ui/cZ6CYI6/FjNzZUsylK90y+e+mHQeN+aI6vs
 c0gSxUUgbafZhbrayjC1WCr//En4WvW1dmG88BzvHvEBARu6qoSrtfb1V5M3lJAqzkglGjXd4
 DURAE167xrPCTFRkt0YB5JX7hcxMi1h1f8APDtTBR8H2tJ5rYZ/DCuDd8X5tGJEGCD8YAnmmN
 QJ3kEVd2tNKsX4hgha2P2OX91Y+jTpjbxLUOXDdHO9RRwepVvXzevmas7uERTHgOqxdexUIUz
 JiD0ws0ZHMfiewuRm7FI8EuvQpxOqnPlekq6vSfQdvY5Yq7bjSlyL8RJSHAkF/aT2nEhQm9in
 nKPHs4Xy/HoXmDX2fVq0+TJXtD+ETPttZqds3aSeYeXz2Xvbbi6Yu7kBcpL1Sy268o/vOPxYQ
 fgiB/gLNJacJnL2W8UbwQULiB8sNEwTshXpjucEJtiwqFCRS8zNNiDO1yEO6HnN4dz0UaFykk
 1a5RTxt40ioNLJMHxh8Aap+Ez3pcznz+AGxA+OjhOD5y3DOGipD8ji5qKVcfQ3v9UeZ7M2TDU
 09R/VckT+cNkb+nBdD1tM6AlHqnmcPbWhg2/d70cBEtyn34hrRZhFZH+I1iTZ91qIHkZ/nZZj
 dsh/mKc5/A+UhBmC87FDEo89c0L9Z792YvtE7+JZADSNGtR4ECHvLLRAIplikImuTBkAj1vtN
 Nsttopsn0ZT+We2cl5iPCimFS1viOgSd79zShJinZAGG4jmnZCZySOV8t4GPNyrMw+W2nKVqD
 u5mv7djgsuALlLxy7EyaZNGKHXMMCsLfpZ8nbGLnjgPn1meVBtzE0Xvh9vleikZDADCj2LiPa
 6jkB/cTLkNpRZXHvsbwB8d+vHtvbNHe6+zSf4IBMPr1dcshut7YqJWV9IEVSFbz0uckTW4we5
 fcrmRKjlaMO/pZh79cu+g6sjhOEAs8gUNmoOz1/ZtPkI+2+nGfFhNQ2Jj8Vcj8nAhqCZaoRXi
 YqPgvLxGAgeWm1GhMIXpsRDgd84x8wLghxq/B2Ma0KLLcntdtm65LLBeSDF0viKgZGZBV/M8t
 wJd1NK7wMnF4r6yT+9mJm1+x2Wq+3F5pfNqye4bXsvZHFmJszH8RywU3JgebmscHDAkSYmRpH
 CuA03UsIZWe5FDntz
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/25 05:24:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.04.20 10:39, Laurent Vivier wrote:
> Le 24/04/2020 =C3=A0 23:04, Helge Deller a =C3=A9crit=C2=A0:
>> The signalfd4() syscall takes optional O_NONBLOCK and O_CLOEXEC fcntl
>> flags.  If the user gave any other invalid flags, the host syscall will
>> return correct error codes, so simply drop the extra check here.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 05f03919ff..ebf0d38321 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7176,9 +7176,6 @@ static abi_long do_signalfd4(int fd, abi_long mas=
k, int flags)
>>      sigset_t host_mask;
>>      abi_long ret;
>>
>> -    if (flags & ~(TARGET_O_NONBLOCK | TARGET_O_CLOEXEC)) {
>> -        return -TARGET_EINVAL;
>> -    }
>>      if (!lock_user_struct(VERIFY_READ, target_mask, mask, 1)) {
>>          return -TARGET_EFAULT;
>>      }
>>
>
> Perhaps we want to trigger the TARGET_EINVAL before the TARGET_EFAULT if
> we have both cases?
>
> But I've checked the kernel, and the kernel does a copy_from_user()
> before checking the flags, but it returns EINVAL rather than EFAULT.

That's not the full picture, since the kernel is not consistent here!
In the compat-case (32bit userspace on 64bit kernel) it returns correctly
EINVAL and EFAULT:
        if (sigsetsize !=3D sizeof(compat_sigset_t))
                return -EINVAL;
        if (get_compat_sigset(&mask, user_mask))
                return -EFAULT;
while in the non-compat case it returns EINVAL only:
        if (sizemask !=3D sizeof(sigset_t) ||
            copy_from_user(&mask, user_mask, sizeof(mask)))
                return -EINVAL;

I think the kernel should be fixed here...

> We can remove the flags checking but we should also change TARGET_EFAULT
> by TARGET_EINVAL.

According to the different behaviour of the kernel mentioned above
you won't get it correct either way.

Helge

