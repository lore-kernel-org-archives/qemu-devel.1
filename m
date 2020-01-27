Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1355C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF4D20842
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 08:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8sXZn8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF4D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivzgW-0000w5-Im
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 03:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ivzfr-0000Qu-7r
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ivzfn-0005i0-KL
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:23:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ivzfn-0005gV-2r
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 03:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580113385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/tTcZ0EQg+wctppff0s86blRCdRIVqon2kTc/lUlXY=;
 b=b8sXZn8NAYoWmvnOvk0+CRj6j2XKjxpsqxL/iXwZot1IfdUghifnpoxW5U1nBrHQcL8Ge+
 ceYp/jcSzS62oZoOSp0/OerFt7foeKBW+blCVb4tAJsa2nxz3JPHYcRMdn8vSttYbjjFaG
 6D2irRFhKiFubfVrh6loBNXtciy1fxI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-Yfm6R48vNxqM9FHO4d4NsA-1; Mon, 27 Jan 2020 03:23:03 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so5680358wrx.22
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 00:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FWQ9f0GT43JH2rrdzbGxlj9+Y9fHtnMNjilseCjcj8s=;
 b=k9vMfrsLFR1Xl7z7ghWZthsbY1YKYZswSbBXAHCx8l/v2U7WHElA5CyD7ZHiYcBRs+
 EHAt8niWhIzDLUoulZHnesYt612NWFEnAcL7RzCv9QmLkEWiXM0L9104Jku9lUTq2yfH
 rLVdV/tkferuPH1FSpBlGgmB8K+wwRv1K642IW1ykg853+DfuxuEVN/EspLnf+dhByF9
 9mgR9IV/m+EGG6JYPpH9XhNIoQMXP5M+YZfaqe2UFJBw6w3oasVNfWmVikKB4aNTTfPR
 F9+Z5Qn2wVcN9yHQQG7ZfXmIOXzJXWh9Rd6hCJ9IY50Wpy7A13/KDKwwSSZu3KJGQ3oz
 kf9Q==
X-Gm-Message-State: APjAAAUVYBKmJpB2wqKLy87/vbe0nAOOhKHigScB8x6UaH5BrmBQbBEW
 847mrmsKAEZN3xCAqb/NNAOBaec+izWtQTbYLfd/NVerIhX4d+MI02Z5J14//4OPGW4taZQUXvG
 Te78KzRVAYl1gops=
X-Received: by 2002:adf:df8e:: with SMTP id z14mr18996619wrl.190.1580113382561; 
 Mon, 27 Jan 2020 00:23:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbSjYdoh/uid/lRoUOksP41T57U/wvmPJ4DeRdPbFZcri7UUiaULsF5jvTguN1PSEoJLG5Jg==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr18996589wrl.190.1580113382322; 
 Mon, 27 Jan 2020 00:23:02 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t1sm18510825wma.43.2020.01.27.00.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 00:23:01 -0800 (PST)
Subject: Re: [PATCH v2 2/8] hxtool: Support SRST/ERST directives
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200124162606.8787-1-peter.maydell@linaro.org>
 <20200124162606.8787-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1ff66395-d1c6-3d41-fabe-ab5094c789af@redhat.com>
Date: Mon, 27 Jan 2020 09:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124162606.8787-3-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: Yfm6R48vNxqM9FHO4d4NsA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 5:26 PM, Peter Maydell wrote:
> We want to add support for including rST document fragments
> in our .hx files, in the same way we currently have texinfo
> fragments. These will be delimited by SRST and ERST directives,
> in the same way the texinfo is delimited by STEXI/ETEXI.
> The rST fragments will not be extracted by the hxtool
> script, but by a different mechanism, so all we need to
> do in hxtool is have it ignore all the text inside a
> SRST/ERST section, with suitable error-checking for
> mismatched rST-vs-texi fragment delimiters.
>=20
> The resulting effective state machine has only three states:
>   * flag =3D 0, rstflag =3D 0 : reading section for C output
>   * flag =3D 1, rstflag =3D 0 : reading texi fragment
>   * flag =3D 0, rstflag =3D 1 : reading rST fragment
> and flag =3D 1, rstflag =3D 1 is not possible. Using two
> variables makes the parallel between the rST handling and
> the texi handling clearer; in any case all this code will
> be deleted once we've converted entirely to rST.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   scripts/hxtool | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/hxtool b/scripts/hxtool
> index 7d7c4289e32..0003e7b673d 100644
> --- a/scripts/hxtool
> +++ b/scripts/hxtool
> @@ -7,7 +7,7 @@ hxtoh()
>           case $str in
>               HXCOMM*)
>               ;;
> -            STEXI*|ETEXI*) flag=3D$(($flag^1))
> +            STEXI*|ETEXI*|SRST*|ERST*) flag=3D$(($flag^1))
>               ;;
>               *)
>               test $flag -eq 1 && printf "%s\n" "$str"
> @@ -27,12 +27,17 @@ print_texi_heading()
>   hxtotexi()
>   {
>       flag=3D0
> +    rstflag=3D0
>       line=3D1
>       while read -r str; do
>           case "$str" in
>               HXCOMM*)
>               ;;
>               STEXI*)
> +            if test $rstflag -eq 1 ; then
> +                printf "line %d: syntax error: expected ERST, found '%s'=
\n" "$line" "$str" >&2
> +                exit 1
> +            fi
>               if test $flag -eq 1 ; then
>                   printf "line %d: syntax error: expected ETEXI, found '%=
s'\n" "$line" "$str" >&2
>                   exit 1
> @@ -40,12 +45,38 @@ hxtotexi()
>               flag=3D1
>               ;;
>               ETEXI*)
> +            if test $rstflag -eq 1 ; then
> +                printf "line %d: syntax error: expected ERST, found '%s'=
\n" "$line" "$str" >&2
> +                exit 1
> +            fi
>               if test $flag -ne 1 ; then
>                   printf "line %d: syntax error: expected STEXI, found '%=
s'\n" "$line" "$str" >&2
>                   exit 1
>               fi
>               flag=3D0
>               ;;
> +            SRST*)
> +            if test $rstflag -eq 1 ; then
> +                printf "line %d: syntax error: expected ERST, found '%s'=
\n" "$line" "$str" >&2
> +                exit 1
> +            fi
> +            if test $flag -eq 1 ; then
> +                printf "line %d: syntax error: expected ETEXI, found '%s=
'\n" "$line" "$str" >&2
> +                exit 1
> +            fi
> +            rstflag=3D1
> +            ;;
> +            ERST*)
> +            if test $flag -eq 1 ; then
> +                printf "line %d: syntax error: expected ETEXI, found '%s=
'\n" "$line" "$str" >&2
> +                exit 1
> +            fi
> +            if test $rstflag -ne 1 ; then
> +                printf "line %d: syntax error: expected SRST, found '%s'=
\n" "$line" "$str" >&2
> +                exit 1
> +            fi
> +            rstflag=3D0
> +            ;;
>               DEFHEADING*)
>               print_texi_heading "$(expr "$str" : "DEFHEADING(\(.*\))")"
>               ;;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


