Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A04C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E005621741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILqNmD6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E005621741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjKx-0002ea-VR
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izjJV-0001SJ-9E
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izjJT-00044V-Uy
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:43:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27842
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izjJT-00041a-Qx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581003811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+LPCfjsPj6f6ITV+Ye7RjUPTCwxLEJuhJVD88QqbE4=;
 b=ILqNmD6ErQDIvH6rVqypkUHDWOzhzi+JJqpQm45b0NfGOUyefjIO68EIa7tsWmcJZ4LLL/
 x69zs33Pv3KH0MJikOnao9txUrBvux5U2aHNUD3LWTXp6SZ1Jt+p4qAHvJ5Eb9gLQC1CCF
 n+lc1gkU+JwjcYDpCd+Pbvz8ttsTEJA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-JOzUiklgMQWo3NM1-yVyww-1; Thu, 06 Feb 2020 10:43:24 -0500
Received: by mail-wr1-f72.google.com with SMTP id s13so3598352wrb.21
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 07:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PSEjJafm4oyyXQRWmKfdoia3T1a9rBoV90HUP61A6sw=;
 b=Dme+iCDnTduwnmHZb9hWcNZJ5W90Fcmx2h4VPugnQXzGt2/MPJMsc/7CpItft0ESdy
 5atJfnBxDey24HlfoWeVl/nrp+1GYqreAEcd31bo3RkCLNjkYgRRHcvA/0yMbeVVoM/A
 R/LDwrBXFdO2KI4re3A4P5LHkKskubPjByh4h5qmrPVf1Izqf8Ue+kCFs0b78bXLEjk1
 RqUIYem1JllZXpjj+9KFVYcE19Gx9PP9UaR3KogP+sM2FH/Xg9kojKwqksKqyLWz1yl6
 mZGchpwigZwRi54dLsan19ay7iA3bGDUnKB32bASvwgsL4cFi11s7zw2srZ5qAwODSP5
 hsvA==
X-Gm-Message-State: APjAAAVpFGgJUpngRAnNSU3MAsOAgFDEnWFFzqNMTIwH/CD3wy+sroGx
 ZSwrlsHo52JIs+Z2vG766tRi5DRVzY8egxc6ikQ+ybRihXbuBzZZzCAPXJks1BxIeOl3D+yIAkG
 H5n1PWIPTqYOO2Os=
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr5182696wmc.162.1581003802938; 
 Thu, 06 Feb 2020 07:43:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1sUyWXLR6LZQDW+LXDWAi15GedzETTXIOXn9iQ6RAQbANXojoAwRm+3+ccZh2pz/z2svlOw==
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr5182685wmc.162.1581003802735; 
 Thu, 06 Feb 2020 07:43:22 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id s8sm4513198wrt.57.2020.02.06.07.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 07:43:22 -0800 (PST)
Subject: Re: [PATCH v4 4/8] python/qemu: accel: Fix kvm_available() on ppc64le
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200205203250.30526-1-wainersm@redhat.com>
 <20200205203250.30526-5-wainersm@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5f3ba490-ea0b-f2fe-d314-e7c08db7ca95@redhat.com>
Date: Thu, 6 Feb 2020 16:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205203250.30526-5-wainersm@redhat.com>
Content-Language: en-US
X-MC-Unique: JOzUiklgMQWo3NM1-yVyww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: drjones@redhat.com, thuth@redhat.com, alex.bennee@linaro.org,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 9:32 PM, Wainer dos Santos Moschetta wrote:
> On ppc64le, the accel.kvm_available() check may wrongly
> return False because the host arch (as returned by os.uname[4])
> and the target arch (ppc64) mismatch. In order to solve this
> it is added an ppc64le -> ppc64 mapping which is used as an
> fallback verification.
>=20
> Fixes: 53a049d7d78e5ccf6d4c0d7
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   python/qemu/accel.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> index 0b38ddf0ab..36ae85791e 100644
> --- a/python/qemu/accel.py
> +++ b/python/qemu/accel.py
> @@ -24,7 +24,8 @@ LOG =3D logging.getLogger(__name__)
>   # support which often includes its 32 bit cousin.
>   ADDITIONAL_ARCHES =3D {
>       "x86_64" : "i386",
> -    "aarch64" : "armhf"
> +    "aarch64" : "armhf",
> +    "ppc64le" : "ppc64",
>   }
>  =20
>   def list_accel(qemu_bin):
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

And applied to my python-next tree:
https://gitlab.com/philmd/qemu/commits/python-next


