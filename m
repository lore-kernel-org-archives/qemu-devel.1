Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD912C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A7120661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BuwmEVuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A7120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyMP-0005EG-SD
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1iyyL3-0003uI-Ju
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1iyyL2-00072i-0R
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:34:01 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1iyyL1-0006pw-Mb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:33:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014DX3g9128120;
 Tue, 4 Feb 2020 13:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=C1FpgTu958Ot9QqX2MPEuh7dI8cwGXIhQKe2dOvQhZQ=;
 b=BuwmEVuIZwIorJtJXNUB+25aUuMz0XPUSnzg5dA13v7kXn/qybaWulytIkE7VTU7HEZZ
 95ttEd/qba6VqmKCbGLoXCIUv+C1kUs7KyOfzACPYIt5PM6tiAA4pGgOzrGTLTG7UW1N
 QZ5zHx/SVRdAeSkh79qFn0n2sryOyDC/Dj/uojuCAOPBQ6bcIj6DuzOthp7dK1auDY0G
 yW1UqP4dvQtWn1NqjH4M0U6hkdAtI6RB0aWnc5fDSpbv0eAUh5hppWOkWyrm//Ml0BQJ
 3ULgWAAvS3cOmAMe7gbDtF1KxErqFD2PHkL6Ve+7Xp0QZs8PKnBR+ouY+fZc+44do1GF ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2xwyg9jv8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 13:33:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014DSc18011294;
 Tue, 4 Feb 2020 13:31:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2xxw0wyx48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2020 13:31:45 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014DVhV3011314;
 Tue, 4 Feb 2020 13:31:43 GMT
Received: from [10.175.175.161] (/10.175.175.161)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 04 Feb 2020 05:31:43 -0800
Subject: Re: [PATCH 5/6] tests/boot_linux_console: add extract_from_rpm method
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-6-git-send-email-liam.merwick@oracle.com>
 <20200130120506.mq6tejv5i2k776k5@steredhat>
 <f60513b8-b974-a46b-f829-993e45a0cff9@oracle.com>
 <d6bed079-9e79-5e64-f7e2-76499f24454c@redhat.com>
 <027bfff2-ff27-3fc6-05e6-aa5940e7fc04@oracle.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <0902eab2-8ed2-9f44-4269-02f96d44fa76@oracle.com>
Date: Tue, 4 Feb 2020 13:31:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <027bfff2-ff27-3fc6-05e6-aa5940e7fc04@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=739
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=794 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040097
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 014DX3g9128120
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
Cc: fam@euphon.net, slp@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/01/2020 15:02, Liam Merwick wrote:

[... deleted ...]

>>
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :returns: path of the e=
xtracted file
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cwd =3D os.getcwd()
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(self.workdir)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 process.run("rpm2cpio %=
s | cpio -id %s" % (rpm, path),=20
>>>>> shell=3DTrue)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os.chdir(cwd)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self.workdir + '=
/' + path
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Is the extra slash needed? (just because th=
e extract_from_deb()
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 doesn't put it)
>>>>
>>>
>>>
>>> Yes, I needed to put it in there because the 'path' passed in for
>>> processing by cpio is a relative patch unlike the deb arg so it
>>> couldn't be just appended to 'self.workdir' which doesn't end in a '/=
'.
>>
>>
>> It is a good practice use the `os.path` module methods when dealing=20
>> with filesystem paths. So that can be replaced with:
>>
>> =C2=A0>>> os.path.normpath(os.path.join('/path/to/workdir', './file/in=
/rpm'))
>> '/path/to/workdir/file/in/rpm'
>>
>=20
>=20
> Will do.=C2=A0 I'll add a patch to fix extract_from_deb() too.

Using the exact same code didn't work with extract_from_deb() because=20
the callers set 'path' to an absolute path (so os.path.join() drops the=20
self.workdir part).  I'll include a patch with the following change and=20
it can be dropped if people think using os.path.relpath() is too much of=20
a hack.

--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -49,7 +49,12 @@ class BootLinuxConsole(Test):
          process.run("ar x %s %s" % (deb, file_path))
          archive.extract(file_path, self.workdir)
          os.chdir(cwd)
-        return self.workdir + path
+        # Return complete path to extracted file.  We need to use
+        # os.path.relpath() because callers specify 'path' with a leadin=
g
+        # slash which causes os.path.join() to interpret it as an absolu=
te
+        # path and to drop self.workdir part.
+        return os.path.normpath(os.path.join(self.workdir,
+                                             os.path.relpath(path, '/'))=
)

      def extract_from_rpm(self, rpm, path):
          """

Regards,
Liam

