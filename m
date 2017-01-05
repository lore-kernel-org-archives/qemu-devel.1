Received: from eggs.gnu.org ([2001:4830:134:3::10]:59127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cP26H-0006PE-K8
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jitendra.kolhe@hpe.com>) id 1cP26E-0000Jb-DP
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:04:37 -0500
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:51411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jitendra.kolhe@hpe.com>)
	id 1cP26E-0000IP-6w
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 02:04:34 -0500
References: <1463570440-29685-1-git-send-email-jitendra.kolhe@hpe.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34811E@shsmsx102.ccr.corp.intel.com>
	<ebc6d79a-833d-5413-8617-b3252bc45a07@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34BC76@shsmsx102.ccr.corp.intel.com>
From: Jitendra Kolhe <jitendra.kolhe@hpe.com>
Message-ID: <89e9f19f-1249-d45a-af19-39e7db248737@hpe.com>
Date: Thu, 5 Jan 2017 12:34:17 +0530
MIME-Version: 1.0
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3C34BC76@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] migration: skip scanning and
 migrating ram pages released by virtio-balloon driver.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Li, Liang Z" <liang.z.li@intel.com>, David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "simhan@hpe.com" <simhan@hpe.com>, "JBottomley@Odin.com" <JBottomley@Odin.com>, "armbru@redhat.com" <armbru@redhat.com>, "lcapitulino@redhat.com" <lcapitulino@redhat.com>, "renganathan.meenakshisundaram@hpe.com" <renganathan.meenakshisundaram@hpe.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "mohan_parthasarathy@hpe.com" <mohan_parthasarathy@hpe.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "den@openvz.org" <den@openvz.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

On 1/5/2017 7:03 AM, Li, Liang Z wrote:
>> Am 23.12.2016 um 03:50 schrieb Li, Liang Z:
>>>> While measuring live migration performance for qemu/kvm guest, it wa=
s
>>>> observed that the qemu doesn=E2=80=99t maintain any intelligence for=
 the
>>>> guest ram pages released by the guest balloon driver and treat such
>>>> pages as any other normal guest ram pages. This has direct impact on
>>>> overall migration time for the guest which has released (ballooned o=
ut)
>> memory to the host.
>>>>
>>>> In case of large systems, where we can configure large guests with
>>>> 1TB and with considerable amount of memory released by balloon drive=
r
>>>> to the host, the migration time gets worse.
>>>>
>>>> The solution proposed below is local to qemu (and does not require
>>>> any modification to Linux kernel or any guest driver). We have
>>>> verified the fix for large guests =3D1TB on HPE Superdome X (which c=
an
>>>> support up to 240 cores and 12TB of memory).
>>>>
>>>> During live migration, as part of first iteration in
>>>> ram_save_iterate() -> ram_find_and_save_block () will try to migrate
>>>> ram pages even if they are released by vitrio-balloon driver (balloo=
n
>>>> inflate). Although these pages which are returned to the host by
>>>> virtio-balloon driver are zero pages, the migration algorithm will
>>>> still end up scanning the entire page
>>>> ram_find_and_save_block() ->
>>>> ram_save_page()/ram_save_compressed_page() ->
>>>> save_zero_page() -> is_zero_range(). We also end-up sending header
>>>> information over network for these pages during migration. This adds
>>>> to the total migration time.
>>>>
>>>> The solution creates a balloon bitmap ramblock as a part of
>>>> virtio-balloon device initialization. The bits in the balloon bitmap
>>>> represent a guest ram page of size 1UL << VIRTIO_BALLOON_PFN_SHIFT
>> or
>>>> 4K. If TARGET_PAGE_BITS <=3D VIRTIO_BALLOON_PFN_SHIFT, ram_addr
>> offset
>>>> for the dirty page which is used by dirty page bitmap during
>>>> migration is checked against the balloon bitmap as is, if the bit is
>>>> set in the balloon bitmap, the corresponding ram page will be
>>>> excluded from scanning and sending header information during
>>>> migration. In case TARGET_PAGE_BITS > VIRTIO_BALLOON_PFN_SHIFT
>> for a
>>>> given dirty page ram_addr, all sub-pages of 1UL <<
>>>> VIRTIO_BALLOON_PFN_SHIFT size should be ballooned out to avoid zero
>> page scan and sending header information.
>>>>
>>>> The bitmap represents entire guest ram memory till max configured
>> memory.
>>>> Guest ram pages claimed by the virtio-balloon driver will be
>>>> represented by 1 in the bitmap. Since the bitmap is maintained as a
>>>> ramblock, it=E2=80=99s migrated to target as part migration=E2=80=99=
s ram iterative
>>>> and ram complete phase. So that substituent migrations from the targ=
et
>> can continue to use optimization.
>>>>
>>>> A new migration capability called skip-balloon is introduced. The
>>>> user can disable the capability in cases where user does not expect
>>>> much benefit or in case the migration is from an older version.
>>>>
>>>> During live migration setup the optimization can be set to disabled =
state if .
>>>> no virtio-balloon device is initialized.
>>>> . skip-balloon migration capability is disabled.
>>>> . If the guest virtio-balloon driver has not set
>>>> VIRTIO_BALLOON_F_MUST_TELL_HOST
>>>>   flag. Which means the guest may start using a ram pages freed by
>>>> guest balloon
>>>>   driver, even before the host/qemu is aware of it. In such case, th=
e
>>>>   optimization is disabled so that the ram pages that are being used=
 by the
>>>>   guest will continue to be scanned and migrated.
>>>>
>>>> Balloon bitmap ramblock size is set to zero if the optimization is
>>>> disabled, to avoid overhead of migrating the bitmap. If the bitmap i=
s
>>>> not migrated to the target, the destination starts with a fresh
>>>> bitmap and tracks the ballooning operation thereafter.
>>>>
>>>
>>> I have a better way to get rid of the bitmap.
>>> We should not maintain the inflating pages in the bitmap, instead, we
>>> can get them from the guest if it's needed, just like what we did for
>>> the guest's unused pages. Then we can combine the inflating page info
>>> with the unused page info together, and skip them during live migrati=
on.
>>>
>>
>> If we want to actually host enforce (disallow) access to inflated page=
s, having
>=20
> Is that a new feature?
>=20
>> such a bitmap in QEMU is required. Getting them from the guest doesn't
>> make sense in that context anymore.
>=20
> Even a bitmap is required, we should avoid to send it in the stop & cop=
y stage.
>=20

How about using both ways? If the guest is capable to share ballooned out=
 page
information using unused page framework use it. If the guest is not capab=
le we
maintain a bitmap in qemu. This way we can use advantage of both approach=
es.=20
1. In case the guest is capable - we avoid bitmap send in stop and copy s=
tage.
2. In case the guest is not capable - host can still disallow migration o=
f ballooned=20
out pages.
But since this approach may add a bit of code churn, we recommend to go w=
ith maintaining=20
the bitmap in qemu at first phase (existing implementation) and then enha=
nce it later=20
to use unused page approach (to query guest) based on the guest capabilit=
y.=20

Thanks,
- Jitendra

> Thanks!
> Liang
>>
>> Thanks,
>> David
>>
