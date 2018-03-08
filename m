Received: from eggs.gnu.org ([2001:4830:134:3::10]:44939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eu1YC-0007P5-Ht
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eu1YB-0000FV-NV
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:50:04 -0500
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
	<20180207125037.13510-2-vsementsov@virtuozzo.com>
	<20180306153213.GK31045@stefanha-x1.localdomain>
	<49f2f289-ce1c-6e24-8b54-bb5b5c1601bc@redhat.com>
	<9ef1c947-616f-0cde-040d-7a4f0fc8f146@virtuozzo.com>
	<c8e6c246-1311-fd52-6267-b78eb02bfd07@virtuozzo.com>
	<9ed82315-3b8a-52c4-5d80-4c5041bd3c87@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa519c33-dc85-4494-8ea5-426998bd29e0@redhat.com>
Date: Thu, 8 Mar 2018 13:49:51 -0600
MIME-Version: 1.0
In-Reply-To: <9ed82315-3b8a-52c4-5d80-4c5041bd3c87@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

On 03/08/2018 12:58 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> Hm. these numbers are actually boundary points of histogram=20
>>> intervals, not intervals itself. And, wiki says "The bins are usually=
=20
>>> specified as consecutive, non-overlapping intervals of a variable.",=20
>>> so, intervals are bins.
>>>
>>> So, what about:
>>>
>>> 1. interval_boundaries
>>> 2. bin_boundaries
>>> 3. boundaries
>>>
>>> (and same names with s/_/-/ for qapi)

Any of those works for me; 1 is probably most precise, while 3 is the=20
shortest to type.

>>>
>>>
>>
>>
>> Also, now I doubt, is it a good idea to share same bin boundaries for=20
>> each io type.
>>
>=20
> so, for qmp command, what about:
>=20
> boundaries - optional, default boundaries for all io operations
> boundaries-read - boundaries for read
> boundaries-write - boundaries for write
> ...
>=20
> so, call without any boundaries: drop _all_ histograms
> call with only specific boundaries-*: set or reset _only_ corresponding=
=20
> specific histograms
> call with only boundaries parameter: set or reset _all_ histograms
> call with boundaries parameter and some of (or all, but it is not=20
> useful) specific boundaries-*: set or reset _all_ histograms, some to=20
> default=C2=A0 and some to specific.

Seems reasonable, and if that makes the command more useful for your=20
timing, I'm fine with it (your argument that different timing bins for=20
read and write also makes sense, as there are some inherent differences=20
in the amount of work done in the two directions).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
