Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E4EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2285B21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 15:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oCYmrT1K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nG26Ycy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2285B21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izikL-0003kC-9C
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 10:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1izija-00035V-8Q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1izijU-0004Gg-LU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:06:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1izijU-0003y3-BZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 10:06:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016F3xJn158073;
 Thu, 6 Feb 2020 15:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=54HpMFxsTKG6rGaZkF7uzsspAOLzIEvzXPP+H54tHFY=;
 b=oCYmrT1KhNTvWimOJU/u2eZUmSjyqxWuaINle6xn38TXupn+5IqWtXWNJbhujuJnlmEh
 vANZAYxdp8Zsibo5VoNgHjGA64g/rK76/BkQDgC5nAO7js+0QtteqsBRYc1wTqCAfyUj
 DR3MtJl/rvLa6DdAX+I5gazhYM9y7wtNXsGLKuWzDZQTM3T82D782UGIr7a9oaW4vbxv
 ce2FmoVXKfWgAuOadDL++QusryhEDdFB5XlO8NBZp54dok3IFrlGLMbhGOU9NEuR6Xzh
 Khnkg/0f4ZY/Ap/VkMcZ27ucsoDbSwKBwlKQL+kZRwBDKG9jHqLcjL7hiqgPjBg4WL3r 7g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=54HpMFxsTKG6rGaZkF7uzsspAOLzIEvzXPP+H54tHFY=;
 b=nG26Ycy5jhU/jTtmrP4jxQb1RJ3mbf6LsXASfQz33eMjwqDMIsrGV9GM3zXnavQ/lwi+
 I3JZpGwwZAuMHPHXhVidoVunnxfa6wbiXuD7+nTofagMkMEQe882ggWTtzi3OzcaneEM
 75jzCGAQW+MdNEBbhoMu6KcB6kuk7QJ3US31PHTFRiVsgPX2OjempKTJGowi9WkyaAX9
 7wFtXkVOJqYcFkVzSrzGa+w9LdmRpvCTAL3QM2Rgq98Gze8NmkfS2XEl/SkqDCmKd+9/
 fC6uwr1rsnTmNYEmCoGbGxTHutFxX77i56sbpuBF4Eianj810nnkZ4MTbnJQQ+mn0XZk Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2xykbpa8mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2020 15:06:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016F3udL182457;
 Thu, 6 Feb 2020 15:06:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2y080dbtgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 Feb 2020 15:06:02 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 016F60uj012740;
 Thu, 6 Feb 2020 15:06:00 GMT
Received: from [10.175.182.212] (/10.175.182.212)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 06 Feb 2020 07:06:00 -0800
Subject: Re: [PATCH v2 1/6] tests/boot_linux_console: add microvm acceptance
 test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 alex.bennee@linaro.org, fam@euphon.net
References: <1580914565-19675-1-git-send-email-liam.merwick@oracle.com>
 <1580914565-19675-2-git-send-email-liam.merwick@oracle.com>
 <6ceb7e42-125a-ac91-fad6-e67c332c48b4@redhat.com>
 <03a996af-49eb-8c91-eabd-4b9a29270f63@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <09b5f7df-fe96-27c5-8559-1c760522f526@oracle.com>
Date: Thu, 6 Feb 2020 15:05:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <03a996af-49eb-8c91-eabd-4b9a29270f63@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060115
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 016F3xJn158073
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, wainersm@redhat.com,
 slp@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/02/2020 14:09, Philippe Mathieu-Daud=E9 wrote:
> Hi Liam,
>=20
> On 2/6/20 2:57 PM, Philippe Mathieu-Daud=E9 wrote:
>> On 2/5/20 3:56 PM, Liam Merwick wrote:
>>> Refactor test_x86_64_pc() to test_x86_64_machine() so that separate
>>> functions which specify the Avocado tag of ':avocado: tags=3Dmachine:=
'
>>> as being either 'pc' or 'microvm' can be used to test booting a
>>> compressed kernel using either machine class.
>>>
>>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>> =A0 tests/acceptance/boot_linux_console.py | 20 +++++++++++++++++---
>>> =A0 1 file changed, 17 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>> b/tests/acceptance/boot_linux_console.py
>>> index e40b84651b0b..233601b429bd 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -51,10 +51,10 @@ class BootLinuxConsole(Test):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 os.chdir(cwd)
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return self.workdir + path
>>> -=A0=A0=A0 def test_x86_64_pc(self):
>>> +=A0=A0=A0 def do_test_x86_64_machine(self):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> -=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>> -=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>>> +=A0=A0=A0=A0=A0=A0=A0 Common routine to boot an x86_64 guest.
>>> +=A0=A0=A0=A0=A0=A0=A0 Caller must specify tags=3Darch and tags=3Dmac=
hine
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
>>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>>> @@ -70,6 +70,20 @@ class BootLinuxConsole(Test):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 console_pattern =3D 'Kernel command line:=
 %s' %=20
>>> kernel_command_line
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 self.wait_for_console_pattern(console_pat=
tern)
>>> +=A0=A0=A0 def test_x86_64_pc(self):
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:pc
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>> +
>>> +=A0=A0=A0 def test_x86_64_microvm(self):
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>>> +=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Dmachine:microvm
>>> +=A0=A0=A0=A0=A0=A0=A0 """
>>> +=A0=A0=A0=A0=A0=A0=A0 self.do_test_x86_64_machine()
>>> +
>>> =A0=A0=A0=A0=A0 def test_mips_malta(self):
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:mips
>>>
>>
>> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Actually this breaks testing the distrib QEMU:


I happen to have a QEMU RPM installed - how do I override 'make=20
check-acceptance' to pick up /usr/bin/qemu-system-x86_64 (and=20
/usr/share/qemu/bios-microvm.bin - not sure that is a universal location=20
for distros)?   Overriding QTEST_QEMU_BINARY didn't seem to work for me=20
- doesn't appear to apply to the check-acceptance rule.

>=20
>  =A0(1/2)=20
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:=
=20
> PASS (2.58 s)
>  =A0(2/2)=20
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_mic=
rovm:=20
>=20
> Output: 'qemu-system-x86_64: -machine microvm: unsupported machine=20
> type\nUse -machine help to list supported machines\n'
> ERROR: timed out (15.10 s)
>=20
> Do you mind testing the series testing a machine is available?
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg675086.html


Sure. I'll test/review those.

Regards,
Liam


