Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14F7FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F1C21D7E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jfbu4Ufj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F1C21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2d7-0005iN-1T
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iT2cB-0004bg-Mh
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iT2cA-00084N-IZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:39:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iT2cA-000848-Fd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573213182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MFgiZXRLx4B0se1rCoKI2dGn6KBZP6GEWL5guv6gDI=;
 b=Jfbu4Ufj/9hYsbjJ/d60hri/8ef/7nTPpaotHvzuuquEy1QGT30q2Alt+oCpqDFROexJBG
 yC0NdVEUM8hr0zgkMw6xn8SzzbF3remgEYrmuAn5JfWsM1fPT4q+SMsekPTgD+gPcEHNta
 /47GamUoSqzYcu9PS6RJ5MbDEN+GtBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-HHY1q-FnN3CVYdm4gvAV0Q-1; Fri, 08 Nov 2019 06:39:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6E131800D7B;
 Fri,  8 Nov 2019 11:39:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-227.ams2.redhat.com
 [10.36.117.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59E685D6B7;
 Fri,  8 Nov 2019 11:39:26 +0000 (UTC)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
 <b6005d59-c5d2-1844-db94-a67e258c2867@redhat.com>
 <d0cf0f78-a0c9-e0fa-7959-ecdebf27f912@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f688cac2-d370-23af-27fd-fa1f3c3637f9@redhat.com>
Date: Fri, 8 Nov 2019 12:39:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d0cf0f78-a0c9-e0fa-7959-ecdebf27f912@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: HHY1q-FnN3CVYdm4gvAV0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-trivial@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/08/19 11:42, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/8/19 11:34 AM, Thomas Huth wrote:
>> On 08/11/2019 11.28, Philippe Mathieu-Daud=C3=A9 wrote:
>>> The bzip2 tool is not included in default installations.
>>> On freshly installed systems, ./configure succeeds but 'make'
>>> might fail later:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>>> =C2=A0=C2=A0 /bin/sh: bzip2: command not found
>>> =C2=A0=C2=A0 make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd]=
 Error 127
>>> =C2=A0=C2=A0 make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>>> =C2=A0=C2=A0 make: *** Waiting for unfinished jobs....
>>>
>>> Add a check in ./configure to warn the user if bzip2 is missing.
>>>
>>> Fixes: 536d2173b2b
>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> =C2=A0 configure | 7 +++++++
>>> =C2=A0 1 file changed, 7 insertions(+)
>>>
>>> diff --git a/configure b/configure
>>> index efe165edf9..9957e913e8 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -1851,6 +1851,13 @@ python_version=3D$($python -c 'import sys;
>>> print("%d.%d.%d" % (sys.version_info[0]
>>> =C2=A0 # Suppress writing compiled files
>>> =C2=A0 python=3D"$python -B"
>>> +# Some firmware binaries are compressed with bzip2
>>> +if has bzip2; then
>>> +=C2=A0 :
>>> +else
>>> +=C2=A0 error_exit "bzip2 program not found. Please install it"
>>> +fi
>>
>> It's only required for the edk2 binaries, isn't it? So should this
>> maybe also check whether we build any of the i386-softmmu,
>> x86_64-softmmu arm-softmmu or aarch64-softmmu targets and pass otherwise=
?
>=20
> I have this on my TODO somewhere, because we extract the edk2 firmwares
> even if we only build MIPS/PowerPC.

But that applies to all of "BLOBS" in the root-level Makefile, doesn't
it? We also install, say, "vgabios-qxl.bin", when only the MIPS/PowerPC
system emulators are built. The only aspect that's specific to edk2
binaries is that they are kept compressed until installation time, to
save space in the git repo and in the source tarball.

I'm reminded of the "external QEMU blob / firmware repo" idea.

Thanks
Laszlo


