Received: from eggs.gnu.org ([2001:4830:134:3::10]:41435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMM4-0001Iz-Mu
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMM1-0002aQ-GM
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:13:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elMM1-0002ZY-B0
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:13:41 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-24-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1011949b-ca28-3c9e-9aed-21f8af8d5f7e@redhat.com>
Date: Mon, 12 Feb 2018 16:13:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-24-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 23/29] Include less of the generated
 modular QAPI headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:36 AM, Markus Armbruster wrote:
> In my "build everything" tree, a change to the types in
> qapi-schema.json triggers a recompile of about 4800 out of 5100
> objects.
> 
> The previous commit split up qmp-commands.h, qmp-event.h, qmp-visit.h,
> qapi-types.h.  Each of these headers still includes all its shards.
> Reduce compile time by including just the shards we actually need.
> 
> To illustrate the benefits: adding a type to qapi/migration.json now
> recompiles some 2300 instead of 4800 objects.  The next commit will
> improve it further.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   backends/cryptodev.c             |  1 -
>   backends/hostmem.c               |  3 ++-

How did you determine which shards to include where? Remove all shards, 
try compiling, and see what fails, then add back in the right includes? 
Or was it scripted somehow?  (Trying to figure out, in case I have to 
rebase this patch)

> +++ b/block/crypto.c
> @@ -24,9 +24,9 @@
>   #include "sysemu/block-backend.h"
>   #include "crypto/block.h"
>   #include "qapi/opts-visitor.h"
> +#include "qapi/qapi-visit-crypto.h"
>   #include "qapi/qmp/qdict.h"
>   #include "qapi/qobject-input-visitor.h"
> -#include "qapi-visit.h"
>   #include "qapi/error.h"

Any rhyme or reason to the resulting include order that I should be 
looking for (we aren't alphabetical in general, but if your changes were 
trying to honor a particular pattern among the few affected lines, 
that's useful to know).

> +++ b/scripts/qapi/commands.py

The non-mechanical portion of the patch :)

> @@ -241,6 +241,9 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):
>   
>       def _begin_module(self, name):
>           self._visited_ret_types[self._genc] = set()
> +        commands = self._module_basename('qapi-commands', name)
> +        types = self._module_basename('qapi-types', name)
> +        visit = self._module_basename('qapi-visit', name)
>           self._genc.add(mcgen('''
>   #include "qemu/osdep.h"
>   #include "qemu-common.h"
> @@ -251,18 +254,17 @@ class QAPISchemaGenCommandVisitor(QAPISchemaModularCVisitor):
>   #include "qapi/qobject-input-visitor.h"
>   #include "qapi/dealloc-visitor.h"
>   #include "qapi/error.h"
> -#include "%(prefix)sqapi-types.h"
> -#include "%(prefix)sqapi-visit.h"
> -#include "%(prefix)sqmp-commands.h"
> +#include "%(visit)s.h"
> +#include "%(commands)s.h"
>   
>   ''',
> -                             prefix=self._prefix))
> +                             commands=commands, visit=visit))
>           self._genh.add(mcgen('''
> -#include "%(prefix)sqapi-types.h"
> +#include "%(types)s.h"
>   #include "qapi/qmp/dispatch.h"
>   
>   ''',
> -                             prefix=self._prefix))
> +                             types=types))

Makes sense.

The compiler will catch anything we did wrong.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
