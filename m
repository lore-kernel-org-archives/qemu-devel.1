Received: from eggs.gnu.org ([2001:4830:134:3::10]:36293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS1eF-00061W-1Z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS1eA-00052G-N0
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:16:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS1eA-00051n-G2
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:16:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DEB1BDCF
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 14:16:29 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
References: <20171219181129.24189-1-maxime.coquelin@redhat.com>
	<20171220160741.GE12566@stefanha-x1.localdomain>
	<20171221055215-mutt-send-email-mst@kernel.org>
	<ee4d8ff5-6a67-6146-1516-1c242787054c@redhat.com>
Message-ID: <cb8ead0b-7172-82a8-54e9-7bc44dc8d379@redhat.com>
Date: Thu, 21 Dec 2017 15:16:20 +0100
MIME-Version: 1.0
In-Reply-To: <ee4d8ff5-6a67-6146-1516-1c242787054c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Vhost: no more leak QEMU virtual
 addresses to user backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, mlureau@redhat.com



On 12/21/2017 03:01 PM, Maxime Coquelin wrote:
>=20
>=20
> On 12/21/2017 04:53 AM, Michael S. Tsirkin wrote:
>> On Wed, Dec 20, 2017 at 04:07:41PM +0000, Stefan Hajnoczi wrote:
>>> On Tue, Dec 19, 2017 at 07:11:26PM +0100, Maxime Coquelin wrote:
>>>> Before this series, QEMU process virtual addresses are sent to the
>>>> user backend as user addresses.
>>>>
>>>> Passing these virtual addresses aren't useful, as the backend doesn'=
t
>>>> direct access to QEMU address space.
>>>>
>>>> It does make sense however for kernel backend, which can access QEMU
>>>> address space.
>>>>
>>>> This series introduce a new enum set by the backend stating whether =
it
>>>> prefers using QEMU Virtual addresses or Guest physical addresses as
>>>> User address, and make vhost-user backend to use Guest physical
>>>> addresses.
>>>>
>>>> Maxime Coquelin (3):
>>>> =C2=A0=C2=A0 vhost-user: rename VhostUserMemory userspace_addr field=
 to user_addr
>>>> =C2=A0=C2=A0 vhost: introduce backend's user address type
>>>> =C2=A0=C2=A0 vhost-user: no more leak QEMU virtual addresses to user=
 backend
>>>>
>>>> =C2=A0 hw/virtio/vhost-backend.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 1 +
>>>> =C2=A0 hw/virtio/vhost-user.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++--
>>>> =C2=A0 hw/virtio/vhost.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++----
>>>> =C2=A0 include/hw/virtio/vhost-backend.h |=C2=A0 6 ++++++
>>>> =C2=A0 4 files changed, 23 insertions(+), 6 deletions(-)
>>>>
>>>> --=20
>>>> 2.14.3
>>>>
>>>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> This makes make check fail. Any idea why?
>>
>=20
> That's interesting, it fails because the rings aren't initialized with
> vhost-user-test (even without my series, but we don't notice).
>=20
> It fails in vhost_virtqueue_start(), because vq->desc is NULL.
>=20
> Adding some debug prints shows that vq->desc_phys, vq->avail_phys and=20
> vq->used_phys are all 0 for both queues.
>=20
> So when using QEMU VAs as user addresses, vq->desc, vq->used and
> vq->avail are translated to a non-NULL address, and it doesn't fail.
>=20
> Only the multiqueue test returns non-zero and different addresses
> between the rings.
>=20
> I'm looking into it.

I get it now, qvirtqueue_setup() is only called in the multiqueue test.

> Regards,
> Maxime
