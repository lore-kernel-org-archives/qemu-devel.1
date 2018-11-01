Received: from eggs.gnu.org ([2001:4830:134:3::10]:32816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gIAEr-0003Kf-Rp
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gIAEl-0006sO-Tn
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:30:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gIAEj-0006pX-RQ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 06:30:03 -0400
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-5-david@redhat.com>
	<20181101110051.67ffb084@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <47807013-d4f0-7057-b484-329dda514501@redhat.com>
Date: Thu, 1 Nov 2018 11:29:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181101110051.67ffb084@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/7] range: add some more functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01.11.18 11:00, Igor Mammedov wrote:
> On Tue, 23 Oct 2018 17:23:03 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> Add some more functions that will be used in memory-device context.
>>
>> range_init(): Init using lower bound and size, check for validity
>> range_init_nofail(): Init using lower bound and size, validity asserte=
d
>> range_size(): Extract the size of a range
>> range_overlaps_range(): Check for overlaps of two ranges
>> range_contains_range(): Check if one range is contained in the other
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/qemu/range.h | 62 +++++++++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 62 insertions(+)
>>
>> diff --git a/include/qemu/range.h b/include/qemu/range.h
>> index 7e75f4e655..ba606c6bc0 100644
>> --- a/include/qemu/range.h
>> +++ b/include/qemu/range.h
>> @@ -112,6 +112,68 @@ static inline uint64_t range_upb(Range *range)
>>      return range->upb;
>>  }
>> =20
>> +/*
>> + * Initialize @range to span the interval [@lob,@lob + @size - 1].
>> + * @size may be 0. If the range would overflow, returns -ERANGE, othe=
rwise
>> + * 0.
>> + */
>> +static inline int QEMU_WARN_UNUSED_RESULT range_init(Range *range, ui=
nt64_t lob,
>> +                                                     uint64_t size)
>> +{
>> +    if (lob + size < lob) {
>> +        return -ERANGE;
>> +    }
>> +    range->lob =3D lob;
>> +    range->upb =3D lob + size - 1;
>> +    range_invariant(range);
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Initialize @range to span the interval [@lob,@lob + @size - 1].
>> + * @size may be 0. Range must not overflow.
>> + */
>> +static inline void range_init_nofail(Range *range, uint64_t lob, uint=
64_t size)
>> +{
>> +    range->lob =3D lob;
>> +    range->upb =3D lob + size - 1;
>> +    range_invariant(range);
>> +}
>> +
>> +/*
>> + * Get the size of @range.
>> + */
>> +static inline uint64_t range_size(const Range *range)
>> +{
>> +    return range->upb - range->lob + 1;
>> +}
>> +
>> +/*
>> + * Check if @range1 overlaps with @range2. If one of the ranges is em=
pty,
>> + * the result is always "false".
>> + */
>> +static inline bool range_overlaps_range(const Range *range1,
>> +                                        const Range *range2)
>> +{
>> +    if (range_is_empty(range1) || range_is_empty(range2)) {
> compilation fails with:
>  "error: passing argument 1 of =E2=80=98range_is_empty=E2=80=99 discard=
s =E2=80=98const=E2=80=99 qualifier from pointer target type [-Werror]"
>=20
> the same for range_invariant,
> following should fix issues:

I guess you missed patch #3.


--=20

Thanks,

David / dhildenb
