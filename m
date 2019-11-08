Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A339AFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5D42085B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zr1iuotV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5D42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT30h-00018v-Ko
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iT2zn-0000T8-84
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iT2zl-0003DI-UL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:04:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29357
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iT2zl-0003Au-Qd
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573214645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HU5M3CzU/w1/r0d+V0Co2DNK9MgH+Xi0kKIiDzxYqgk=;
 b=Zr1iuotV9WOfItwfNB5d2y2rBXvY+BrZV9rpjiSgFCLPzVO++ukVVi3Gzejw/YG42Nwfud
 FjvkALxaW0ha0rEJKqmD52lU4L33Ktt4U5Y6HEErbUfh7w6d0EHRNgv27mvoQCM7a8w/lK
 xnrkCg6NnfLgUW0vHCYMchseNOrDNmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-tKpMsQaDN7qpQfsLUEOJ-g-1; Fri, 08 Nov 2019 07:04:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 537DC800C72;
 Fri,  8 Nov 2019 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-167.ams2.redhat.com
 [10.36.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBC14600D3;
 Fri,  8 Nov 2019 12:03:50 +0000 (UTC)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
 <b6005d59-c5d2-1844-db94-a67e258c2867@redhat.com>
 <d0cf0f78-a0c9-e0fa-7959-ecdebf27f912@redhat.com>
 <f688cac2-d370-23af-27fd-fa1f3c3637f9@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <599870e8-a2d8-8160-4ab5-718db200a3c6@redhat.com>
Date: Fri, 8 Nov 2019 13:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <f688cac2-d370-23af-27fd-fa1f3c3637f9@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tKpMsQaDN7qpQfsLUEOJ-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2019 12.39, Laszlo Ersek wrote:
> On 11/08/19 11:42, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 11/8/19 11:34 AM, Thomas Huth wrote:
>>> On 08/11/2019 11.28, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> The bzip2 tool is not included in default installations.
>>>> On freshly installed systems, ./configure succeeds but 'make'
>>>> might fail later:
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>>>>  =C2=A0=C2=A0 /bin/sh: bzip2: command not found
>>>>  =C2=A0=C2=A0 make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.f=
d] Error 127
>>>>  =C2=A0=C2=A0 make: *** Deleting file 'pc-bios/edk2-i386-secure-code.f=
d'
>>>>  =C2=A0=C2=A0 make: *** Waiting for unfinished jobs....
>>>>
>>>> Add a check in ./configure to warn the user if bzip2 is missing.
>>>>
>>>> Fixes: 536d2173b2b
>>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> ---
>>>>  =C2=A0 configure | 7 +++++++
>>>>  =C2=A0 1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/configure b/configure
>>>> index efe165edf9..9957e913e8 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -1851,6 +1851,13 @@ python_version=3D$($python -c 'import sys;
>>>> print("%d.%d.%d" % (sys.version_info[0]
>>>>  =C2=A0 # Suppress writing compiled files
>>>>  =C2=A0 python=3D"$python -B"
>>>> +# Some firmware binaries are compressed with bzip2
>>>> +if has bzip2; then
>>>> +=C2=A0 :
>>>> +else
>>>> +=C2=A0 error_exit "bzip2 program not found. Please install it"
>>>> +fi
>>>
>>> It's only required for the edk2 binaries, isn't it? So should this
>>> maybe also check whether we build any of the i386-softmmu,
>>> x86_64-softmmu arm-softmmu or aarch64-softmmu targets and pass otherwis=
e?
>>
>> I have this on my TODO somewhere, because we extract the edk2 firmwares
>> even if we only build MIPS/PowerPC.
>=20
> But that applies to all of "BLOBS" in the root-level Makefile, doesn't
> it? We also install, say, "vgabios-qxl.bin", when only the MIPS/PowerPC
> system emulators are built.

IIRC there was another odd dependency that the PCI devices need their=20
ROM also on non-x86 systems... but that's another story...

> The only aspect that's specific to edk2
> binaries is that they are kept compressed until installation time, to
> save space in the git repo and in the source tarball.

I noticed that there are also some iotests that use bzip2 ... they are=20
not used during the build process, but still, it might be better to=20
simply always require bzip2, also in case some other architectures want=20
to use it. So I'm also fine if we simply always require bzip2 for the build=
.

  Thomas

PS: Anybody interested in writing a patch to compress the other big=20
binaries in the pc-bios folder, too? ... skiboot.lid ...=20
openbios-sparc64 ... ppc_rom.bin ...


