Received: from eggs.gnu.org ([2001:4830:134:3::10]:43634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu03y-0005fE-M7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eu03v-0004P3-FR
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:14:46 -0500
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180207125037.13510-2-vsementsov@virtuozzo.com>
	<20180306153213.GK31045@stefanha-x1.localdomain>
	<49f2f289-ce1c-6e24-8b54-bb5b5c1601bc@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9ef1c947-616f-0cde-040d-7a4f0fc8f146@virtuozzo.com>
Date: Thu, 8 Mar 2018 21:14:34 +0300
MIME-Version: 1.0
In-Reply-To: <49f2f289-ce1c-6e24-8b54-bb5b5c1601bc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block/accounting: introduce latency
 histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

08.03.2018 20:31, Eric Blake wrote:
> On 03/06/2018 09:32 AM, Stefan Hajnoczi wrote:
>> On Wed, Feb 07, 2018 at 03:50:36PM +0300, Vladimir=20
>> Sementsov-Ogievskiy wrote:
>>> Introduce latency histogram statics for block devices.
>>> For each accounted operation type latency region [0, +inf) is
>>> divided into subregions by several points. Then, calculate
>>> hits for each subregion.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>
>> According to Wikipedia and Mathworld, "intervals" and "bins" are
>> commonly used terms:
>> https://en.wikipedia.org/wiki/Histogram
>> http://mathworld.wolfram.com/Histogram.html
>>
>> I suggest:
>>
>> =C2=A0=C2=A0 typedef struct {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The following histogram is repre=
sented like this:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 5|=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 4|=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 3| *=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 2| *=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1| *=C2=A0=C2=A0=C2=A0 *=C2=
=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0 +------------------
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 10=C2=A0=C2=A0 50=C2=A0=C2=A0 100
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * BlockLatencyHistogram histo=
gram =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 .nb=
ins =3D 4,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 .in=
tervals =3D {10, 50, 100},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 .bi=
ns =3D {3, 1, 5, 2},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * };
>
> The name 'intervals' is still slightly ambiguous: does it hold the=20
> boundary point (0-10 for 10 slots, 10-50 for 40 slots, 50-100, for 50=20
> slots, then 100-INF) or is it the interval size of each slot (first=20
> bin is 10 slots for 0-10, next bin is 50 slots wide so 10-60, next bin=20
> is 100 slots wide so 60-160, everything else is 160-INF).=C2=A0 But the=20
> ascii-art diagram plus the text is sufficient to resolve the intent if=20
> you keep that name (I don't have a suggestion for a better name).
>

Hm. these numbers are actually boundary points of histogram intervals,=20
not intervals itself. And, wiki says "The bins are usually specified as=20
consecutive, non-overlapping intervals of a variable.", so, intervals=20
are bins.

So, what about:

1. interval_boundaries
2. bin_boundaries
3. boundaries

(and same names with s/_/-/ for qapi)


--=20
Best regards,
Vladimir
