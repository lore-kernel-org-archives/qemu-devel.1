Received: from eggs.gnu.org ([2001:4830:134:3::10]:42811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8Rtj-0003m4-Hj
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8Rtg-0002qp-EJ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8Rtg-0002pb-5C
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:43:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-4-ehabkost@redhat.com>
Date: Wed, 10 May 2017 15:43:16 +0200
In-Reply-To: <20170505201128.12099-4-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Fri, 5 May 2017 17:11:28 -0300")
Message-ID: <8760h825fv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/3] string-input-visitor: Support
 alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

In addition to Eric's remarks:

Eduardo Habkost <ehabkost@redhat.com> writes:

> When parsing alternates from a string, there are some limitations in
> what we can do, but it is a valid use case in some situations. We can
> support booleans, integer types, and enums.
>
> This will be used to support 'feature=force' in -cpu options, while
> keeping 'feature=on|off|true|false' represented as boolean values.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Updated string_input_visitor_new() documentation
>   to mention alternate support (Markus Armbruster)
> * Detect ambiguous alternates at runtime. Test case included.
> * Removed support for integers. We don't need it yet, and
>   it would require sorting out the parse_str() mess.
> * Change supported_qtypes to uint32_t (Eric Blake)
> * Update tests/qapi-schema/qapi-schema-test.out to match
>   qapi-schema-test.json updates
>   (Eric Blake)
> * Code indentation fix (Markus Armbruster)
> * Use &error_abort on test cases instead of g_assert(!err)
>   (Markus Armbruster)
> ---
>  include/qapi/string-input-visitor.h     |  6 +-
>  qapi/string-input-visitor.c             | 99 +++++++++++++++++++++++++++++----
>  tests/test-string-input-visitor.c       | 76 +++++++++++++++++++++++++
>  tests/qapi-schema/qapi-schema-test.json |  8 +++
>  tests/qapi-schema/qapi-schema-test.out  |  9 +++
>  5 files changed, 187 insertions(+), 11 deletions(-)
>
> diff --git a/include/qapi/string-input-visitor.h b/include/qapi/string-input-visitor.h
> index 33551340e3..e7f359f225 100644
> --- a/include/qapi/string-input-visitor.h
> +++ b/include/qapi/string-input-visitor.h
> @@ -19,8 +19,12 @@ typedef struct StringInputVisitor StringInputVisitor;
>  
>  /*
>   * The string input visitor does not implement support for visiting
> - * QAPI structs, alternates, null, or arbitrary QTypes.  It also
> + * QAPI structs, null, or arbitrary QTypes.  It also
>   * requires a non-null list argument to visit_start_list().

I'd prefer to have this paragraph refilled.

> + *
> + * Support for alternates is very limited: only bool and enum
> + * members are supported, and only when the enum members'
> + * representations can't be confused with a bool value.
>   */
>  Visitor *string_input_visitor_new(const char *str);
>  
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index c089491c24..e339b88192 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -19,6 +19,7 @@
>  #include "qemu/option.h"
>  #include "qemu/queue.h"
>  #include "qemu/range.h"
> +#include "qemu/host-utils.h"

Still needed?

>  
>  
>  struct StringInputVisitor
[...]

Skipping the rest for now.  I'd like to explore restricting alternates
at compile-time.  If that turns out well, we can drop most of this
patch.
