Received: from eggs.gnu.org ([2001:4830:134:3::10]:55312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5FK-0004tI-Em
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5FJ-0003bX-KM
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:05:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj5FJ-0003bI-FB
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:05:37 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-19-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f713262-9295-9224-fcd4-4f267a2be550@redhat.com>
Date: Fri, 27 Jul 2018 11:05:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/23] migration-test: Clean up string
 interpolation into QMP, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> Leaving interpolation into JSON to qmp() is more robust than building
> QMP input manually, as explained in the recent commit "tests: Clean up
> string interpolation into QMP input (simple cases)".
> 
> migrate() interpolates members into a JSON object.  Change it to take
> its extra QMP arguments as arguments for qdict_from_jsonf_nofail()
> instead of a string containing JSON members.
> 
> Bonus: gets rid of a non-literal format string.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
> 
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>   tests/migration-test.c | 28 ++++++++++++++++------------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 

> +++ b/tests/migration-test.c
> @@ -14,6 +14,7 @@
>   
>   #include "libqtest.h"
>   #include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qjson.h"
>   #include "qemu/option.h"
>   #include "qemu/range.h"
>   #include "qemu/sockets.h"
> @@ -381,16 +382,19 @@ static void migrate_set_capability(QTestState *who, const char *capability,
>       qobject_unref(rsp);
>   }
>   
> -static void migrate(QTestState *who, const char *uri, const char *extra)
> +static void migrate(QTestState *who, const char *uri, const char *fmt, ...)
>   {

No gcc attribute?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
