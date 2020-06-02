Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D40DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71977206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71977206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9dP-0005W7-MW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jg9bn-000471-5c; Tue, 02 Jun 2020 12:17:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13198
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jg9bk-0006p4-VI; Tue, 02 Jun 2020 12:17:46 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 052G2t82058160; Tue, 2 Jun 2020 12:17:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31ddd2g1x2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2020 12:17:42 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 052G6TpP076719;
 Tue, 2 Jun 2020 12:17:41 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31ddd2g1wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2020 12:17:41 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052GAisU004471;
 Tue, 2 Jun 2020 16:17:40 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma04dal.us.ibm.com with ESMTP id 31bf4a2990-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2020 16:17:40 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 052GHei654395260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jun 2020 16:17:40 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16E15112067;
 Tue,  2 Jun 2020 16:17:40 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03A63112062;
 Tue,  2 Jun 2020 16:17:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  2 Jun 2020 16:17:39 +0000 (GMT)
Subject: Re: [RFC 4/6] tests: tpm-emu: Remove assert on TPM2_ST_NO_SESSIONS
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
References: <20200601102113.1207-1-eric.auger@redhat.com>
 <20200601102113.1207-5-eric.auger@redhat.com>
 <50a54958-e9e0-c95f-3893-f7f790186e0e@linux.ibm.com>
 <80ce5833-90ee-cbc5-9822-cca1fabc33e6@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <b310bcc1-02aa-4948-20d0-2e66de68acb3@linux.ibm.com>
Date: Tue, 2 Jun 2020 12:17:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <80ce5833-90ee-cbc5-9822-cca1fabc33e6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-02_13:2020-06-02,
 2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 cotscore=-2147483648
 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020111
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 09:30:21
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 12:13 PM, Auger Eric wrote:
> Hi Stefan,
>
> On 6/2/20 3:39 PM, Stefan Berger wrote:
>> On 6/1/20 6:21 AM, Eric Auger wrote:
>>> While writing tests for checking the content of TPM2 and DSDT
>>> along with TPM-TIS instantiation I attempted to reuse the
>>> framework used for TPM-TIS tests. However While dumping the
>>> ACPI tables I get an assert on TPM2_ST_NO_SESSIONS. My assumption
>>> is maybe the other tests did not execute long enough to encounter
>>> this. So I tentatively propose to remove the assert as it
>>> does not seem to break other tests and enable the new ones.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>    tests/qtest/tpm-emu.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/tests/qtest/tpm-emu.c b/tests/qtest/tpm-emu.c
>>> index c43ac4aef8..298d0eec74 100644
>>> --- a/tests/qtest/tpm-emu.c
>>> +++ b/tests/qtest/tpm-emu.c
>>> @@ -49,7 +49,6 @@ static void *tpm_emu_tpm_thread(void *data)
>>>            s->tpm_msg->tag = be16_to_cpu(s->tpm_msg->tag);
>>>            s->tpm_msg->len = be32_to_cpu(s->tpm_msg->len);
>>>            g_assert_cmpint(s->tpm_msg->len, >=, minhlen);
>>> -        g_assert_cmpint(s->tpm_msg->tag, ==, TPM2_ST_NO_SESSIONS);
>> You should not have to remove this. The tests are skipped if swtpm does
>> not support TPM 2 via --tpm2 option. This would be a very old swtpm
>> version, though. So, all tests are run with --tpm2 option and any
>> response received from the TPM would be a TPM 2 response that should
>> have TPM2_ST_NO_SESSIONS as the tag. I'd be curious what other value you
>> are seeing there.
> If I revert this patch I am getting TPM2_ST_SESSIONS on my end.

Is firmware/BIOS active? There's no TPM2_ST_SESSIONS coming out of QEMU.

    Stefan



