Received: from eggs.gnu.org ([2001:4830:134:3::10]:43761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eKGgx-0007Zd-8u
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eKGgt-0005Os-3l
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:43:19 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:45649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eKGgs-0005OG-Sy
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:43:15 -0500
Received: by mail-pl0-x242.google.com with SMTP id f6so3542719pln.12
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 20:43:14 -0800 (PST)
References: <20171122051552.3529-1-aik@ozlabs.ru>
	<20171129082632.0ba2f118@t450s.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5b30294c-1a10-836e-5046-7dd375f23dc5@ozlabs.ru>
Date: Thu, 30 Nov 2017 15:43:08 +1100
MIME-Version: 1.0
In-Reply-To: <20171129082632.0ba2f118@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] vfio/spapr: Allow fallback to SPAPR
 TCE IOMMU v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 30/11/17 02:26, Alex Williamson wrote:
> On Wed, 22 Nov 2017 16:15:52 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> The vfio_iommu_spapr_tce driver always advertises v1 and v2 IOMMU support,
>> however PR KVM (a special version of KVM designed to work in
>> a paravirtualized system; these days used for nested virtualizaion) only
>> supports the "pseries" platform which does not support v2. Since there is
>> no way to choose the IOMMU version in QEMU, it fails to start.
> 
> Seems like the bug is then in advertising v2 support when it doesn't
> exist. 


The way to distinguish v1 IOMMUs from v2 IOMMU in the powerpc code is: get
an IOMMU group ops pointer and see if DMA window callbacks are defined. So
at least in theory it is still possible to have both types of IOMMUs and
VFIO_CHECK_EXTENSION is called before any group is attached to a container.

Well, I could walk through all IOMMU groups in the system (possibly
hundreds), work out the maximum common set of IOMMU types and only
advertise those. Doing fallback to v1 seems nicer, no?



> Isn't that a kernel bug?  Otherwise I think this is a long
> standing bug, since QEMU-2.7 and probably not 2.11 material this late
> into the freeze.  A "Fixes" tag would probably also be appropriate,
> identifying the commit where this was introduced (318f67ce1371) if it
> is a QEMU bug.  Thanks,
> 
> Alex
> 
>> This adds a fallback to the v1 IOMMU if v2 cannot be used.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  hw/vfio/common.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 7b2924c..cd81cc9 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1040,6 +1040,11 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>              v2 ? VFIO_SPAPR_TCE_v2_IOMMU : VFIO_SPAPR_TCE_IOMMU;
>>          ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
>>          if (ret) {
>> +            container->iommu_type = VFIO_SPAPR_TCE_IOMMU;
>> +            v2 = false;
>> +            ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
>> +        }
>> +        if (ret) {
>>              error_setg_errno(errp, errno, "failed to set iommu for container");
>>              ret = -errno;
>>              goto free_container_exit;
> 


-- 
Alexey
