Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C42C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8B320656
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FimgIuci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8B320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXF9-0004Ia-NO
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icWxj-00030T-4p
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icWxg-0003Ch-2n
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icWxe-0003Aa-27
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575474784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrSBXIgFplizIJGW733sIWhfJJbgVQWhR8Tyi4VB5EE=;
 b=FimgIuciNXSqTD0WjCNjBuUM68tEZM0Rsy1L6kHKeTTDrrl+588/TEv9aGrANXuTC+hW0B
 2xwcpgzwoOkwbHga5jOus8qkYIAmygpt6dU8GM4sc0l/YX2/16sBSU+hppXgXFo7jRXUah
 wQOgNKlp8789JOA2CY6UxMK0yXwKQS8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-J_9yop0UPSWOPm-wZWA_vQ-1; Wed, 04 Dec 2019 10:53:03 -0500
Received: by mail-wm1-f70.google.com with SMTP id f191so2252823wme.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8rTEEii87gDdjvwMl+D6c9Fv9roDXWob1LlFNOprxVE=;
 b=lVQmN503+LNfX9FvxkTYdgckKIWrwb/DlLuQdtAEbb84QZLVNZwwHu3vZc7YjNbE7u
 ejXVwgC2923aS97x4Ecgs/wD3O/r3meV+0NiPRt+fN5/GlUjEiXCN4gOWdVB7YQ+W1hz
 B0R0aNQD286fwad+MIl1VHOkFcL5oM7sqEUMtT7bhsvZeeZd3BioWZICm9CB9TxQg0n4
 oU2EO9Qlnrvx44UHrpLNLee1kMl4RDEN1UcJZjG1sN4jpBUrHMqerikO3wXnaAnou48L
 Z7cwCxZagffQdobc7Y2lGqX1vVe5AO6OQwXLse9vsoezNuiebOFjIXgFNwERUxGhTe1S
 UNqA==
X-Gm-Message-State: APjAAAUDxn6kY0msMRqso34dtBY2u9JghODRH8y2Vco2mIfe9frHouvV
 o5HYCN6mYL1hTcHIN3PBEfjTLZjI9m2bIo4VQ/fyg+IWWT1gRcOfbORkZQHIQ/KyXjCv6HeSyfw
 XR6K0dOAcIeeAwEY=
X-Received: by 2002:a1c:2745:: with SMTP id n66mr226232wmn.171.1575474782202; 
 Wed, 04 Dec 2019 07:53:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8FfzAsseU2NvTq1M3SZ3fFqTpVOg/51OodPJ4VQ1mAWX53iZouTbauMZwwkj3QIqx68jfgQ==
X-Received: by 2002:a1c:2745:: with SMTP id n66mr226217wmn.171.1575474781986; 
 Wed, 04 Dec 2019 07:53:01 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id z18sm7082188wmf.21.2019.12.04.07.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 07:53:01 -0800 (PST)
Subject: Re: [PATCH v2 1/7] iotests: Provide a function for checking the
 creation of huge files
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191204154618.23560-1-thuth@redhat.com>
 <20191204154618.23560-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c517b736-4a30-a69d-34c2-a94212676ad9@redhat.com>
Date: Wed, 4 Dec 2019 16:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204154618.23560-2-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: J_9yop0UPSWOPm-wZWA_vQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-block@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 4:46 PM, Thomas Huth wrote:
> Some tests create huge (but sparse) files, and to be able to run those
> tests in certain limited environments (like CI containers), we have to
> check for the possibility to create such files first. Thus let's introduc=
e
> a common function to check for large files, and replace the already
> existing checks in the iotests 005 and 220 with this function.
>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/005       |  5 +----
>   tests/qemu-iotests/220       |  6 ++----
>   tests/qemu-iotests/common.rc | 10 ++++++++++
>   3 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
> index 58442762fe..b6d03ac37d 100755
> --- a/tests/qemu-iotests/005
> +++ b/tests/qemu-iotests/005
> @@ -59,10 +59,7 @@ fi
>   # Sanity check: For raw, we require a file system that permits the crea=
tion
>   # of a HUGE (but very sparse) file. Check we can create it before conti=
nuing.
>   if [ "$IMGFMT" =3D "raw" ]; then
> -    if ! truncate --size=3D5T "$TEST_IMG"; then
> -        _notrun "file system on $TEST_DIR does not support large enough =
files"
> -    fi
> -    rm "$TEST_IMG"
> +    _require_large_file 5T
>   fi
>  =20
>   echo
> diff --git a/tests/qemu-iotests/220 b/tests/qemu-iotests/220
> index 2d62c5dcac..15159270d3 100755
> --- a/tests/qemu-iotests/220
> +++ b/tests/qemu-iotests/220
> @@ -42,10 +42,8 @@ echo "=3D=3D Creating huge file =3D=3D"
>  =20
>   # Sanity check: We require a file system that permits the creation
>   # of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
> -if ! truncate --size=3D513T "$TEST_IMG"; then
> -    _notrun "file system on $TEST_DIR does not support large enough file=
s"
> -fi
> -rm "$TEST_IMG"
> +_require_large_file 513T
> +
>   IMGOPTS=3D'cluster_size=3D2M,refcount_bits=3D1' _make_test_img 513T
>  =20
>   echo "=3D=3D Populating refcounts =3D=3D"
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 0cc8acc9ed..6f0582c79a 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -643,5 +643,15 @@ _require_drivers()
>       done
>   }
>  =20
> +# Check that we have a file system that allows huge (but very sparse) fi=
les
> +#
> +_require_large_file()
> +{
> +    if ! truncate --size=3D"$1" "$TEST_IMG"; then
> +        _notrun "file system on $TEST_DIR does not support large enough =
files"
> +    fi
> +    rm "$TEST_IMG"
> +}

:)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
>   # make sure this script returns success
>   true
>=20


