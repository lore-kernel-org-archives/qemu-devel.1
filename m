Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AD3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9F220663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGWek28t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9F220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZTu-0004dx-AH
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixZT7-0003zo-Rh
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:48:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixZT6-00069g-HW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:48:33 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixZT6-000686-A3
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:48:32 -0500
Received: by mail-wr1-x442.google.com with SMTP id k11so9418617wrd.9
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 08:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=l4f8peNaJno60DuFzYXo8NQiqW5owEAYtfnDUcIxrK8=;
 b=FGWek28t6mH1lRv3fT0sv8DCL6ildX/cXTF/76qLeVbUakTl8FNwX6+bTfb1btkJFA
 r5qFSWz//L3evjt5pWShlkXoUDORkLUuPjxpKNtKM3AjCrYZVgruhVOEfrHImJ7ov0Fs
 3EdzNyiQAaL8wJp4SSM0O8L/qPfberX+5wGJypYBOxE/k1+bh9CBs7/Wsg6yWjnXu2X1
 Ue0ptCvC3Q27U0DJAkT08jJWMK5g8j21zubIVm2niauWOVm0ZFUAIcOa3I+6qWLl072W
 QItXtfgllHUl1pmn9JGedvBOQr8Fu0KDl9R/C7CHX+JnM6DCpDwI8X71OcLdicTEB0tO
 LvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=l4f8peNaJno60DuFzYXo8NQiqW5owEAYtfnDUcIxrK8=;
 b=lBBHtPsgddQvPvR86M2+BK7NwZP0xd/5dMcgZK+hO7wnof+oxEwY+Bo9bbWsTUqKlB
 ptLTKnWVwiC1SyNbcnb8GMg4RqH+9iiC0FA6HkpchXvEc4L8Z0UN8BZLNSRYbnrJVaO6
 Mq1MO0Bk5il5Vu/zXkDK3Ewx+pibvue/5IVk5X7J02B5uiAYf++Ct4BcPj/D99TYUj8e
 pTDWs+RzgIMEIxbRNaBYau/QU7QjkKbDZIztY3ckudCH1H9dGAwOJXC/r80ufN1mPke7
 9lVmPKmmKUIHGYVUzN0E/c5/et9SwA2WMNcM1dKtrgZTInv9DMGdXU02L5fP4PWz2whC
 mqXA==
X-Gm-Message-State: APjAAAW9hN7SqWPRF7JPAwJvUyx94h1ztVFERbZVIrjP6ImBSadz4PCD
 wCYvTqEYlm2xtq8aWA3TqN5sXw==
X-Google-Smtp-Source: APXvYqxx3Ltbxd0j5EMFXL8PVrk78ULWCdIdqUkSRZa6D17relWdkcxBkvDb3BckoegB7qx9+Hl7cA==
X-Received: by 2002:adf:f10b:: with SMTP id r11mr13118500wro.307.1580489310103; 
 Fri, 31 Jan 2020 08:48:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i204sm11972996wma.44.2020.01.31.08.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2020 08:48:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 126711FF87;
 Fri, 31 Jan 2020 16:48:28 +0000 (GMT)
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-3-alex.bennee@linaro.org>
 <8a1eb0c0-9fe4-0b6b-c1ca-28f48ec89512@redhat.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 02/12] tests/docker: better handle symlinked libs
In-reply-to: <8a1eb0c0-9fe4-0b6b-c1ca-28f48ec89512@redhat.com>
Date: Fri, 31 Jan 2020 16:48:28 +0000
Message-ID: <8736bv8tcz.fsf@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 1/30/20 12:32 PM, Alex Benn=C3=A9e wrote:
>> When we are copying we want to ensure we grab the first
>> resolution (the found in path section). However even that binary might
>> be a symlink so lets make sure we chase the symlinks to copy the right
>> binary to where it can be found.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/docker/docker.py | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 31d8adf836..7dfca63fe4 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -109,7 +109,7 @@ def _get_so_libs(executable):
>>       ensure theright data is copied."""
>>         libs =3D []
>> -    ldd_re =3D re.compile(r"(/.*/)(\S*)")
>> +    ldd_re =3D re.compile(r"(?:\S+ =3D> )?(\S*) \(:?0x[0-9a-f]+\)")
>>       try:
>>           ldd_output =3D subprocess.check_output(["ldd", executable]).de=
code('utf-8')
>>           for line in ldd_output.split("\n"):
>> @@ -145,7 +145,8 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
>>       if libs:
>>           for l in libs:
>>               so_path =3D os.path.dirname(l)
>> -            _copy_with_mkdir(l, dest_dir, so_path)
>> +            real_l =3D os.path.realpath(l)
>> +            _copy_with_mkdir(real_l, dest_dir, so_path)
>>=20=20=20=20=20
>>   def _check_binfmt_misc(executable):
>>=20
>
> Rob raised an issue in this patch, it appears in a separated thread:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675307.html

If fixed it up thusly:

def _get_so_libs(executable):
    """Return a list of libraries associated with an executable.

    The paths may be symbolic links which would need to be resolved to
    ensure the right data is copied."""

    libs =3D []
    ldd_re =3D re.compile(r"(?:\S+ =3D> )?(\S*) \(:?0x[0-9a-f]+\)")
    try:
        ldd_output =3D subprocess.check_output(["ldd", executable]).decode(=
'utf-8')
        for line in ldd_output.split("\n"):
            search =3D ldd_re.search(line)
            if search:
                try:
                    libs.append(s.group(1))
                except IndexError:
                    pass
    except subprocess.CalledProcessError:
        print("%s had no associated libraries (static build?)" % (executabl=
e))

    return libs


--=20
Alex Benn=C3=A9e

