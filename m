Received: from eggs.gnu.org ([2001:4830:134:3::10]:42103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1chGnF-0000go-LN
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1chGnC-0002ve-Db
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:24:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57529
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1chGnC-0002vR-6P
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:24:18 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1OEFIsh140792
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:24:17 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28tm1vpu4e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:24:17 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 24 Feb 2017 07:24:16 -0700
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<20170220141943.8426-4-cornelia.huck@de.ibm.com>
	<d8c1475a-765b-e980-cb48-255c29efdaf6@redhat.com>
	<4340aa12-3289-9d19-6156-9121a9643749@linux.vnet.ibm.com>
	<75631dfb-bd96-b905-6720-84980cbd477d@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 09:24:10 -0500
MIME-Version: 1.0
In-Reply-To: <75631dfb-bd96-b905-6720-84980cbd477d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <ca131ed7-2a25-3946-13c1-c48effe7e332@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] s390x/ipl: Load network boot image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, agraf@suse.de



On 02/24/2017 05:11 AM, Thomas Huth wrote:
> On 22.02.2017 16:01, Farhan Ali wrote:
>> Hi Thomas,
>>
>> Thanks for the review.
>>
>> On 02/20/2017 10:28 AM, Thomas Huth wrote:
>>> On 20.02.2017 15:19, Cornelia Huck wrote:
>>>> From: Farhan Ali <alifm@linux.vnet.ibm.com>
> [...]
>>>> +    }
>>>> +
>>>> +    ram_ptr = memory_region_get_ram_ptr(mr);
>>>> +    if (!ram_ptr) {
>>>> +        error_report("No RAM found");
>>>> +        goto unref_mr;
>>>> +    }
>>>> +
>>>> +    netboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
>>>> ipl->netboot_fw);
>>>> +    if (netboot_filename == NULL) {
>>>> +        error_report("Could not find network bootloader");
>>>> +        goto unref_mr;
>>>> +    }
>>>
>>> So you're doing error_report() here already ...
>>>
>>>> +    img_size = load_elf_ram(netboot_filename, NULL, NULL,
>>>> &ipl->start_addr,
>>>> +                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false);
>>>> +
>>>> +    if (img_size < 0) {
>>>> +        img_size = load_image_size(netboot_filename, ram_ptr,
>>>> ram_size);
>>>> +        ipl->start_addr = KERN_IMAGE_START;
>>>> +    }
>>>> +
>>>> +    g_free(netboot_filename);
>>>> +
>>>> +unref_mr:
>>>> +    memory_region_unref(mr);
>>>> +out:
>>>> +    return img_size;
>>>> +}
>>>> +
>>>> +static bool is_virtio_net_device(IplParameterBlock *iplb)
>>>> +{
>>>> +    uint8_t cssid;
>>>> +    uint8_t ssid;
>>>> +    uint16_t devno;
>>>> +    uint16_t schid;
>>>> +    SubchDev *sch = NULL;
>>>> +
>>>> +    if (iplb->pbt != S390_IPL_TYPE_CCW) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    devno = be16_to_cpu(iplb->ccw.devno);
>>>> +    ssid = iplb->ccw.ssid & 3;
>>>> +
>>>> +    for (schid = 0; schid < MAX_SCHID; schid++) {
>>>> +        for (cssid = 0; cssid < MAX_CSSID; cssid++) {
>>>> +            sch = css_find_subch(1, cssid, ssid, schid);
>>>> +
>>>> +            if (sch && sch->devno == devno) {
>>>> +                return sch->id.cu_model == VIRTIO_ID_NET;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +   return false;
>>>> +}
>>>> +
>>>>  void s390_ipl_update_diag308(IplParameterBlock *iplb)
>>>>  {
>>>>      S390IPLState *ipl = get_ipl_device();
>>>>
>>>>      ipl->iplb = *iplb;
>>>>      ipl->iplb_valid = true;
>>>> +    ipl->netboot = is_virtio_net_device(iplb);
>>>>  }
>>>>
>>>>  IplParameterBlock *s390_ipl_get_iplb(void)
>>>> @@ -298,6 +377,13 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>>>>              ipl->iplb_valid = s390_gen_initial_iplb(ipl);
>>>>          }
>>>>      }
>>>> +    if (ipl->netboot) {
>>>> +        if (load_netboot_image() < 0) {
>>>> +            error_report("Failed to load network bootloader");
>>>
>>> ... and then you do another error_report here again ... so one error
>>> gets reported with two error message. Wouldn't it be nicer to rather do
>>> error_setg(...) in load_netboot_image() and then report only one error
>>> at this level here?
>>>
>>
>> What would be the advantage of doing that?
>
> It's just good coding style to report an error only once, at the
> outermost calling function. Otherwise the same error gets reported
> multiple times to the user, with different error messages, and that can
> easily get confusing. It's likely not a big problem here yet, since the
> call depths is only 2 functions, but imagine a situation where you've
> got a call depth or 5 or more and an error is reported at every
> depths... that's ugly. So this is why we've got error_setg() and friends
> in QEMU.
>
>  Thomas
>

Yes, I realized it. We update with a version 2. Would appreciate your 
feedback on it :)

Thanks
Farhan
