Received: from eggs.gnu.org ([2001:4830:134:3::10]:48863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIYoq-0008FV-Mp
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIYol-0004mz-NT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dIYol-0004mt-Ei
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 07:08:03 -0400
Date: Wed, 7 Jun 2017 12:07:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170607110758.GC2099@work-vm>
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606165510.33057-3-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] vmstate: error hint for failed
 equal checks part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> Verbose error reporting for the _EQUAL family. Modify the standard _EQUAL
> so the hint states the assertion probably failed due to a bug. Introduce
> _EQUAL_HINT for specifying a context specific hint.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

I'd prefer not to print 'Bug!?' by default - they already get the
message telling them something didn't match and the migration fails.
There are none-bug ways of this happening, e.g. a user starting a VM on
the source and destination with different configs.

(I also worry we have a lot f macros for each size;
EQUAL, EQUAL_V, EQUAL_V_HINT but I don't know of a better answer for
that)

Dave

> ---
> Keeping this separate for now because we may want something different
> here. E.g. no new macros and adding an extra NULL parameter for all
> pre-existing  _EQUAL usages.
> ---
>  include/migration/vmstate.h | 54 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index d90d9b12ca..ed1e1fd047 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -302,6 +302,18 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .offset       = vmstate_offset_value(_state, _field, _type),     \
>  }
>  
> +#define VMSTATE_SINGLE_FULL(_field, _state, _test, _version, _info,  \
> +                            _type, _err_hint) {                      \
> +    .name         = (stringify(_field)),                             \
> +    .err_hint     = (_err_hint),                                     \
> +    .version_id   = (_version),                                      \
> +    .field_exists = (_test),                                         \
> +    .size         = sizeof(_type),                                   \
> +    .info         = &(_info),                                        \
> +    .flags        = VMS_SINGLE,                                      \
> +    .offset       = vmstate_offset_value(_state, _field, _type),     \
> +}
> +
>  /* Validate state using a boolean predicate. */
>  #define VMSTATE_VALIDATE(_name, _test) { \
>      .name         = (_name),                                         \
> @@ -808,30 +820,60 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_UINT64(_f, _s)                                        \
>      VMSTATE_UINT64_V(_f, _s, 0)
>  
> +#define VMSTATE_UINT8_EQUAL_HINT(_f, _s, _err_hint)                   \
> +    VMSTATE_SINGLE_FULL(_f, _s, NULL, 0, vmstate_info_uint8_equal,    \
> +                        uint8_t, _err_hint)
> +
>  #define VMSTATE_UINT8_EQUAL(_f, _s)                                   \
> -    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_uint8_equal, uint8_t)
> +    VMSTATE_UINT8_EQUAL_HINT(_f, _s, "Bug!?")
> +
> +#define VMSTATE_UINT16_EQUAL_HINT(_f, _s, _err_hint)                  \
> +    VMSTATE_SINGLE_FULL(_f, _s, NULL, 0, vmstate_info_uint16_equal,   \
> +                        uint16_t, _err_hint)
>  
>  #define VMSTATE_UINT16_EQUAL(_f, _s)                                  \
> -    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_uint16_equal, uint16_t)
> +    VMSTATE_UINT16_EQUAL_HINT(_f, _s, "Bug!?")
> +
> +#define VMSTATE_UINT16_EQUAL_V_HINT(_f, _s, _v, _err_hint)            \
> +    VMSTATE_SINGLE_FULL(_f, _s, NULL, _v, vmstate_info_uint16_equal,  \
> +                        uint16_t, _err_hint)
>  
>  #define VMSTATE_UINT16_EQUAL_V(_f, _s, _v)                            \
> -    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16_equal, uint16_t)
> +    VMSTATE_UINT16_EQUAL_V_HINT(_f, _s, _v, "Bug!?")
> +
> +#define VMSTATE_INT32_EQUAL_HINT(_f, _s, _err_hint)                   \
> +    VMSTATE_SINGLE_FULL(_f, _s, NULL, 0, vmstate_info_int32_equal,    \
> +                        int32_t, _err_hint)
>  
>  #define VMSTATE_INT32_EQUAL(_f, _s)                                   \
> -    VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_equal, int32_t)
> +    VMSTATE_INT32_EQUAL_HINT(_f, _s, "Bug!?")
> +
> +#define VMSTATE_UINT32_EQUAL_V_HINT(_f, _s, _v,  _err_hint)           \
> +    VMSTATE_SINGLE_FULL(_f, _s, NULL, _v, vmstate_info_uint32_equal,  \
> +                        uint32_t, _err_hint)
>  
>  #define VMSTATE_UINT32_EQUAL_V(_f, _s, _v)                            \
> -    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32_equal, uint32_t)
> +    VMSTATE_UINT32_EQUAL_V_HINT(_f, _s, _v, "Bug!?")
>  
>  #define VMSTATE_UINT32_EQUAL(_f, _s)                                  \
>      VMSTATE_UINT32_EQUAL_V(_f, _s, 0)
>  
> +#define VMSTATE_UINT32_EQUAL_HINT(_f, _s, _err_hint)                  \
> +    VMSTATE_UINT32_EQUAL_V_HINT(_f, _s, 0, _err_hint)
> +
> +#define VMSTATE_UINT64_EQUAL_V_HINT(_f, _s, _v,  _err_hint)           \
> +    VMSTATE_SINGLE_FULL(_f, _s, NULL, _v, vmstate_info_int64_equal,   \
> +                        uint64_t, _err_hint)
> +
>  #define VMSTATE_UINT64_EQUAL_V(_f, _s, _v)                            \
> -    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64_equal, uint64_t)
> +    VMSTATE_UINT64_EQUAL_V_HINT(_f, _s, _v, "Bug!?")
>  
>  #define VMSTATE_UINT64_EQUAL(_f, _s)                                  \
>      VMSTATE_UINT64_EQUAL_V(_f, _s, 0)
>  
> +#define VMSTATE_UINT64_EQUAL_HINT(_f, _s, _err_hint)                  \
> +    VMSTATE_UINT64_EQUAL_V_HINT(_f, _s, 0, _err_hint)
> +
>  #define VMSTATE_INT32_POSITIVE_LE(_f, _s)                             \
>      VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_le, int32_t)
>  
> -- 
> 2.11.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
