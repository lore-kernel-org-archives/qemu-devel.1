Received: from eggs.gnu.org ([2001:4830:134:3::10]:40844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkwyH-0000O7-Rm
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkwyD-0003Y2-Ti
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:35:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkwyD-0003X2-Ks
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 14:35:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
	<1503564371-26090-3-git-send-email-armbru@redhat.com>
	<04558062-88d3-0bd2-06d2-ba8a5af8ba8e@redhat.com>
Date: Thu, 24 Aug 2017 20:35:04 +0200
In-Reply-To: <04558062-88d3-0bd2-06d2-ba8a5af8ba8e@redhat.com> (Eric Blake's
	message of "Thu, 24 Aug 2017 11:38:33 -0500")
Message-ID: <87y3q8ddbb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/16] qapi: Drop superfluous
 qapi_enum_parse() parameter max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/24/2017 03:45 AM, Markus Armbruster wrote:
>> The lookup tables have a sentinel, no need to make callers pass their
>> size.
>> 
>> Fun: the header has it in the wrong position.  Good riddance.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block.c                  |  1 -
>>  block/file-posix.c       |  7 +++----
>>  block/file-win32.c       |  2 +-
>>  block/gluster.c          |  6 ++----
>>  block/parallels.c        |  3 ++-
>>  block/qcow2.c            |  6 ++----
>>  blockdev.c               |  1 -
>>  hmp.c                    |  2 +-
>>  include/qapi/util.h      |  2 +-
>>  migration/global_state.c |  3 +--
>
> This would be a patch where using scripts/git.orderfile to highlight the
> interface change first would make review a bit quicker :)
>
>> +++ b/include/qapi/util.h
>> @@ -12,7 +12,7 @@
>>  #define QAPI_UTIL_H
>>  
>>  int qapi_enum_parse(const char * const lookup[], const char *buf,
>> -                    int max, int def, Error **errp);
>> +                    int def, Error **errp);
>
> I'm not sure what you meant by wrong position; were you thinking that
> lookup/max should be immediately adjacent (since max is a property of
> the lookup[] parameter), and sticking 'buf' in between the two is what
> meant 'max' was in the wrong position?

Compare the declaration above with the definition below:

    diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
    index 46eda7d..ee7594f 100644
    --- a/qapi/qapi-util.c
    +++ b/qapi/qapi-util.c
    @@ -16,7 +16,7 @@
     #include "qapi/util.h"

     int qapi_enum_parse(const char * const lookup[], const char *buf,
    -                    int max, int def, Error **errp)
    +                    int def, Error **errp)
     {
         int i;

Declaration has max before def, definition has it the other way round.

Such errors are one reason I prefer to have documentation next to
definitions, which are authoritative, rather than declarations, which
may or may not match the definition.

> The change itself is reasonable, even if the commit message needs a
> tweak to answer my question.

Care to suggest a wording?

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
