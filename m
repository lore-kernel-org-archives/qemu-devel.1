Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdHiD-0005XA-Gu
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cdHiA-00076q-TZ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:34:41 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cdHiA-00076L-Ih
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:34:38 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v77so95049591wmv.0
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 06:34:38 -0800 (PST)
References: <20170203160651.19917-1-dgilbert@redhat.com>
	<20170203160651.19917-3-dgilbert@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170203160651.19917-3-dgilbert@redhat.com>
Date: Mon, 13 Feb 2017 14:34:55 +0000
Message-ID: <87inoeupkg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: Add VMSTATE_WITH_TMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> VMSTATE_WITH_TMP is for handling structures where some calculation
> or rearrangement of the data needs to be performed before the data
> hits the wire.
> For example,  where the value on the wire is an offset from a
> non-migrated base, but the data in the structure is the actual pointer.
>
> To use it, a temporary type is created and a vmsd used on that type.
> The first element of the type must be 'parent' a pointer back to the
> type of the main structure.  VMSTATE_WITH_TMP takes care of allocating
> and freeing the temporary before running the child vmsd.
>
> The post_load/pre_save on the child vmsd can copy things from the parent
> to the temporary using the parent pointer and do any other calculations
> needed; it can then use normal VMSD entries to do the actual data
> storage without having to fiddle around with qemu_get_*/qemu_put_*
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  include/migration/vmstate.h | 19 +++++++++++++++++++
>  migration/vmstate.c         | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index cc66910..f2dfb85 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -259,6 +259,7 @@ extern const VMStateInfo vmstate_info_cpudouble;
>  extern const VMStateInfo vmstate_info_timer;
>  extern const VMStateInfo vmstate_info_buffer;
>  extern const VMStateInfo vmstate_info_unused_buffer;
> +extern const VMStateInfo vmstate_info_tmp;
>  extern const VMStateInfo vmstate_info_bitmap;
>  extern const VMStateInfo vmstate_info_qtailq;
>
> @@ -651,6 +652,24 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .offset     = offsetof(_state, _field),                          \
>  }
>
> +/* Allocate a temporary of type 'tmp_type', set tmp->parent to _state
> + * and execute the vmsd on the temporary.  Note that we're working with
> + * the whole of _state here, not a field within it.
> + * We compile time check that:
> + *    That _tmp_type contains a 'parent' member that's a pointer to the
> + *        '_state' type
> + *    That the pointer is right at the start of _tmp_type.
> + */
> +#define VMSTATE_WITH_TMP(_state, _tmp_type, _vmsd) {                 \
> +    .name         = "tmp",                                           \
> +    .size         = sizeof(_tmp_type) +                              \
> +                    QEMU_BUILD_BUG_ON_ZERO(offsetof(_tmp_type, parent) != 0) + \
> +                    type_check_pointer(_state,                       \
> +                        typeof_field(_tmp_type, parent)),            \
> +    .vmsd         = &(_vmsd),                                        \
> +    .info         = &vmstate_info_tmp,                               \
> +}
> +
>  #define VMSTATE_UNUSED_BUFFER(_test, _version, _size) {              \
>      .name         = "unused",                                        \
>      .field_exists = (_test),                                         \
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 2b2b3a5..a3de20f 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -935,6 +935,46 @@ const VMStateInfo vmstate_info_unused_buffer = {
>      .put  = put_unused_buffer,
>  };
>
> +/* vmstate_info_tmp, see VMSTATE_WITH_TMP, the idea is that we allocate
> + * a temporary buffer and the pre_load/pre_save methods in the child vmsd
> + * copy stuff from the parent into the child and do calculations to fill
> + * in fields that don't really exist in the parent but need to be in the
> + * stream.
> + */
> +static int get_tmp(QEMUFile *f, void *pv, size_t size, VMStateField *field)
> +{
> +    int ret;
> +    const VMStateDescription *vmsd = field->vmsd;
> +    int version_id = field->version_id;
> +    void *tmp = g_malloc(size);
> +
> +    /* Writes the parent field which is at the start of the tmp */
> +    *(void **)tmp = pv;
> +    ret = vmstate_load_state(f, vmsd, tmp, version_id);
> +    g_free(tmp);
> +    return ret;
> +}
> +
> +static int put_tmp(QEMUFile *f, void *pv, size_t size, VMStateField *field,
> +                    QJSON *vmdesc)
> +{
> +    const VMStateDescription *vmsd = field->vmsd;
> +    void *tmp = g_malloc(size);
> +
> +    /* Writes the parent field which is at the start of the tmp */
> +    *(void **)tmp = pv;
> +    vmstate_save_state(f, vmsd, tmp, vmdesc);
> +    g_free(tmp);
> +
> +    return 0;
> +}
> +
> +const VMStateInfo vmstate_info_tmp = {
> +    .name = "tmp",
> +    .get = get_tmp,
> +    .put = put_tmp,
> +};
> +
>  /* bitmaps (as defined by bitmap.h). Note that size here is the size
>   * of the bitmap in bits. The on-the-wire format of a bitmap is 64
>   * bit words with the bits in big endian order. The in-memory format


--
Alex Bennée
