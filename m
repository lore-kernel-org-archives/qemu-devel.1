Received: from eggs.gnu.org ([2001:4830:134:3::10]:59002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egnIA-0002WN-Bs
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1egnI7-0005HN-8R
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:58:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1egnI7-0005GN-0S
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:58:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F111736809
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 07:58:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-4-armbru@redhat.com>
	<8bb9095a-93f8-ba14-3296-5a2d03cbf5e4@redhat.com>
Date: Wed, 31 Jan 2018 08:58:43 +0100
In-Reply-To: <8bb9095a-93f8-ba14-3296-5a2d03cbf5e4@redhat.com> (Eric Blake's
	message of "Tue, 30 Jan 2018 10:14:37 -0600")
Message-ID: <877ery793g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/18] Include qapi/error.h exactly where
 needed
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

> On 01/30/2018 04:21 AM, Markus Armbruster wrote:
>> This cleanup makes the number of objects depending on qapi/error.h
>> drop from 1910 (out of 4739) to 1612 in my "build everything" tree.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  arch_init.c                             | 1 +
>>  audio/wavcapture.c                      | 1 +
>>  balloon.c                               | 1 +
>>  block.c                                 | 2 ++
>>  block/block-backend.c                   | 1 +
>>  block/iscsi.c                           | 1 +
>>  block/qapi.c                            | 1 +
>
> So several .c files have to use it explicitly,
>
>>  fsdev/qemu-fsdev-throttle.h             | 1 -
>
>>  include/crypto/random.h                 | 1 -
>>  include/crypto/xts.h                    | 1 -
>>  include/hw/ide/internal.h               | 1 -
>>  include/ui/console.h                    | 1 -
>
> because they were previously getting it from .h files that don't
> directly emit an error.  Makes sense.
>
> Patches like this are easy to test - if it still compiles, you did it
> right ;)  Out of curiousity, how are you counting how many files got
> compiled per run?  Touch the .h, then pass 'make' output to 'grep -c "^
> CC "'?

The data is up for grabs: in the .d gcc spits out for make.  I process
them like this, after fresh build:

    $ find bld -name \*.d -exec cat {} + | clean-deps

where clean-deps is this AWK script:

    #!/usr/bin/awk -f
    /\\$/ {
        l = $0
        while (sub(/\\$/, "", l) && (getline t))
            l = l t
        $0 = l
    }

    NF > 1 {
        delete a
        for (i = 2; i <= NF; i++) {
            n = $i
            # ignore system headers and non-headers
            if (match(n, /^\/usr/) || !match(n, /\.h$/))
                continue
            # strip leading ../ from target build running in sub-directory
            sub(/^\.\.\//, "", n)
            # normalize /../ and /./
            while (sub(/[^\/]*\/\.\.\//, "", n)) ;
            gsub(/\/\.\//, "/", n)
            # absolute -> relative
            sub(/\/home\/armbru\/work\//, "/work/armbru/", n)
            sub(/\/work\/armbru\/qemu\/(bld\/)?/, "", n)
            # ignore dupes
            if (n in a)
                continue
            a[n] = i
            h[n]++
        }
    }

    END {
        for (i in h)
            print i, h[i]
    }

My conversion from absolute to relative is specific to my personal
setup.  It would have to be generalized before we can put this into
scripts.

> But just to make sure nothing weird is happening, I also read through
> it, and found:
>
>> 
>> diff --git a/arch_init.c b/arch_init.c
>> index a0b8ed6167..0fb8093f92 100644
>> --- a/arch_init.c
>> +++ b/arch_init.c
>> @@ -21,6 +21,7 @@
>>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>   * THE SOFTWARE.
>>   */
>> +
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>>  #include "cpu.h"
>
> Spurious whitespace change.  Should this belong in 1/18, even though
> arch_init.c didn't need cleanup there?  Or...
>
>> +++ b/block.c
>> @@ -21,6 +21,7 @@
>>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>   * THE SOFTWARE.
>>   */
>> +
>>  #include "qemu/osdep.h"
>>  #include "block/trace.h"
>>  #include "block/block_int.h"
>
> ...since you did it again, do you need a separate patch for ALL of these
> types of whitespace cleanups near osdep.h?

I routinely insert this blank line when I touch includes anyway.

>> +++ b/block/qcow2.c
>> @@ -21,6 +21,7 @@
>>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>   * THE SOFTWARE.
>>   */
>> +
>>  #include "qemu/osdep.h"
>>  #include "block/block_int.h"
>>  #include "sysemu/block-backend.h"
>
> and again
>
>> +++ b/chardev/char-ringbuf.c
>> @@ -21,9 +21,11 @@
>>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>>   * THE SOFTWARE.
>>   */
>> +
>>  #include "qemu/osdep.h"
>>  #include "chardev/char.h"
>>  #include "qmp-commands.h"
>> +#include "qapi/error.h"
>>  #include "qemu/base64.h"
>>  
>>  /* Ring buffer chardev */
>
> Here, it's in the same hunk, so a bit more forgivable.  But there's
> definitely enough of them that a separate commit might be in order.
>
> At any rate, whether done as one patch (with a better commit message) or
> as two, I see nothing semantically wrong with the cleanups done here, so

I'll amend the commit message.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
