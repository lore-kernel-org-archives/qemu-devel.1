Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24234C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47D520720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ee/o3U0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47D520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkCJ-0000Dz-2Q
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izkBc-00085i-Rr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izkBb-0007k1-Do
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:39:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30838
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izkBb-0007hn-AA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581007166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E3FB871UFrR8A910GuxHkmWEOhcUhKY155rm8rqLKnE=;
 b=Ee/o3U0ZVDGu2CXo9nQNnr0/qYunTioKT6h+gPLtQ4bz/8sxh7Gg1DoVmOrzEtOwo8djIx
 UFOZA6cBwRzfUAMZLEziOE91mMk0HtFKwRUwFvaZY9diOP3AAJjQINM/EJH+Q4+FVUAiuX
 lbruFtvjO+3G5YgCu1+IDXvOkqwvmJ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-Cj_SB8kdNyaTfbyPytISXQ-1; Thu, 06 Feb 2020 11:39:25 -0500
Received: by mail-wr1-f71.google.com with SMTP id n23so3732277wra.20
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 08:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D5PotJNT+E4jSAMGPLA7Q7JeheexJeazaucLaY47vN0=;
 b=gL3SBoZA2W3GOHYOIk1qeqSeexMaHaO7VgasIm+oDi0p039EaNsXGSkHYszMl/krj5
 4ajCfaIGi6tTRLJrpY/tVkriyQnelHtc4tnBrW6uYZhKEsne9r3cSAEAeW3EIqlxqsCY
 6NvbEai7DZOp6ma9CYdi9SLJP3G2N1iggJFBTfXvKNMvlg5TXtMxyDmSGHeaKjhqmpcr
 KFiBp6Ou3VX0kiiVqu1yXxoZMELarlKyVR+Bmnzxk8vTRFb8cY/Rc2DvqDaFCjvAbdbz
 RaMXj9cP8XyoSfBv0T/h6ifbxMSXwwkfrxzwNkrnecooLu8+Et/Dz8fOaWGttqgPIip/
 qayQ==
X-Gm-Message-State: APjAAAVChJ3hAlii5MbL3+B+qCGMh0F1q5tp/HVqqL4kZvWRGN18fW9e
 h2fj9eV9bj8b3hfiFrLyfjn5nciXkIFvDkIeNXHsDbWFfN7cwS5ZIAWV3rA3W/ZGyIuqYzr80jU
 quqjgcCp/yGTmDpM=
X-Received: by 2002:a1c:6389:: with SMTP id x131mr5348010wmb.174.1581007163913; 
 Thu, 06 Feb 2020 08:39:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqyByNVIu2T+0XFN51dxRYQCooNojoeXhlIThF64bGIr/BBg0y1Pw0dKxBUpVRtMdrrLEDHTsg==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr5347981wmb.174.1581007163575; 
 Thu, 06 Feb 2020 08:39:23 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id q1sm4366866wrw.5.2020.02.06.08.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 08:39:22 -0800 (PST)
Subject: Re: [PATCH v2 03/29] python/qemu: Add binutils::binary_get_version()
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-4-philmd@redhat.com>
 <cfec25d9-95c4-18e9-f4e1-d087a7bc5a2e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4021bd42-6f27-c7c5-d480-f788e1827598@redhat.com>
Date: Thu, 6 Feb 2020 17:39:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cfec25d9-95c4-18e9-f4e1-d087a7bc5a2e@redhat.com>
Content-Language: en-US
X-MC-Unique: Cj_SB8kdNyaTfbyPytISXQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 8:17 PM, Wainer dos Santos Moschetta wrote:
>=20
> On 1/29/20 7:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Add a helper to query the version of a QEMU binary.
>> We simply send the 'query-version' command over a QMP
>> socket.
>> Introduce the PythonQemuCoreScripts class to test our
>> new helper.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> =C2=A0 python/qemu/binutils.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 38 ++++++++++++++++++++++++++++++++
>=20
> I'm not sure about creating the file with that name, it reminds me to=20
> GNU Binutils rather than the QEMU binary. :)
>=20
> Perhaps it could be named qemu_bin.py?

OK, I don't mind.

>=20
> Another suggestion is to encapsulate the methods you propose in this=20
> series in an object. For example:
>=20
> class QEMUBin:
>  =C2=A0=C2=A0=C2=A0 def __init__(self, bin_path):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check bin exists.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.bin_path =3D bin_path
>=20
>  =C2=A0=C2=A0=C2=A0 def get_version(self):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # binutils.binary_get_version=
() goes here.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass
>=20
>  =C2=A0=C2=A0=C2=A0 def get_arch(self):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # binutils.binary_get_arch() =
goes here.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass
>=20
>  =C2=A0=C2=A0=C2=A0 def list_accel(self):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # move accel.list_accel() met=
hod to here.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass
>=20
>  =C2=A0=C2=A0=C2=A0 def get_vm(self, args):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Return an QEMUMachine objec=
t...
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return QEMUMachine(self.bin_p=
ath, *args)
>=20
>  =C2=A0=C2=A0=C2=A0 def get_build_config_host(self):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Detect if self.bin_path is =
in a build directory,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # attempt to read the host-co=
nfig.mak and return
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # as hash. Or fail...
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass

OK, I'll try.

>=20
>> =C2=A0 tests/acceptance/core_scripts.py | 31 ++++++++++++++++++++++++++
>> =C2=A0 2 files changed, 69 insertions(+)
>> =C2=A0 create mode 100644 python/qemu/binutils.py
>> =C2=A0 create mode 100644 tests/acceptance/core_scripts.py
>>
>> diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
>> new file mode 100644
>> index 0000000000..96b200eef4
>> --- /dev/null
>> +++ b/python/qemu/binutils.py
>> @@ -0,0 +1,38 @@
>> +"""
>> +QEMU binary utility module:
>> +
>> +The binary utility module provides helpers to query QEMU binary for
>> +build-dependent configuration options at runtime.
>> +"""
>> +#
>> +# Copyright (c) 2020 Red Hat, Inc.
>> +#
>> +# Author:
>> +#=C2=A0 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or=20
>> later.
>> +# See the COPYING file in the top-level directory.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import logging
>> +
>> +from .machine import QEMUMachine
>> +
>> +LOG =3D logging.getLogger(__name__)
>> +
>> +
>> +def binary_get_version(qemu_bin):
>> +=C2=A0=C2=A0=C2=A0 '''
>> +=C2=A0=C2=A0=C2=A0 Get QEMU binary version
>> +
>> +=C2=A0=C2=A0=C2=A0 @param qemu_bin (str): path to the QEMU binary
>=20
> It could check that qemu_bin file exists, otherwise raise an exception=20
> or return None.

OK.

>=20
>> +=C2=A0=C2=A0=C2=A0 @return binary version (dictionary with major/minor/=
micro keys)
>> +=C2=A0=C2=A0=C2=A0 '''
>> +=C2=A0=C2=A0=C2=A0 with QEMUMachine(qemu_bin) as vm:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.set_machine('none')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.launch()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D vm.command('query-ve=
rsion')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LOG.info(res)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm.shutdown()
>=20
> Don't need this, the vm will be shutdown anyway (see=20
> QEMUMachine.__exit__())

OK.

>=20
> Thanks!
>=20
> - Wainer
>=20
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return res['qemu']
>> diff --git a/tests/acceptance/core_scripts.py=20
>> b/tests/acceptance/core_scripts.py
>> new file mode 100644
>> index 0000000000..3f253337cd
>> --- /dev/null
>> +++ b/tests/acceptance/core_scripts.py
>> @@ -0,0 +1,31 @@
>> +# Tests covering various python/qemu/ scripts
>> +#
>> +# Copyright (c) 2020 Red Hat, Inc.
>> +#
>> +# Author:
>> +#=C2=A0 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or=20
>> later.
>> +# See the COPYING file in the top-level directory.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +import sys
>> +import os
>> +import logging
>> +
>> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..',=20
>> 'python'))
>> +from avocado_qemu import Test
>> +from qemu.binutils import binary_get_version
>> +
>> +
>> +class PythonQemuCoreScripts(Test):
>> +
>> +=C2=A0=C2=A0=C2=A0 def test_get_version(self):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger =3D logging.getLogger=
('core')
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 version =3D binary_get_versi=
on(self.qemu_bin)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger.debug('version: {}'.f=
ormat(version))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # QMP 'query-version' introd=
uced with QEMU v0.14
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertGreaterEqual(vers=
ion['major'], 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if version['major'] =3D=3D 0=
:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.assertGreaterEqual(version['minor'], 14)
>=20


