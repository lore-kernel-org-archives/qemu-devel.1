Received: from eggs.gnu.org ([2001:4830:134:3::10]:53752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHteW-0005XD-KE
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHteK-0004R9-Ux
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:47:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gHteK-0004QU-Lc
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:47:20 -0400
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-2-david@redhat.com>
	<87pnvqdvsj.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e8fe86a1-d075-2ea8-d1f4-e08e5dceee07@redhat.com>
Date: Wed, 31 Oct 2018 17:47:13 +0100
MIME-Version: 1.0
In-Reply-To: <87pnvqdvsj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] qapi: use qemu_strtoi64() in
 parse_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 31.10.18 15:40, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> The qemu api claims to be easier to use, and the resulting code seems to
>> agree.
> 
> Ah, an opportunity to nitpick spelling!  "The QEMU API", and "qapi: Use
> qemu_strtoi64() ..."

Whatever floats your boat ;) Will change.

> 
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  qapi/string-input-visitor.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
>> index b3fdd0827d..c1454f999f 100644
>> --- a/qapi/string-input-visitor.c
>> +++ b/qapi/string-input-visitor.c
>> @@ -20,6 +20,7 @@
>>  #include "qemu/option.h"
>>  #include "qemu/queue.h"
>>  #include "qemu/range.h"
>> +#include "qemu/cutils.h"
>>  
>>  
>>  struct StringInputVisitor
>> @@ -46,10 +47,10 @@ static void free_range(void *range, void *dummy)
>>  
>>  static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>  {
>> -    char *str = (char *) siv->string;
>> -    long long start, end;
>> +    const char *str = (char *) siv->string;
> 
> And an opportunity to nitpick whitespace!  Drop the space between (char
> *) and siv->string while there.

Shouldn't checkpatch complain, too? Will fix.

> 
>> +    const char *endptr;
>> +    int64_t start, end;
>>      Range *cur;
>> -    char *endptr;
>>  
>>      if (siv->ranges) {
>>          return 0;
>> @@ -60,9 +61,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>      }
>>  
>>      do {
>> -        errno = 0;
>> -        start = strtoll(str, &endptr, 0);
>> -        if (errno == 0 && endptr > str) {
>> +        if (!qemu_strtoi64(str, &endptr, 0, &start)) {
>>              if (*endptr == '\0') {
>>                  cur = g_malloc0(sizeof(*cur));
>>                  range_set_bounds(cur, start, start);
>> @@ -71,11 +70,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>                  str = NULL;
>>              } else if (*endptr == '-') {
>>                  str = endptr + 1;
>> -                errno = 0;
>> -                end = strtoll(str, &endptr, 0);
>> -                if (errno == 0 && endptr > str && start <= end &&
>> -                    (start > INT64_MAX - 65536 ||
>> -                     end < start + 65536)) {
>> +                if (!qemu_strtoi64(str, &endptr, 0, &end) && start < end) {
> 
> You deleted (start > INT64_MAX - 65536 || end < start + 65536).  Can you
> explain that to me?  I'm feeling particularly dense today...

qemu_strtoi64 performs all different kinds of error handling completely
internally. This old code here was an attempt to filter out -EWHATEVER
from the response. No longer needed as errors and the actual value are
reported via different ways.

Thanks!

> 
>>                      if (*endptr == '\0') {
>>                          cur = g_malloc0(sizeof(*cur));
>>                          range_set_bounds(cur, start, end);


-- 

Thanks,

David / dhildenb
