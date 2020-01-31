Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DD9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8483920705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kaTdO0WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8483920705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXpj-0001Qi-Mm
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 10:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1ixXot-0000za-Ah
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1ixXor-0002tR-Bb
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:02:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1ixXoq-0002sO-UI
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:02:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VErkG0083252;
 Fri, 31 Jan 2020 15:02:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=2R9x3wDchnnzyLdMBDIH6f9u0qJgeAwsPdG7j93NEFs=;
 b=kaTdO0WZETKEK0KWbFqwqKPvzsH1OgQbxRGMEPb5F8vC3/TKYkjKuyC7PRFU7vFcF79p
 W01geBRniNKRRM2CqMiDIMsnltGhrJksKuiFFHuBuZNwM/lybp5wq/ZW6i/XHd2ok7OW
 YFyq1qSMyqcugtZWu9cgRH949sZYfXBHWzoYfpLz1H0ggowpBnaQ4wgZ6+rqyGfvOoBr
 0CrtfhbBpyPLedi5v66Et+ZdbcmKP2Xlt+uwBYYZXljXSmgvBbWoqQuVibZUca6E4eqX
 jxL4duZwkdZMKnWU7XQKIjIkDu+yTQYdsbSk60rEnjodQnU2poQQSvhhMn+yJb9DTJxx dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2xrd3utwk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jan 2020 15:02:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00VF0LEV011249;
 Fri, 31 Jan 2020 15:02:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2xv8nr54h3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jan 2020 15:02:35 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00VF2W41006253;
 Fri, 31 Jan 2020 15:02:32 GMT
Received: from [10.175.183.219] (/10.175.183.219)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jan 2020 07:02:32 -0800
Subject: Re: [PATCH 5/6] tests/boot_linux_console: add extract_from_rpm method
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-6-git-send-email-liam.merwick@oracle.com>
 <20200130120506.mq6tejv5i2k776k5@steredhat>
 <f60513b8-b974-a46b-f829-993e45a0cff9@oracle.com>
 <d6bed079-9e79-5e64-f7e2-76499f24454c@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <027bfff2-ff27-3fc6-05e6-aa5940e7fc04@oracle.com>
Date: Fri, 31 Jan 2020 15:02:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d6bed079-9e79-5e64-f7e2-76499f24454c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=875
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=925 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310127
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 00VErkG0083252
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
Cc: fam@euphon.net, slp@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/2020 19:19, Wainer dos Santos Moschetta wrote:
>=20
> On 1/30/20 1:34 PM, Liam Merwick wrote:
>> On 30/01/2020 12:05, Stefano Garzarella wrote:
>>> On Mon, Jan 27, 2020 at 04:36:33PM +0000, Liam Merwick wrote:
>>>> Add a method to extract a specified file from an RPM to the test's
>>>> working directory and return the path to the extracted file.
>>>>
>>>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>>>> ---
>>>> =C2=A0 tests/acceptance/boot_linux_console.py | 14 ++++++++++++++
>>>> =C2=A0 1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/tests/acceptance/boot_linux_console.py=20
>>>> b/tests/acceptance/boot_linux_console.py
>>>> index 43bc928b03a2..6af19ae3b14a 100644
>>>> --- a/tests/acceptance/boot_linux_console.py
>>>> +++ b/tests/acceptance/boot_linux_console.py
>>>> @@ -51,6 +51,20 @@ class BootLinuxConsole(Test):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(cwd)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.w=
orkdir + path
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 def extract_from_rpm(self, rpm, path):
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Extracts a file from a r=
pm package into the test workdir
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param rpm: path to the =
rpm archive
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :param path: path within=
 the rpm archive of the file to be=20
>>>> extracted
>=20
>=20
> Might not be obvious to users that `path` should start with '.', and if=
=20
> he/she doesn't do that then extract_from_rpm() will silently fail to=20
> extract the file. So could you document that?


Sure.

>=20
>>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :returns: path of the ex=
tracted file
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cwd =3D os.getcwd()
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(self.workdir)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 process.run("rpm2cpio %s=
 | cpio -id %s" % (rpm, path),=20
>>>> shell=3DTrue)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(cwd)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.workdir + '/=
' + path
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Is the extra slash needed? (just because the=
 extract_from_deb()
>>> =C2=A0=C2=A0=C2=A0=C2=A0 doesn't put it)
>>>
>>
>>
>> Yes, I needed to put it in there because the 'path' passed in for
>> processing by cpio is a relative patch unlike the deb arg so it
>> couldn't be just appended to 'self.workdir' which doesn't end in a '/'.
>=20
>=20
> It is a good practice use the `os.path` module methods when dealing wit=
h=20
> filesystem paths. So that can be replaced with:
>=20
>  >>> os.path.normpath(os.path.join('/path/to/workdir', './file/in/rpm')=
)
> '/path/to/workdir/file/in/rpm'
>=20


Will do.  I'll add a patch to fix extract_from_deb() too.

Regards,
Liam


> Thanks,
>=20
> Wainer
>=20
>=20
>>
>>
>> Regards,
>> Liam
>>
>>
>>> Anyway this patch LGTM:
>>>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>>
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def do_test_x86_64_machine(self):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tag=
s=3Darch:x86_64
>>>> --=20
>>>> 1.8.3.1
>>>>
>>>
>>
>=20


