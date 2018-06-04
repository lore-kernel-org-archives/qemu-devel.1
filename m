Received: from eggs.gnu.org ([2001:4830:134:3::10]:59562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPp8v-0007ux-5I
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPp8u-0004A1-CV
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:03:25 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPp8u-00049c-7K
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:03:24 -0400
Received: by mail-oi0-x242.google.com with SMTP id k5-v6so28314466oiw.0
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 06:03:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87603evivz.fsf@linaro.org>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-16-peter.maydell@linaro.org>
	<87603evivz.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 14:03:03 +0100
Message-ID: <CAFEAcA8xRj5CWkAMdUVvT_cZJWSL5ysvt8qb6fbypSp5ZJF1sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/27] iommu: Add IOMMU index argument to
 notifier APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 23 May 2018 at 10:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Add support for multiple IOMMU indexes to the IOMMU notifier APIs.
>> When initializing a notifier with iommu_notifier_init(), the caller
>> must pass the IOMMU index that it is interested in. When a change
>> happens, the IOMMU implementation must pass
>> memory_region_notify_iommu() the IOMMU index that has changed and
>> that notifiers must be called for.
>>
>> IOMMUs which support only a single index don't need to change.
>> Callers which only really support working with IOMMUs with a single
>> index can use the result of passing MEMTXATTRS_UNSPECIFIED to
>> memory_region_iommu_attrs_to_index().
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/exec/memory.h    | 11 ++++++++++-
>>  hw/i386/intel_iommu.c    |  4 ++--
>>  hw/ppc/spapr_iommu.c     |  2 +-
>>  hw/s390x/s390-pci-inst.c |  4 ++--
>>  hw/vfio/common.c         |  6 +++++-
>>  hw/virtio/vhost.c        |  7 ++++++-
>>  memory.c                 |  8 +++++++-
>>  7 files changed, 33 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index f6226fb263..4e6b125add 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -71,6 +71,7 @@ struct IOMMUTLBEntry {
>>      hwaddr           iova;
>>      hwaddr           translated_addr;
>>      hwaddr           addr_mask;  /* 0xfff =3D 4k translation */
>> +    int              iommu_idx;
>>      IOMMUAccessFlags perm;
>>  };
>>
>> @@ -98,18 +99,21 @@ struct IOMMUNotifier {
>>      /* Notify for address space range start <=3D addr <=3D end */
>>      hwaddr start;
>>      hwaddr end;
>> +    int iommu_idx;
>
> Its a minor thing but are we ever expecting iommu_idx to ever be
> negative?

Coming back to this one -- no, we don't expect negative iommu_idxs.
But on the other hand we don't ever expect negative TCG mmu_indexes
either, and we use 'int' for those...

thanks
-- PMM
