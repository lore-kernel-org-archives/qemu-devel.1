Received: from eggs.gnu.org ([2001:4830:134:3::10]:37563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVjmz-00040T-AF
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:33:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVjmw-00072A-0z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:33:13 -0400
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-4-david@redhat.com>
	<9b002cf5-a752-9b4d-1ef5-3bb0fbd62b7d@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <892b57f3-7418-8dd2-ec4b-6c24c11e5585@redhat.com>
Date: Wed, 20 Jun 2018 22:33:07 +0200
MIME-Version: 1.0
In-Reply-To: <9b002cf5-a752-9b4d-1ef5-3bb0fbd62b7d@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/7] s390x/tcg: properly implement the
 TOD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On 20.06.2018 21:33, Richard Henderson wrote:
> On 06/20/2018 12:08 AM, David Hildenbrand wrote:
>> +/* Converts ns to s390's clock format */
>> +static inline uint64_t time2tod(uint64_t ns)
>> +{
>> +    return (ns << 9) / 125;
>> +}
>> +
>> +/* Converts s390's clock format to ns */
>> +static inline uint64_t tod2time(uint64_t t)
>> +{
>> +    return (t * 125) >> 9;
>> +}
>=20

In this patch I'm only moving the code. If we find this is a problem,
this should go into a separate patch.

> How many significant bits on input here?

Basically all are significant, and as it is a clock, we will reach these
bits at one point.

> Do you in fact want to be using muldiv64?

Looking at linux:

arch/s390/include/asm/timex.h

They have a lengthy documentation, resulting in (a spli to avoid overflow=
s)

return ((todval >> 9) * 125) + (((todval & 0x1ff) * 125) >> 9);

Maybe we should do the same?

>=20
>=20
> r~
>=20


--=20

Thanks,

David / dhildenb
