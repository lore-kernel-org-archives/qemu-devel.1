Received: from eggs.gnu.org ([2001:4830:134:3::10]:37478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHrYU-0005U3-Ar
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHrYP-0005VO-AI
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:33:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHrYP-0005V6-2z
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:33:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-3-david@redhat.com>
Date: Wed, 31 Oct 2018 15:32:55 +0100
In-Reply-To: <20181023152306.3123-3-david@redhat.com> (David Hildenbrand's
	message of "Tue, 23 Oct 2018 17:23:01 +0200")
Message-ID: <87zhuudw4o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qapi: correctly parse uint64_t
 values from strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

David Hildenbrand <david@redhat.com> writes:

> Right now, we parse uint64_t values just like int64_t values, resulting
> in negative values getting accepted and certain valid large numbers only
> being representable as negative numbers. Also, reported errors indicate
> that an int64_t is expected.
>
> Parse uin64_t separately. We don't have to worry about ranges.

The commit message should mention *why* we don't we have to worry about
ranges.

>
> E.g. we can now also specify
>     -device nvdimm,memdev=mem1,id=nv1,addr=0xFFFFFFFFC0000000
> Instead of only going via negative values
>     -device nvdimm,memdev=mem1,id=nv1,addr=-0x40000000
>
> Resulting in the same values
>
> (qemu) info memory-devices
> Memory device [nvdimm]: "nv1"
>   addr: 0xffffffffc0000000
>   slot: 0
>   node: 0
>

Suggest to mention this makes the string-input-visitor catch up with the
qobject-input-visitor, which got changed similarly in commit
5923f85fb82.

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  qapi/string-input-visitor.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
> index c1454f999f..f2df027325 100644
> --- a/qapi/string-input-visitor.c
> +++ b/qapi/string-input-visitor.c
> @@ -247,15 +247,16 @@ error:
>  static void parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
>                                Error **errp)
>  {
> -    /* FIXME: parse_type_int64 mishandles values over INT64_MAX */
> -    int64_t i;
> -    Error *err = NULL;
> -    parse_type_int64(v, name, &i, &err);
> -    if (err) {
> -        error_propagate(errp, err);
> -    } else {
> -        *obj = i;
> +    StringInputVisitor *siv = to_siv(v);
> +    uint64_t val;
> +
> +    if (qemu_strtou64(siv->string, NULL, 0, &val)) {

Works because qemu_strtou64() accepts negative numbers and interprets
them modulo 2^64.

> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
> +                   "an uint64 value");

I think this should be "a uint64 value".

> +        return;
>      }
> +
> +    *obj = val;
>  }
>  
>  static void parse_type_size(Visitor *v, const char *name, uint64_t *obj,

Patch looks good to me otherwise.
