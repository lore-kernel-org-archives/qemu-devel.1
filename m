Received: from eggs.gnu.org ([2001:4830:134:3::10]:49026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLPlN-0002I5-MA
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fLPlK-0002KO-EA
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:08:53 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fLPlK-0002Jq-7b
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:08:50 -0400
Received: by mail-wm0-x241.google.com with SMTP id a67-v6so6848995wmf.3
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 02:08:50 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-16-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-16-peter.maydell@linaro.org>
Date: Wed, 23 May 2018 10:08:48 +0100
Message-ID: <87603evivz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add support for multiple IOMMU indexes to the IOMMU notifier APIs.
> When initializing a notifier with iommu_notifier_init(), the caller
> must pass the IOMMU index that it is interested in. When a change
> happens, the IOMMU implementation must pass
> memory_region_notify_iommu() the IOMMU index that has changed and
> that notifiers must be called for.
>
> IOMMUs which support only a single index don't need to change.
> Callers which only really support working with IOMMUs with a single
> index can use the result of passing MEMTXATTRS_UNSPECIFIED to
> memory_region_iommu_attrs_to_index().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/memory.h    | 11 ++++++++++-
>  hw/i386/intel_iommu.c    |  4 ++--
>  hw/ppc/spapr_iommu.c     |  2 +-
>  hw/s390x/s390-pci-inst.c |  4 ++--
>  hw/vfio/common.c         |  6 +++++-
>  hw/virtio/vhost.c        |  7 ++++++-
>  memory.c                 |  8 +++++++-
>  7 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index f6226fb263..4e6b125add 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -71,6 +71,7 @@ struct IOMMUTLBEntry {
>      hwaddr           iova;
>      hwaddr           translated_addr;
>      hwaddr           addr_mask;  /* 0xfff =3D 4k translation */
> +    int              iommu_idx;
>      IOMMUAccessFlags perm;
>  };
>
> @@ -98,18 +99,21 @@ struct IOMMUNotifier {
>      /* Notify for address space range start <=3D addr <=3D end */
>      hwaddr start;
>      hwaddr end;
> +    int iommu_idx;

Its a minor thing but are we ever expecting iommu_idx to ever be
negative?

> --- a/memory.c
> +++ b/memory.c
> @@ -1802,6 +1802,9 @@ void memory_region_register_iommu_notifier(MemoryRe=
gion *mr,
>      iommu_mr =3D IOMMU_MEMORY_REGION(mr);
>      assert(n->notifier_flags !=3D IOMMU_NOTIFIER_NONE);
>      assert(n->start <=3D n->end);
> +    assert(n->iommu_idx >=3D 0 &&
> +           n->iommu_idx < memory_region_iommu_num_indexes(iommu_mr));
> +

And then this would only have to assert we haven't exceeded the upper bound.

--
Alex Benn=C3=A9e
