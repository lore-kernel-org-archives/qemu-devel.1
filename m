Received: from eggs.gnu.org ([209.51.188.92]:35801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHPM-0005V7-Sv
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gzHB8-00067e-6y
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 03:36:31 -0500
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-15-david@redhat.com>
	<c57c068f-1c42-9cba-0f0f-3204f6648d8d@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f11109de-6ba3-5104-71b6-1245c42b282e@redhat.com>
Date: Thu, 28 Feb 2019 09:36:20 +0100
MIME-Version: 1.0
In-Reply-To: <c57c068f-1c42-9cba-0f0f-3204f6648d8d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 14/33] s390x/tcg: Implement VECTOR LOAD
 MULTIPLE
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

On 27.02.19 17:02, Richard Henderson wrote:
> On 2/26/19 3:38 AM, David Hildenbrand wrote:
>> Also fairly easy to implement. One issue we have is that exceptions wi=
ll
>> result in some vectors already being modified. At least handle it
>> consistently per vector by using a temporary vector. Good enough for
>> now, add a FIXME.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/insn-data.def      |  2 ++
>>  target/s390x/translate_vx.inc.c | 26 ++++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>=20
> I suppose the fixme is good enough.  For the record, I think you could =
do the
> check with just two loads -- the first and last quadword.  After that, =
none of
> the other loads can fault, and you can store everything else into the
> destination vectors as you read them.

Aren't such approaches prone to races if other VCPUs invalidate page
tables/TLB entries?

(or am I messing up things and the MMU of this VCPU won't be touched
while in this block and once we touched all applicable pages, it cannot
fail anymore?)

>=20
> Also missing for the fixme: MO_ALIGN{,_16}.

Just like the other occurrence, I think MO_ALIGN would be wrong.

"Setting the alignment hint to a non-zero value
that doesn=E2=80=99t correspond to the alignment of the
second operand may reduce performance on
some models."

>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20

Thanks!

>=20
> r~
>=20


--=20

Thanks,

David / dhildenb
