Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F6AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CB421835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx/EsHGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CB421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuHHW-00066r-To
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuHGq-0005fq-2C
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuHGo-0006s6-UG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:46:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39028
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuHGo-0006rl-QW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579704374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/FE+4WSxlFKRdNm2+CpbYGDCIBHgTiC9jSUmhd/8UY=;
 b=gx/EsHGOJ7jC0eRzGDclihLIhha+pt/v5GDpmKKM86Xgjn7JmWbejRDHaSlIZs5zJaVxQ2
 gAf1BlG4Zvl6sa7W7NiELSDVUktOXzVkpjAtrg9Dg5z47fiTyTPTaK08fCdVR/IWukYA8U
 y/H6s7BqybvGmjEeyYnPezzEN/JcmP0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-Bm3EROQwMNaPUt2BFLd_mw-1; Wed, 22 Jan 2020 09:46:11 -0500
Received: by mail-wr1-f69.google.com with SMTP id w6so3159669wrm.16
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 06:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yjl2ksuWS8kVMgxPUhAOAtdY7FJsF0dqyuJPf5EUeZw=;
 b=FVnRk41e+3YzkTdx+uFzVcbNo4ypMuOFosvi7QAuHHSTIT4Q5IuCDh1K2d+H7Hd3Ls
 gGpyn/5f4JA4grqMRVbViHsMS2GF3t9MitoFRrO/MiGbjeoMtklbBqIRAbsOUvZv/EBi
 EsC8GxMNcTyGZWsunXTMte4wPPfBPycmx3oLroXHqdi7bf0SDv99XP8Ke2HENeeOuAUv
 s/swGbdJhYgEqupBa4++O0DGHzidbsBRxBDeiDrXmrSE9iYgjjqqdjLR8x71snOHnAXD
 FYAIFvVAnFebAgTr/NF8wHW2XrNSiMXrqbgj5J4InH5T/+wrEBCg9Sv0bFx5Xddlfj+t
 hdtw==
X-Gm-Message-State: APjAAAUitwG/lG+lSUpw7aT9NEDuM0p2gXRCFQ801YyvtsUe3Qo2RDfN
 BPLl6W+7U/NTfEa5hfn9xpEhC/PnN05gHfmolCpXW10QuwAD3evVMQqYe9vF5FqwO6XCM0zV/n3
 fAIAGp6ND3lwLvbU=
X-Received: by 2002:adf:eb48:: with SMTP id u8mr11401751wrn.283.1579704370297; 
 Wed, 22 Jan 2020 06:46:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwuJsu9P0CN/VTee7s+3wWXGfBhMtj7XffDRNKRxlmgdo6LEs+qvJLImnHhlYLDhcSRTfyHfg==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr11401719wrn.283.1579704370000; 
 Wed, 22 Jan 2020 06:46:10 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s19sm4121144wmj.33.2020.01.22.06.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 06:46:09 -0800 (PST)
Subject: Re: [PATCH v1 2/3] tests/docker: better handle symlinked libs
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200122102223.20036-1-alex.bennee@linaro.org>
 <20200122102223.20036-3-alex.bennee@linaro.org>
 <00813be1-eadb-b3c8-2a3c-084302de78b6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9b180dab-246b-1b1e-8ec8-6585227330a7@redhat.com>
Date: Wed, 22 Jan 2020 15:46:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <00813be1-eadb-b3c8-2a3c-084302de78b6@redhat.com>
Content-Language: en-US
X-MC-Unique: Bm3EROQwMNaPUt2BFLd_mw-1
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
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 2:24 PM, Wainer dos Santos Moschetta wrote:
>=20
> On 1/22/20 8:22 AM, Alex Benn=C3=A9e wrote:
>> When we are copying we want to ensure we grab the first
>> resolution (the found in path section). However even that binary might
>> be a symlink so lets make sure we chase the symlinks to copy the right
>> binary to where it can be found.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> =C2=A0 tests/docker/docker.py | 3 ++-
>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 31d8adf836..96d4326d53 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -109,7 +109,7 @@ def _get_so_libs(executable):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ensure theright data is copied."""
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libs =3D []
>> -=C2=A0=C2=A0=C2=A0 ldd_re =3D re.compile(r"(/.*/)(\S*)")
>> +=C2=A0=C2=A0=C2=A0 ldd_re =3D re.compile(r"=3D> ?(/.*/)(\S*)")

Why the 'optional space' after "=3D>"?

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ldd_output =3D su=
bprocess.check_output(["ldd",=20
>> executable]).decode('utf-8')
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for line in ldd_o=
utput.split("\n"):
>> @@ -145,6 +145,7 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if libs:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for l in libs:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 so_path =3D os.path.dirname(l)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 real=
_l =3D os.path.realpath(l)
>=20
> real_l is not used.

I suppose the idea is to use it as:

                 _copy_with_mkdir(real_l, dest_dir, so_path)

>=20
> - Wainer
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 _copy_with_mkdir(l, dest_dir, so_path)
>=20


