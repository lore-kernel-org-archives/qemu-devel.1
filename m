Received: from eggs.gnu.org ([2001:4830:134:3::10]:40817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gOkHm-0007RZ-GE
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gOkHi-0001WZ-M6
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:12:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gOkHe-0001TZ-AM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:12:14 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-7-david@redhat.com>
	<87muq972p0.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3d186921-e32f-60aa-cfc6-07345f6795c7@redhat.com>
Date: Mon, 19 Nov 2018 15:12:11 +0100
MIME-Version: 1.0
In-Reply-To: <87muq972p0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 6/9] qapi: rewrite string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

>>
>> Tests have to be fixed up:
>> - Two BUGs were hardcoded that are fixed now
>> - The string-input-visitor now actually returns a parsed list and not
>>   an ordered set.
>=20
> I'd expect this to necessitate an update of callers that expect a set, =
but...
>=20
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/qapi/string-input-visitor.h |   4 +-
>>  qapi/string-input-visitor.c         | 410 ++++++++++++++++-----------=
-
>>  tests/test-string-input-visitor.c   |  18 +-
>>  3 files changed, 239 insertions(+), 193 deletions(-)
>=20
> ... there's none.
>=20
> Let me know if you need help finding them.  I think we tracked them dow=
n
> during the discussion that led to this series.
>=20

Indeed, I missed to document that. So here is the outcome:

1. backends/hostmem.c:host_memory_backend_set_host_nodes()

-> calls visit_type_uint16List(via bitmap)
-> the code can deal with duplicates/unsorted lists (bitmap_set)

Side node: I am not sure if there should be some range checks, but maybe
the bitmap is large enough .... hm ...

2. qapi-visit.c::visit_type_Memdev_members()

-> calls visit_type_uint16List()
-> I think this never used for input, only for output / freeing

3. qapi-visit.c::visit_type_NumaNodeOptions_members()

-> calls visit_type_uint16List()
-> I think this never used for input, only for output / freeing

4. qapi-visit.c::visit_type_RockerOfDpaGroup_members

-> calls visit_type_uint32List()
-> I think this never used for input, only for output / freeing

5. qapi-visit.c::visit_type_RxFilterInfo_members()

-> calls visit_type_intList()
-> I think this never used for input, only for output / freeing

6. numa.c::query_memdev()

-> calls object_property_get_uint16List()
--> String parsed via visit_type_uint16List() into list
-> qmp_query_memdev() uses this list
--> Not relevant if unique or sorted
-> hmp_info_memdev() uses this list
--> List converted again to a string using string output visitor

-> I don't think unique/sorted is relevant here.


Am I missing anything / is any of my statements wrong?

Thanks!

>>
>> diff --git a/include/qapi/string-input-visitor.h b/include/qapi/string=
-input-visitor.h
>> index 33551340e3..921f3875b9 100644
>> --- a/include/qapi/string-input-visitor.h
>> +++ b/include/qapi/string-input-visitor.h
>> @@ -19,8 +19,8 @@ typedef struct StringInputVisitor StringInputVisitor=
;
>> =20
>>  /*
>>   * The string input visitor does not implement support for visiting
>> - * QAPI structs, alternates, null, or arbitrary QTypes.  It also
>> - * requires a non-null list argument to visit_start_list().
>> + * QAPI structs, alternates, null, or arbitrary QTypes. Only flat lis=
ts
>> + * of integers (except type "size") are supported.
>>   */
>>  Visitor *string_input_visitor_new(const char *str);
>> =20
>> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
>> index b89c6c4e06..4113be01fb 100644
>> --- a/qapi/string-input-visitor.c
>> +++ b/qapi/string-input-visitor.c
>> @@ -4,10 +4,10 @@
>>   * Copyright Red Hat, Inc. 2012-2016
>>   *
>>   * Author: Paolo Bonzini <pbonzini@redhat.com>
>> + *         David Hildenbrand <david@redhat.com>
>>   *
>>   * This work is licensed under the terms of the GNU LGPL, version 2.1=
 or later.
>>   * See the COPYING.LIB file in the top-level directory.
>> - *
>>   */
>> =20
>>  #include "qemu/osdep.h"
>> @@ -18,21 +18,39 @@
>>  #include "qapi/qmp/qerror.h"
>>  #include "qapi/qmp/qnull.h"
>>  #include "qemu/option.h"
>> -#include "qemu/queue.h"
>> -#include "qemu/range.h"
>>  #include "qemu/cutils.h"
>> =20

[...]
>>  static void parse_type_int64(Visitor *v, const char *name, int64_t *o=
bj,
>>                               Error **errp)
>>  {
>>      StringInputVisitor *siv =3D to_siv(v);
>> -
>> -    if (parse_str(siv, name, errp) < 0) {
>> +    int64_t val;
>> +
>> +    switch (siv->lm) {
>> +    case LM_NONE:
>> +        /* just parse a simple int64, bail out if not completely cons=
umed */
>> +        if (qemu_strtoi64(siv->string, NULL, 0, &val)) {
>> +                error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
>> +                           name ? name : "null", "int64");
>> +            return;
>> +        }
>> +        *obj =3D val;
>>          return;
>> +    case LM_UNPARSED:
>> +        if (try_parse_int64_list_entry(siv, obj)) {
>> +            error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? nam=
e : "null",
>> +                       "list of int64 values or ranges");
>> +            return;
>> +        }
>> +        assert(siv->lm =3D=3D LM_INT64_RANGE);
>> +        /* FALLTHROUGH */
>=20
> Please spell it /* fall through */, because:
>=20
> $ git-grep -Ei '/\* *fall.?thr[a-z]* *\*/' | sed 's/.*\* *\(fall[^*]*\)=
\*.*/\1/i' | sort | uniq -c
>       4 FALL THROUGH=20
>       8 FALLTHROUGH=20
>      61 FALLTHRU=20
>      36 Fall through=20
>      20 Fallthrough=20
>       4 Fallthru=20
>     237 fall through=20
>       1 fall-through=20
>      16 fallthrough=20
>      39 fallthru=20

Done!

[...]
>=20
>> +    case LM_INT64_RANGE:
>> +        /* return the next element in the range */
>> +        assert(siv->rangeNext.i64 <=3D siv->rangeEnd.i64);
>> +        *obj =3D siv->rangeNext.i64++;
>> +
>> +        if (siv->rangeNext.i64 > siv->rangeEnd.i64 || *obj =3D=3D INT=
64_MAX) {
>> +            /* end of range, check if there is more to parse */
>> +            if (siv->unparsed_string[0]) {
>> +                siv->lm =3D LM_UNPARSED;
>> +            } else {
>> +                siv->lm =3D LM_END;
>> +            }
>=20
> I'd do
>=20
>                siv->lm =3D siv->unparsed_string[0] ? LM_UNPARSED : LM_E=
ND;
>=20
> Matter of taste, entirely up to you.

Yes, makes sense, thanks!

>=20
>> +        }
>> +        return;
>> +    case LM_END:
>> +        error_setg(errp, "Fewer list elements expected");
>> +        return;
>> +    default:
>> +        abort();
>>      }
>> +}
>> =20
>> -    if (!siv->ranges) {
>> -        goto error;
>> -    }
>> -
>> -    if (!siv->cur_range) {
>> -        Range *r;
>> +static int try_parse_uint64_list_entry(StringInputVisitor *siv, uint6=
4_t *obj)
>> +{
>> +    const char *endptr;
>> +    uint64_t start, end;
>> =20
>> -        siv->cur_range =3D g_list_first(siv->ranges);
>> -        if (!siv->cur_range) {
>> -            goto error;
>> +    /* parse a simple uint64 or range */
>=20
> try_parse_int64_list_entry() doesn't have this comment.  I think either
> both or none should have it.  You decide.

Indeed, the comment got lost on the way. Will readd it.

[...]

--=20

Thanks,

David / dhildenb
