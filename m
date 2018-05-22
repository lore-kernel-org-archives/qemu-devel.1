Received: from eggs.gnu.org ([2001:4830:134:3::10]:48757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL3Pa-0007NU-Lc
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fL3PV-0005Q8-L0
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:16:54 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fL3PV-0005Pn-Bh
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:16:49 -0400
Received: by mail-wm0-x244.google.com with SMTP id j5-v6so31456745wme.5
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 02:16:49 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-2-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180521140402.23318-2-peter.maydell@linaro.org>
Date: Tue, 22 May 2018 10:16:46 +0100
Message-ID: <87o9h8uk1t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/27] memory.h: Improve IOMMU related
 documentation
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

> Add more detail to the documentation for memory_region_init_iommu()
> and other IOMMU-related functions and data structures.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2->v3 changes:
>  * minor wording tweaks per Eric's review
>  * moved the bit about requirements to notify out from the translate
>    method docs to the top level class doc comment
>  * added description of flags argument and in particular that it's
>    just an optimization and callers can pass IOMMU_NONE to get the
>    full permissions
> v1 -> v2 changes:
>  * documented replay method
>  * added note about wanting RCU or big qemu lock while calling
>    translate
> ---
>  include/exec/memory.h | 105 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 95 insertions(+), 10 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 4fa1227f13..cce355d2d8 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -194,29 +194,100 @@ enum IOMMUMemoryRegionAttr {
>      IOMMU_ATTR_SPAPR_TCE_FD
>  };
>
> +/**
> + * IOMMUMemoryRegionClass:
> + *
> + * All IOMMU implementations need to subclass TYPE_IOMMU_MEMORY_REGION
> + * and provide an implementation of at least the @translate method here
> + * to handle requests to the memory region. Other methods are optional.
> + *
> + * The IOMMU implementation must use the IOMMU notifier infrastructure
> + * to report whenever mappings are changed, by calling
> + * memory_region_notify_iommu() (or, if necessary, by calling
> + * memory_region_notify_one() for each registered notifier).
> + */
>  typedef struct IOMMUMemoryRegionClass {
>      /* private */
>      struct DeviceClass parent_class;
>
>      /*
> -     * Return a TLB entry that contains a given address. Flag should
> -     * be the access permission of this translation operation. We can
> -     * set flag to IOMMU_NONE to mean that we don't need any
> -     * read/write permission checks, like, when for region replay.
> +     * Return a TLB entry that contains a given address.
> +     *
> +     * The IOMMUAccessFlags indicated via @flag are optional and may
> +     * be specified as IOMMU_NONE to indicate that the caller needs
> +     * the full translation information for both reads and writes. If
> +     * the access flags are specified then the IOMMU implementation
> +     * may use this as an optimization, to stop doing a page table
> +     * walk as soon as it knows that the requested permissions are not
> +     * allowed. If IOMMU_NONE is passed then the IOMMU must do the
> +     * full page table walk and report the permissions in the returned
> +     * IOMMUTLBEntry. (Note that this implies that an IOMMU may not
> +     * return different mappings for reads and writes.)
> +     *
> +     * The returned information remains valid while the caller is
> +     * holding the big QEMU lock or is inside an RCU critical section;
> +     * if the caller wishes to cache the mapping beyond that it must
> +     * register an IOMMU notifier so it can invalidate its cached
> +     * information when the IOMMU mapping changes.
> +     *
> +     * @iommu: the IOMMUMemoryRegion
> +     * @hwaddr: address to be translated within the memory region
> +     * @flag: requested access permissions
>       */
>      IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
>                                 IOMMUAccessFlags flag);
> -    /* Returns minimum supported page size */
> +    /* Returns minimum supported page size in bytes.
> +     * If this method is not provided then the minimum is assumed to
> +     * be TARGET_PAGE_SIZE.
> +     *
> +     * @iommu: the IOMMUMemoryRegion
> +     */
>      uint64_t (*get_min_page_size)(IOMMUMemoryRegion *iommu);
> -    /* Called when IOMMU Notifier flag changed */
> +    /* Called when IOMMU Notifier flag changes (ie when the set of
> +     * events which IOMMU users are requesting notification for changes).
> +     * Optional method -- need not be provided if the IOMMU does not
> +     * need to know exactly which events must be notified.
> +     *
> +     * @iommu: the IOMMUMemoryRegion
> +     * @old_flags: events which previously needed to be notified
> +     * @new_flags: events which now need to be notified
> +     */
>      void (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
>                                  IOMMUNotifierFlag old_flags,
>                                  IOMMUNotifierFlag new_flags);
> -    /* Set this up to provide customized IOMMU replay function */
> +    /* Called to handle memory_region_iommu_replay().
> +     *
> +     * The default implementation of memory_region_iommu_replay() is to
> +     * call the IOMMU translate method for every page in the address spa=
ce
> +     * with flag =3D=3D IOMMU_NONE and then call the notifier if transla=
te
> +     * returns a valid mapping. If this method is implemented then it
> +     * overrides the default behaviour, and must provide the full semant=
ics
> +     * of memory_region_iommu_replay(), by calling @notifier for every
> +     * translation present in the IOMMU.
> +     *
> +     * Optional method -- an IOMMU only needs to provide this method
> +     * if the default is inefficient or produces undesirable side effect=
s.
> +     *
> +     * Note: this is not related to record-and-replay functionality.
> +     */
>      void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
>
> -    /* Get IOMMU misc attributes */
> -    int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr,
> +    /* Get IOMMU misc attributes. This is an optional method that
> +     * can be used to allow users of the IOMMU to get implementation-spe=
cific
> +     * information. The IOMMU implements this method to handle calls
> +     * by IOMMU users to memory_region_iommu_get_attr() by filling in
> +     * the arbitrary data pointer for any IOMMUMemoryRegionAttr values t=
hat
> +     * the IOMMU supports. If the method is unimplemented then
> +     * memory_region_iommu_get_attr() will always return -EINVAL.
> +     *
> +     * @iommu: the IOMMUMemoryRegion
> +     * @attr: attribute being queried
> +     * @data: memory to fill in with the attribute data
> +     *
> +     * Returns 0 on success, or a negative errno; in particular
> +     * returns -EINVAL for unrecognized or unimplemented attribute types.
> +     */
> +    int (*get_attr)(IOMMUMemoryRegion *iommu, enum IOMMUMemoryRegionAttr=
 attr,
>                      void *data);
>  } IOMMUMemoryRegionClass;
>
> @@ -705,6 +776,14 @@ static inline void memory_region_init_reservation(Me=
moryRegion *mr,
>   * An IOMMU region translates addresses and forwards accesses to a target
>   * memory region.
>   *
> + * The IOMMU implementation must define a subclass of TYPE_IOMMU_MEMORY_=
REGION.
> + * @_iommu_mr should be a pointer to enough memory for an instance of
> + * that subclass, @instance_size is the size of that subclass, and
> + * @mrtypename is its name. This function will initialize @_iommu_mr as =
an
> + * instance of the subclass, and its methods will then be called to hand=
le
> + * accesses to the memory region. See the documentation of
> + * #IOMMUMemoryRegionClass for further details.
> + *
>   * @_iommu_mr: the #IOMMUMemoryRegion to be initialized
>   * @instance_size: the IOMMUMemoryRegion subclass instance size
>   * @mrtypename: the type name of the #IOMMUMemoryRegion
> @@ -953,6 +1032,8 @@ void memory_region_register_iommu_notifier(MemoryReg=
ion *mr,
>   * a notifier with the minimum page granularity returned by
>   * mr->iommu_ops->get_page_size().
>   *
> + * Note: this is not related to record-and-replay functionality.
> + *
>   * @iommu_mr: the memory region to observe
>   * @n: the notifier to which to replay iommu mappings
>   */
> @@ -962,6 +1043,8 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *i=
ommu_mr, IOMMUNotifier *n);
>   * memory_region_iommu_replay_all: replay existing IOMMU translations
>   * to all the notifiers registered.
>   *
> + * Note: this is not related to record-and-replay functionality.
> + *
>   * @iommu_mr: the memory region to observe
>   */
>  void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr);
> @@ -981,7 +1064,9 @@ void memory_region_unregister_iommu_notifier(MemoryR=
egion *mr,
>   * memory_region_iommu_get_attr: return an IOMMU attr if get_attr() is
>   * defined on the IOMMU.
>   *
> - * Returns 0 if succeded, error code otherwise.
> + * Returns 0 on success, or a negative errno otherwise. In particular,
> + * -EINVAL indicates that the IOMMU does not support the requested
> + * attribute.
>   *
>   * @iommu_mr: the memory region
>   * @attr: the requested attribute


--
Alex Benn=C3=A9e
