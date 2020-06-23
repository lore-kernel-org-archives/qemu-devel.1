Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1639C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B023820768
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IqH450CZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B023820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfNV-0002WX-Uz
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liran.alon@oracle.com>)
 id 1jnfKg-0006FO-W3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:35:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liran.alon@oracle.com>)
 id 1jnfKe-0002PL-SU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:35:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05N9GRAs018714;
 Tue, 23 Jun 2020 09:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vmTtrMHoiA3S4bpytCmU19WHDVMsvnzESuYGioZFyjk=;
 b=IqH450CZ9MUCIoZCPJqByhiEOCb+NTzASjArjSboBN8MNSAsoHzRlZAeVeTkK8T00aF5
 B1GNzI5bzCiv2+seCnb6iP90dIWj94A4ABLsu32zG9KOErZ0IJa8BpJx62GJLPmJ+X6H
 yKZxlYCOKt2aDnUnRUXJoLBEdB2DHOzz/C4uwj/q5EQgG9ibUJoHiZ6A0/aBrPqkVzR1
 qDAtIh7CjPiHsThbtd2Zbck6MWoXYyDB7sQEnIhWJCciUplPWw3G7Q37WJu+xRXJBp3L
 ZsWtCG8i4jim/4pKcf9E1gijfKiaF8Kby9Xxvn6Fj32CUxB5FtlSosC8VybytROEMMrl JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 31sebbm73y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jun 2020 09:35:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05N9I0BV034912;
 Tue, 23 Jun 2020 09:35:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 31svc3nrmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2020 09:35:04 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05N9Z2Fg007217;
 Tue, 23 Jun 2020 09:35:02 GMT
Received: from [192.168.14.112] (/79.176.227.138)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 23 Jun 2020 09:35:02 +0000
Subject: Re: [PULL 027/115] hw/i386/vmport: Propagate IOPort read to vCPU EAX
 register
To: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel@nongnu.org
References: <20200611194449.31468-1-pbonzini@redhat.com>
 <20200611194449.31468-28-pbonzini@redhat.com>
 <f6f506ab-99a9-0f64-3bc0-2090f58f80f0@redhat.com>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <db41f0d2-386c-44c9-9b44-2e1e72648e2a@oracle.com>
Date: Tue, 23 Jun 2020 12:34:59 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f6f506ab-99a9-0f64-3bc0-2090f58f80f0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230074
Received-SPF: pass client-ip=156.151.31.86; envelope-from=liran.alon@oracle.com;
 helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 05:35:05
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 23/06/2020 11:46, Laurent Vivier wrote:
> On 11/06/2020 21:43, Paolo Bonzini wrote:
>> From: Liran Alon <liran.alon@oracle.com>
>>
>> vmport_ioport_read() returns the value that should propagate to vCPU EAX
>> register when guest reads VMPort IOPort (i.e. By x86 IN instruction).
>>
>> However, because vmport_ioport_read() calls cpu_synchronize_state(), the
>> returned value gets overridden by the value in QEMU vCPU EAX register.
>> i.e. cpu->env.regs[R_EAX].
>>
>> To fix this issue, change vmport_ioport_read() to explicitly override
>> cpu->env.regs[R_EAX] with the value it wish to propagate to vCPU EAX
>> register.
>>
>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> Message-Id: <20200312165431.82118-4-liran.alon@oracle.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   hw/core/machine.c |  1 +
>>   hw/i386/vmport.c  | 32 +++++++++++++++++++++++++++++---
>>   2 files changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index bb3a7b18b1..83f0fe5c91 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_4_2[] = {
>>       { "qxl", "revision", "4" },
>>       { "qxl-vga", "revision", "4" },
>>       { "fw_cfg", "acpi-mr-restore", "false" },
>> +    { "vmport", "x-read-set-eax", "off" },
> This is modifying the hw_compat_4_2 properties while qemu-5.0 has been
> already released. I think all the vmport property updates [1] should go
> to hw_compat_5_0.
>
> Liran? Paolo?

When I submitted these patches, QEMU 5.0 wasn't released yet. That's why 
I updated hw_compat_4_2[].

Having said that, I believe the compatibility risk here is very small 
and therefore because QEMU 5.0 was
released for a very short time-span before these patches were merged, 
I'm not sure it's really preferable
to move these flags to hw_compat_5_0[]. But I will leave this for Paolo 
to decide.
(Note that moving these flags will also risk in comparability people 
running with current patches and
specifying explicitly machine-type 5.0...)

-Liran

>
> Thanks,
> Laurent
>
> [1]
>
> b889212973da hw/i386/vmport: Propagate IOPort read to vCPU EAX register
> 0342ee761ef2 hw/i386/vmport: Set EAX to -1 on failed and unsupported
> commands
> f8bdc550370f hw/i386/vmport: Report vmware-vmx-type in CMD_GETVERSION
> aaacf1c15a22 hw/i386/vmport: Add support for CMD_GETBIOSUUID
>
>      { "vmport", "x-read-set-eax", "off" },
>      { "vmport", "x-signal-unsupported-cmd", "off" },
>      { "vmport", "x-report-vmx-type", "off" },
>      { "vmport", "x-cmds-v2", "off" },
>

