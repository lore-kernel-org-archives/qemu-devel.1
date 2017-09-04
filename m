Received: from eggs.gnu.org ([2001:4830:134:3::10]:56480)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dp1DJ-0001R4-3o
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dp1DE-0004cH-9y
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:55:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:51845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dp1DD-0004c4-Ub
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:55:28 -0400
References: <20170903163304.17919-1-n54@gmx.com>
	<6b1b26a9-092c-4bd1-bcae-4041d1ec74b5@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <9a59070b-aae9-f683-d7a6-6e167b48b8f4@gmx.com>
Date: Tue, 5 Sep 2017 01:57:29 +0200
MIME-Version: 1.0
In-Reply-To: <6b1b26a9-092c-4bd1-bcae-4041d1ec74b5@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E1FsmI11cV1Tma18JojmI6MpbexR98VWk"
Subject: Re: [Qemu-devel] [PATCH] memory: Rename queue to mrqueue (memory
 region queue)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E1FsmI11cV1Tma18JojmI6MpbexR98VWk
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org
Message-ID: <9a59070b-aae9-f683-d7a6-6e167b48b8f4@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] memory: Rename queue to mrqueue (memory
 region queue)
References: <20170903163304.17919-1-n54@gmx.com>
 <6b1b26a9-092c-4bd1-bcae-4041d1ec74b5@amsat.org>
In-Reply-To: <6b1b26a9-092c-4bd1-bcae-4041d1ec74b5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.09.2017 02:39, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Kamil,
>=20
> On 09/03/2017 01:33 PM, Kamil Rytarowski wrote:
>> SunOS declares struct queue in <netinet/in.h>.
>=20
> I didn't check what is this define for, but I'd rather add in
> include/sysemu/os-posix.h:
>=20
> #ifdef queue
> #undef queue
> #endif
>=20
> If no QEMU code rely on this netinet queue.
>=20

It's not a define, but a struct.

I have made a mistake. The struct queue is located in <sys/stream.h>,
which is included from <netinet/in.h>.

sys/stream.h:typedef struct queue {

>>
>> This fixes build on SmartOS (Joyent).
>>
>> Patch cherry-picked from pkgsrc by jperkin (Joyent).
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>> ---
>>   memory.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/memory.c b/memory.c
>> index c0adc35410..b9920a6540 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -2701,10 +2701,10 @@ typedef struct MemoryRegionList MemoryRegionLi=
st;
>>     struct MemoryRegionList {
>>       const MemoryRegion *mr;
>> -    QTAILQ_ENTRY(MemoryRegionList) queue;
>> +    QTAILQ_ENTRY(MemoryRegionList) mrqueue;
>>   };
>>   -typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;
>> +typedef QTAILQ_HEAD(mrqueue, MemoryRegionList) MemoryRegionListHead;
>>     #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>>                              int128_sub((size), int128_one())) : 0)
>> @@ -2746,7 +2746,7 @@ static void mtree_print_mr(fprintf_function
>> mon_printf, void *f,
>>           bool found =3D false;
>>             /* check if the alias is already in the queue */
>> -        QTAILQ_FOREACH(ml, alias_print_queue, queue) {
>> +        QTAILQ_FOREACH(ml, alias_print_queue, mrqueue) {
>>               if (ml->mr =3D=3D mr->alias) {
>>                   found =3D true;
>>               }
>> @@ -2755,7 +2755,7 @@ static void mtree_print_mr(fprintf_function
>> mon_printf, void *f,
>>           if (!found) {
>>               ml =3D g_new(MemoryRegionList, 1);
>>               ml->mr =3D mr->alias;
>> -            QTAILQ_INSERT_TAIL(alias_print_queue, ml, queue);
>> +            QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
>>           }
>>           mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
>>                      " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
>> @@ -2783,26 +2783,26 @@ static void mtree_print_mr(fprintf_function
>> mon_printf, void *f,
>>       QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
>>           new_ml =3D g_new(MemoryRegionList, 1);
>>           new_ml->mr =3D submr;
>> -        QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
>> +        QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>>               if (new_ml->mr->addr < ml->mr->addr ||
>>                   (new_ml->mr->addr =3D=3D ml->mr->addr &&
>>                    new_ml->mr->priority > ml->mr->priority)) {
>> -                QTAILQ_INSERT_BEFORE(ml, new_ml, queue);
>> +                QTAILQ_INSERT_BEFORE(ml, new_ml, mrqueue);
>>                   new_ml =3D NULL;
>>                   break;
>>               }
>>           }
>>           if (new_ml) {
>> -            QTAILQ_INSERT_TAIL(&submr_print_queue, new_ml, queue);
>> +            QTAILQ_INSERT_TAIL(&submr_print_queue, new_ml, mrqueue);
>>           }
>>       }
>>   -    QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
>> +    QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>>           mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,
>>                          alias_print_queue);
>>       }
>>   -    QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, queue, next_ml) {
>> +    QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
>>           g_free(ml);
>>       }
>>   }
>> @@ -2872,13 +2872,13 @@ void mtree_info(fprintf_function mon_printf,
>> void *f, bool flatview)
>>       }
>>         /* print aliased regions */
>> -    QTAILQ_FOREACH(ml, &ml_head, queue) {
>> +    QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>>           mon_printf(f, "memory-region: %s\n",
>> memory_region_name(ml->mr));
>>           mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head);
>>           mon_printf(f, "\n");
>>       }
>>   -    QTAILQ_FOREACH_SAFE(ml, &ml_head, queue, ml2) {
>> +    QTAILQ_FOREACH_SAFE(ml, &ml_head, mrqueue, ml2) {
>>           g_free(ml);
>>       }
>>   }
>>



--E1FsmI11cV1Tma18JojmI6MpbexR98VWk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrehwAAoJEEuzCOmwLnZsyrkP/2PKHBo5ilJ34n5ZEED5yWo2
rrwRlGLqKx62LHIhDp0bQieFhFtXbKO07gKt7HpCv1nR8tEL487gb2CUe68cYqG9
PYjAVnF+IrmNAPalAl8FCykgL/uzXLgNT9Z87sai8fyP1QHITuFf0i4GsdJK4/jT
FyV00vJLrZAZFkrjycddsO9Y7y7Otfgdf/EDAduqYUH8dyQaf43VAsd4aBY5+Jk4
eqzYlWKKDqTeSbrUkUk3QbmaESqRcbf6puF0psq7VaWZjTmDqq2/VE3WZbb+Cr2P
m5Z0+aZKOhpV3vWUB3WTwJ3hRPPfHTz0wRSc1vNOsmCvehoA8sdMlkq1nQ3RNsiw
QkEmW15Xvs2AkgKrSQ2EHgrK72AnFZD1DlmL46JdmH8ghDKNte1r7r/fqrtHJrXe
w8HpApnYEToT2v/0C2NUpaOul7xeSVkYbBfrhE7GuV4xoccl4wRQd3kZ0+g8TLeh
glsTfg7Fx3Jt8lS8aEFoG1utnCC/7DNl36kR2n7fUCeYAKzi+Snwy5vymvxVg2DT
db/Jj8uaQSTTYElAlOwlqrBBtaoTo03HCJtv6MTAA0MFXbQKLfJTzyDnnGERC9Ie
3XqbRU8kImuclgPR6EbxR+8i7gMfuZgdA+1zuo5lVu5+RnJ6UJtFQSMBe0EEOPgX
B3OHA1gROF44czwczDP9
=bJn8
-----END PGP SIGNATURE-----

--E1FsmI11cV1Tma18JojmI6MpbexR98VWk--
