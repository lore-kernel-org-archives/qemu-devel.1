Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2930C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC77D2051A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sf/zNOk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC77D2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBtY-0000jt-Sf
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.merwick@oracle.com>) id 1ixBt1-0000Ki-60
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.merwick@oracle.com>) id 1ixBt0-0004es-3Z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:37:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
 id 1ixBsz-0004dQ-Rm
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:37:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00UFXmSb152381;
 Thu, 30 Jan 2020 15:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=REA/fyhpQPwEo0O4zh+qY0Mp8X6BCfS8/70r9dw+YXc=;
 b=Sf/zNOk5ZsDH6BUGaA6/nMr5mUGnmGjV41Ywkzvwp1xHtj+oVnMadvS+DjzvwHOY7rJv
 cAw+dG22fvnc1mDSroDufmRSrNzxvdXCd1OlSLW+hNF5m7UZjJol9is3NUxHWiVwbGrl
 SRTD5QwazapRIkEhOpje0F3Rrr1Qvw+/0yNwkUT1I98h6Z2K4gATzeidiAMjNpq9S9m4
 xyE+7J10c53/6qTccO/ZXaVaf+ixH16J4wnYm8SpfPOWI1wjEE2OBnDfJlZpaqM/nuBn
 MkqHs8IKTaKTHyfr/HwCMtnf/s8TygiDvdN/HGFbY2111NLyNKAQRapuso4f3FuHb5T+ 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2xrearmqpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jan 2020 15:37:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00UFZIPi125377;
 Thu, 30 Jan 2020 15:35:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2xuemwm909-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jan 2020 15:35:33 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00UFYCDE027471;
 Thu, 30 Jan 2020 15:34:12 GMT
Received: from [10.175.206.58] (/10.175.206.58)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jan 2020 07:34:12 -0800
Subject: Re: [PATCH 2/6] tests/boot_linux_console: add BIOS acceptance test
To: Stefano Garzarella <sgarzare@redhat.com>
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-3-git-send-email-liam.merwick@oracle.com>
 <20200130112721.vm5u5zv7bifjremw@steredhat>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <ce5b024f-8fd6-d325-a9f7-fbea4ffeff0f@oracle.com>
Date: Thu, 30 Jan 2020 15:34:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200130112721.vm5u5zv7bifjremw@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001300112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
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

On 30/01/2020 11:27, Stefano Garzarella wrote:
> Hi Liam,
> 
> On Mon, Jan 27, 2020 at 04:36:30PM +0000, Liam Merwick wrote:
>> Add tests to use qboot with the 'pc' and 'microvm' machine classes
>> by adding the '-bios' option via self.vm.add_args() before calling
>> do_test_x86_64_machine().
>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> ---
>>   tests/acceptance/boot_linux_console.py | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index aa5b07b1c609..8daf6461ffac 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py

...

>>   
>> +    def test_x86_64_microvm_qboot(self):
>> +        """
>> +        :avocado: tags=machine:microvm
>> +        """
>> +        self.vm.add_args('-bios', 'pc-bios/bios-microvm.bin')
>> +        self.do_test_x86_64_machine()
>> +
> 
> Reading the docs/microvm.rst, microvm should use qboot as default, so
> the test_x86_64_microvm() and test_x86_64_microvm_qboot() maybe are the
> same (I didn't test them).

I traced loader_write_rom() and in both cases bios-microvm.bin got
loaded. While there may be a slight benefit in verifying that usage of
an explicit -bios works, I think I'll just drop the unnecessary test
case in patches 2 and 6 in v2.

> 
>>       def test_mips_malta(self):
>>           """
>>           :avocado: tags=arch:mips
> 
> Thanks for doing these tests!

And thanks for reviewing the series.

Regards,
Liam

