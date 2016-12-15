Received: from eggs.gnu.org ([2001:4830:134:3::10]:50168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHVDh-0000RD-L5
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cHVDd-0001RG-Lo
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:33:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cHVDd-0001Qu-DL
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 07:33:05 -0500
Date: Thu, 15 Dec 2016 12:33:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161215123259.GH2509@work-vm>
References: <20161108095603.72301-1-pasic@linux.vnet.ibm.com>
	<20161108095603.72301-8-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161108095603.72301-8-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 7/8] migration/vmstate: fix array of
 pointers to struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Shah <amit.shah@redhat.com>, Juan Quintela <quintela@redhat.com>, Guenther Hutzl <hutzl@linux.vnet.ibm.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> Make VMS_ARRAY_OF_POINTER cope with null pointers. Previously the reward
> for trying to migrate an array with some null pointers in it was an
> illegal memory access, that is a swift and painless death of the process.
> Let's make vmstate cope with this scenario at least for pointers to
> structs. The general approach is when we encounter a null pointer
> (element) instead of following the pointer to save/load the data behind
> it we save/load a placeholder. This way we can detect if we expected a
> null pointer at the load side but not null data was saved instead. Sadly
> all other error scenarios are not detected by this scheme (and would
> require the usage of the JSON meta data).
> 
> Limitations: Does not work for pointers to primitives.

Please document that limitation in a comment in the vmstate.h near the
macros that use it.

> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com> Reviewed-by:
> Guenther Hutzl <hutzl@linux.vnet.ibm.com> ---
> 
> We will need this to load/save some on demand created state from within
> the channel subsystem (see ChannelSubSys.css in hw/s390x/css.c for an
> example).
> ---
>  include/migration/vmstate.h |  5 +++++
>  migration/vmstate.c         | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 5940db0..86d4aca 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -236,6 +236,10 @@ extern const VMStateInfo vmstate_info_uint16;
>  extern const VMStateInfo vmstate_info_uint32;
>  extern const VMStateInfo vmstate_info_uint64;
>  
> +/** Put this in the stream when migrating a null pointer.*/
> +#define VMS_NULLPTR_MARKER ((int8_t) -1)

You seem to be making things harder by using a signed int everywhere
when you just want a byte;  I suggest using '0'

> +extern const VMStateInfo vmstate_info_nullptr;
> +
>  extern const VMStateInfo vmstate_info_float64;
>  extern const VMStateInfo vmstate_info_cpudouble;
>  
> @@ -453,6 +457,7 @@ extern const VMStateInfo vmstate_info_bitmap;
>      .size       = sizeof(_type *),                                    \
>      .flags      = VMS_ARRAY|VMS_STRUCT|VMS_ARRAY_OF_POINTER,         \
>      .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
> +    .info       = &vmstate_info_nullptr,                              \

What's this change for?

>  }
>  
>  #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 10a7645..ce3490a 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -109,7 +109,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>                  if (field->flags & VMS_ARRAY_OF_POINTER) {
>                      curr_elem = *(void **)curr_elem;
>                  }
> -                if (field->flags & VMS_STRUCT) {
> +                if (!curr_elem) {
> +                    /* if null pointer check placeholder and do not follow */
> +                    assert(field->flags & VMS_ARRAY_OF_POINTER);
> +                    vmstate_info_nullptr.get(f, curr_elem, size);
> +                } else if (field->flags & VMS_STRUCT) {
>                      ret = vmstate_load_state(f, field->vmsd, curr_elem,
>                                               field->vmsd->version_id);
>                  } else {
> @@ -320,7 +324,11 @@ void vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>                      assert(curr_elem);
>                      curr_elem = *(void **)curr_elem;
>                  }
> -                if (field->flags & VMS_STRUCT) {
> +                if (!curr_elem) {
> +                    /* if null pointer write placeholder and do not follow */
> +                    assert(field->flags & VMS_ARRAY_OF_POINTER);
> +                    vmstate_info_nullptr.put(f, curr_elem, size);
> +                } else if (field->flags & VMS_STRUCT) {
>                      vmstate_save_state(f, field->vmsd, curr_elem, vmdesc_loop);
>                  } else {
>                      field->info->put(f, curr_elem, size);
> @@ -708,6 +716,26 @@ const VMStateInfo vmstate_info_uint64 = {
>      .put  = put_uint64,
>  };
>  
> +static int get_nullptr(QEMUFile *f, void *pv, size_t size)
> +{
> +    int8_t tmp;
> +    qemu_get_s8s(f, &tmp);

Now that I've suggested using just a character you can turn that
into:

  return qemu_get_byte(f) == VMS_NULLPTR_MARKER ? 0 : -EINVAL;

> +    return tmp == VMS_NULLPTR_MARKER ? 0 : -EINVAL;
> +}
> +
> +static void put_nullptr(QEMUFile *f, void *pv, size_t size)
> +{
> +    int8_t tmp = VMS_NULLPTR_MARKER;
> +    assert(pv == NULL);
> +    qemu_put_s8s(f, &tmp);

and similarly put_byte.

Dave

> +}
> +
> +const VMStateInfo vmstate_info_nullptr = {
> +    .name = "uint64",
> +    .get  = get_nullptr,
> +    .put  = put_nullptr,
> +};
> +
>  /* 64 bit unsigned int. See that the received value is the same than the one
>     in the field */
>  
> -- 
> 2.8.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
