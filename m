Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B882CC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADCD2072F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ky9VmcjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADCD2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMdKy-00041J-Mn
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 15:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMdKM-0003bP-Nd
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:59:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMdKK-0007KE-Bp
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:59:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMdKK-0007Je-1b
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:59:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id h9so13403894wrc.8
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 12:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OFMT9KZrUvCL9bEP1fnzdqPCahzmpZRXdi7q5mS484c=;
 b=Ky9VmcjZ9sU9qSAPmCXhi7dJaGfOpDdU8tu6V6+y3QrwAeYg/nGajMMIhzF1vip0hD
 yRbNyDsv5KGYo+VwkHB45KbRdyuOoCTz+RZnDK/u/cgXxAJMHpabtFIcScO7db4Ca413
 9k3GSQepDCh6X6rG5kfgPh7hDEMZBQGirtMB5aSXOtL2VhAoiZgY+xcpzKMsuS9TWGO1
 gIco1OhhtgAcTKAL38F+Xi09P5zq4B1H+DGjy1fF0q1d+lSsaFTYoI71+GezJB4Iz9EG
 /Th3zJcnb8VhTp7rGW5aPEL7s5DgNWOroI8PGxdGGOQo0ZOXI8iVCpxvg0LGZwMwprYd
 /Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OFMT9KZrUvCL9bEP1fnzdqPCahzmpZRXdi7q5mS484c=;
 b=ie1Q7iaIjBP40GxzvTuKYPA54Lq53hT3Y0iSHBmjAEeL329Dod0iwXcpbREX9EnRl5
 IZ0WcqHG4MA7cocGU8LuTwJLC156vmKPjexUpm27gB4WQ+0TfbKUtEBcsnEvR/u9SUJm
 B19z2G7iOZQPQrwGhP0lzlECpphjmTnJzSH1xbIm/iDNzJQH/soDUjSBiwMB3pOF0tHW
 Aik1V9meAWGVHxA6cpCP61hDCvmnVpiv7gBnphRAKqkmzoohQKriswOPoKt6pKgLBXFF
 0QRruB1drGlJlfLg2t3b9730tMMzEkpU41aVIPBksZ5/HD8C9S+MOr7vBranlwI5oSXV
 2Uaw==
X-Gm-Message-State: AGi0PubHUrlzGab377A4lmv76Mj9KwvJ1gcO2/ivohp2M4aQ2gLUaHzn
 gjvleMn6rxHTPxA/Qzx6I4ylIw==
X-Google-Smtp-Source: APiQypLbALVcgg9AhSL2EYNxjYmFjIDMjY/Mjz+ELserx1tgNe/JsLKK4EfmURXWzA5WIgOOZgfFow==
X-Received: by 2002:adf:f98b:: with SMTP id f11mr793265wrr.259.1586462342549; 
 Thu, 09 Apr 2020 12:59:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 138sm5159334wmb.14.2020.04.09.12.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 12:59:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5CE061FF7E;
 Thu,  9 Apr 2020 20:59:00 +0100 (BST)
References: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>
 <87wo6oadcc.fsf@linaro.org>
 <149b6a99-fa9e-7ba2-6325-3ad1ff151f6c@inria.fr>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: linux-user: keep the name-ending parenthesis in /proc/self/stat
In-reply-to: <149b6a99-fa9e-7ba2-6325-3ad1ff151f6c@inria.fr>
Date: Thu, 09 Apr 2020 20:59:00 +0100
Message-ID: <87tv1sa0sb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Brice Goglin <Brice.Goglin@inria.fr> writes:

> Le 09/04/2020 =C3=A0 17:27, Alex Benn=C3=A9e a =C3=A9crit :
>> Brice Goglin <Brice.Goglin@inria.fr> writes:
>>
>>> When the program name is very long, qemu-user may truncate it in
>>> /proc/self/stat. However the truncation must keep the ending ") "
>>> to conform to the proc manpage which says:
>>>     (2) comm  %s
>>>            The  filename of the executable, in parentheses.  This
>>>            is visible whether or not the  executable  is  swapped
>>>            out.

Huh testing on my box here it seems to truncate a lot earlier than that:

20:54:41 [alex@zen:~/l/q/b/all] sanitiser/fixes-for-5.1|=E2=97=8F1=E2=9C=9A=
1=E2=80=A6(+1/-1) +
./cat_with9_123456789012345678901234567890123456789012345678901234567890123=
45678901234567890123456789012345678901234567890___4567890 /proc/self/stat
23132 (cat_with9_12345) R 15690 23132 15676 34827 23132 4194304 87 0 0 0 0 =
0 0 0 20 0 1 0 133272440 6172672 188 18446744073709551615 94698916007936 94=
698916032905 140729243846896 0 0 0 0 0 0 0 0 0 17 2 0 0 0 0 0 9469891605204=
8 94698916053600 94698933542912 140729243849857 140729243850006 14072924385=
0006 140729243852659 0

20:55:21 [alex@zen:~/l/q/b/all] sanitiser/fixes-for-5.1|=E2=97=8F1=E2=9C=9A=
1=E2=80=A6(+1/-1) 126 +
./x86_64-linux-user/qemu-x86_64  ./cat_with9_123456789012345678901234567890=
123456789012345678901234567890123456789012345678901234567890123456789012345=
67890___4567890 /proc/s
elf/stat
23519 (./cat_with9_12345678901234567890123456789012345678901234567890123456=
789012345678901234567890123456789012345678901234567890___40 0 0 0 0 0 0 0 0=
 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 274903122400 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

>>>
>>> To reproduce:
>>> $ ln -s /bin/cat <filenamewithmorethan128chars>
>>> $ qemu-x86_64 ./<filenamewithmorethan128chars> /proc/self/stat
>>>
>>> Before the patch, you get:
>>> 1134631 (<filenametruncated>0 0 0 0 0 0 0 0 ...
>>> After the patch:
>>> 1134631 (<filenametruncat>) 0 0 0 0 0 0 0 0 ...
>>>
>>> This fixes an issue with hwloc failing to parse /proc/self/stat
>>> when Ludovic Courtes was testing it in Guix over qemu-aarch64.
>>>
>>> Signed-off-by: Philippe_Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Signed-off-by: Brice Goglin <Brice.Goglin@inria.fr>
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -7305,7 +7305,11 @@ static int open_self_stat(void *cpu_env, int fd)
>>>          snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
>>>        } else if (i =3D=3D 1) {
>>>          /* app name */
>>> -        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
>>> +        char *ptr =3D buf;
>>> +
>>> +        *ptr++ =3D '(';
>>> +        ptr =3D stpncpy(ptr, ts->bprm->argv[0], sizeof(buf) - 3);
>>> +        strcpy(ptr, ") ");
>> why not just use a format string:
>>
>>   snprintf(buf, sizeof(buf), "(%.125s) ", ts->bprm->argv[0]);
>>
>
> Go ahead and apply what you want (maybe 124 instead of 125 because of
> the ending \0).
>
> My commit message above explains how to test things very quickly.
>
> I don't use qemu-user or Guix myself, and I can't spend time
> debugging/testing this further.
>
> Thank you
>
> Brice


--=20
Alex Benn=C3=A9e

