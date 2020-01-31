Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0EDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:04:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64F420705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DWkw6Zij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64F420705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXqi-0002b0-5k
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 10:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1ixXpL-0001KG-N8
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1ixXpK-0003A7-9r
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:03:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40750)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1ixXpK-00038j-17
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:03:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VErgXb062498;
 Fri, 31 Jan 2020 15:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=zXBsTISomMyCgoC+86sjB1Wwa6DygwQ46La4orjAFNg=;
 b=DWkw6Zijw6LHrAPbDQ20fhMUnv5w4XUqFoX6UmnS8BymXyZGv4QaBA0jc43zfikbZ/JA
 Uoz+4eU5PrfBSfTibp5CaGTBp/YCcv5jo5lkcx55K5G6fpY38RWS5dTvjyVGNs/Uvxtg
 7lueZLlo7Zveh0TyVlvQd1Er2CvU5838F0v9z5UBOMza5o22uwcJojdXeTXBuDMKZNny
 UuKSVqc3kjfBWy7X1NS8kJYELXtnIfNfwfyheuamdj4CSBt5/EM0rAjjGw4SWTSKIXVG
 2jrBkwZuxlXYu8QG0y2ROLQ903h9R81cy6/4pPkiO6mchMvNgczanacMPxkv5GrPbTR6 uQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xrearttfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jan 2020 15:03:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VF0IW4011081;
 Fri, 31 Jan 2020 15:03:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2xv8nr55xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jan 2020 15:03:11 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00VF3Aq1007004;
 Fri, 31 Jan 2020 15:03:10 GMT
Received: from [10.175.183.219] (/10.175.183.219)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jan 2020 07:03:10 -0800
Subject: Re: [PATCH 6/6] tests/boot_linux_console: add PVH acceptance tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 alex.bennee@linaro.org, fam@euphon.net
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-7-git-send-email-liam.merwick@oracle.com>
 <33e03e74-e579-c0e8-e1fc-bd408aeb32e8@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <8bf4b25b-0e1b-1d7a-d166-e7b746dba207@oracle.com>
Date: Fri, 31 Jan 2020 15:03:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <33e03e74-e579-c0e8-e1fc-bd408aeb32e8@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310127
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 00VErgXb062498
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
Cc: slp@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 pbonzini@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/2020 23:57, Philippe Mathieu-Daud=E9 wrote:
> On 1/27/20 5:36 PM, Liam Merwick wrote:
>> Add tests to boot an uncompressed kernel using the x86/HVM direct boot=
=20
>> ABI.
>> The vmlinux binary is obtained from a small RPM for Kata containers an=
d
>> extracted using the new extract_from_rpm() method.
>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> ---
>> =A0 tests/acceptance/boot_linux_console.py | 49=20
>> +++++++++++++++++++++++++++++-----
>> =A0 1 file changed, 43 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py=20
>> b/tests/acceptance/boot_linux_console.py
>> index 6af19ae3b14a..ab2200aa0e47 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -65,15 +65,26 @@ class BootLinuxConsole(Test):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 os.chdir(cwd)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return self.workdir + '/' + path
>> -=A0=A0=A0 def do_test_x86_64_machine(self):
>> +=A0=A0=A0 def do_test_x86_64_machine(self, pvh=3DFalse):
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 :avocado: tags=3Darch:x86_64
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 """
>> -=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
>> ('https://archives.fedoraproject.org/pub/archive/fedora'
>> -                     =20
>> '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 '/vml=
inuz')
>> -=A0=A0=A0=A0=A0=A0=A0 kernel_hash =3D '23bebd2680757891cf7adedb033532=
163a792495'
>> -=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.fetch_asset(kernel_url,=20
>> asset_hash=3Dkernel_hash)
>> +=A0=A0=A0=A0=A0=A0=A0 if pvh:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rpm_url =3D ('https://yum.oracle.co=
m/repo/OracleLinux/'
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'O=
L7/olcne/x86_64/getPackage/'
>> +                      =20
>> 'kernel-uek-container-4.14.35-1902.6.6.1.el7.x86_64.rpm')
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rpm_hash =3D '4c781711a9d32dcb8e81d=
a2b397cb98926744e23'
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rpm_path =3D self.fetch_asset(rpm_u=
rl, asset_hash=3Drpm_hash)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.extract_from_r=
pm(rpm_path,
>> +                                               =20
>> './usr/share/kata-containers/'
>> +                                   =20
>> 'vmlinux-4.14.35-1902.6.6.1.el7.container')
>> +=A0=A0=A0=A0=A0=A0=A0 else:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_url =3D=20
>> ('https://archives.fedoraproject.org/pub/archive/'
>> +                         =20
>> 'fedora/linux/releases/29/Everything/x86_64/os/'
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 'images/pxeboot/vmlinuz')
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_hash =3D '23bebd2680757891cf=
7adedb033532163a792495'
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kernel_path =3D self.fetch_asset(ke=
rnel_url,=20
>> asset_hash=3Dkernel_hash)
>> +
>=20
> Can you try using a dictionaries instead? This way we can add more=20
> images easily.
> See IMAGE_INFO in tests/acceptance/linux_ssh_mips_malta.py.

I can. I won't convert the users of extract_from_deb() but will try make=20
it easily extendable.


--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -31,6 +31,29 @@ class BootLinuxConsole(Test):

      KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '

+    KERNEL_PATH_INFO =3D {
+        ('x86_64', 'bzImage'): {
+            'type': 'file',
+            'url': 'https://archives.fedoraproject.org/'
+                   'pub/archive/fedora/linux/releases/29/Everything/'
+                   'x86_64/os/images/pxeboot/vmlinuz',
+            'hash': '23bebd2680757891cf7adedb033532163a792495'
+        }
+    }
+
+    def get_kernel_path(self, key):
+        """
+        For the provided key, download (and extract, if necessary) the=20
kernel
+        and return the path the the kernel binary.
+
+        :param key: index into KERNEL_PATH_INFO dict containing kernel=20
location
+        :returns: path of the extracted file
+        """
+        dinfo =3D self.KERNEL_PATH_INFO[(self.arch, key)]
+
+        if dinfo['type'] is 'file':
+            return self.fetch_asset(dinfo['url'], asset_hash=3Ddinfo['ha=
sh'])
+
      def wait_for_console_pattern(self, success_message):
          wait_for_console_pattern(self, success_message,
                                   failure_message=3D'Kernel panic - not=20
syncing')
@@ -72,11 +95,7 @@ class BootLinuxConsole(Test):
          Common routine to boot an x86_64 guest.
          Caller must specify tags=3Darch and tags=3Dmachine
          """
-        kernel_url =3D=20
('https://archives.fedoraproject.org/pub/archive/fedora'
-=20
'/linux/releases/29/Everything/x86_64/os/images/pxeboot'
-                      '/vmlinuz')
-        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
-        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+        kernel_path =3D self.get_kernel_path('bzImage')
          self.vm.set_console()
          kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE +=20
'console=3DttyS0'
          self.vm.add_args('-kernel', kernel_path,


Regards,
Liam


