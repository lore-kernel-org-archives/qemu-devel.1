Received: from eggs.gnu.org ([2001:4830:134:3::10]:53275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dz6K6-0005Ki-99
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dz6K1-0007xj-73
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:24:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dz6K0-0007wT-U2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 15:24:09 -0400
Date: Mon, 2 Oct 2017 16:24:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171002192404.GC17385@localhost.localdomain>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1506935300-132598-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/38] qom: add helper
 type_init_from_array()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
List-ID: <qemu-devel.nongnu.org>

On Mon, Oct 02, 2017 at 11:07:43AM +0200, Igor Mammedov wrote:
> it will help to remove code duplication in places
> that currently open code registration of several
> types.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> I'm going to use it for CPU types in followup patches
> 
> CC: ehabkost@redhat.com
> ---
>  include/qemu/module.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 56dd218..29f9089 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -52,6 +52,16 @@ typedef enum {
>  #define type_init(function) module_init(function, MODULE_INIT_QOM)
>  #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
>  
> +#define type_init_from_array(array)                                        \

So we're moving from a imperative way to register types to a
declarative way.  Sounds nice.

You are also adding a way to register a TypeInfo array easily.
That's nice, too.

But, why do we need to address both at the same time?  I think
this adds some confusing gaps to the module/QOM APIs:

* If you want to register a type at runtime, there are only
  functions to register a single type (type_register(),
  type_register_static().  What if I want to register a TypeInfo
  array from an existing type_init() function?
* If you want to declare types to be registered automatically at
  module_call_init(MODULE_INIT_QOM), you are adding a helper that
  avoids manual type_register*() calls, but only for arrays.
  What if I want to register a single type?  (There are 440+
  functions containing a single type_register*() call in the
  tree)

I have two suggestions:

* Adding a type_register_static_array() helper first, call it
  from a type_init() function, and think about a module.h-based
  helper for arrays later.

* (For later) adding a module_init() helper that works for
  registering a single type too. So, this very common pattern:

      static const TypeInfo FOO_type = {
          /* ... */
      };
      
      static void register_FOO_type(void)
      {
          type_register_static(&FOO_type);
      }
      
      QOM_TYPE(register_FOO_type);

  could be written as:

      static const TypeInfo FOO_type = {
          /* ... */
      };
      
      QOM_TYPE(FOO_type);

(I'm suggesting QOM_TYPE as the macro name, but I'm not sure
about it.  But I think type_init_*() is confusing because it
doesn't work like the other *_init() helpers in module.h)

QOM_TYPE(T) could be just a shortcut to:
QOM_TYPES_PTR(&T, 1).

Your type_init_from_array(A) helper could be just a shortcut to:
QOM_TYPES_PTR(A, ARRAY_SIZE(A)).

> +static void do_qemu_init_ ## array(void)                                   \
> +{                                                                          \
> +    int i;                                                                 \
> +    for (i = 0; i < ARRAY_SIZE(array); i++) {                              \
> +        type_register_static(&array[i]);                                   \

type_register_static() is in qom/object.[ch], and module.[ch] has
no dependency on QOM at all.  I believe this belongs in
qom/object.h, not module.h.

> +    }                                                                      \
> +}                                                                          \
> +module_init(do_qemu_init_ ## array, MODULE_INIT_QOM)

Why not use type_init(do_qemu_init_ ## array)?

> +

Also for later: this is not the first time we generate function
bodies on the fly for module_init().  Maybe module_init could
support a void* data argument?

>  #define block_module_load_one(lib) module_load_one("block-", lib)
>  
>  void register_module_init(void (*fn)(void), module_init_type type);
> -- 
> 2.7.4
> 

-- 
Eduardo
