Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D5520708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 12:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D5520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsn5k-0006mT-HV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 08:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jsn5B-0006Hn-IN; Tue, 07 Jul 2020 08:52:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jsn59-0004XT-Nl; Tue, 07 Jul 2020 08:52:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 067CVv2N067179; Tue, 7 Jul 2020 08:52:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 324pxscmxb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 08:52:11 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 067CX6fv070515;
 Tue, 7 Jul 2020 08:52:11 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 324pxscmww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 08:52:11 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067CpGT4015209;
 Tue, 7 Jul 2020 12:52:10 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma02dal.us.ibm.com with ESMTP id 322hd95ntp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 12:52:10 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 067Cq9Qb51315082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2020 12:52:09 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 558BBAC05F;
 Tue,  7 Jul 2020 12:52:09 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13736AC05B;
 Tue,  7 Jul 2020 12:52:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2020 12:52:08 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] tpm: tpm_spapr: Exit on TPM backend failures
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 marcandre.lureau@redhat.com
References: <20200707040522.4013885-1-stefanb@linux.vnet.ibm.com>
 <20200707040522.4013885-2-stefanb@linux.vnet.ibm.com>
 <aa63c5f3-308e-59e1-11ff-0e0d923658e8@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b974cd46-3902-3124-302d-ffa2a1120905@linux.ibm.com>
Date: Tue, 7 Jul 2020 08:52:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <aa63c5f3-308e-59e1-11ff-0e0d923658e8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-07_07:2020-07-07,
 2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 cotscore=-2147483648 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070092
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 08:52:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 12:20 AM, Philippe Mathieu-Daudé wrote:
> Hi Stefan,
>
> On 7/7/20 6:05 AM, Stefan Berger wrote:
>> Exit on TPM backend failures in the same way as the TPM CRB and TIS device
>> models do.
> Maybe the other models are not the best examples ;)

At least they are known to report the error...


>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   hw/tpm/tpm_spapr.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>> index cb4dfd1e6a..8288ab0a15 100644
>> --- a/hw/tpm/tpm_spapr.c
>> +++ b/hw/tpm/tpm_spapr.c
>> @@ -306,7 +306,10 @@ static void tpm_spapr_reset(SpaprVioDevice *dev)
>>                               TPM_SPAPR_BUFFER_MAX);
>>   
>>       tpm_backend_reset(s->be_driver);
>> -    tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
>> +
>> +    if (tpm_spapr_do_startup_tpm(s, s->be_buffer_size) < 0) {
> I don't see error reported, how users can know the cause of the exit?


virt-manager does report the error then. It seems to be taking it from 
the last error message reported in the emulator backend when TPM_INIT 
fails with error code 0x101:

error: internal error: qemu unexpectedly closed the monitor: 
2020-07-07T12:49:28.333928Z qemu-system-ppc64: tpm-emulator: TPM result 
for CMD_INIT: 0x101 operation failed


>
>> +        exit(1);
> What about using this instead?
>
>             qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);

It doesn't have any effect, the VM just keeps on running. So the exit(1) 
is better and does report an error.



