Received: from eggs.gnu.org ([2001:4830:134:3::10]:56919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fvjaj-0005fz-8x
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fvjUh-0005QJ-M7
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:29:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51858
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fvjUh-0005Q7-G0
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:29:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7VDSbZv161909
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 09:29:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2m757wv0hj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 09:29:46 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 31 Aug 2018 07:29:45 -0600
References: <1513111443-22790-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1513111443-22790-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<20180726053127.GF12001@umbus.fritz.box>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 31 Aug 2018 09:29:40 -0400
MIME-Version: 1.0
In-Reply-To: <20180726053127.GF12001@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-MW
Message-Id: <45ffd3dd-60ca-2e46-44e8-d8ccff1feca1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/2] tpm_spapr: Support
 suspend and resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lo1@us.ibm.com, qemu-devel@nongnu.org, James.Bottomley@hansenpartnership.com, qemu-ppc@nongnu.org, clg@kaod.org, marcandre.lureau@redhat.com

On 07/26/2018 01:31 AM, David Gibson wrote:
> On Tue, Dec 12, 2017 at 03:44:03PM -0500, Stefan Berger wrote:
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_spapr.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 57 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>> index ef5e62d..0b8a424 100644
>> --- a/hw/tpm/tpm_spapr.c
>> +++ b/hw/tpm/tpm_spapr.c
>> @@ -248,9 +248,8 @@ static int tpm_spapr_do_crq(struct VIOsPAPRDevice *dev, uint8_t *crq_data)
>>       return H_SUCCESS;
>>   }
>>   
>> -static void tpm_spapr_request_completed(TPMIf *ti)
>> +static void _tpm_spapr_request_completed(SPAPRvTPMState *s)
> Don't start identifiers with _, please, they're reserved by the
> standard library.
>
>>   {
>> -    SPAPRvTPMState *s = VIO_SPAPR_VTPM(ti);
>>       TPMSpaprCRQ *crq = &s->crq;
>>       uint32_t len;
>>       int rc;
>> @@ -281,6 +280,13 @@ static void tpm_spapr_request_completed(TPMIf *ti)
>>       }
>>   }
>>   
>> +static void tpm_spapr_request_completed(TPMIf *ti)
>> +{
>> +    SPAPRvTPMState *s = VIO_SPAPR_VTPM(ti);
>> +
>> +    _tpm_spapr_request_completed(s);
>> +}
> I don't see much value in this wrapper - there's only one caller,
> local to this code, so it can do the cast itself.

ok.

>> +
>>   static int tpm_spapr_do_startup_tpm(SPAPRvTPMState *s, size_t buffersize)
>>   {
>>       return tpm_backend_startup_tpm(s->be_driver, buffersize);
>> @@ -313,9 +319,56 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
>>       return tpm_backend_get_tpm_version(s->be_driver);
>>   }
>>   
>> +/* persistent state handling */
>> +
>> +static int tpm_spapr_pre_save(void *opaque)
>> +{
>> +    SPAPRvTPMState *s = opaque;
>> +
>> +    /*
>> +     * Synchronize with backend completion.
>> +     */
>> +    tpm_backend_wait_cmd_completed(s->be_driver);
>> +
>> +    /*
>> +     * we cannot deliver the results to the VM (in state
>> +     * SPAPR_VTPM_STATE_EXECUTION) since DMA would touch VM memory
>> +     */
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpm_spapr_post_load(void *opaque,
>> +                               int version_id __attribute__((unused)))
> Use the G_GNUC_UNUSED macro instead, please.

I will remove the attribute altogether since it's not used anywhere 
else, either.

>
>> +{
>> +    SPAPRvTPMState *s = opaque;
>> +
>> +    if (s->state == SPAPR_VTPM_STATE_EXECUTION) {
>> +        /*
>> +         * now we can deliver the results to the VM via DMA
>> +         */
>> +        _tpm_spapr_request_completed(s);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vmstate_spapr_vtpm = {
>> -    .name = "tpm_spapr",
>> -    .unmigratable = 1,
>> +    .name = "tpm-spapr",
>> +    .version_id = 1,
>> +    .minimum_version_id = 0,
>> +    .minimum_version_id_old = 0,
>> +    .pre_save = tpm_spapr_pre_save,
>> +    .post_load = tpm_spapr_post_load,
>> +    .fields = (VMStateField[]) {
> This should include VMSTATE_SPAPR_VIO(), which will cover several of
> the fields you list explicitly below.

True. I thought I had tried this 'back then' and for some reason it 
wouldn't recover completely while saving/restoring during firmware 
execution, but now it works...

I will repost soon. I added a new 2nd patch a while ago that gets a 
boolean from the function we need to call before suspend 
[tpm_backend_wait_cmd_completed(s->be_driver)] that indicates true if a 
response was received from the TPM and we need to deliver it to the VM 
post resume.

>
>> +        VMSTATE_BUFFER(crq.raw, SPAPRvTPMState),
>> +        VMSTATE_UINT64(vdev.crq.qladdr, SPAPRvTPMState),
>> +        VMSTATE_UINT32(vdev.crq.qsize, SPAPRvTPMState),
>> +        VMSTATE_UINT32(vdev.crq.qnext, SPAPRvTPMState),
>> +        VMSTATE_UINT8(state, SPAPRvTPMState),
>> +        VMSTATE_BUFFER(buffer, SPAPRvTPMState),
>> +        VMSTATE_END_OF_LIST(),
>> +    }
>>   };
>>   
>>   static Property tpm_spapr_properties[] = {
