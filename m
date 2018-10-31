Received: from eggs.gnu.org ([2001:4830:134:3::10]:36692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHu8i-00052v-JB
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHu8f-0008Vx-S4
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:18:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gHu8e-0008UZ-Ds
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:18:41 -0400
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-3-david@redhat.com>
	<87zhuudw4o.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4a5ef5ab-52c5-1aec-bb20-85e7c487fb98@redhat.com>
Date: Wed, 31 Oct 2018 18:18:33 +0100
MIME-Version: 1.0
In-Reply-To: <87zhuudw4o.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 31.10.18 15:32, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
>=20
>> Right now, we parse uint64_t values just like int64_t values, resultin=
g
>> in negative values getting accepted and certain valid large numbers on=
ly
>> being representable as negative numbers. Also, reported errors indicat=
e
>> that an int64_t is expected.
>>
>> Parse uin64_t separately. We don't have to worry about ranges.
>=20
> The commit message should mention *why* we don't we have to worry about
> ranges.

"Parse uin64_t separately. We don't have to worry about ranges as far as
I can see. Ranges are parsed and processed via start_list()/next_list()
and friends. parse_type_int64() only has to deal with ranges as it
reuses the function parse_str(). E.g. parse_type_size() also does not
have to handle ranges. (I assume that we could easily reimplement
parse_type_int64() in a similar fashion, too).

The only thing that will change is that uint64_t properties that didn't
expect a range will now actually bail out if a range is supplied."

I'll do some more testing.

>=20
>>
>> E.g. we can now also specify
>>     -device nvdimm,memdev=3Dmem1,id=3Dnv1,addr=3D0xFFFFFFFFC0000000
>> Instead of only going via negative values
>>     -device nvdimm,memdev=3Dmem1,id=3Dnv1,addr=3D-0x40000000
>>
>> Resulting in the same values
>>
>> (qemu) info memory-devices
>> Memory device [nvdimm]: "nv1"
>>   addr: 0xffffffffc0000000
>>   slot: 0
>>   node: 0
>>
>=20
> Suggest to mention this makes the string-input-visitor catch up with th=
e
> qobject-input-visitor, which got changed similarly in commit
> 5923f85fb82.

Yes, I will add that!

>=20
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  qapi/string-input-visitor.c | 17 +++++++++--------
>>  1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
>> index c1454f999f..f2df027325 100644
>> --- a/qapi/string-input-visitor.c
>> +++ b/qapi/string-input-visitor.c
>> @@ -247,15 +247,16 @@ error:
>>  static void parse_type_uint64(Visitor *v, const char *name, uint64_t =
*obj,
>>                                Error **errp)
>>  {
>> -    /* FIXME: parse_type_int64 mishandles values over INT64_MAX */
>> -    int64_t i;
>> -    Error *err =3D NULL;
>> -    parse_type_int64(v, name, &i, &err);
>> -    if (err) {
>> -        error_propagate(errp, err);
>> -    } else {
>> -        *obj =3D i;
>> +    StringInputVisitor *siv =3D to_siv(v);
>> +    uint64_t val;
>> +
>> +    if (qemu_strtou64(siv->string, NULL, 0, &val)) {
>=20
> Works because qemu_strtou64() accepts negative numbers and interprets
> them modulo 2^64.

I will also add a comment to the description that negative numbers will
continue to work.

>=20
>> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : =
"null",
>> +                   "an uint64 value");
>=20
> I think this should be "a uint64 value".

As I am not a native speaker, I will stick to your suggestion unless
somebody else speaks up.

>=20
>> +        return;
>>      }
>> +
>> +    *obj =3D val;
>>  }
>> =20
>>  static void parse_type_size(Visitor *v, const char *name, uint64_t *o=
bj,
>=20
> Patch looks good to me otherwise.
>=20

Thanks!

--=20

Thanks,

David / dhildenb
