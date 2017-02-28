Received: from eggs.gnu.org ([2001:4830:134:3::10]:56730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cinlb-0000DR-Ax
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cinla-0007gP-6z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:48:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-13-git-send-email-armbru@redhat.com>
	<f2beae5b-482d-7151-cb7a-1f103e031f3b@redhat.com>
Date: Tue, 28 Feb 2017 20:48:50 +0100
In-Reply-To: <f2beae5b-482d-7151-cb7a-1f103e031f3b@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 13:19:38 -0600")
Message-ID: <87efyif659.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 12/24] qobject: Propagate parse errors
 through qobject_from_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com, pkrempa@redhat.com, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/27/2017 05:20 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block.c                            |  2 +-
>>  include/qapi/qmp/qjson.h           |  5 +--
>>  monitor.c                          |  2 +-
>>  qobject/qjson.c                    |  4 +--
>>  tests/check-qjson.c                | 62 +++++++++++++++++++-------------------
>>  tests/test-visitor-serialization.c |  2 +-
>>  6 files changed, 39 insertions(+), 38 deletions(-)
>> 
>
> As with 8/24, this would be a good place for the commit message to
> mention that this patch adds the parameter and mechanically adjusts
> callers with minimal semantic changes, but that later patches will take
> advantage of the parameter.

Already done :)

>> +++ b/include/qapi/qmp/qjson.h
>> @@ -17,8 +17,9 @@
>>  #include "qapi/qmp/qobject.h"
>>  #include "qapi/qmp/qstring.h"
>>  
>> -QObject *qobject_from_json(const char *string);
>> -QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2);
>> +QObject *qobject_from_json(const char *string, Error **errp);
>
> The real change here, vs.
>
>> +QObject *qobject_from_jsonf(const char *string, ...)
>> +    GCC_FMT_ATTR(1, 2);
>
> formatting.  Should the formatting be hoisted earlier in the series,
> when you first touch qobject_from_jsonv?

Either that, or simply drop this change.  I'd say drop.

>>  QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
>>      GCC_FMT_ATTR(1, 0);
>
> This makes qobject_from_jsonf() and qobject_from_jsonv() asymmetric
> (only one of the two can report errors);

Yes, but they've always been asymmetric: only qobject_from_jsonv() can
fail, qobject_from_jsonf() asserts instead.

>                                          and looks a bit weird to have a
> va_list not as the last argument (as it is, a 'va_list *' argument is
> already weird).

The weirdness precedes the patch, though.

>                  If symmetry is important, we can put errp prior to the
> .../ap argument (then both forms have an errp pointer).  But I don't
> think it matters in the context of this series.  If you DO change it,
> though, then 8/24 would be the place to tweak it.

I'd prefer not to change it now.  Perhaps we can improve things around
here in separate patches.

> At one point, I posted a series that removed all uses of
> qobject_from_json[fv] (leaving just qobject_from_json); at the time,
> there was not a strong opinion on whether the series was worthwhile, but
> if we want it, I'm fine rebasing on top of this.  (One argument in favor
> of my series would be getting rid of the weird 'va_list *' argument).

I didn't like it at the time.  Perhaps I should have a second look.

>> +++ b/qobject/qjson.c
>> @@ -50,9 +50,9 @@ QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
>>      return state.result;
>>  }
>>  
>> -QObject *qobject_from_json(const char *string)
>> +QObject *qobject_from_json(const char *string, Error **errp)
>>  {
>> -    return qobject_from_jsonv(string, NULL, NULL);
>> +    return qobject_from_jsonv(string, NULL, errp);
>
> Of course, if you rebase the series to rearrange where errp appears in
> relation to va_list, then be sure this changes to match (the compiler
> may or may not flag it, if va_list looks too much like void*).
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
