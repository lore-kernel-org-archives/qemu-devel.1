Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5123C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D3F2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWLAI5gw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D3F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdYz-0002HB-Tj
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihdYF-0001s5-92
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihdYC-0007fi-W6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:55:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihdYC-0007Xr-9o
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576691755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xz/8bs0ZOiAyKCLNC5vUezDn0ldLr5XIkHTomtsSGvI=;
 b=KWLAI5gwjmh+r4LvygcGZo1fjRi4E/lyE2mhOeYSyHCSWCpov6k7mheI6fiwTxNErbLnqB
 m5t9CPp1jWo7Ji4somjGlMSGjm+ZKOyQZFyd1CD16VTMeMrY8RjyBCumPChwoTRoFs91A0
 jP4aIT/dJEpzlDWI2Lwata0t/mfBSIU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-AIFXogpKPD6hobPZ9m5bjQ-1; Wed, 18 Dec 2019 12:55:53 -0500
Received: by mail-wr1-f70.google.com with SMTP id r2so1177297wrp.7
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 09:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o4BeZ/XdLDEDiEygzh4C7bafSRhdfu8zWAZ7k3FN/AU=;
 b=NKWVRWi1WKNt7gZmXNm+NI1/Gx0m0nUg9cR6xjWGr04M6e6ZiG4P9HwItiWdcq1z/l
 D7tjdVze9e20YIDTMg5TuvmQ7jpOZPje4J5Ll+wNRtVJRpeVPpcjDU3cPApStIGjMWMs
 zO8JAGY4g047lVBcP29cpPcAWdj2+2Cc1uthHSVhWhZAacLDChcxLhA/HodhZzywQXJg
 OnEAh6U1RvFE9Ym9+5iiTYE/EBiSK9su3HcJrYtH971sC6x915rLBZGlSCLNW6pXn7lf
 Gr3X/e95yfbV1r4+XpDTGIZEWzDH5Ptv+12/r2nL18OqnjdHG3QD3NZprpG7kJXd3zdi
 VMMg==
X-Gm-Message-State: APjAAAW+FSX0FRriM+IWVkoBeZ0M3cmCJDAQxtx0VvGGplV+G4VHkiRE
 MBCg5WRR51aNjKo+L3c430J8fpyqNivDFsc4q+CXQ433ldzv/dgo/mEkn/A7BILWWOx9PGaI4df
 YnMubyaQSdHVyejY=
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr4417267wrs.287.1576691752764; 
 Wed, 18 Dec 2019 09:55:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDmf1Ew13JFLgvtzO3fLutO2W76bsQKDaQoDK7zW3Z5bdieoD24Z01O1ihV4gRWGmNXcLcpw==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr4417244wrs.287.1576691752578; 
 Wed, 18 Dec 2019 09:55:52 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id c68sm3245946wme.13.2019.12.18.09.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 09:55:51 -0800 (PST)
Subject: Re: [PATCH 4/7] configure: Always detect -no-pie toolchain support
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218031920.6414-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <71c6e085-b4ad-ac62-46e8-cfe703812ad8@redhat.com>
Date: Wed, 18 Dec 2019 18:55:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218031920.6414-5-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: AIFXogpKPD6hobPZ9m5bjQ-1
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
Cc: i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 4:19 AM, Richard Henderson wrote:
> The CFLAGS_NOPIE and LDFLAGS_NOPIE variables are used
> in pc-bios/optionrom/Makefile, which has nothing to do
> with the PIE setting of the main qemu executables.
>=20
> This overrides any operating system default to build
> all executables as PIE, which is important for ROMs.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure | 18 ++++++++----------
>   1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/configure b/configure
> index 2fb4457d7c..972ce7396f 100755
> --- a/configure
> +++ b/configure
> @@ -2012,26 +2012,24 @@ if ! compile_prog "-Werror" "" ; then
>   =09"Thread-Local Storage (TLS). Please upgrade to a version that does."
>   fi
>  =20
> -if test "$pie" !=3D "no" ; then
> -  cat > $TMPC << EOF
> +cat > $TMPC << EOF
>  =20
>   #ifdef __linux__
>   #  define THREAD __thread
>   #else
>   #  define THREAD
>   #endif
> -
>   static THREAD int tls_var;
> -
>   int main(void) { return tls_var; }
> -
>   EOF
> -  # check we support --no-pie first...
> -  if compile_prog "-Werror -fno-pie" "-no-pie"; then
> -    CFLAGS_NOPIE=3D"-fno-pie"
> -    LDFLAGS_NOPIE=3D"-nopie"
> -  fi
>  =20
> +# Check we support --no-pie first; we will need this for building ROMs.
> +if compile_prog "-Werror -fno-pie" "-no-pie"; then
> +  CFLAGS_NOPIE=3D"-fno-pie"
> +  LDFLAGS_NOPIE=3D"-no-pie"
> +fi
> +
> +if test "$pie" !=3D "no" ; then
>     if compile_prog "-fPIE -DPIE" "-pie"; then
>       QEMU_CFLAGS=3D"-fPIE -DPIE $QEMU_CFLAGS"
>       LDFLAGS=3D"-pie $LDFLAGS"
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


