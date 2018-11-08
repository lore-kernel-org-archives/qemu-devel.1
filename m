Received: from eggs.gnu.org ([2001:4830:134:3::10]:60983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gKlaD-00089I-03
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gKla8-0007ZV-ST
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:46:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gKla6-0007TP-ST
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:46:52 -0500
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-2-david@redhat.com>
	<87pnvqdvsj.fsf@dusky.pond.sub.org>
	<e8fe86a1-d075-2ea8-d1f4-e08e5dceee07@redhat.com>
	<875zxingqn.fsf@dusky.pond.sub.org>
	<440eb166-73d1-77b6-5dd9-66a0abd7d665@redhat.com>
	<87muqn5ydc.fsf@dusky.pond.sub.org>
	<1ec41fe2-d4b4-fce2-9381-818ee3356409@redhat.com>
	<87tvkv2r2b.fsf@dusky.pond.sub.org>
	<64720ade-c69d-40a4-5359-2132711c01cd@redhat.com>
	<87d0rgvrbk.fsf@dusky.pond.sub.org>
	<fcbd588d-f51c-4ab4-fa45-ad5360aff5b1@redhat.com>
	<8736scq7y9.fsf@dusky.pond.sub.org>
	<bfebc5b0-cebd-8a83-3106-effba5332094@redhat.com>
	<878t24ort1.fsf@dusky.pond.sub.org>
	<50328c72-ec11-6158-bd44-018f7454de18@redhat.com>
	<877ehnmyak.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <32eda606-79b8-5805-e61f-06741eddb2cc@redhat.com>
Date: Thu, 8 Nov 2018 15:46:34 +0100
MIME-Version: 1.0
In-Reply-To: <877ehnmyak.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 08.11.18 15:36, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
>=20
>> I found some more ugliness, looking at the tests. I am not sure the te=
st
>> is correct here.
>>
>> test_visitor_in_intList():
>>
>> v =3D visitor_input_test_init(data, "1,2,0,2-4,20,5-9,1-8");
>>
>> -> we expect { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 }, implying that the
>> visitor actually does sorting + duplicate elimination. Now I consider
>> this is wrong. We are parsing a list of integers, not an ordered set.
>>
>> What's your take on this?
>=20
> I think you're right.  Visitors are tied to QAPI, and QAPI does *lists*=
,
> not sets.  Lists are more general than sets.
>=20
> I figure what drove development of this code was a need for sets, so
> sets got implemented.  Review fail.
>=20
> If the visitor does lists, whatever needs sets can convert the lists to
> sets.
>=20
> I'd advise against evolving the current code towards sanity.  Instead,
> rewrite, and rely on tests to avoid unwanted changes in behavior.
>=20

With the current rewrite I have, I can parse uint64 and int64 lists. The
other types will bail out if lists are used right now.

The changes that have to be done to the tests are:

diff --git a/tests/test-string-input-visitor.c
b/tests/test-string-input-visitor.c
index 88e0e1aa9a..5d2d707e80 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -92,16 +92,6 @@ static void check_ulist(Visitor *v, uint64_t
*expected, size_t n)
     uint64List *tail;
     int i;

-    /* BUG: unsigned numbers above INT64_MAX don't work */
-    for (i =3D 0; i < n; i++) {
-        if (expected[i] > INT64_MAX) {
-            Error *err =3D NULL;
-            visit_type_uint64List(v, NULL, &res, &err);
-            error_free_or_abort(&err);
-            return;
-        }
-    }
-
     visit_type_uint64List(v, NULL, &res, &error_abort);
     tail =3D res;
     for (i =3D 0; i < n; i++) {
@@ -118,9 +108,9 @@ static void
test_visitor_in_intList(TestInputVisitorData *data,
                                     const void *unused)
 {
-    /* Note: the visitor *sorts* ranges *unsigned* */
-    int64_t expect1[] =3D { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 };
+    int64_t expect1[] =3D { 1, 2, 0, 2, 3, 4, 20, 5, 6, 7, 8, 9, 1, 2, 3=
,
4, 5, 6, 7, 8 };
     int64_t expect2[] =3D { 32767, -32768, -32767 };
-    int64_t expect3[] =3D { INT64_MAX, INT64_MIN };
+    int64_t expect3[] =3D { INT64_MIN, INT64_MAX };
     uint64_t expect4[] =3D { UINT64_MAX };
     Error *err =3D NULL;
     int64List *res =3D NULL;
@@ -189,7 +179,7 @@ static void
test_visitor_in_intList(TestInputVisitorData *data,
     visit_type_int64(v, NULL, &tail->value, &err);
     g_assert_cmpint(tail->value, =3D=3D, 0);
     visit_type_int64(v, NULL, &val, &err);
-    g_assert_cmpint(val, =3D=3D, 1); /* BUG */
+    error_free_or_abort(&err);
     visit_check_list(v, &error_abort);
     visit_end_list(v, (void **)&res);


Basically fixing two bugs (yey, let's make our tests pass by hardcoding
BUG behavior, so the actually fixed code will break them)

And converting two assumptions about ordered sets into unordered lists.

(using unsigned ranges for handling signed ranges is completely broken,
as can also be seen via the removed "Note:")

--=20

Thanks,

David / dhildenb
