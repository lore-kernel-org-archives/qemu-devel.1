Received: from eggs.gnu.org ([2001:4830:134:3::10]:36335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cNyOK-0004Xf-Qe
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 03:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cNyOH-0004GF-OT
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 03:54:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cNyOH-0004FW-Fp
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 03:54:49 -0500
References: <1463570440-29685-1-git-send-email-jitendra.kolhe@hpe.com>
	<F2CBF3009FA73547804AE4C663CAB28E3C34811E@shsmsx102.ccr.corp.intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ebc6d79a-833d-5413-8617-b3252bc45a07@redhat.com>
Date: Mon, 2 Jan 2017 09:54:36 +0100
MIME-Version: 1.0
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3C34811E@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: "Li, Liang Z" <liang.z.li@intel.com>, Jitendra Kolhe <jitendra.kolhe@hpe.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "simhan@hpe.com" <simhan@hpe.com>, "JBottomley@Odin.com" <JBottomley@Odin.com>, "armbru@redhat.com" <armbru@redhat.com>, "lcapitulino@redhat.com" <lcapitulino@redhat.com>, "renganathan.meenakshisundaram@hpe.com" <renganathan.meenakshisundaram@hpe.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "mohan_parthasarathy@hpe.com" <mohan_parthasarathy@hpe.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "den@openvz.org" <den@openvz.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>

Am 23.12.2016 um 03:50 schrieb Li, Liang Z:
>> While measuring live migration performance for qemu/kvm guest, it was
>> observed that the qemu doesn=E2=80=99t maintain any intelligence for t=
he guest ram
>> pages released by the guest balloon driver and treat such pages as any=
 other
>> normal guest ram pages. This has direct impact on overall migration ti=
me for
>> the guest which has released (ballooned out) memory to the host.
>>
>> In case of large systems, where we can configure large guests with 1TB=
 and
>> with considerable amount of memory released by balloon driver to the h=
ost,
>> the migration time gets worse.
>>
>> The solution proposed below is local to qemu (and does not require any
>> modification to Linux kernel or any guest driver). We have verified th=
e fix for
>> large guests =3D1TB on HPE Superdome X (which can support up to 240 co=
res
>> and 12TB of memory).
>>
>> During live migration, as part of first iteration in ram_save_iterate(=
) ->
>> ram_find_and_save_block () will try to migrate ram pages even if they =
are
>> released by vitrio-balloon driver (balloon inflate). Although these pa=
ges
>> which are returned to the host by virtio-balloon driver are zero pages=
, the
>> migration algorithm will still end up scanning the entire page
>> ram_find_and_save_block() ->
>> ram_save_page()/ram_save_compressed_page() ->
>> save_zero_page() -> is_zero_range(). We also end-up sending header
>> information over network for these pages during migration. This adds t=
o the
>> total migration time.
>>
>> The solution creates a balloon bitmap ramblock as a part of virtio-bal=
loon
>> device initialization. The bits in the balloon bitmap represent a gues=
t ram
>> page of size 1UL << VIRTIO_BALLOON_PFN_SHIFT or 4K. If
>> TARGET_PAGE_BITS <=3D VIRTIO_BALLOON_PFN_SHIFT, ram_addr offset for
>> the dirty page which is used by dirty page bitmap during migration is =
checked
>> against the balloon bitmap as is, if the bit is set in the balloon bit=
map, the
>> corresponding ram page will be excluded from scanning and sending head=
er
>> information during migration. In case TARGET_PAGE_BITS >
>> VIRTIO_BALLOON_PFN_SHIFT for a given dirty page ram_addr, all sub-page=
s
>> of 1UL << VIRTIO_BALLOON_PFN_SHIFT size should be ballooned out to
>> avoid zero page scan and sending header information.
>>
>> The bitmap represents entire guest ram memory till max configured memo=
ry.
>> Guest ram pages claimed by the virtio-balloon driver will be represent=
ed by 1
>> in the bitmap. Since the bitmap is maintained as a ramblock, it=E2=80=99=
s migrated to
>> target as part migration=E2=80=99s ram iterative and ram complete phas=
e. So that
>> substituent migrations from the target can continue to use optimizatio=
n.
>>
>> A new migration capability called skip-balloon is introduced. The user=
 can
>> disable the capability in cases where user does not expect much benefi=
t or in
>> case the migration is from an older version.
>>
>> During live migration setup the optimization can be set to disabled st=
ate if .
>> no virtio-balloon device is initialized.
>> . skip-balloon migration capability is disabled.
>> . If the guest virtio-balloon driver has not set
>> VIRTIO_BALLOON_F_MUST_TELL_HOST
>>   flag. Which means the guest may start using a ram pages freed by gue=
st
>> balloon
>>   driver, even before the host/qemu is aware of it. In such case, the
>>   optimization is disabled so that the ram pages that are being used b=
y the
>>   guest will continue to be scanned and migrated.
>>
>> Balloon bitmap ramblock size is set to zero if the optimization is dis=
abled, to
>> avoid overhead of migrating the bitmap. If the bitmap is not migrated =
to the
>> target, the destination starts with a fresh bitmap and tracks the ball=
ooning
>> operation thereafter.
>>
>
> I have a better way to get rid of the bitmap.
> We should not maintain the inflating pages in the bitmap, instead, we
> can get them from the guest if it's needed, just like what we did for t=
he guest's
> unused pages. Then we can combine the inflating page info with the unus=
ed page
> info together, and skip them during live migration.
>

If we want to actually host enforce (disallow) access to inflated pages,=20
having such a bitmap in QEMU is required. Getting them from the guest=20
doesn't make sense in that context anymore.

Thanks,
David

> Thanks!
> Liang
>
>


--=20

David
