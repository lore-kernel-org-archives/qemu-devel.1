Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4757214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4757214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSyL-0006HP-De
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifS1D-0000eR-R9
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1ifS1C-0003oN-8U
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:12:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41428
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1ifS1C-0003nF-2H; Thu, 12 Dec 2019 12:12:50 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBCH627F146140; Thu, 12 Dec 2019 12:12:41 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxrfuge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 12:12:40 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBCH7gZA007739;
 Thu, 12 Dec 2019 12:12:40 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxrfuej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 12:12:39 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBCHAcTa026013;
 Thu, 12 Dec 2019 17:12:37 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma05wdc.us.ibm.com with ESMTP id 2wtdq7juu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 17:12:37 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBCHCaP557475340
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 17:12:36 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06DC1136055;
 Thu, 12 Dec 2019 17:12:36 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89A65136051;
 Thu, 12 Dec 2019 17:12:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 12 Dec 2019 17:12:35 +0000 (GMT)
Subject: Re: [PACTH v3 3/5] tpm_spapr: Support suspend and resume
From: Stefan Berger <stefanb@linux.ibm.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20191211162050.970199-1-stefanb@linux.vnet.ibm.com>
 <20191211162050.970199-4-stefanb@linux.vnet.ibm.com>
 <CAJ+F1CL6R5wwn6pnFTRaoTWqXUr7eTDAzMzT27M8zSkG2K7uEw@mail.gmail.com>
 <08e2a506-2a0e-f8d2-40ea-97429ff2c46c@linux.ibm.com>
Message-ID: <77e12176-5dc0-e5d1-f50d-960e9156c56d@linux.ibm.com>
Date: Thu, 12 Dec 2019 12:12:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <08e2a506-2a0e-f8d2-40ea-97429ff2c46c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_05:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120133
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xBCH627F146140
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

On 12/12/19 8:22 AM, Stefan Berger wrote:
> On 12/12/19 6:00 AM, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Wed, Dec 11, 2019 at 8:27 PM Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>> Extend the tpm_spapr frontend with VM suspend and resume support.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 hw/tpm/tpm_spapr.c | 42 ++++++++++++++++++++++++++++++++++++++=
+++-
>>> =C2=A0 1 file changed, 41 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>>> index c4a67e2403..d9153bd95c 100644
>>> --- a/hw/tpm/tpm_spapr.c
>>> +++ b/hw/tpm/tpm_spapr.c
>>> @@ -87,6 +87,8 @@ typedef struct {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPMVersion be_tpm_version;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t be_buffer_size;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 bool deliver_response; /* whether to deliver resp=
onse after VM=20
>>> resume */
>>> =C2=A0 } SPAPRvTPMState;
>>>
>>> =C2=A0 static void tpm_spapr_show_buffer(const unsigned char *buffer,
>>> @@ -339,9 +341,47 @@ static enum TPMVersion=20
>>> tpm_spapr_get_version(TPMIf *ti)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tpm_backend_get_tpm_version(s->=
be_driver);
>>> =C2=A0 }
>>>
>>> +/* persistent state handling */
>>> +
>>> +static int tpm_spapr_pre_save(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 SPAPRvTPMState *s =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->deliver_response =3D tpm_backend_finish_sync(s=
->be_driver);
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * we cannot deliver the results to the VM s=
ince DMA would=20
>>> touch VM memory
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static int tpm_spapr_post_load(void *opaque, int version_id)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 SPAPRvTPMState *s =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->deliver_response) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* deliver the results to=
 the VM via DMA */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_spapr_request_complet=
ed(TPM_IF(s), 0);
>> Why isn't it enough to rely on tpm_spapr_request_completed callback
>> being called during pre-save when tpm_backend_finish_sync() is called?
>> (like tis & crb)
>
>
> When .pre_save is called the VM memory has been fully replicated and=20
> only the devices need to save their state, right? So TIS and CRB save=20
> the response in memory of the device for the OS driver to pick up=20
> after resume. The SPAPR device model is expected to write the response=20
> into VM memory using DMA but memory won't be marked dirty anymore and=20
> replicated (afaik). So we may have the mechanism of having=20
> tpm_spapr_request_completed() invoked but in addition we need to=20
> re-deliver a response after resume so that the OS driver reads the=20
> proper response then. I'll investigate, though...


Suspend/resume works fine for as long as we don't catch a 'delayed=20
response', meaning a response received while the devices suspend (and=20
.pre_save is called). With this device the troubles are starting when=20
having to deliver such a 'delayed response' because the whole=20
tpm_spapr_request_completed() has to be deferred until after resume,=20
otherwise the OS driver gets stuck. So, in tpm_spapr_request_completed()=20
we need to be able to query the backend whether it is suspending,=20
meaning whether its .pre_save() has been invoked and we received the=20
response due to polling. If so, we must not do anything in this function=20
at this time but do it in post_load and we need to remember this in a=20
field 'deliver_response'. I have this field now but the reason why I set=20
it was not correct, at least not for the tpm_emulator backend. In case=20
we do get a delayed response while in the tpm_spapr's pre_save function,=20
we do need to set the 'deliver_response' as well in order to call the=20
tpm_spapr_request_completed() in tpm_spapr_post_load() when resuming.

The easiest way to trigger all this is to read a TPM 2.0's PCRs inside a=20
VM and have libtpms instrumented with a sleep(4) in PCRRead() function=20
to cause enough delays to trigger the critical code when suspending the V=
M.

I'll repost with these fixes.

 =C2=A0=C2=A0 Stefan


>
>


