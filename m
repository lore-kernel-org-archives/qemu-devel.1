Received: from eggs.gnu.org ([2001:4830:134:3::10]:59641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIXcn-0005Nm-8t
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIXcj-0002Br-AO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:51:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dIXcj-0002Bb-16
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:51:33 -0400
Date: Wed, 7 Jun 2017 10:51:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170607095127.GB2099@work-vm>
References: <20170606165510.33057-1-pasic@linux.vnet.ibm.com>
	<20170606165510.33057-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170606165510.33057-2-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vmstate: error hint for failed
 equal checks
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
> In some cases a failing VMSTATE_*_EQUAL does not mean we detected a bug
> (it's actually the best we can do). Especially in these cases a verbose
> error message is required.
> 
> Let's introduce infrastructure for specifying a error hint to be used if
> equal check fails.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> Macros come in part 2. Once we are happy with the macros
> this two patches should be squashed into one. 
> ---
>  include/migration/vmstate.h |  1 +
>  migration/vmstate-types.c   | 36 +++++++++++++++++++++++++++++++-----
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 66895623da..d90d9b12ca 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -200,6 +200,7 @@ typedef enum {
>  
>  struct VMStateField {
>      const char *name;
> +    const char *err_hint;
>      size_t offset;
>      size_t size;
>      size_t start;
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 7287c6baa6..84d0545a38 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -19,6 +19,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/queue.h"
>  #include "trace.h"
> +#include "qapi/error.h"
>  
>  /* bool */
>  
> @@ -118,6 +119,7 @@ const VMStateInfo vmstate_info_int32 = {
>  static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
>                             VMStateField *field)
>  {
> +    Error *err = NULL;
>      int32_t *v = pv;
>      int32_t v2;
>      qemu_get_sbe32s(f, &v2);
> @@ -125,7 +127,11 @@ static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
>      if (*v == v2) {
>          return 0;
>      }
> -    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> +    error_setg(&err, "%" PRIx32 " != %" PRIx32, *v, v2);
> +    if (field->err_hint) {
> +        error_append_hint(&err, "%s\n", field->err_hint);
> +    }
> +    error_report_err(err);

I'm a bit worried as to whether the error_append_hint data gets
printed out by error_report_err if we're being driven by a QMP
monitor.
error_report_err uses error_printf_unless_qmp

Since this code doesn't really handle Error *'s back up,
and always prints it's errors into stderr, I'd prefer if you just
used error_report again for the hint, something like:

if (field->err_hint) {
  error_report("%" PRIx32 " != %" PRIx32 "(%s)",
               *v, v2, field->err_hint);
} else {
  error_report("%" PRIx32 " != %" PRIx32, *v, v2);
}

Dave

>      return -EINVAL;
>  }
>  
> @@ -259,6 +265,7 @@ const VMStateInfo vmstate_info_uint32 = {
>  static int get_uint32_equal(QEMUFile *f, void *pv, size_t size,
>                              VMStateField *field)
>  {
> +    Error *err = NULL;
>      uint32_t *v = pv;
>      uint32_t v2;
>      qemu_get_be32s(f, &v2);
> @@ -266,7 +273,11 @@ static int get_uint32_equal(QEMUFile *f, void *pv, size_t size,
>      if (*v == v2) {
>          return 0;
>      }
> -    error_report("%" PRIx32 " != %" PRIx32, *v, v2);
> +    error_setg(&err, "%" PRIx32 " != %" PRIx32, *v, v2);
> +    if (field->err_hint) {
> +        error_append_hint(&err, "%s\n", field->err_hint);
> +    }
> +    error_report_err(err);
>      return -EINVAL;
>  }
>  
> @@ -333,6 +344,7 @@ const VMStateInfo vmstate_info_nullptr = {
>  static int get_uint64_equal(QEMUFile *f, void *pv, size_t size,
>                              VMStateField *field)
>  {
> +    Error *err = NULL;
>      uint64_t *v = pv;
>      uint64_t v2;
>      qemu_get_be64s(f, &v2);
> @@ -340,7 +352,11 @@ static int get_uint64_equal(QEMUFile *f, void *pv, size_t size,
>      if (*v == v2) {
>          return 0;
>      }
> -    error_report("%" PRIx64 " != %" PRIx64, *v, v2);
> +    error_setg(&err, "%" PRIx64 " != %" PRIx64, *v, v2);
> +    if (field->err_hint) {
> +        error_append_hint(&err, "%s\n", field->err_hint);
> +    }
> +    error_report_err(err);
>      return -EINVAL;
>  }
>  
> @@ -356,6 +372,7 @@ const VMStateInfo vmstate_info_uint64_equal = {
>  static int get_uint8_equal(QEMUFile *f, void *pv, size_t size,
>                             VMStateField *field)
>  {
> +    Error *err = NULL;
>      uint8_t *v = pv;
>      uint8_t v2;
>      qemu_get_8s(f, &v2);
> @@ -363,7 +380,11 @@ static int get_uint8_equal(QEMUFile *f, void *pv, size_t size,
>      if (*v == v2) {
>          return 0;
>      }
> -    error_report("%x != %x", *v, v2);
> +    error_setg(&err, "%x != %x", *v, v2);
> +    if (field->err_hint) {
> +        error_append_hint(&err, "%s\n", field->err_hint);
> +    }
> +    error_report_err(err);
>      return -EINVAL;
>  }
>  
> @@ -379,6 +400,7 @@ const VMStateInfo vmstate_info_uint8_equal = {
>  static int get_uint16_equal(QEMUFile *f, void *pv, size_t size,
>                              VMStateField *field)
>  {
> +    Error *err = NULL;
>      uint16_t *v = pv;
>      uint16_t v2;
>      qemu_get_be16s(f, &v2);
> @@ -386,7 +408,11 @@ static int get_uint16_equal(QEMUFile *f, void *pv, size_t size,
>      if (*v == v2) {
>          return 0;
>      }
> -    error_report("%x != %x", *v, v2);
> +    error_setg(&err, "%x != %x", *v, v2);
> +    if (field->err_hint) {
> +        error_append_hint(&err, "%s\n", field->err_hint);
> +    }
> +    error_report_err(err);
>      return -EINVAL;
>  }
>  
> -- 
> 2.11.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
