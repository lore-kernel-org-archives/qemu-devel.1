Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03B5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83728214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83728214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPF7-0003E5-12
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifOQZ-00068s-ET
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifOQY-000082-2V
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 08:22:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20974
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ifOQX-00006r-TZ; Thu, 12 Dec 2019 08:22:46 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCDCCcV089627; Thu, 12 Dec 2019 08:22:34 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxr7egq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 08:22:34 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCDCf6v092981;
 Thu, 12 Dec 2019 08:22:33 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxr7efy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 08:22:33 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCDKc2Q014076;
 Thu, 12 Dec 2019 13:22:33 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 2wr3q81dcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 13:22:33 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCDMVhd50528696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 13:22:31 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BFA813605D;
 Thu, 12 Dec 2019 13:22:31 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EB3F136059;
 Thu, 12 Dec 2019 13:22:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 13:22:30 +0000 (GMT)
Subject: Re: [PACTH v3 3/5] tpm_spapr: Support suspend and resume
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20191211162050.970199-1-stefanb@linux.vnet.ibm.com>
 <20191211162050.970199-4-stefanb@linux.vnet.ibm.com>
 <CAJ+F1CL6R5wwn6pnFTRaoTWqXUr7eTDAzMzT27M8zSkG2K7uEw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <08e2a506-2a0e-f8d2-40ea-97429ff2c46c@linux.ibm.com>
Date: Thu, 12 Dec 2019 08:22:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL6R5wwn6pnFTRaoTWqXUr7eTDAzMzT27M8zSkG2K7uEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_03:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120100
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xBCDCCcV089627
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 QEMU <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 6:00 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Dec 11, 2019 at 8:27 PM Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Extend the tpm_spapr frontend with VM suspend and resume support.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_spapr.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>> index c4a67e2403..d9153bd95c 100644
>> --- a/hw/tpm/tpm_spapr.c
>> +++ b/hw/tpm/tpm_spapr.c
>> @@ -87,6 +87,8 @@ typedef struct {
>>       TPMVersion be_tpm_version;
>>
>>       size_t be_buffer_size;
>> +
>> +    bool deliver_response; /* whether to deliver response after VM re=
sume */
>>   } SPAPRvTPMState;
>>
>>   static void tpm_spapr_show_buffer(const unsigned char *buffer,
>> @@ -339,9 +341,47 @@ static enum TPMVersion tpm_spapr_get_version(TPMI=
f *ti)
>>       return tpm_backend_get_tpm_version(s->be_driver);
>>   }
>>
>> +/* persistent state handling */
>> +
>> +static int tpm_spapr_pre_save(void *opaque)
>> +{
>> +    SPAPRvTPMState *s =3D opaque;
>> +
>> +    s->deliver_response =3D tpm_backend_finish_sync(s->be_driver);
>> +    /*
>> +     * we cannot deliver the results to the VM since DMA would touch =
VM memory
>> +     */
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpm_spapr_post_load(void *opaque, int version_id)
>> +{
>> +    SPAPRvTPMState *s =3D opaque;
>> +
>> +    if (s->deliver_response) {
>> +        /* deliver the results to the VM via DMA */
>> +        tpm_spapr_request_completed(TPM_IF(s), 0);
> Why isn't it enough to rely on tpm_spapr_request_completed callback
> being called during pre-save when tpm_backend_finish_sync() is called?
> (like tis & crb)


When .pre_save is called the VM memory has been fully replicated and=20
only the devices need to save their state, right? So TIS and CRB save=20
the response in memory of the device for the OS driver to pick up after=20
resume. The SPAPR device model is expected to write the response into VM=20
memory using DMA but memory won't be marked dirty anymore and replicated=20
(afaik). So we may have the mechanism of having=20
tpm_spapr_request_completed() invoked but in addition we need to=20
re-deliver a response after resume so that the OS driver reads the=20
proper response then. I'll investigate, though...



