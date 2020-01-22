Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1E4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A32621835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WV5tgeAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A32621835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuIPl-0005vf-Oc
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuIOd-00052T-4O
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuIOb-0005Qt-M6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:58:22 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuIOb-0005PO-De
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:58:21 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so7894256wrr.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ekluN5ztgjB8EcDqO/2bE6Fuh6sFlHgRZqqmMfNFXIM=;
 b=WV5tgeAHoNONfZKcQXN8RqR85sTy0JbRFZ9iq0d8RjHVamr9jZeSJHV/IBcJ9iAqW/
 oJ3pkcriiy+ssapisV5f5USwliFJpu1My+mWvTr4DT5aJ2ovJhILK2iNeoesvHfDUm+5
 M7BZj0GRJapdpBb4FKUOXaO50aPWe31Bcv6JtVKohjMwFpl20ZDdBeOd7+cztOd/5GUH
 rhYP0y+kmNkdYau3bugVmXAxTXgniDvMcMNejXcxMrvLo+Wo8sBoWim+B6nE3dkmxvrG
 wX1RMcdvWCWlJ9eZdO/iYwtTFHqPFk+HozLxYMAlHVQk7s2JpQtA17i4w2L3E3DCCzVX
 bgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ekluN5ztgjB8EcDqO/2bE6Fuh6sFlHgRZqqmMfNFXIM=;
 b=QZUMTBfSk8ZrreyuUv0RvxeBQUp7n9PLHI4RRXzmN4SGSxMqgGz5n7pvdxS8bxE9Dq
 ViixfuHmMlVj+RZfwcZbvt45rD5KFVs2wdHqLiLU/PcD1mUeAfRuFWfyG5GQ5zw09lQp
 DTGqAOqL+5fpSSOF50u3CYqAac8+3Gh8qkac8mRWB0Lv7B5hzyWNfa3WedJnZtgEOJ4L
 dGwbfZYZU381Mprqgp67u61TlFJmU9Q28OJZvMagUId3WV2ql48Sy/6ysdozTLjuwBfJ
 0Ch61k1tlyKu9dOxf+3kpU26MDNjijBCDppNhqJFlxmdGNcyGwPnII/2HhEjvCtRWCxD
 ZfAQ==
X-Gm-Message-State: APjAAAUNQoyFx1klpL+nxAUtYcSDRk/4+TLLE+/FhBzICY0jvwKmc78F
 Ww3ahwSLp5HmXa5geVNzJr81pw==
X-Google-Smtp-Source: APXvYqxbR0ZD0DdKCToeRLfTHjTtX3ylsXODEaC8lmoLVSe5nopprmWke0YF3QyRHjAkqS6L3f6U6w==
X-Received: by 2002:adf:e6d2:: with SMTP id y18mr11808527wrm.262.1579708699426; 
 Wed, 22 Jan 2020 07:58:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o16sm5047168wmc.18.2020.01.22.07.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 07:58:18 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B6E2F1FF87;
 Wed, 22 Jan 2020 15:58:17 +0000 (GMT)
References: <20200122102223.20036-1-alex.bennee@linaro.org>
 <20200122102223.20036-3-alex.bennee@linaro.org>
 <00813be1-eadb-b3c8-2a3c-084302de78b6@redhat.com>
 <9b180dab-246b-1b1e-8ec8-6585227330a7@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v1 2/3] tests/docker: better handle symlinked libs
In-reply-to: <9b180dab-246b-1b1e-8ec8-6585227330a7@redhat.com>
Date: Wed, 22 Jan 2020 15:58:17 +0000
Message-ID: <87muafzdnq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 1/22/20 2:24 PM, Wainer dos Santos Moschetta wrote:
>> On 1/22/20 8:22 AM, Alex Benn=C3=A9e wrote:
>>> When we are copying we want to ensure we grab the first
>>> resolution (the found in path section). However even that binary might
>>> be a symlink so lets make sure we chase the symlinks to copy the right
>>> binary to where it can be found.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>   tests/docker/docker.py | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>>> index 31d8adf836..96d4326d53 100755
>>> --- a/tests/docker/docker.py
>>> +++ b/tests/docker/docker.py
>>> @@ -109,7 +109,7 @@ def _get_so_libs(executable):
>>>       ensure theright data is copied."""
>>>       libs =3D []
>>> -    ldd_re =3D re.compile(r"(/.*/)(\S*)")
>>> +    ldd_re =3D re.compile(r"=3D> ?(/.*/)(\S*)")
>
> Why the 'optional space' after "=3D>"?

Actually what I want is an optional "=3D> "

>
>>>       try:
>>>           ldd_output =3D subprocess.check_output(["ldd",
>>> executable]).decode('utf-8')
>>>           for line in ldd_output.split("\n"):
>>> @@ -145,6 +145,7 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
>>>       if libs:
>>>           for l in libs:
>>>               so_path =3D os.path.dirname(l)
>>> +            real_l =3D os.path.realpath(l)
>> real_l is not used.
>
> I suppose the idea is to use it as:
>
>                 _copy_with_mkdir(real_l, dest_dir, so_path)

Yes - looks like I need to retest.

>
>> - Wainer
>>=20
>>>               _copy_with_mkdir(l, dest_dir, so_path)
>>=20


--=20
Alex Benn=C3=A9e

