Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14A3C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3B9206E7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LpzbkhOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3B9206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCXw0-0002kU-VU
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCXvM-0002BB-7C
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCXvJ-0000LI-Ii
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:11:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCXvI-0000Je-9r
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:11:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02D09WI1155214;
 Fri, 13 Mar 2020 00:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6MItKYjAtUCTgt+dC9ppJYEitZfH85o25iI3KK/e5ts=;
 b=LpzbkhOSk7MqDGNJLsggwuO3RxXA/gypKkiGCZAI5ozXhv5F342GKKF4tOPr1Fdo592F
 81WTTT54y6O582OUs8icCykl8dCu/AB3z+olz0uqbunglo0rCQbRmudDcJYXFN6isbt4
 lw4nWOTQLA/JULeP789we3+T5IRSX3Yjq5PNpKd80HW6XoyUSbFtggd1MIEAHwqxRVec
 OzOLpQhfY3sgsxSd0skS4e1inrgESUIE4sEuMHZZ3dqk8/WW51iR3jqarL/S8A/DM41E
 2WzqyVylQXd8XSehesAxODwkC05S5qrC3fSM4JLZ5kHB28ZFXHy/saNJexmbwUS/uUHr jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yqtavh6qc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 00:11:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02D02JUJ104280;
 Fri, 13 Mar 2020 00:11:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2yqtac5hd5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2020 00:11:28 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02D0BR49020944;
 Fri, 13 Mar 2020 00:11:27 GMT
Received: from [192.168.14.112] (/109.67.207.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 17:11:27 -0700
Subject: Re: [PATCH v3 12/16] hw/i386/vmport: Add support for CMD_GET_VCPU_INFO
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-13-liran.alon@oracle.com>
 <20200312200658-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <c3db8905-c589-dbd0-1508-ff341fb3e2a0@oracle.com>
Date: Fri, 13 Mar 2020 02:11:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312200658-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003120119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003120119
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 13/03/2020 2:09, Michael S. Tsirkin wrote:
> On Thu, Mar 12, 2020 at 06:54:27PM +0200, Liran Alon wrote:
>> Command currently returns that it is unimplemented by setting
>> the reserved-bit in it's return value.
>>
>> Following patches will return various useful vCPU information
>> to guest.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> ---
>>   hw/i386/vmport.c         | 14 ++++++++++++++
>>   include/hw/i386/vmport.h |  1 +
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>> index 7e57eda4b526..2ce78aaf7b4c 100644
>> --- a/hw/i386/vmport.c
>> +++ b/hw/i386/vmport.c
>> @@ -55,6 +55,13 @@
>>   #define VMPORT_COMPAT_CMDS_V2                   \
>>       (1 << VMPORT_COMPAT_CMDS_V2_BIT)
>>   
>> +/* vCPU features reported by CMD_GET_VCPU_INFO */
>> +#define VCPU_INFO_SLC64_BIT             0
>> +#define VCPU_INFO_SYNC_VTSCS_BIT        1
>> +#define VCPU_INFO_HV_REPLAY_OK_BIT      2
>> +#define VCPU_INFO_LEGACY_X2APIC_BIT     3
>> +#define VCPU_INFO_RESERVED_BIT          31
>> +
>>   #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
>>   
>>   typedef struct VMPortState {
>
> Prefix with VMPORT_ please, and add comments.
Ok regarding prefix.
Which comments do you expect? What every flag means? Sure.

-Liran



