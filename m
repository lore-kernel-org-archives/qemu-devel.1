Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A49C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA812051A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hYzY/Tqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA812051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBrv-0008CK-3D
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1ixBrE-0007iZ-Mr
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1ixBrD-0001co-8v
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:35:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1ixBrC-0001TV-NR
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:35:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00UFXixG152337;
 Thu, 30 Jan 2020 15:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=/m0zuViR65AQuWEZKuOew3oN5i/GHd3M7ttRBqmaJNM=;
 b=hYzY/TqzNplFML41ySEiuPFBvmSaCmdZtfi0F942U/9InUY/BvsqCHxdFWFMOvHHia0s
 dC6FAfj3CTh1KvfuYJFJ4ZcgFfpNq/FFlOP59A0mUBihmhJ3LCHXouf0SIpBq1W0Imta
 xXIXTQT4lCAoG7z9zagOg8Bu4fkhnrBHt1rHOrZGnlfgsBr5SjDGwcwIZtHqLhVVGey0
 uL9JqK+LpIZGEn7DxHrEnP4zHc9ZlRlXBwoHfsARPMAHKYWZqfnWxl29kbyvKSsf8W+j
 d7KbF1HluApFzLt6Eo/1olMl8+YZt7CRHC2gakQ/1+XannaI9NC9w3Bdo/IJ/z5rA1kn AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2xrearmq68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jan 2020 15:35:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00UFZ8O6066610;
 Thu, 30 Jan 2020 15:35:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2xu8e8w05y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jan 2020 15:35:31 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00UFYJ1F014194;
 Thu, 30 Jan 2020 15:34:19 GMT
Received: from [10.175.206.58] (/10.175.206.58)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jan 2020 07:34:18 -0800
Subject: Re: [PATCH 5/6] tests/boot_linux_console: add extract_from_rpm method
To: Stefano Garzarella <sgarzare@redhat.com>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-6-git-send-email-liam.merwick@oracle.com>
 <20200130120506.mq6tejv5i2k776k5@steredhat>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <f60513b8-b974-a46b-f829-993e45a0cff9@oracle.com>
Date: Thu, 30 Jan 2020 15:34:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200130120506.mq6tejv5i2k776k5@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001300112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=867 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001300112
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
 qemu-devel@nongnu.org, wainersm@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/2020 12:05, Stefano Garzarella wrote:
> On Mon, Jan 27, 2020 at 04:36:33PM +0000, Liam Merwick wrote:
>> Add a method to extract a specified file from an RPM to the test's
>> working directory and return the path to the extracted file.
>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> ---
>>   tests/acceptance/boot_linux_console.py | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index 43bc928b03a2..6af19ae3b14a 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -51,6 +51,20 @@ class BootLinuxConsole(Test):
>>           os.chdir(cwd)
>>           return self.workdir + path
>>   
>> +    def extract_from_rpm(self, rpm, path):
>> +        """
>> +        Extracts a file from a rpm package into the test workdir
>> +
>> +        :param rpm: path to the rpm archive
>> +        :param path: path within the rpm archive of the file to be extracted
>> +        :returns: path of the extracted file
>> +        """
>> +        cwd = os.getcwd()
>> +        os.chdir(self.workdir)
>> +        process.run("rpm2cpio %s | cpio -id %s" % (rpm, path), shell=True)
>> +        os.chdir(cwd)
>> +        return self.workdir + '/' + path
>                                    ^
>      Is the extra slash needed? (just because the extract_from_deb()
>      doesn't put it)
> 


Yes, I needed to put it in there because the 'path' passed in for
processing by cpio is a relative patch unlike the deb arg so it
couldn't be just appended to 'self.workdir' which doesn't end in a '/'.

Regards,
Liam


> Anyway this patch LGTM:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
>> +
>>       def do_test_x86_64_machine(self):
>>           """
>>           :avocado: tags=arch:x86_64
>> -- 
>> 1.8.3.1
>>
> 


