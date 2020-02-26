Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB1DC4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B30620801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TXwrpspL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B30620801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70cV-0005en-6u
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1j70bp-00050R-OM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1j70bn-00008z-Sp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:36:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1j70bm-0008Qr-33
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:36:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QHWhTf021929;
 Wed, 26 Feb 2020 17:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=usxX5nqPhmvwGWxR8O7L2q+ma7dsV/pW9xlz1p2xANA=;
 b=TXwrpspLTvnR/C8/AGaV3QpepKzXKbyCc6oRskKN/0Ei6O44/F061Y/+76bW5GY3Kp+4
 721d/OYA76qYAK/bjVnc40us9Z0nSz+J6a0xmz6mUsE5uAxt2pkS2DTCjxr/7vY8CUOY
 GZ15AerKJ8drN7wuuhCAEpBXRBGl+dnjdivL2mEJVCG9GuUhh4C4c2rB+tsZ0JWMv6jQ
 dEzebwyaigaDxPZ/Cz/Ijxm2VwBrKods6/AVyAdsOanfLI38US945/PNRemAkzwMyCxW
 QbIziVitQ3SJyasvoxZvDkBQytbHL3n4GcEHwKgmf9kENap6W4ycfwIkhdh/bHf/aEPa 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2ydct3589p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 17:36:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QHWDsR155664;
 Wed, 26 Feb 2020 17:36:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2ydcs2npgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 17:36:14 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01QHaCNT014730;
 Wed, 26 Feb 2020 17:36:12 GMT
Received: from [10.175.167.101] (/10.175.167.101)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Feb 2020 09:36:12 -0800
Subject: Re: [PATCH v2 2/6] tests/boot_linux_console: add BIOS acceptance test
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 alex.bennee@linaro.org, fam@euphon.net, Cleber Rosa <crosa@redhat.com>
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-3-git-send-email-liam.merwick@oracle.com>
 <e7db8848-b8fb-94ff-a229-779b532c5e18@redhat.com>
 <f610e44e-57d8-cfb2-efd1-f567136bf416@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <4cd299b6-443c-fa94-32ae-a6f605a5f971@oracle.com>
Date: Wed, 26 Feb 2020 17:36:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f610e44e-57d8-cfb2-efd1-f567136bf416@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260115
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 01QHWhTf021929
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/02/2020 19:20, Wainer dos Santos Moschetta wrote:
>=20
> On 2/6/20 12:12 PM, Philippe Mathieu-Daud=E9 wrote:
>> On 2/5/20 3:56 PM, Liam Merwick wrote:
>>> Add a test to use qboot with the 'pc' machine class and SeaBIOS with
>>> the 'microvm' machine class (since microvm uses qboot by default) by
>>> adding the '-bios' option via self.vm.add_args() before
>>> calling do_test_x86_64_machine().
>>>
>>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>> =A0 tests/acceptance/boot_linux_console.py | 17 ++++++++++++++++-
>>> =A0 1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>> b/tests/acceptance/boot_linux_console.py
>>> index 233601b429bd..e9375590bc1c 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -61,7 +61,6 @@ class BootLinuxConsole(Test):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 '/vmlinuz')
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_hash =3D '23bebd2680757891cf7adedb=
033532163a792495'
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.fetch_asset(kernel_u=
rl,=20
>>> asset_hash=3Dkernel_hash)
>>> -
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.vm.set_console()
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_command_line =3D self.KERNEL_COMMO=
N_COMMAND_LINE +=20
>>> 'console=3DttyS0'
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.vm.add_args('-kernel', kernel_path,
>>> @@ -77,6 +76,14 @@ class BootLinuxConsole(Test):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>> =A0 +=A0=A0=A0 def test_x86_64_pc_qboot(self):
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 self.vm.add_args('-bios', 'pc-bios/bios-microv=
m.bin')
>=20
> The test boots QEMU with bios file from $PWD/pc-bios/bios-microvm.bin.=20
> If you want to get (optionally) the file from an installed QEMU you=20
> could use Avocado test parameters [1]. Here goes an example:
>=20
> self.vm.add_args('-bios', self.params.get('bios_microvm',=20
> default=3D'pc-bios/bios-microvm.bin'))
>=20
> Then you evoke avocado as:
>=20
> $ avocado run -p bios_microvm=3D/usr/share/qemu/bios-microvm.bin (...)
>=20
> [1]=20
> https://avocado-framework.readthedocs.io/en/75.1/guides/writer/chapters=
/parameters.html=20
>=20
>=20

Thanks Wainer - that works well for my patches.

Regards,
Liam


>=20
>>>
>>
>> This breaks running once QEMU is installed:
>>
>> =A0(2/4)=20
>> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc=
_qboot:=20
>>
>> qemu: could not load PC BIOS 'pc-bios/bios-microvm.bin'
>> ERROR: [Errno 104] Connection reset by peer (0.08 s)
>>
>> Cleber, Wainer, what path should we use?
>=20
>=20
> Philippe, above answers your question?
>=20
> Thanks,
>=20
> - Wainer
>=20
>>
>>
>>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>> +
>>> =A0=A0=A0=A0=A0 def test_x86_64_microvm(self):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>> @@ -84,6 +91,14 @@ class BootLinuxConsole(Test):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>> =A0 +=A0=A0=A0 def test_x86_64_microvm_seabios(self):
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:microvm
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 self.vm.add_args('-bios', 'pc-bios/bios.bin')
>>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>> +
>>> =A0=A0=A0=A0=A0 def test_mips_malta(self):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:mips
>>>
>>
>=20


