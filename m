Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC06C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03FD206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxnqeLMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03FD206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDOE3-0004Zp-35
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDODI-00044e-2I
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDODF-0004oN-Uk
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:29:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55989
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDODF-0004m7-QW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569482956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=/cGhteoZZJM+vapsRTgKYXtTysqbQNmn8NRXYFFQri8=;
 b=dxnqeLMACcUYZFyF2ofPDL96bS2+ANXOkTqYJ+I5U/WzIp7mxyGmvNmA+oq/eDSMv7jMvj
 RWTJcjLYWgi9iYACovXC6ld7VAGiA5sK+bmbn8qzWgihABQNavPnXt7tq6dAlnPWN+T3U/
 m4aglL+AWyyXQNoHKifYNqj6t3UNhQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-O_VeUjffOv-fvvgwIicZ0g-1; Thu, 26 Sep 2019 03:29:14 -0400
Received: by mail-wm1-f71.google.com with SMTP id l3so723962wmf.8
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 00:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iDJmicGAl96yidCuawMr1CMMu54lmfAcQ3Il8nPoQpk=;
 b=WUmIjVvrBBUbWlfIzPoaPUlIUqNciWtRTAMjO0+D52x2SLpgOyBFmIVMyFP9aMRMzC
 akglUa1su+AYQ+/0KVNTsVba/qBOQ9XC20Kw9UwIVpM8WDoG/RipRaLCTGiwX5hT1Fx5
 UEEjPOzXTXA3trgbQf+sbYMV4iIwsIr8PrWQhGL7HNqC6cINvI8pLNHJuqPdAhpgFIbT
 Ua4WEIiwXgH8NS5N6dP1jYsL/JqPTi+NmBmclkfzGOCfSnVLUQLOKdikC2nhN6crVXNF
 VAzB1UjHjAj942TiEc5KOZzwYD74x+SJqC9+OsxUMrU3jXtLK8oyfzm0EstivGzJowBB
 lQQQ==
X-Gm-Message-State: APjAAAXnD0F1wwRPDE6/md/l0yJ7uHwaUlFWzeotRf1d3ryf+dOCdMHj
 6pEgRQxAL4LRSlbjcNdZR1idMlZljBhsb33ZBOj8IhBT92svT4pIWjW5lyv7UplNx5987tOYQRw
 loGrZGNgtbDkQhAw=
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr1763099wmb.95.1569482953418; 
 Thu, 26 Sep 2019 00:29:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqytWh9o/+F5HwiXhX4OCTQ27hOmu6kO4GRZHJI2D7s1OaF+YcfghSexKpmUXgflgUkJ82HKHw==
X-Received: by 2002:a1c:1b58:: with SMTP id b85mr1763088wmb.95.1569482953208; 
 Thu, 26 Sep 2019 00:29:13 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id o188sm2839780wma.14.2019.09.26.00.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 00:29:12 -0700 (PDT)
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190925233013.6449-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e08a9d80-a797-76a9-b1e5-6ccbef0b1c37@redhat.com>
Date: Thu, 26 Sep 2019 09:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925233013.6449-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: O_VeUjffOv-fvvgwIicZ0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-discuss@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 1:30 AM, Alex Benn=C3=A9e wrote:
> The 32 bit hosts are already a second class citizen especially with
> support for running 64 bit guests under TCG. We are also limited by
> testing as actual working 32 bit machines are getting quite rare in
> developers personal menageries. For TCG supporting newer types like
> Int128 is a lot harder with 32 bit calling conventions compared to
> their larger bit sized cousins. Fundamentally address space is the
> most useful thing for the translator to have even for a 32 bit guest a
> 32 bit host is quite constrained.
>=20
> As far as I'm aware 32 bit KVM users are even less numerous. Even
> ILP32 doesn't make much sense given the address space QEMU needs to
> manage.
>=20
> Lets mark these machines as deprecated so we can have the wailing and
> gnashing of teeth now and look to actually dropping the support in a
> couple of cycles.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/configure b/configure
> index 542f6aea3f..776fd460b5 100755
> --- a/configure
> +++ b/configure
> @@ -728,7 +728,7 @@ ARCH=3D
>  # Normalise host CPU name and set ARCH.
>  # Note that this case should only have supported host CPUs, not guests.
>  case "$cpu" in
> -  ppc|ppc64|s390|s390x|sparc64|x32|riscv32|riscv64)
> +  ppc64|s390|s390x|sparc64|riscv64)
>      supported_cpu=3D"yes"
>    ;;
>    ppc64le)
> @@ -737,7 +737,6 @@ case "$cpu" in
>    ;;
>    i386|i486|i586|i686|i86pc|BePC)
>      cpu=3D"i386"
> -    supported_cpu=3D"yes"
>    ;;
>    x86_64|amd64)
>      cpu=3D"x86_64"
> @@ -745,19 +744,22 @@ case "$cpu" in
>    ;;
>    armv*b|armv*l|arm)
>      cpu=3D"arm"
> -    supported_cpu=3D"yes"

I think linux-user is quite used in embedded stuff such NAS.

Eventually this public don't need edge QEMU, it might keep using QEMU
v5.0.stable until all NAS/embedded devices are 64-bit...

>    ;;
>    aarch64)
>      cpu=3D"aarch64"
>      supported_cpu=3D"yes"
>    ;;
> -  mips*)
> +  mips64*)
>      cpu=3D"mips"
>      supported_cpu=3D"yes"
>    ;;
> +  mips*)
> +    cpu=3D"mips"

Similarly I can imagine linux-user being used on some routers.

> +  ;;
>    sparc|sun4[cdmuv])
>      cpu=3D"sparc"
> -    supported_cpu=3D"yes"
> +  ;;
> +  x32|riscv32)

x32 is borderline :) but yes, pointers are 32-bit.

>    ;;
>    *)
>      # This will result in either an error or falling back to TCI later
> @@ -6438,12 +6440,12 @@ if test "$supported_cpu" =3D "no"; then
>      echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELE=
ASES!"
>      echo
>      echo "CPU host architecture $cpu support is not currently maintained=
."
> -    echo "The QEMU project intends to remove support for this host CPU i=
n"
> -    echo "a future release if nobody volunteers to maintain it and to"
> -    echo "provide a build host for our continuous integration setup."
> -    echo "configure has succeeded and you can continue to build, but"
> -    echo "if you care about QEMU on this platform you should contact"
> -    echo "us upstream at qemu-devel@nongnu.org."
> +    echo "The QEMU project intends to remove support for all 32 bit host=
"
> +    echo "CPUs in a future release. 64 bit hosts will need a volunteer"
> +    echo "to maintain it and to provide a build host for our continuous"
> +    echo "integration setup. configure has succeeded and you can continu=
e"
> +    echo "to build, but if you care about QEMU on this platform you"
> +    echo "should contact us upstream at qemu-devel@nongnu.org."
>  fi
> =20
>  if test "$supported_os" =3D "no"; then
>=20


