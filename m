Received: from eggs.gnu.org ([2001:4830:134:3::10]:57470)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dp1Fj-0002QI-O1
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dp1Fe-0006GI-O7
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:58:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:57337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dp1Fe-0006FR-CG
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 19:57:58 -0400
From: Kamil Rytarowski <n54@gmx.com>
References: <20170903163304.17919-1-n54@gmx.com>
	<6b1b26a9-092c-4bd1-bcae-4041d1ec74b5@amsat.org>
	<9a59070b-aae9-f683-d7a6-6e167b48b8f4@gmx.com>
Message-ID: <e6f29b58-f16b-47d0-4b2b-9f156f3a2ed1@gmx.com>
Date: Tue, 5 Sep 2017 02:00:04 +0200
MIME-Version: 1.0
In-Reply-To: <9a59070b-aae9-f683-d7a6-6e167b48b8f4@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M60ebHm5BslVGU2OMTanHTJUHpBIJD05m"
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
Cc: qemu-devel@nongnu.org, Jonathan Perkin <jperkin@joyent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M60ebHm5BslVGU2OMTanHTJUHpBIJD05m
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Jonathan Perkin <jperkin@joyent.com>
Message-ID: <e6f29b58-f16b-47d0-4b2b-9f156f3a2ed1@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] memory: Rename queue to mrqueue (memory
 region queue)
References: <20170903163304.17919-1-n54@gmx.com>
 <6b1b26a9-092c-4bd1-bcae-4041d1ec74b5@amsat.org>
 <9a59070b-aae9-f683-d7a6-6e167b48b8f4@gmx.com>
In-Reply-To: <9a59070b-aae9-f683-d7a6-6e167b48b8f4@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

+CC jperkin

On 05.09.2017 01:57, Kamil Rytarowski wrote:
> On 04.09.2017 02:39, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Kamil,
>>
>> On 09/03/2017 01:33 PM, Kamil Rytarowski wrote:
>>> SunOS declares struct queue in <netinet/in.h>.
>>
>> I didn't check what is this define for, but I'd rather add in
>> include/sysemu/os-posix.h:
>>
>> #ifdef queue
>> #undef queue
>> #endif
>>
>> If no QEMU code rely on this netinet queue.
>>
>=20
> It's not a define, but a struct.
>=20
> I have made a mistake. The struct queue is located in <sys/stream.h>,
> which is included from <netinet/in.h>.
>=20
> sys/stream.h:typedef struct queue {
>=20
>>>
>>> This fixes build on SmartOS (Joyent).
>>>
>>> Patch cherry-picked from pkgsrc by jperkin (Joyent).
>>>
>>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>>> ---
>>>   memory.c | 22 +++++++++++-----------
>>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/memory.c b/memory.c
>>> index c0adc35410..b9920a6540 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -2701,10 +2701,10 @@ typedef struct MemoryRegionList MemoryRegionL=
ist;
>>>     struct MemoryRegionList {
>>>       const MemoryRegion *mr;
>>> -    QTAILQ_ENTRY(MemoryRegionList) queue;
>>> +    QTAILQ_ENTRY(MemoryRegionList) mrqueue;
>>>   };
>>>   -typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;=

>>> +typedef QTAILQ_HEAD(mrqueue, MemoryRegionList) MemoryRegionListHead;=

>>>     #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
>>>                              int128_sub((size), int128_one())) : 0)
>>> @@ -2746,7 +2746,7 @@ static void mtree_print_mr(fprintf_function
>>> mon_printf, void *f,
>>>           bool found =3D false;
>>>             /* check if the alias is already in the queue */
>>> -        QTAILQ_FOREACH(ml, alias_print_queue, queue) {
>>> +        QTAILQ_FOREACH(ml, alias_print_queue, mrqueue) {
>>>               if (ml->mr =3D=3D mr->alias) {
>>>                   found =3D true;
>>>               }
>>> @@ -2755,7 +2755,7 @@ static void mtree_print_mr(fprintf_function
>>> mon_printf, void *f,
>>>           if (!found) {
>>>               ml =3D g_new(MemoryRegionList, 1);
>>>               ml->mr =3D mr->alias;
>>> -            QTAILQ_INSERT_TAIL(alias_print_queue, ml, queue);
>>> +            QTAILQ_INSERT_TAIL(alias_print_queue, ml, mrqueue);
>>>           }
>>>           mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
>>>                      " (prio %d, %s): alias %s @%s " TARGET_FMT_plx
>>> @@ -2783,26 +2783,26 @@ static void mtree_print_mr(fprintf_function
>>> mon_printf, void *f,
>>>       QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
>>>           new_ml =3D g_new(MemoryRegionList, 1);
>>>           new_ml->mr =3D submr;
>>> -        QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
>>> +        QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>>>               if (new_ml->mr->addr < ml->mr->addr ||
>>>                   (new_ml->mr->addr =3D=3D ml->mr->addr &&
>>>                    new_ml->mr->priority > ml->mr->priority)) {
>>> -                QTAILQ_INSERT_BEFORE(ml, new_ml, queue);
>>> +                QTAILQ_INSERT_BEFORE(ml, new_ml, mrqueue);
>>>                   new_ml =3D NULL;
>>>                   break;
>>>               }
>>>           }
>>>           if (new_ml) {
>>> -            QTAILQ_INSERT_TAIL(&submr_print_queue, new_ml, queue);
>>> +            QTAILQ_INSERT_TAIL(&submr_print_queue, new_ml, mrqueue);=

>>>           }
>>>       }
>>>   -    QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
>>> +    QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>>>           mtree_print_mr(mon_printf, f, ml->mr, level + 1, cur_start,=

>>>                          alias_print_queue);
>>>       }
>>>   -    QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, queue, next_ml) {
>>> +    QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
>>>           g_free(ml);
>>>       }
>>>   }
>>> @@ -2872,13 +2872,13 @@ void mtree_info(fprintf_function mon_printf,
>>> void *f, bool flatview)
>>>       }
>>>         /* print aliased regions */
>>> -    QTAILQ_FOREACH(ml, &ml_head, queue) {
>>> +    QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>>>           mon_printf(f, "memory-region: %s\n",
>>> memory_region_name(ml->mr));
>>>           mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head);
>>>           mon_printf(f, "\n");
>>>       }
>>>   -    QTAILQ_FOREACH_SAFE(ml, &ml_head, queue, ml2) {
>>> +    QTAILQ_FOREACH_SAFE(ml, &ml_head, mrqueue, ml2) {
>>>           g_free(ml);
>>>       }
>>>   }
>>>
>=20
>=20



--M60ebHm5BslVGU2OMTanHTJUHpBIJD05m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZrekEAAoJEEuzCOmwLnZsJcoP/3k2TBpVCNdumbOphck/2hr4
LML212h11dQIrc7jETy35K7RSKZW+Zel3cP5oLJ+pqRO1RgupPSoraehhww22seD
VduORrInGZFlk6g8ARXtlnTHCkPdhSPshqIZeQuPTPlO68rMPxJfYX2J6zVCoqZm
A/X9x2LwCgQdAuwQe3ZtK6SK+07dmlYrqA3uNLiab6jyW0ybG71q3zjbcaT3TIna
R5KdTojRd71/kbzIZwL+PiLhmOEUYrWcoXdEHpb8SqtgZa3EZzUvMDh3ryqI1yYq
T3HU0ISM2IL3Ok7CYABWyVIei2KQbXwpgzuK8k7OwnPJRjnEtoCzmaF31qV5E9JM
E6wiURCu3UfXEeKqSkEvxkySrFVFsBL2PExt4WRiAyDSKtWOjUymPzmPmC3tXqrZ
UJMyIYTnbNSPDJvKq753u4f9v+ZKc5kArs9iqMK/4SIQxaj1tHakhab/dsSMf0Ma
FhFKymKtOqPXbujx1SNwCZlrqIbNwSR2bFKqoKauPf9fQECbtfjjw8LSsdoh438b
GOiYvHrXvIVnrl8r7OTWtkSbCPBMZBL0nnxYk7Bz4DhkgHT8G4rWNrF9Dajnczi5
E7QkqzLbcXKHcOZvNSNbCo8H4W4jc0IVoPyJoqaWw6tcIalMXrWOutA3r83dVx0P
npP4dkMx4e48JDasSF4Y
=h0/M
-----END PGP SIGNATURE-----

--M60ebHm5BslVGU2OMTanHTJUHpBIJD05m--
