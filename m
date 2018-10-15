Received: from eggs.gnu.org ([2001:4830:134:3::10]:34867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC8fk-0004gX-VB
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC8fh-00028k-8v
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:37:00 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC8ff-00027U-9k
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:36:56 -0400
Received: by mail-pl1-x643.google.com with SMTP id f18-v6so9795516plr.1
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 12:36:54 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-4-aclindsa@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3a964ae2-a5d0-5960-9e15-7ede929a8294@linaro.org>
Date: Mon, 15 Oct 2018 12:36:50 -0700
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-4-aclindsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 03/14] migration: Add post_save function
 to VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aclindsa@gmail.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> In some cases it may be helpful to modify state before saving it for
> migration, and then modify the state back after it has been saved. The
> existing pre_save function provides half of this functionality. This
> patch adds a post_save function to provide the second half.
> 
> Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
> ---
>  docs/devel/migration.rst    |  9 +++++++--
>  include/migration/vmstate.h |  1 +
>  migration/vmstate.c         | 10 +++++++++-
>  3 files changed, 17 insertions(+), 3 deletions(-)

Hmm, maybe.  I believe the common practice is for pre_save to copy state into a
separate member on the side, so that conversion back isn't necessary.

Ccing in the migration maintainers for a second opinion.


r~

> 
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index 687570754d..2a2533c9b3 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -419,8 +419,13 @@ The functions to do that are inside a vmstate definition, and are called:
>  
>    This function is called before we save the state of one device.
>  
> -Example: You can look at hpet.c, that uses the three function to
> -massage the state that is transferred.
> +- ``void (*post_save)(void *opaque);``
> +
> +  This function is called after we save the state of one device
> +  (even upon failure, unless the call to pre_save returned and error).
> +
> +Example: You can look at hpet.c, that uses the first three functions
> +to massage the state that is transferred.
>  
>  The ``VMSTATE_WITH_TMP`` macro may be useful when the migration
>  data doesn't match the stored device data well; it allows an
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 2b501d0466..f6053b94e4 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -185,6 +185,7 @@ struct VMStateDescription {
>      int (*pre_load)(void *opaque);
>      int (*post_load)(void *opaque, int version_id);
>      int (*pre_save)(void *opaque);
> +    void (*post_save)(void *opaque);
>      bool (*needed)(void *opaque);
>      VMStateField *fields;
>      const VMStateDescription **subsections;
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 0bc240a317..9afc9298f3 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -387,6 +387,9 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  if (ret) {
>                      error_report("Save of field %s/%s failed",
>                                   vmsd->name, field->name);
> +                    if (vmsd->post_save) {
> +                        vmsd->post_save(opaque);
> +                    }
>                      return ret;
>                  }
>  
> @@ -412,7 +415,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>          json_end_array(vmdesc);
>      }
>  
> -    return vmstate_subsection_save(f, vmsd, opaque, vmdesc);
> +    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc);
> +
> +    if (vmsd->post_save) {
> +        vmsd->post_save(opaque);
> +    }
> +    return ret;
>  }
>  
>  static const VMStateDescription *
> 
