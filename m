Received: from eggs.gnu.org ([2001:4830:134:3::10]:34307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egnXD-0000PM-Sa
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egnXA-0006C6-NY
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:14:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egnXA-0006BV-IE
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:14:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DD71E780E9
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:14:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-19-armbru@redhat.com>
	<d21a61a0-686c-6356-b223-231789378025@redhat.com>
Date: Wed, 31 Jan 2018 09:14:18 +0100
In-Reply-To: <d21a61a0-686c-6356-b223-231789378025@redhat.com> (Eric Blake's
	message of "Tue, 30 Jan 2018 12:08:32 -0600")
Message-ID: <87wozy5tt1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 18/18] Move include qemu/option.h from
 qemu-common.h to actual users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 01/30/2018 04:22 AM, Markus Armbruster wrote:
>> qemu-common.h includes qemu/option.h, but most places that include the
>> former don't actually need the latter.  Drop the include, and add it
>> to the places that actually need it.
>> 
>> While there, drop superfluous includes of both headers.
>> 
>> This cleanup makes the number of objects depending on qemu/option.h
>> drop from 4542 (out of 4739) to 284 in my "build everything" tree.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  103 files changed, 98 insertions(+), 54 deletions(-)
>
> Bigger effort, but still a nice cleanup.  And especially nice if we're
> trying to reduce users of QemuOpts.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>> +++ b/block/file-posix.c
>> @@ -21,12 +21,14 @@
>>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>   * THE SOFTWARE.
>>   */
>> +
>>  #include "qemu/osdep.h"
>>  #include "qapi/error.h"
>>  #include "qemu/cutils.h"
>>  #include "qemu/error-report.h"
>>  #include "block/block_int.h"
>>  #include "qemu/module.h"
>> +#include "qemu/option.h"
>>  #include "trace.h"
>
> More of the blank line before osdep.h cleanup comment.
>
>> +++ b/hw/9pfs/9p-handle.c
>> @@ -22,6 +22,7 @@
>>  #include "qemu/xattr.h"
>>  #include "qemu/cutils.h"
>>  #include "qemu/error-report.h"
>> +#include "qemu/option.h"
>>  #include <linux/fs.h>
>>  #ifdef CONFIG_LINUX_MAGIC_H
>>  #include <linux/magic.h>
>
> Shouldn't we be fixing this one to include system headers (like
> <linux/fs.h> prior to internal headers?  Separate cleanup, though.

I'd love to see a tree-wide #include ordering cleanup, with a checkpatch
extension or a make target check-source to keep it clean.  Out of this
series' scope.

>> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
>> index c6d8af4fb8..d85494bd31 100644
>> --- a/hw/9pfs/9p-local.c
>> +++ b/hw/9pfs/9p-local.c
>> @@ -26,6 +26,7 @@
>>  #include "qapi/error.h"
>>  #include "qemu/cutils.h"
>>  #include "qemu/error-report.h"
>> +#include "qemu/option.h"
>>  #include <libgen.h>
>>  #include <linux/fs.h>
>
> More of that separate cleanup.
