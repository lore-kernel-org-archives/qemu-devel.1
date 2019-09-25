Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E006C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437B021D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 21:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V16VPpEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437B021D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDEZa-0002UR-CH
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 17:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDEYC-0001PE-5u
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDEY6-0007xm-48
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:10:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39665)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDEXz-0007rD-Sj
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 17:10:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so276419wrj.6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TN9RWfy8eXoJgtmTLcGvgehESF4ku5+5IxK6o4Pf1x8=;
 b=V16VPpEVg9V337et3hcFJ2S140A6uhIr8mYUjieC4MYDOqlDlsIchnMyqf0oqiB7ES
 2LFRRuhfMPaU66LxFhZJ/6qmgXe4LZN0ETOkqowPsQuIOa4Sdrg2Kis6qB/ZH3d8t2v9
 5IVxPV7hX9rcHQ0zOs8ED6R9ejRgjlfrg/GY0WQWQQgIy6cB8IDdL4yx/EnqalokkXPy
 kF3uIzairOti1VOAztKGId97qgBcz9SEhTJsvJ0JrJjiv7J9AND+hHZBy8hTYbmgoziQ
 aJEv4hh39wgHs9MmkbBY+8W7E4nEMCCDxotqJc9dmpRgplyefocVW4ISC8uAz7hcpneU
 eSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TN9RWfy8eXoJgtmTLcGvgehESF4ku5+5IxK6o4Pf1x8=;
 b=jjvx7UhHuw8fNNHLpfK17iGfPKXK2d3gF5A2qPrgTJCMQx/EKgaHdECFRijiiMYR7S
 7pDB3Bpvhgj++9+cXoB+ePrhE708xjlTX44+4myRk/sesYjJKtOzOT5AsvYxlIFk5Lde
 ChgwcfSLuHx4b/cXLo53fRFQz80hwyum2vKy/P6O17YP8+38gp9UNsfv0JNcAFvOXyAA
 wPIxQcWaznK3GdH7rFZtEY96sSZzv6bXU5nIS0oLyFks+UELkO9v0hgw6JucCzRlh4Nr
 EM+bMqa8TZJo3wcp10iq6QWYtlrmTqXCj1N5VOOE0yw21Ulp11wI4F2GnTc9PAKh/X5M
 7PAQ==
X-Gm-Message-State: APjAAAWXgqF9VVe0PN3//Ban0iqDcn8Ol9CEQzNLAlfLmNGy7Y70a7PT
 EA/fzJfybtIbgRMmr13R6vqNJQ==
X-Google-Smtp-Source: APXvYqyM6uQArJFpLgy0ryQM582kJmi//hvNQ3BGVtvmAcRkHpfDM+cn7mvp+LI25NFm3XEDlz0A2Q==
X-Received: by 2002:adf:e908:: with SMTP id f8mr240891wrm.210.1569445736385;
 Wed, 25 Sep 2019 14:08:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q10sm503840wrd.39.2019.09.25.14.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 14:08:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 109B41FF87;
 Wed, 25 Sep 2019 22:08:55 +0100 (BST)
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-26-alex.bennee@linaro.org>
 <7e2fffd9-4b88-870f-1c18-1f08c3f44737@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 25/33] tests/docker: Add fedora-win10sdk-cross image
In-reply-to: <7e2fffd9-4b88-870f-1c18-1f08c3f44737@redhat.com>
Date: Wed, 25 Sep 2019 22:08:55 +0100
Message-ID: <87h8509j88.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
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
Cc: Fam Zheng <fam@euphon.net>, Justin Terry <juterry@microsoft.com>,
 jsnow@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Alex,
>
> On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>> To build WHPX (Windows Hypervisor) binaries, we need the WHPX
>> headers provided by the Windows SDK.
>
> Justin is checking with his company if this patch is OK with them,
> I'd rather wait before merging it:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg646351.html
>
> Can you unqueue this and the next patch (which depends of it) meanwhile
> please?
>

OK, done.

> Thanks,
>
> Phil.
>
>> Add a script that fetches the required MSI/CAB files from the
>> latest SDK (currently 10.0.18362.1).
>>
>> Headers are accessible under /opt/win10sdk/include.
>>
>> Set the QEMU_CONFIGURE_OPTS environment variable accordingly,
>> enabling HAX and WHPX. Due to CPP warnings related to Microsoft
>> specific #pragmas, we also need to use the '--disable-werror'
>> configure flag.
>>
>> Cc: Justin Terry <juterry@microsoft.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20190920113329.16787-3-philmd@redhat.com>
>> ---
>>  tests/docker/Makefile.include                 |  2 ++
>>  .../dockerfiles/fedora-win10sdk-cross.docker  | 23 ++++++++++++++++
>>  tests/docker/dockerfiles/win10sdk-dl.sh       | 27 +++++++++++++++++++
>>  3 files changed, 52 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/fedora-win10sdk-cross.docker
>>  create mode 100755 tests/docker/dockerfiles/win10sdk-dl.sh
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.inclu=
de
>> index 3fc7a863e51..e85e73025ba 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -125,6 +125,8 @@ docker-image-debian-ppc64-cross: docker-image-debian=
10
>>  docker-image-debian-riscv64-cross: docker-image-debian10
>>  docker-image-debian-sh4-cross: docker-image-debian10
>>  docker-image-debian-sparc64-cross: docker-image-debian10
>> +docker-image-fedora-win10sdk-cross: docker-image-fedora
>> +docker-image-fedora-win10sdk-cross: EXTRA_FILES:=3D$(DOCKER_FILES_DIR)/=
win10sdk-dl.sh
>>
>>  docker-image-travis: NOUSER=3D1
>>
>> diff --git a/tests/docker/dockerfiles/fedora-win10sdk-cross.docker b/tes=
ts/docker/dockerfiles/fedora-win10sdk-cross.docker
>> new file mode 100644
>> index 00000000000..55ca933d40d
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/fedora-win10sdk-cross.docker
>> @@ -0,0 +1,23 @@
>> +#
>> +# Docker MinGW64 cross-compiler target with WHPX header installed
>> +#
>> +# This docker target builds on the Fedora 30 base image.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +FROM qemu:fedora
>> +
>> +RUN dnf install -y \
>> +        cabextract \
>> +        msitools \
>> +        wget
>> +
>> +# Install WHPX headers from Windows Software Development Kit:
>> +# https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk
>> +ADD win10sdk-dl.sh /usr/local/bin/win10sdk-dl.sh
>> +RUN /usr/local/bin/win10sdk-dl.sh
>> +
>> +ENV QEMU_CONFIGURE_OPTS ${QEMU_CONFIGURE_OPTS} \
>> +    --cross-prefix=3Dx86_64-w64-mingw32- \
>> +    --extra-cflags=3D-I/opt/win10sdk/include --disable-werror \
>> +    --enable-hax --enable-whpx
>> diff --git a/tests/docker/dockerfiles/win10sdk-dl.sh b/tests/docker/dock=
erfiles/win10sdk-dl.sh
>> new file mode 100755
>> index 00000000000..1c35c2a2524
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/win10sdk-dl.sh
>> @@ -0,0 +1,27 @@
>> +#!/bin/bash
>> +#
>> +# Install WHPX headers from Windows Software Development Kit
>> +# https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +WINDIR=3D/opt/win10sdk
>> +mkdir -p ${WINDIR}
>> +pushd ${WINDIR}
>> +# Get the bundle base for Windows SDK v10.0.18362.1
>> +BASE_URL=3D$(curl --silent --include 'http://go.microsoft.com/fwlink/?p=
rd=3D11966&pver=3D1.0&plcid=3D0x409&clcid=3D0x409&ar=3DWindows10&sar=3DSDK&=
o1=3D10.0.18362.1' | sed -nE 's_Location: (.*)/\r_\1_p')/Installers
>> +# Fetch the MSI containing the headers
>> +wget --no-verbose ${BASE_URL}/'Windows SDK Desktop Headers x86-x86_en-u=
s.msi'
>> +while true; do
>> +    # Fetch all cabinets required by this MSI
>> +    CAB_NAME=3D$(msiextract Windows\ SDK\ Desktop\ Headers\ x86-x86_en-=
us.msi 3>&1 2>&3 3>&-| sed -nE "s_.*Error opening file $PWD/(.*): No such f=
ile or directory_\1_p")
>> +    test -z "${CAB_NAME}" && break
>> +    wget --no-verbose ${BASE_URL}/${CAB_NAME}
>> +done
>> +rm *.{cab,msi}
>> +mkdir /opt/win10sdk/include
>> +# Only keep the WHPX headers
>> +for inc in "${WINDIR}/Program Files/Windows Kits/10/Include/10.0.18362.=
0/um"/WinHv*; do
>> +    ln -s "${inc}" /opt/win10sdk/include
>> +done
>> +popd > /dev/null
>>


--
Alex Benn=C3=A9e

