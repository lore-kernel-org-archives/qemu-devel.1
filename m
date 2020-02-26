Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419B7C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4E2222C2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tiqOTesf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4E2222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70bQ-0004Qt-3K
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1j70aZ-0003ii-KF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1j70aY-0003JA-1g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:35:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1j70aX-0003CU-OA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:35:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QHWZWW021726;
 Wed, 26 Feb 2020 17:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AF/orsysS17ScJjbrih4kRwJjVlS+7wHJ2giBLo5lw8=;
 b=tiqOTesfF4UdBJnDooYOTM1C74+TzFh88oez3Mb56NCUAVWh0f+v8FFZIxmPOTKenLXB
 EHd/Xhn4SJV5TpDYOEUDA49GIwsEq5woCLIOKdeNN0L52KsGwLRoewbHDUQlcVw1UC7k
 OtZ2LIQpVom4ek0O6bAq77+famSNZp3PtBnGhERRPi/Mb1pCbS4FmIqm/o25B6Kq3bpi
 wXDMa0mHLjr55Qss3Ap/7EdLfDrTDbi/R9QRYExECqWuV8/gOBy8gO4YCax/JQaRaeET
 lWYrkym2zAwXD2x7uApmU1UOzXWecJWwUyZh/0i1XcmhIWtGvkbIZaXxqEk/uu5a+aqA UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2ydct3583d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 17:35:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QHWgw5065880;
 Wed, 26 Feb 2020 17:35:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2ydcsa9umu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 17:35:09 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01QHZ77M014049;
 Wed, 26 Feb 2020 17:35:08 GMT
Received: from [10.175.167.101] (/10.175.167.101) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Wed, 26 Feb 2020 09:34:58 -0800
USER-AGENT: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <92dac8fb-87ae-d1a9-8bcf-5c39c8479816@oracle.com>
Date: Wed, 26 Feb 2020 09:34:55 -0800 (PST)
From: Liam Merwick <liam.merwick@oracle.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Denis
 Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/29] tests/acceptance: Use 'machine' tag to check if
 available in QEMU binary
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-10-philmd@redhat.com>
 <e1100e02-33aa-02a4-c59b-ad04f214972a@oracle.com>
In-Reply-To: <e1100e02-33aa-02a4-c59b-ad04f214972a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=4 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=4 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260115
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 01QHWZWW021726
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/02/2020 18:17, Liam Merwick wrote:
> On 29/01/2020 21:23, Philippe Mathieu-Daud=C3=A9 wrote:
>> We already use the 'machine' tag in Avocado tests.
>> If the requested machine is not available in the QEMU binary,
>> the tests will be cancelled (skipped):
>>
>> =C2=A0=C2=A0 $ python -m avocado --show=3Dapp run=20
>> tests/acceptance/x86_cpu_model_versions.py
>> =C2=A0=C2=A0=C2=A0 ...
>> =C2=A0=C2=A0=C2=A0 (04/11) CascadelakeArchCapabilities.test_4_1: CANCE=
L: Test expects=20
>> machine 'pc-i440fx-4.1' which is missing from QEMU binary (0.10 s)
>> =C2=A0=C2=A0=C2=A0 (05/11) CascadelakeArchCapabilities.test_4_0: CANCE=
L: Test expects=20
>> machine 'pc-i440fx-4.0' which is missing from QEMU binary (0.11 s)
>> =C2=A0=C2=A0=C2=A0 ...
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> =C2=A0 tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>> =C2=A0 1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/acceptance/avocado_qemu/__init__.py=20
>> b/tests/acceptance/avocado_qemu/__init__.py
>> index e7d5affe24..53ec8512d1 100644
>> --- a/tests/acceptance/avocado_qemu/__init__.py
>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>> @@ -20,6 +20,7 @@ SRC_ROOT_DIR =3D=20
>> os.path.join(os.path.dirname(__file__), '..', '..', '..')
>> =C2=A0 sys.path.append(os.path.join(SRC_ROOT_DIR, 'python'))
>> =C2=A0 from qemu.binutils import binary_get_arch
>> +from qemu.binutils import binary_get_machines
>> =C2=A0 from qemu.binutils import binary_get_version
>> =C2=A0 from qemu.machine import QEMUMachine
>> @@ -118,9 +119,6 @@ class Test(avocado.Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.arch =3D s=
elf.params.get('arch',
>>                                      =20
>> default=3Dself._get_unique_tag_val('arch'))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.machine =3D self.para=
ms.get('machine',
>> -                                      =20
>> default=3Dself._get_unique_tag_val('machine'))
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Verify qemu_b=
in
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default_qemu_bi=
n =3D pick_default_qemu_bin(arch=3Dself.arch)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.qemu_bin =3D=
 self.params.get('qemu_bin',
>> @@ -151,6 +149,15 @@ class Test(avocado.Test):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if bin_arch !=3D self.arch:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.cancel(fmt.format(self.arch, bin_arch=
))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Verify machine
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.machine =3D self.para=
ms.get('machine',
>> +                                      =20
>> default=3Dself._get_unique_tag_val('machine'))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logger.debug('machine: {}'=
.format(self.machine))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.machine:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fm=
t =3D "Test expects machine '{}' which is missing from=20
>> QEMU binary"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 self.machine not in binary_get_machines(self.qemu_bin):
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 self.cancel(fmt.format(self.machine))
>> +
>=20
> Starting with this patch:
>=20
> $ avocado run --filter-by-tags arch:x86_64 tests/acceptance
> ...
> /boot_linux_console.py:BootLinuxConsole.test_x86_64_pc: CANCEL: Test=20
> expects machine 'pc' which is missing from QEMU binary (0.05 s)
> ...
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -machine help
> Supported machines are:
> microvm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 microvm (i386)
> pc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Standard PC (i440FX + PIIX, 1996)=
 (alias of=20
> pc-i440fx-5.0)
> ...
>=20
> but checking via QMP, 'pc' (and 'q35') is listed as 'alias'
> ...
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ho=
tpluggable-cpus": true,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "na=
me": "pc-i440fx-5.0",
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "nu=
ma-mem-supported": true,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "de=
fault-cpu-type": "qemu64-x86_64-cpu",
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "is=
-default": true,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "cp=
u-max": 255,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "de=
precated": false,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "al=
ias": "pc"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> ...
>=20
> Does 'alias' need to be checked by binary_get_machines() in Patch8 as=20
> well as 'name'?
>=20

When I made this change (I'm sure there is a more Pythonesque way)

--- a/python/qemu/binutils.py
+++ b/python/qemu/binutils.py
@@ -65,7 +65,12 @@ def binary_get_machines(qemu_bin):
          res =3D vm.command('query-machines')
          LOG.info(res)
          vm.shutdown()
-        return [m['name'] for m in res]
+        d =3D []
+        for m in res:
+            d +=3D [m['name']]
+            if 'alias' in m:
+                d +=3D [m['alias']]
+        return d



I can then use binary_get_machines() in my PVH acceptance test patches.

@@ -72,11 +74,16 @@ class BootLinuxConsole(Test):
          os.chdir(cwd)
          return os.path.normpath(os.path.join(self.workdir, path))

-    def test_x86_64_pc(self):
+    def do_test_x86_64_machine(self):
          """
-        :avocado: tags=3Darch:x86_64
-        :avocado: tags=3Dmachine:pc
+        Common routine to boot an x86_64 guest.
+        Caller must specify tags=3Darch and tags=3Dmachine
          """
+
+        if self.machine not in binary_get_machines(self.qemu_bin):
+            raise TestCancel('QEMU binary %s does not support machine=20
class %s'
+                             % (self.qemu_bin, self.machine))
+

otherwise I was getting

  (1/7)=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:=20
CANCEL: Test expects machine 'pc' which is missing from QEMU binary (0.03=
 s)

Regards,
Liam

