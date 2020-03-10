Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB7C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632CE24680
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zoFIWh3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632CE24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdUt-0006un-It
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBdSk-00053h-0h
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBdSi-00013z-Tj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:54:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBdSi-00011S-Jv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:54:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABrLfG062597;
 Tue, 10 Mar 2020 11:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OwotNE+pdMSjIYTiQGzfQtnmCmFp3VzQdh8NRSxfDTA=;
 b=zoFIWh3X3wwKIatjynByfuasE0biW51f2r0SHa3Zn2bSNsLTiq7HIjTfP2FI9vqBPvOY
 jCL4tC1i5ZP/3QCWChKLYdHYv9tg2kHaCNbhMJ/z81UOpxZN9rh8ytEdJ59UGPsfmTOV
 BMErcLWOwJg9JJCnn6vAMbK7TeIix4B0t/Tl6iLuV4PDIGj/v9T/c9uBIkhcIlAbROCV
 6x7nvPjt4BqGAdtA3du5bhA34dRmk2KXjy6YZgKWC32hSR8VqADM2l0DitOsREPsaavg
 hSOBRisahLv9dNZARY4vXBpkqyyNKCquxMbERv5+nF2A4tSVH/oYN13nw+gNFYvQe/Au mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yp7hm1ea7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:54:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABq6gV000933;
 Tue, 10 Mar 2020 11:54:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2yp8pr4yyc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 11:54:13 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02ABsDOE013258;
 Tue, 10 Mar 2020 11:54:13 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 04:54:13 -0700
Subject: Re: [PATCH 06/14] hw/i386/vmport: Define enum for all commands
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-7-liran.alon@oracle.com>
 <20200310052327-mutt-send-email-mst@kernel.org>
 <63a5be78-65e2-4092-f771-984572cd07cf@oracle.com>
 <20200310072236-mutt-send-email-mst@kernel.org>
 <6de0d982-aa39-4188-455e-fe8c11a11b7e@oracle.com>
 <20200310074457-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <98de576b-7a66-1e17-f404-2d25b650a2ee@oracle.com>
Date: Tue, 10 Mar 2020 13:54:08 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310074457-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100080
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


On 10/03/2020 13:46, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 01:37:40PM +0200, Liran Alon wrote:
>> On 10/03/2020 13:23, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 01:16:51PM +0200, Liran Alon wrote:
>>>> On 10/03/2020 11:28, Michael S. Tsirkin wrote:
>>>>> On Tue, Mar 10, 2020 at 01:54:03AM +0200, Liran Alon wrote:
>>>>>> No functional change.
>>>>>>
>>>>>> Defining an enum for all VMPort commands have the following advantages:
>>>>>> * It gets rid of the error-prone requirement to update VMPORT_ENTRIES
>>>>>> when new VMPort commands are added to QEMU.
>>>>>> * It makes it clear to know by looking at one place at the source, what
>>>>>> are all the VMPort commands supported by QEMU.
>>>>>>
>>>>>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>>>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>>>> ---
>>>>>>
>>>>>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>>>>>> index d5ac76d54e1f..7f15a01137b1 100644
>>>>>> --- a/include/hw/i386/pc.h
>>>>>> +++ b/include/hw/i386/pc.h
>>>>>> @@ -138,12 +138,21 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
>>>>>>     #define TYPE_VMPORT "vmport"
>>>>>>     typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
>>>>>> +typedef enum {
>>>>>> +    VMPORT_CMD_GETVERSION       = 10,
>>>>>> +    VMPORT_CMD_GETRAMSIZE       = 20,
>>>>>> +    VMPORT_CMD_VMMOUSE_DATA     = 39,
>>>>>> +    VMPORT_CMD_VMMOUSE_STATUS   = 40,
>>>>>> +    VMPORT_CMD_VMMOUSE_COMMAND  = 41,
>>>>>> +    VMPORT_ENTRIES
>>>>>> +} VMPortCommand;
>>>>>> +
>>>>> Please don't, let's leave pc.h alone. If you must add a new header for
>>>>> vmport/vmmouse and put this stuff there.
>>>> As you can see, pc.h already contains definitions which are specific to
>>>> vmport. E.g. TYPE_VMPORT, VMPortReadFunc(), vmport_register(),
>>>> vmmouse_get_data(), vmmouse_set_data(). Adding this enum is not what makes
>>>> the difference.
>>>> It is possible to create a new vmport.h header file but it's not really
>>>> related to this patch. It's just general refactoring. I can do that in v2 if
>>>> you think it's appropriate.
>>>>
>>>> -Liran
>>> Well I just don't want lots of enums in pc.h
>> This is the only one which is global, and makes sense as it's directly
>> related to vmport_register() exposed API.
>> Similar to how the VMPortReadFunc typedef is put in here.
>>
>> -Liran
> So pls find another home for this stuff. Whoever touches legacy code
> gets to clean it up a bit first :) Tough but that's the only stick
> maintainers have to make maintainance happen.

Will do then in v2. :)

-Liran



