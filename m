Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139F1C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C786A21835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 22:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IetTWbfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C786A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuOJL-0005Oz-VX
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 17:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuOHZ-0003wa-2w
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuOHX-0004rh-05
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:15:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuOHW-0004pf-Qc
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 17:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579731325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QboA8IZz/eSNfHu7foxtdR6R80YXwTZjJjo5barTHPI=;
 b=IetTWbfoPt46ZwKgxu70CO7BiSgdTQxKwiDuephViYKRh8ETM//NEWfcyx3xvS8MQx7HOL
 uS/jvAfZHEDEXWWmFSXQR6biAh9ceApPQZXD5u6SgDP+764d649uhHtoKcr24oAEI4Srvp
 53DIbn5pAoVCCXXrrsN7nH4VasRtKDg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-GzCTVnzPMtyT_ACE-INSdg-1; Wed, 22 Jan 2020 17:15:21 -0500
Received: by mail-wr1-f71.google.com with SMTP id 90so723635wrq.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 14:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OA78RvdFyp1nK4k4qH2h3zZ65WFYB1lRKMoIvM7BTNs=;
 b=U+2QIWzP3ZCdwoVyc09xqetv9hfU0V6r+kLy1v3ppbVobbZhj4rqPQ1dkRmK+5UXzi
 pjxE7y28BqmdMtCrzmxptMsfjqa/YB7W9mmRpilnf/F2Cq3MkztP4wsG21z0K/YITAAr
 zP19DIk8WVDadYY0F/tHA9ZOOxy+JpjL3dIja7PNcy4F+hwOcBkhGZ67vRMwh5I6ISyR
 tL4rcXYe5Tt1xVSEOsmMnKs+P8f0kmIAs0DYU4F1a0L3qif0++meYnNmy0V/iZDJ3eSz
 MI1C68kUlHhrHY1SY0DeU8TdhjpgHnQHAQoQ5O87DQTA0miibCDYAeZLs5xmCYDH+OuZ
 C+ww==
X-Gm-Message-State: APjAAAWUI3A12PtBar/gdE0StEzlQgC/FcwCO9/0RRs4f8aPHOxZoGcJ
 XhRHMEUsdyRidEldytY0e95CKgHU+BbcKZCtUSikd0Ka4aLtSqE37lWu4dTz1KnyPlCAS4yppKg
 3JEb2PYbx+s1TWhs=
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr12995098wrq.43.1579731319941; 
 Wed, 22 Jan 2020 14:15:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkeNTNEZ553Y2qHZRcYnq+EMjBRMYobQ6+wqRvLOtcZNTQzTaTFWphkmdFGtXaU9/ytywWwQ==
X-Received: by 2002:a5d:4a8c:: with SMTP id o12mr12995080wrq.43.1579731319717; 
 Wed, 22 Jan 2020 14:15:19 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n189sm67662wme.33.2020.01.22.14.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 14:15:18 -0800 (PST)
Subject: Re: [PATCH v1 2/3] tests/docker: better handle symlinked libs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200122102223.20036-1-alex.bennee@linaro.org>
 <20200122102223.20036-3-alex.bennee@linaro.org>
 <00813be1-eadb-b3c8-2a3c-084302de78b6@redhat.com>
 <9b180dab-246b-1b1e-8ec8-6585227330a7@redhat.com> <87muafzdnq.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <00801ef6-a06e-1c69-eb79-01d2cfac53b0@redhat.com>
Date: Wed, 22 Jan 2020 23:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87muafzdnq.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: GzCTVnzPMtyT_ACE-INSdg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 1/22/20 4:58 PM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 1/22/20 2:24 PM, Wainer dos Santos Moschetta wrote:
>>> On 1/22/20 8:22 AM, Alex Benn=C3=A9e wrote:
>>>> When we are copying we want to ensure we grab the first
>>>> resolution (the found in path section). However even that binary might
>>>> be a symlink so lets make sure we chase the symlinks to copy the right
>>>> binary to where it can be found.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>    tests/docker/docker.py | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>>>> index 31d8adf836..96d4326d53 100755
>>>> --- a/tests/docker/docker.py
>>>> +++ b/tests/docker/docker.py
>>>> @@ -109,7 +109,7 @@ def _get_so_libs(executable):
>>>>        ensure theright data is copied."""
>>>>        libs =3D []
>>>> -    ldd_re =3D re.compile(r"(/.*/)(\S*)")
>>>> +    ldd_re =3D re.compile(r"=3D> ?(/.*/)(\S*)")
>>
>> Why the 'optional space' after "=3D>"?
>=20
> Actually what I want is an optional "=3D> "

Maybe r"(?:\S+ =3D> )?(\S*) \(:?0x[0-9a-f]+\)"?

optional non-capturing upto "=3D> ",
capture until space,
non-capture address in parenthesis.

>=20
>>
>>>>        try:
>>>>            ldd_output =3D subprocess.check_output(["ldd",
>>>> executable]).decode('utf-8')
>>>>            for line in ldd_output.split("\n"):
>>>> @@ -145,6 +145,7 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir=
):
>>>>        if libs:
>>>>            for l in libs:
>>>>                so_path =3D os.path.dirname(l)
>>>> +            real_l =3D os.path.realpath(l)
>>> real_l is not used.
>>
>> I suppose the idea is to use it as:
>>
>>                  _copy_with_mkdir(real_l, dest_dir, so_path)
>=20
> Yes - looks like I need to retest.
>=20
>>
>>> - Wainer
>>>
>>>>                _copy_with_mkdir(l, dest_dir, so_path)
>>>
>=20
>=20


