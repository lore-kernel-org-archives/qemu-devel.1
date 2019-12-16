Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5062C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7772D2064B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVOkK7rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7772D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igvcf-0003ln-LF
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igvbK-0002uB-7q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:00:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igvbI-0007SA-GL
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:00:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igvbI-0007QB-CU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576522811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MzFgqgEiWPmJRwb4OBQjI5r1wcRUF4nLM01yn/XNLyo=;
 b=XVOkK7rKNXjhH7WP/VAVQ3GrOzDEa6imzXIEfGyAx5EAGAMFfbsadj7kusONZh2SpB2Kpa
 v2TufvuS9Zr7yQRGvT4VVrOHi4rmU+Tn+wxAoKSZ/nKeZKDJJSaaT2461JQ5MCm/MdsmqF
 KxqKIuZq70OoFx3/vSorS45J4+L3fNI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-5hANIBcpOSeLqvYnWKntIw-1; Mon, 16 Dec 2019 14:00:10 -0500
Received: by mail-wr1-f72.google.com with SMTP id i9so4180012wru.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 11:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ui8Jg8m+ShBid5nVdW+ULrJB7CGA0L+6aVwWTac/jWs=;
 b=JSl/2Fl+SSYRJh/otQKv5KBSEkuNajjSRorf0IoSShVNzML9rmgc8z9tFfJky56YkN
 p1euMpnVJN5PdIC6yhXPpWzUBRiKW0XmAumnL0g9HUUQlGkRE6So+rSgoj+onTst0X+F
 uUA+54stHvIkJMY0Dp6/PEbWEyMD/2vjzU6hf3fzXeJDRGKVCYw6Je1TiKSW2kUNqAS8
 vV8Yp0a0vZQ4hHSvkMk8Ze1PQ9DXnSNm+ppwvJBR5pClamCv6nCRQIUwWQbw6nn0RQH3
 Z4OSZ4Qt4PL5m66aJ00dtQUsT4wKgYFQXZbiuPsJqsDXQG55fEP78Ua0kb0LRLGvvhkd
 ggwg==
X-Gm-Message-State: APjAAAU5/JzVVyPF4Rfu9jO1tsBALdVsE+u8kTPN++eKWDcuQDVUXhkT
 X6uj3yBuIQxkr4SuQDGnhX+wmKD61XRZsf747Sbs1HeaUrgwPG04ddEsOFRllN7L/t2+aUOzRMu
 ++gf3KFVPkHZTVwI=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr547907wmi.101.1576522806747; 
 Mon, 16 Dec 2019 11:00:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJUJVy+ygc9EhOSNtzmEeIwTvmfiKzVlsM9KTiRwgugEn7F8iTEoWzuyFUqK740J81/F387w==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr547874wmi.101.1576522806540; 
 Mon, 16 Dec 2019 11:00:06 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id 16sm339246wmi.0.2019.12.16.11.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 11:00:06 -0800 (PST)
Subject: Re: [PATCH v1 06/16] iotests: Skip test 079 if it is not possible to
 create large files
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191216110732.24027-1-alex.bennee@linaro.org>
 <20191216110732.24027-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9ab3f2aa-5886-db35-9913-a2f552987423@redhat.com>
Date: Mon, 16 Dec 2019 20:00:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216110732.24027-7-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: 5hANIBcpOSeLqvYnWKntIw-1
X-Mimecast-Spam-Score: 0
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 Max Reitz <mreitz@redhat.com>, cota@braap.org, stefanha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 12:07 PM, Alex Benn=C3=A9e wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> Test 079 fails in the arm64, s390x and ppc64le LXD containers on Travis
> (which we will hopefully enable in our CI soon). These containers
> apparently do not allow large files to be created. Test 079 tries to
> create a 4G sparse file, which is apparently already too big for these
> containers, so check first whether we can really create such files before
> executing the test.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20191204154618.23560-4-thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   tests/qemu-iotests/079 | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
> index 81f0c21f530..78536d3bbfa 100755
> --- a/tests/qemu-iotests/079
> +++ b/tests/qemu-iotests/079
> @@ -39,6 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>   _supported_fmt qcow2
>   _supported_proto file nfs
>  =20
> +# Some containers (e.g. non-x86 on Travis) do not allow large files
> +_require_large_file 4G
> +
>   echo "=3D=3D=3D Check option preallocation and cluster_size =3D=3D=3D"
>   echo
>   cluster_sizes=3D"16384 32768 65536 131072 262144 524288 1048576 2097152=
 4194304"
>=20


