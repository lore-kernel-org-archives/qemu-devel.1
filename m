Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89599C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5060F206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qLEencL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5060F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCVEQ-0007Wp-Gm
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 17:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCVDV-0006vC-Am
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCVDU-0005dD-1D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:18:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCVDT-0005bw-O2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:18:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CLDO0x081536;
 Thu, 12 Mar 2020 21:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+BrzRy2hp06PbYPrxxjXe/JELbBtVPK2fS6aY4TqpvU=;
 b=qLEencL+kwhtfwC53kwcGJ7sb1XYwQ6ehsNOlcAc/Nql6iOGJVfKSKZI/ANq04mOK2SR
 i5AuZv5LjDInO9i4gR9X19NBtnb2YDT2Y/Ms0TacyTFt82vj4iriryDuzlyzOgVzZFAT
 Um53zmmSzOyPxA2NcCCBBYAKhJBObm6Z5oN76Fp7Q0DWmG3DxKT4y1sXe3+u4coaSohJ
 3jjfG+wIR6CkcEtqRAqoV3+dra/Md0eZzgFnYO9391GKeGzqSGvURb4+nvQ4jDkUahHP
 dQUZi2tU07idZSZEaPtqnBNfilPYSl+Fixyoq8PvD2wSXsXNQrwGvZAtCKANX0MZKqL4 vQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2yqtavgrkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 21:18:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CLI5Qd177548;
 Thu, 12 Mar 2020 21:18:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yqta9gu5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 21:17:53 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CLHpwC030910;
 Thu, 12 Mar 2020 21:17:52 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 14:17:51 -0700
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200312172745.1b7b2222@redhat.com>
 <8b3f3166-cc60-eae2-c20d-ad4a593c3e30@oracle.com>
 <20200312154646-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <427af1be-c335-53e0-3b92-2f80aaa3b593@oracle.com>
Date: Thu, 12 Mar 2020 23:17:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312154646-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003120107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003120106
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 Elad Gabay <elad.gabay@oracle.com>, Igor Mammedov <imammedo@redhat.com>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/03/2020 21:47, Michael S. Tsirkin wrote:
> On Thu, Mar 12, 2020 at 07:28:31PM +0200, Liran Alon wrote:
>> On 12/03/2020 18:27, Igor Mammedov wrote:
>>> On Wed, 11 Mar 2020 19:08:26 +0200
>>> Liran Alon <liran.alon@oracle.com> wrote:
>>>
>>> we typically do not version ACPI table changes (there might be exceptions
>>> but it should be a justified one).
>>> ACPI tables are considered to be a part of firmware (even though they are
>>> generated by QEMU) so on QEMU upgrade user gets a new firmware along with
>>> new ACPI tables.
>> Hmm... I would have expected as a QEMU user that upgrading QEMU may update
>> my firmware exposed table (Such as ACPI),
>> but only if I don't specify I wish to run on a specific machine-type. In
>> that case, I would've expect to be exposed with exact same firmware
>> information.
>> I understood that this was one of the main reasons why ACPI/SMBIOS
>> generation was moved from SeaBIOS to QEMU.
>>
>> If you think this isn't the case, I can just remove this flag (Makes code
>> simpler). What do you prefer?
>>
>> Thanks for the review,
>> -Liran
>>
> I'm inclined to agree, but no biggie if Igor disagrees let's go along
> with his opinion.
>
I will wait for Igor's reply on this before I submit v2 (I have it ready 
with the flag still existing).
To make sure that v2 passes all review comments. ;)

-Liran



