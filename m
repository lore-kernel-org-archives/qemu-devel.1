Received: from eggs.gnu.org ([209.51.188.92]:34161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzJLF-0005tG-Gm
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzJLE-0008QE-Fg
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:55:05 -0500
From: David Hildenbrand <david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-34-david@redhat.com>
	<9c8913f5-76b6-1175-5574-19f19d1e8eef@linaro.org>
	<c37a7e69-934c-ab2e-08a1-c67cb3e156c5@redhat.com>
Message-ID: <f4e08332-be07-e2f1-be20-fe4406215427@redhat.com>
Date: Thu, 28 Feb 2019 11:54:54 +0100
MIME-Version: 1.0
In-Reply-To: <c37a7e69-934c-ab2e-08a1-c67cb3e156c5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 33/33] s390x/tcg: Implement VECTOR
 UNPACK *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 28.02.19 10:28, David Hildenbrand wrote:
> On 28.02.19 01:03, Richard Henderson wrote:
>> On 2/26/19 3:39 AM, David Hildenbrand wrote:
>>> Combine all variant in a single handler. As source and destination
>>> have different element sizes, we can't use gvec expansion. Expand
>>> manually. Also watch out for overlapping source and destination and
>>> use a temporary register in that case.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  target/s390x/insn-data.def      |  8 +++++++
>>>  target/s390x/translate_vx.inc.c | 41 +++++++++++++++++++++++++++++++=
++
>>>  2 files changed, 49 insertions(+)
>>
>> This works as is, so
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> But the same comment applies wrt iteration order and not needing a tem=
porary.
>> High unpack can iterate backward, while low unpack can iterate forward=
, with no
>> lost data.
>=20
> I'll fix that right away. I guess vector pack cannot be handled like th=
is.
>=20
> The only way to get rid of the temporary would be to load both elements
> from v2 and v3 and then writing the two (half sized) elements in v1.
>=20
> I'll have a look.

Hmm, as v2 and v3 are handled concatenated it is not that easy. I am not
sure if we can handle this without a temporary vector.

I thought about packing them first interleaved

v2 =3D [v2e0, v2e1]
v3 =3D [v3e0, ve31]
v1 =3D [v2e0_packed, v3e0_packed, v2e1_packed, v3e1_packed]

And then restoring the right order

v1 =3D [v2e0_packed, v2e1_packed, v3e0_packed, v3e1_packed]

But than the second operation seems to be the problem. That shuffling
would have to be hard coded as far as I can see. (shuffling with MO_8 is
nasty -> 14 element shave to be exchanged, in my opinion needing
eventually 14 temporary variables)

Of course, we can also simply detect duplicates and if so, call into a
helper.

--=20

Thanks,

David / dhildenb
