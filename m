Received: from eggs.gnu.org ([2001:4830:134:3::10]:50307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gN1Na-0007Ih-UK
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gN1Na-0008NV-2m
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:03:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gN1NZ-0008Mr-Qz
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:03:14 -0500
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-6-david@redhat.com>
	<87h8gjocj9.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <24876f15-3f6e-3daf-fc63-da3ab1d4d0f5@redhat.com>
Date: Wed, 14 Nov 2018 21:03:08 +0100
MIME-Version: 1.0
In-Reply-To: <87h8gjocj9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 5/6] test-string-input-visitor: split
 off uint64 list tests
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

On 14.11.18 17:21, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
>=20
>> Basically copy all int64 list tests but adapt them to work on uint64
>> instead.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  tests/test-string-input-visitor.c | 71 +++++++++++++++++++++++++++++-=
-
>>  1 file changed, 67 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/test-string-input-visitor.c b/tests/test-string-inp=
ut-visitor.c
>> index 2f6360e9ca..731094f789 100644
>> --- a/tests/test-string-input-visitor.c
>> +++ b/tests/test-string-input-visitor.c
>> @@ -111,7 +111,6 @@ static void test_visitor_in_intList(TestInputVisit=
orData *data,
>>                            6, 7, 8 };
>>      int64_t expect2[] =3D { 32767, -32768, -32767 };
>>      int64_t expect3[] =3D { INT64_MIN, INT64_MAX };
>> -    uint64_t expect4[] =3D { UINT64_MAX };
>>      Error *err =3D NULL;
>>      int64List *res =3D NULL;
>>      Visitor *v;
>> @@ -129,9 +128,6 @@ static void test_visitor_in_intList(TestInputVisit=
orData *data,
>>                                  "-9223372036854775808,922337203685477=
5807");
>>      check_ilist(v, expect3, ARRAY_SIZE(expect3));
>> =20
>> -    v =3D visitor_input_test_init(data, "18446744073709551615");
>> -    check_ulist(v, expect4, ARRAY_SIZE(expect4));
>> -
>=20
> Hmm.  Testing behavior for this input is still worthwhile, isn't it?
>=20
> The use of check_ulist() here is admittedly unclean.

This check has been moved to the other function where we test ulists.

Or do you want this check here to test again ilist and see that an error
gets reported as the value is too big? Will add such range checks.

>=20
>>      /* Empty list */
>> =20
>>      v =3D visitor_input_test_init(data, "");
>> @@ -174,6 +170,71 @@ static void test_visitor_in_intList(TestInputVisi=
torData *data,
>>      visit_end_list(v, NULL);
>>  }
>> =20
>> +static void test_visitor_in_uintList(TestInputVisitorData *data,
>> +                                     const void *unused)
>> +{
>> +    uint64_t expect1[] =3D { 1, 2, 0, 2, 3, 4, 20, 5, 6, 7, 8, 9, 1, =
2, 3, 4, 5,
>=20
> Please wrap this line a bit earlier.

Yes.

>=20
>> +                           6, 7, 8 };
>> +    uint64_t expect2[] =3D { 32767, -32768, -32767 };
>> +    uint64_t expect3[] =3D { UINT64_MAX };
>> +    Error *err =3D NULL;
>> +    uint64List *res =3D NULL;
>> +    Visitor *v;
>> +    uint64_t val;
>> +
>> +    /* Valid lists */
>> +
>> +    v =3D visitor_input_test_init(data, "1,2,0,2-4,20,5-9,1-8");
>> +    check_ulist(v, expect1, ARRAY_SIZE(expect1));
>> +
>> +    v =3D visitor_input_test_init(data, "32767,-32768--32767");
>> +    check_ulist(v, expect2, ARRAY_SIZE(expect2));
>> +
>> +    v =3D visitor_input_test_init(data, "18446744073709551615");
>> +    check_ulist(v, expect3, ARRAY_SIZE(expect3));
>=20
> Test behavior for large negative numbers?

Yes, will add.



--=20

Thanks,

David / dhildenb
