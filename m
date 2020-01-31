Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C9DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D6CB214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnKHsh8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6CB214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYxI-0003h2-CN
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixYwC-0001gg-VV
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixYw9-0002Qu-PE
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:14:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixYw9-0002PF-LJ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 11:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580487268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3c3Z3w3fHAzjJk79WQKL808xbKBvvaRDEGKls1gQPc=;
 b=RnKHsh8GeNByPjQmF4FB0CENbV7upCUvirh7xawGNKnnE8zvat8z+U+M8iNFSgcrWjpSbJ
 +bpFz9E2+LnUCsLnsRelgZ6KVATWfO1dHsqyFjRR/rMYcl8y1L0h3NZJlduYDVh5Yz6Be6
 pESS3TGPzedxCjZRhIBWmFSKzmMmVCY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-AavxL_gaMN6M08XCSMZAdA-1; Fri, 31 Jan 2020 11:14:10 -0500
Received: by mail-wr1-f70.google.com with SMTP id s13so3556008wru.7
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 08:14:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pRS1346M8ox/BifWJnPmM7pLOOWesLQcDkFxfbq3hN0=;
 b=TMP/jgC+7tb8EnUuTY8AxxK+mK4C3YZRL4RGrN77h1voMcUCWPKBT97PiXKKyoZDa4
 fQ/U5m5YTRDb6nCPq/cWE4LKhWkwdUAlsUk9mTSPhepqGmnUIZ8LT55Q+aGc+ijr5wGN
 iwskanLrNpZdM2l7xhnJIADg5Ng7kHaczHnQEq/GAWRqwNncX1iZGrDglv4cWpWcmwLa
 UZ7CfzBTWEBIe0X33anmhHz2rVR5ZuVQxlA4NI6jH4lZCy/6eLd/1Gi+FmiyIPbjDs9E
 CBgwwNK5380uS6yq5IW+akd6oi9iXURGjuN1Zfo2aRCI8vSFrlq114Rfvq/QxJP6RKmS
 YVNA==
X-Gm-Message-State: APjAAAUvLkZ0e2wk/sNeg7ik3nQfUacXsFOK5v7cNVm2oKyA78xh0foq
 3p/OUxy9WZTTw+gEeYKp7+ASpJkwr/5RqPrIWGLUVvfxws1aSDyOyzkt9n3PPwHA4SjHKjTU7w6
 SE+evGEDHJCYcrS8=
X-Received: by 2002:adf:f491:: with SMTP id l17mr13940259wro.149.1580487249031; 
 Fri, 31 Jan 2020 08:14:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWudwUrfHbktuzmknK5AkceloTnp55dFUk6WN8pSwlWwc/Km3F9MlBccGCkyrLNNblSZL/gw==
X-Received: by 2002:adf:f491:: with SMTP id l17mr13940245wro.149.1580487248735; 
 Fri, 31 Jan 2020 08:14:08 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w8sm11453202wmm.0.2020.01.31.08.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 08:14:08 -0800 (PST)
Subject: Re: [PATCH v2 12/12] .travis.yml: limit the arm64 target list
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-13-alex.bennee@linaro.org>
 <b30243fd-c95a-9199-4a7f-16f9df1e9a9b@redhat.com>
Message-ID: <4748fddb-edb9-f274-4ec1-ad514591502e@redhat.com>
Date: Fri, 31 Jan 2020 17:14:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b30243fd-c95a-9199-4a7f-16f9df1e9a9b@redhat.com>
Content-Language: en-US
X-MC-Unique: AavxL_gaMN6M08XCSMZAdA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 4:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/30/20 12:32 PM, Alex Benn=C3=A9e wrote:
>> Even though we can do a good multi-threaded build we are still
>> exceeding the 50 minute build time while running the tests.

Oh now I remember, we are not using ccache on Aarch64 because Thomas=20
reported it was not working:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg650940.html

>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> =C2=A0 .travis.yml | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index a600f508b0..71bf650b1d 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -426,7 +426,7 @@ matrix:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - gen=
isoimage
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_CMD=3D"mak=
e check check-tcg V=3D1"
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--disable-contai=
ners=20
>> --target-list=3D${MAIN_SOFTMMU_TARGETS}"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--disable-contai=
ners=20
>> --target-list=3Daarch64-softmmu,aarch64-linux-user,arm-softmmu,arm-linux=
-user"=20
>>
>=20
> We should split this job in 2 using --target-list-exclude, like on=20
> X86/debug:
>=20
>  =C2=A0 env:
>  =C2=A0 - CONFIG=3D"--disable-containers=20
> --target-list-exclude=3D${MAIN_SOFTMMU_TARGETS}"
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - name: "[ppc64] GCC check-tcg"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch: ppc64le
>>


