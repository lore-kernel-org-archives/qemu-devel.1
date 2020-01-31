Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A101C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E41206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTy0jJGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E41206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYgS-0002T1-6k
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 10:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixY8A-0001Cz-MT
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixY85-0002B4-Hg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:22:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27462
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixY85-00021f-DG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580484161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fU5Q9tAwBYTsvgE9OlTFZHnEXlfsFRDbT/TVi3Mr1rc=;
 b=GTy0jJGt6oXR+lqEjZh/NMbKdN7jGHG7+4R7ufZKpaCWouu7Ln+qLDs20d/5JnojY2mWah
 DYUCa4ODANQ2QuqI3vgpsY8GTtil9NNh7WQmA9L3dXNW+JwNUZZkd897pmtF7YkvPmzgKb
 IIGrU9pA4NeKio1jwp2MTC1K3WkLDhA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-dCQTsqoVOqKzlvUIZtkkXw-1; Fri, 31 Jan 2020 10:22:40 -0500
Received: by mail-wm1-f72.google.com with SMTP id p5so2949270wmc.4
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vtsd8qbd0GVSBzMa2gL/dKjK2YFld8SxxOYyDlMtD5E=;
 b=n92GZpwEN6q4+Mlovyl0lRUSuW2hijXUZTjfkBUKefkm/m375o1Sf7ulDveZZ62FGa
 ODNLGGcI906cmXhd1p8+t3eAV8eaGen7PgCcay8Pb2M7KLjUvZwYs1WP+eqaBRS8WN7s
 2HSySR3t/tcfMY98yO5TGuOGpXYsBUpLrxl5q2uNgsT0iWYCQoE5IPCBou3wS3wjg4a2
 Hm8R3Rv8Ar2P8P6LsenZL3dXGJ5sW7FEgeVzIdHE829uEvWKU+RJXXg3ofgn6Uyc5rB1
 q+A36DruurIJw6Wo0QUzN0PHTaMbnpvghws8AKyJ0qZQsoDf+kT8daSMjHLwS0uW4zrS
 OC+g==
X-Gm-Message-State: APjAAAUk32VYIwfrK1sA/GXHBRnwvWA8vzrnjmwlTMt+QybNrsWwrRNd
 SjMZMFXZgp0VhwoOYefbEeXFOZN4EFKtexznxDrR4n4qZ0amVIncZul1fWriMCk5lNcrqPXMZRV
 eL9vScrsIW1hDRPk=
X-Received: by 2002:a1c:1b42:: with SMTP id b63mr12885588wmb.16.1580484158666; 
 Fri, 31 Jan 2020 07:22:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFv2EPzeHmGY5DjwLV7fzsv7m+45OtWqIvBRdtR+NIrj3AOvJVd0I1vih61bGZ0xendy8Jwg==
X-Received: by 2002:a1c:1b42:: with SMTP id b63mr12885560wmb.16.1580484158368; 
 Fri, 31 Jan 2020 07:22:38 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id 133sm3812095wmd.5.2020.01.31.07.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:22:37 -0800 (PST)
Subject: Re: [PATCH v2 01/12] tests/docker: move most cross compilers to
 buster base
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0d238467-022b-0024-ac40-452b49361fe1@redhat.com>
Date: Fri, 31 Jan 2020 16:22:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200130113223.31046-2-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: dCQTsqoVOqKzlvUIZtkkXw-1
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 12:32 PM, Alex Benn=C3=A9e wrote:
> This includes fixing up the dependencies (Which were already wrong for
> one of the mips variants).
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/docker/Makefile.include                    | 16 ++++++++--------
>   tests/docker/dockerfiles/debian-amd64.docker     |  2 +-
>   .../docker/dockerfiles/debian-armel-cross.docker |  2 +-
>   .../docker/dockerfiles/debian-armhf-cross.docker |  2 +-
>   .../dockerfiles/debian-mips64el-cross.docker     |  2 +-
>   .../dockerfiles/debian-mipsel-cross.docker       |  2 +-
>   .../dockerfiles/debian-ppc64el-cross.docker      |  2 +-
>   .../docker/dockerfiles/debian-s390x-cross.docker |  2 +-
>   8 files changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
> index 19dbe26169..43a8678688 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -91,19 +91,12 @@ endif
>   # Enforce dependencies for composite images
>   docker-image-debian9-mxe: docker-image-debian9
>   ifeq ($(HOST_ARCH),x86_64)
> -docker-image-debian-amd64: docker-image-debian9
> +docker-image-debian-amd64: docker-image-debian10
>   DOCKER_PARTIAL_IMAGES +=3D debian-amd64-cross
>   else
>   docker-image-debian-amd64-cross: docker-image-debian10
>   DOCKER_PARTIAL_IMAGES +=3D debian-amd64
>   endif
> -docker-image-debian-armel-cross: docker-image-debian9
> -docker-image-debian-armhf-cross: docker-image-debian9
> -docker-image-debian-mips-cross: docker-image-debian9
> -docker-image-debian-mipsel-cross: docker-image-debian9
> -docker-image-debian-mips64el-cross: docker-image-debian9
> -docker-image-debian-ppc64el-cross: docker-image-debian9
> -docker-image-debian-s390x-cross: docker-image-debian9
>   docker-image-debian-win32-cross: docker-image-debian9-mxe
>   docker-image-debian-win64-cross: docker-image-debian9-mxe
>  =20
> @@ -118,12 +111,19 @@ endif
>  =20
>   docker-image-debian-alpha-cross: docker-image-debian10
>   docker-image-debian-arm64-cross: docker-image-debian10
> +docker-image-debian-armel-cross: docker-image-debian10
> +docker-image-debian-armhf-cross: docker-image-debian10
>   docker-image-debian-hppa-cross: docker-image-debian10
>   docker-image-debian-m68k-cross: docker-image-debian10
> +docker-image-debian-mips-cross: docker-image-debian10
>   docker-image-debian-mips64-cross: docker-image-debian10
> +docker-image-debian-mips64el-cross: docker-image-debian10
> +docker-image-debian-mipsel-cross: docker-image-debian10
>   docker-image-debian-powerpc-cross: docker-image-debian10
>   docker-image-debian-ppc64-cross: docker-image-debian10
> +docker-image-debian-ppc64el-cross: docker-image-debian10
>   docker-image-debian-riscv64-cross: docker-image-debian10
> +docker-image-debian-s390x-cross: docker-image-debian10
>   docker-image-debian-sh4-cross: docker-image-debian10
>   docker-image-debian-sparc64-cross: docker-image-debian10
>  =20
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
> index 431e947ebd..3b860af106 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -4,7 +4,7 @@
>   # This docker target builds on the debian Stretch base image. Further
>   # libraries which are not widely available are installed by hand.
>   #
> -FROM qemu:debian9
> +FROM qemu:debian10
>   MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  =20
>   RUN apt update && \
> diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/d=
ocker/dockerfiles/debian-armel-cross.docker
> index 15378f8ea2..e3794a61c9 100644
> --- a/tests/docker/dockerfiles/debian-armel-cross.docker
> +++ b/tests/docker/dockerfiles/debian-armel-cross.docker
> @@ -3,7 +3,7 @@
>   #
>   # This docker target builds on the debian Stretch base image.
>   #
> -FROM qemu:debian9
> +FROM qemu:debian10
>   MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  =20
>   # Add the foreign architecture we want and install dependencies
> diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/d=
ocker/dockerfiles/debian-armhf-cross.docker
> index 4a20af6fe1..e163b8b956 100644
> --- a/tests/docker/dockerfiles/debian-armhf-cross.docker
> +++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
> @@ -3,7 +3,7 @@
>   #
>   # This docker target builds on the debian Stretch base image.
>   #
> -FROM qemu:debian9
> +FROM qemu:debian10
>  =20
>   # Add the foreign architecture we want and install dependencies
>   RUN dpkg --add-architecture armhf
> diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/test=
s/docker/dockerfiles/debian-mips64el-cross.docker
> index 2fca112405..453b53ef72 100644
> --- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
> @@ -4,7 +4,7 @@
>   # This docker target builds on the debian Stretch base image.
>   #
>  =20
> -FROM qemu:debian9
> +FROM qemu:debian10
>  =20
>   MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  =20
> diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/=
docker/dockerfiles/debian-mipsel-cross.docker
> index 4abf7832ac..3b6e975c68 100644
> --- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
> +++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
> @@ -3,7 +3,7 @@
>   #
>   # This docker target builds on the debian Stretch base image.
>   #
> -FROM qemu:debian9
> +FROM qemu:debian10
>  =20
>   MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  =20
> diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests=
/docker/dockerfiles/debian-ppc64el-cross.docker
> index 9973df9ff7..cd386f01d9 100644
> --- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
> +++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
> @@ -3,7 +3,7 @@
>   #
>   # This docker target builds on the debian Stretch base image.
>   #
> -FROM qemu:debian9
> +FROM qemu:debian10
>  =20
>   # Add the foreign architecture we want and install dependencies
>   RUN dpkg --add-architecture ppc64el && \
> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/d=
ocker/dockerfiles/debian-s390x-cross.docker
> index eb73c98855..43fe59836f 100644
> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
> @@ -3,7 +3,7 @@
>   #
>   # This docker target builds on the debian Stretch base image.
>   #
> -FROM qemu:debian9
> +FROM qemu:debian10
>  =20
>   # Add the s390x architecture
>   RUN dpkg --add-architecture s390x
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


