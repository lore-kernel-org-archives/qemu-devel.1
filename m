Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DE8C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DC221D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o+6fSHZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DC221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcaf-0007Pu-PL
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBcZt-0006m6-3O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBcZr-0002AG-6d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:57:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55452)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBcZq-00028p-Uy
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:57:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AAsK9e028151;
 Tue, 10 Mar 2020 10:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fwdNYg9BCEEX9ZJ/WGxhtl+43x98Tss6VokBwCY7WIo=;
 b=o+6fSHZOOefIQVwIfZTJCildsZ6HXlX0kCDEQr2AkaX9FTEFia1rGhy94sa+9ObMWR5i
 78kiMm8Mw8j/pDSRB0sBfRFla1H0KCcH9W7wJnlke3fpmvNGQGM5jghNZvu48joZlSZR
 A226Ff/QBluEROiJUj4/10jqcef5WtzGZ8oNJcAivFDnD40bB2RAStWlZQcmiXlZ/+YP
 c5fI6pMOvkcpXpl/F0IeIXKrKPWS0pQpgOEcrSfYAK52QAN6UH8HXV5v0XX0FhSgQ53+
 /biapBeU5G47hrhgYoyQ1lDvGN2BM0/6wsRH1ouzljjfAA48uXCJKgQTcL08jvFHqoEg 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2ym3jqmu9v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 10:57:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AAmEv4091857;
 Tue, 10 Mar 2020 10:57:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yp8ns0t8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 10:57:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AAvVD5031650;
 Tue, 10 Mar 2020 10:57:31 GMT
Received: from [192.168.14.112] (/79.181.212.171)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 03:57:30 -0700
Subject: Re: [PATCH 14/14] hw/i386/vmport: Assert vmport initialized before
 registering commands
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-15-liran.alon@oracle.com>
 <20200310053029-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <e24fcd0a-041e-72b5-0b5d-5010b6c0322d@oracle.com>
Date: Tue, 10 Mar 2020 12:57:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310053029-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100073
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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


On 10/03/2020 11:30, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 01:54:11AM +0200, Liran Alon wrote:
>> vmport_register() is also called from other modules such as vmmouse.
>> Therefore, these modules rely that vmport is realized before those call
>> sites. If this is violated, vmport_register() will NULL-deref.
>>
>> To make such issues easier to debug, assert in vmport_register() that
>> vmport is already realized.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>
> Hmm and what does actually make sure it is realized?

port_state global var is only set in vmport_realizefn().

-Liran

>
>> ---
>>   hw/i386/vmport.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>> index 95d4a23ce9ba..659a323e8448 100644
>> --- a/hw/i386/vmport.c
>> +++ b/hw/i386/vmport.c
>> @@ -68,6 +68,8 @@ static VMPortState *port_state;
>>   void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *opaque)
>>   {
>>       assert(command < VMPORT_ENTRIES);
>> +    assert(port_state);
>> +
>>       trace_vmport_register(command, func, opaque);
>>       port_state->func[command] = func;
>>       port_state->opaque[command] = opaque;
>> -- 
>> 2.20.1

