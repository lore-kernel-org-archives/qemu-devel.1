Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6920C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 07:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5AA2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 07:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="03jKAE+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5AA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58759 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVX0o-0007cg-Ff
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 03:59:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hVWzt-0007Ig-Qf
	for qemu-devel@nongnu.org; Tue, 28 May 2019 03:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hVWzm-0005CB-Nj
	for qemu-devel@nongnu.org; Tue, 28 May 2019 03:58:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
	id 1hVWzX-0004qE-3r; Tue, 28 May 2019 03:57:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4S7mZpv078468; Tue, 28 May 2019 07:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : message-id :
	content-type : mime-version : subject : date : in-reply-to : cc : to :
	references; s=corp-2018-07-02;
	bh=+S+eZZ2lErhbx6075I32pYvIaKelDZM4zsuEQJ1kW9s=;
	b=03jKAE+4TPOSgvEw0P/daRL1rbq59D1H0tlfzmlUyR+DPc6jXp0uewEJhgfSNQw8h55T
	qaI4I/LNERVZzMhPZbKGGtzZwsrjjNxDkjvX70mrrsnHm4GVy8mD/LugUYoVQe1d6w9O
	8gvOpUuIlwHzTopPAYRsYOpFkfjhCyb2MvNhKP9wVTO9KcXoQRh38oMivM1YcwIuwxq4
	ieFvXdQy2e+Xf7V0x0WzgG+BLMMfc8AnUtIuaVy8ee0bHvNxjG37QBzW4rt1B1KYixKM
	s4SdtNqGe8dlGFJahB9a+YaFznKvR3uiZIkHd9eH7FEYGGwN5vuJ8/wzWQOtzKbFFhJ5
	xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2spxbq133a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2019 07:57:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x4S7tvbk018184; Tue, 28 May 2019 07:57:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2srbdwn5rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2019 07:57:38 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4S7vaFE029289;
	Tue, 28 May 2019 07:57:36 GMT
Received: from [10.0.5.157] (/213.57.127.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 28 May 2019 00:57:34 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-Id: <AF0444E6-AE0A-4ADC-A1D5-487775E076A6@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date: Tue, 28 May 2019 10:57:28 +0300
In-Reply-To: <8a27479f-3948-df17-5abc-0c22811ae4b2@redhat.com>
To: Max Reitz <mreitz@redhat.com>
References: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
	<20190424074901.31430-3-shmuel.eiderman@oracle.com>
	<8a27479f-3948-df17-5abc-0c22811ae4b2@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905280052
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9270
	signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905280052
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/2] vmdk: Add read-only support for
 seSparse snapshots
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, eyal.moscovici@oracle.com,
	qemu-block@nongnu.org, arbel.moshe@oracle.com,
	qemu-devel@nongnu.org, liran.alon@oracle.com,
	Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Comments inline

> On 27 May 2019, at 20:39, Max Reitz <mreitz@redhat.com> wrote:
>=20
> On 24.04.19 09:49, Sam Eiderman wrote:
>> Until ESXi 6.5 VMware used the vmfsSparse format for snapshots (VMDK3 =
in
>> QEMU).
>>=20
>> This format was lacking in the following:
>>=20
>>    * Grain directory (L1) and grain table (L2) entries were 32-bit,
>>      allowing access to only 2TB (slightly less) of data.
>>    * The grain size (default) was 512 bytes - leading to data
>>      fragmentation and many grain tables.
>>    * For space reclamation purposes, it was necessary to find all the
>>      grains which are not pointed to by any grain table - so a =
reverse
>>      mapping of "offset of grain in vmdk" to "grain table" must be
>>      constructed - which takes large amounts of CPU/RAM.
>>=20
>> The format specification can be found in VMware's documentation:
>> https://www.vmware.com/support/developer/vddk/vmdk_50_technote.pdf
>>=20
>> In ESXi 6.5, to support snapshot files larger than 2TB, a new format =
was
>> introduced: SESparse (Space Efficient).
>>=20
>> This format fixes the above issues:
>>=20
>>    * All entries are now 64-bit.
>>    * The grain size (default) is 4KB.
>>    * Grain directory and grain tables are now located at the =
beginning
>>      of the file.
>>      + seSparse format reserves space for all grain tables.
>>      + Grain tables can be addressed using an index.
>>      + Grains are located in the end of the file and can also be
>>        addressed with an index.
>>      - seSparse vmdks of large disks (64TB) have huge preallocated
>>        headers - mainly due to L2 tables, even for empty snapshots.
>>    * The header contains a reverse mapping ("backmap") of "offset of
>>      grain in vmdk" to "grain table" and a bitmap ("free bitmap") =
which
>>      specifies for each grain - whether it is allocated or not.
>>      Using these data structures we can implement space reclamation
>>      efficiently.
>>    * Due to the fact that the header now maintains two mappings:
>>        * The regular one (grain directory & grain tables)
>>        * A reverse one (backmap and free bitmap)
>>      These data structures can lose consistency upon crash and result
>>      in a corrupted VMDK.
>>      Therefore, a journal is also added to the VMDK and is replayed
>>      when the VMware reopens the file after a crash.
>>=20
>> Since ESXi 6.7 - SESparse is the only snapshot format available.
>>=20
>> Unfortunately, VMware does not provide documentation regarding the =
new
>> seSparse format.
>>=20
>> This commit is based on black-box research of the seSparse format.
>> Various in-guest block operations and their effect on the snapshot =
file
>> were tested.
>>=20
>> The only VMware provided source of information (regarding the =
underlying
>> implementation) was a log file on the ESXi:
>>=20
>>    /var/log/hostd.log
>>=20
>> Whenever an seSparse snapshot is created - the log is being populated
>> with seSparse records.
>>=20
>> Relevant log records are of the form:
>>=20
>> [...] Const Header:
>> [...]  constMagic     =3D 0xcafebabe
>> [...]  version        =3D 2.1
>> [...]  capacity       =3D 204800
>> [...]  grainSize      =3D 8
>> [...]  grainTableSize =3D 64
>> [...]  flags          =3D 0
>> [...] Extents:
>> [...]  Header         : <1 : 1>
>> [...]  JournalHdr     : <2 : 2>
>> [...]  Journal        : <2048 : 2048>
>> [...]  GrainDirectory : <4096 : 2048>
>> [...]  GrainTables    : <6144 : 2048>
>> [...]  FreeBitmap     : <8192 : 2048>
>> [...]  BackMap        : <10240 : 2048>
>> [...]  Grain          : <12288 : 204800>
>> [...] Volatile Header:
>> [...] volatileMagic     =3D 0xcafecafe
>> [...] FreeGTNumber      =3D 0
>> [...] nextTxnSeqNumber  =3D 0
>> [...] replayJournal     =3D 0
>>=20
>> The sizes that are seen in the log file are in sectors.
>> Extents are of the following format: <offset : size>
>>=20
>> This commit is a strict implementation which enforces:
>>    * magics
>>    * version number 2.1
>>    * grain size of 8 sectors  (4KB)
>>    * grain table size of 64 sectors
>>    * zero flags
>>    * extent locations
>>=20
>> Additionally, this commit proivdes only a subset of the functionality
>> offered by seSparse's format:
>>    * Read-only
>>    * No journal replay
>>    * No space reclamation
>>    * No unmap support
>>=20
>> Hence, journal header, journal, free bitmap and backmap extents are
>> unused, only the "classic" (L1 -> L2 -> data) grain access is
>> implemented.
>>=20
>> However there are several differences in the grain access itself.
>> Grain directory (L1):
>>    * Grain directory entries are indexes (not offsets) to grain
>>      tables.
>>    * Valid grain directory entries have their highest nibble set to
>>      0x1.
>>    * Since grain tables are always located in the beginning of the
>>      file - the index can fit into 32 bits - so we can use its low
>>      part if it's valid.
>> Grain table (L2):
>>    * Grain table entries are indexes (not offsets) to grains.
>>    * If the highest nibble of the entry is:
>>        0x0:
>>            The grain in not allocated.
>>            The rest of the bytes are 0.
>>        0x1:
>>            The grain is unmapped - guest sees a zero grain.
>>            The rest of the bits point to the previously mapped grain,
>>            see 0x3 case.
>>        0x2:
>>            The grain is zero.
>>        0x3:
>>            The grain is allocated - to get the index calculate:
>>            ((entry & 0x0fff000000000000) >> 48) |
>>            ((entry & 0x0000ffffffffffff) << 12)
>>    * The difference between 0x1 and 0x2 is that 0x1 is an unallocated
>>      grain which results from the guest using sg_unmap to unmap the
>>      grain - but the grain itself still exists in the grain extent - =
a
>>      space reclamation procedure should delete it.
>>      Unmapping a zero grain has no effect (0x2 will not change to =
0x1)
>>      but unmapping an unallocated grain will (0x0 to 0x1) - =
naturally.
>>=20
>> In order to implement seSparse some fields had to be changed to =
support
>> both 32-bit and 64-bit entry sizes.
>>=20
>> Read-only is implemented by failing on pwrite since qemu-img opens =
the
>> vmdk with read-write flags for "convert" (which is a read-only)
>> operation.
>=20
> Does it?  The code doesn=E2=80=99t look like it (in img_convert(), =
src_flags is
> never set to anything with BDRV_O_RDWR).
>=20
> In theory, we have bdrv_apply_auto_read_only() for this case.  More on
> that below. [1]

Yes, I added a check on the flags when I did the convert operation and =
it wasn=E2=80=99t read only.
I=E2=80=99ll double check that again, and try to change to =
bdrv_apply_auto_read_only().

I=E2=80=99m not sure how it will look now when the user will try to =
write to the image, I guess that
open with write flags will still work and there will be a failure upon =
write operations.

A better fix would be to change qemu-img convert to not open the image =
as RDWR but I
didn=E2=80=99t want to make a global change with this commit.

>=20
>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>> Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
>> ---
>> block/vmdk.c | 475 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 459 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index fc7378da78..e599c08b95 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>=20
> First, a general observation: BDRV_SECTOR_SIZE is indeed equal to =
VMDK=E2=80=99s
> sector size (both are 512), but I=E2=80=99d consider that a =
coincidence.  This
> file defines a SECTOR_SIZE macro.  I think you should use that instead
> of BDRV_SECTOR_SIZE whenever referring to VMDK=E2=80=99s sector size.
>=20
> (BDRV_SECTOR_SIZE is actually the sector size the qemu block layer =
uses.
> Yes, I know, there are plenty of places in vmdk.c that use it.  I =
still
> think it isn=E2=80=99t entirely correct to use it.)

Yes, I was too confused with all the mixing, I=E2=80=99ll change to =
SECTOR_SIZE.

>=20
>> @@ -91,6 +91,44 @@ typedef struct {
>>     uint16_t compressAlgorithm;
>> } QEMU_PACKED VMDK4Header;
>>=20
>> +typedef struct VMDKSESparseConstHeader {
>> +    uint64_t magic;
>> +    uint64_t version;
>> +    uint64_t capacity;
>> +    uint64_t grain_size;
>> +    uint64_t grain_table_size;
>> +    uint64_t flags;
>> +    uint64_t reserved1;
>> +    uint64_t reserved2;
>> +    uint64_t reserved3;
>> +    uint64_t reserved4;
>> +    uint64_t volatile_header_offset;
>> +    uint64_t volatile_header_size;
>> +    uint64_t journal_header_offset;
>> +    uint64_t journal_header_size;
>> +    uint64_t journal_offset;
>> +    uint64_t journal_size;
>> +    uint64_t grain_dir_offset;
>> +    uint64_t grain_dir_size;
>> +    uint64_t grain_tables_offset;
>> +    uint64_t grain_tables_size;
>> +    uint64_t free_bitmap_offset;
>> +    uint64_t free_bitmap_size;
>> +    uint64_t backmap_offset;
>> +    uint64_t backmap_size;
>> +    uint64_t grains_offset;
>> +    uint64_t grains_size;
>> +    uint8_t pad[304];
>> +} QEMU_PACKED VMDKSESparseConstHeader;
>> +
>> +typedef struct VMDKSESparseVolatileHeader {
>=20
> Is this the official name?  (I know you don=E2=80=99t have a =
specification, but
> maybe you do have some half-official information, I don=E2=80=99t =
know.)
> Generally, I=E2=80=99d call the opposite of =E2=80=9Cconst=E2=80=9D =
=E2=80=9Cmutable=E2=80=9D.

It=E2=80=99s the official name, can be seen in /var/log/hostd.log on =
ESXi host
whenever a sparse snapshot is created.

>=20
>> +    uint64_t magic;
>> +    uint64_t free_gt_number;
>> +    uint64_t next_txn_seq_number;
>> +    uint64_t replay_journal;
>> +    uint8_t pad[480];
>> +} QEMU_PACKED VMDKSESparseVolatileHeader;
>> +
>> #define L2_CACHE_SIZE 16
>>=20
>> typedef struct VmdkExtent {
>> @@ -99,19 +137,23 @@ typedef struct VmdkExtent {
>>     bool compressed;
>>     bool has_marker;
>>     bool has_zero_grain;
>> +    bool sesparse;
>> +    uint64_t sesparse_l2_tables_offset;
>> +    uint64_t sesparse_clusters_offset;
>> +    int32_t entry_size;
>>     int version;
>>     int64_t sectors;
>>     int64_t end_sector;
>>     int64_t flat_start_offset;
>>     int64_t l1_table_offset;
>>     int64_t l1_backup_table_offset;
>> -    uint32_t *l1_table;
>> +    void *l1_table;
>>     uint32_t *l1_backup_table;
>>     unsigned int l1_size;
>>     uint32_t l1_entry_sectors;
>>=20
>>     unsigned int l2_size;
>> -    uint32_t *l2_cache;
>> +    void *l2_cache;
>>     uint32_t l2_cache_offsets[L2_CACHE_SIZE];
>>     uint32_t l2_cache_counts[L2_CACHE_SIZE];
>>=20
>> @@ -434,6 +476,8 @@ static int vmdk_add_extent(BlockDriverState *bs,
>>          *            cluster size: 64KB, L2 table size: 512 entries
>>          *     1PB  - for default "ESXi Host Sparse Extent" =
(VMDK3/vmfsSparse)
>>          *            cluster size: 512B, L2 table size: 4096 entries
>> +         *     8PB  - for default "ESXI seSparse Extent"
>> +         *            cluster size: 4KB,  L2 table size: 4096 =
entries
>>          */
>>         error_setg(errp, "L1 size too big");
>>         return -EFBIG;
>=20
> Hm, now I wonder about this limit.  With this new format, it=E2=80=99d =
be 512M *
> 8 =3D 4 GB of RAM usage.  That seems an awful lot, and I don=E2=80=99t =
think we
> really need to support 8 PB images.  Like, if we want to prevent
> unbounded allocations, 4 GB is far above the limit of what I=E2=80=99d =
consider
> sane.  (And I don=E2=80=99t know too much above vmdk, but can=E2=80=99t =
a user also
> specify multiple extents with a single descriptor file, and thus make
> qemu allocate these 4 GB multiple times?)
>=20
> Some comment in this file says the maximum supported size is 64 TB
> anyway.  Shouldn=E2=80=99t we just limit the L1 size accordingly, =
then?

This is true, vmdk.c assumes that L1 is relatively small (L2 tables can
reach hundreds of GBs in size) and loads it all into memory.
I agree that 512M * 8 (or even * 4) is too large, I=E2=80=99ll see if we =
can reduce it
dramatically.
I just need to take into consideration that theoretically a user can =
override
the number of sectors in a single grain and reduce it to 1 - that means =
that
the L1=E2=80=99s size can increase.
So for each case I=E2=80=99ll just assume that grain size is 512 bytes =
(1 sectors)
and check for the minimal size of the L1 we should allocate.
seSparse descriptors (and vmfsSparse) can only point to a single extent
- so we are good here, however we might have a chain of seSparse files
for multiple consecutive snapshots so it=E2=80=99s really important to =
reduce the
size of the L1 tables since they are all loaded into memory.
In any case, this is only a check and we probably never reached this =
limit
in practice but it is true that we need to make it more strict.

>=20
>> @@ -459,6 +503,7 @@ static int vmdk_add_extent(BlockDriverState *bs,
>>     extent->l2_size =3D l2_size;
>>     extent->cluster_sectors =3D flat ? sectors : cluster_sectors;
>>     extent->next_cluster_sector =3D ROUND_UP(nb_sectors, =
cluster_sectors);
>> +    extent->entry_size =3D sizeof(uint32_t);
>>=20
>>     if (s->num_extents > 1) {
>>         extent->end_sector =3D (*(extent - 1)).end_sector + =
extent->sectors;
>> @@ -480,7 +525,7 @@ static int vmdk_init_tables(BlockDriverState *bs, =
VmdkExtent *extent,
>>     int i;
>>=20
>>     /* read the L1 table */
>> -    l1_size =3D extent->l1_size * sizeof(uint32_t);
>> +    l1_size =3D extent->l1_size * extent->entry_size;
>=20
> Related to the above: This can overflow.  (512M * 8 =3D=3D 4G)

Good catch, reducing the L1 table size will fix this

>=20
>>     extent->l1_table =3D g_try_malloc(l1_size);
>>     if (l1_size && extent->l1_table =3D=3D NULL) {
>>         return -ENOMEM;
>> @@ -498,10 +543,15 @@ static int vmdk_init_tables(BlockDriverState =
*bs, VmdkExtent *extent,
>>         goto fail_l1;
>>     }
>>     for (i =3D 0; i < extent->l1_size; i++) {
>> -        le32_to_cpus(&extent->l1_table[i]);
>> +        if (extent->sesparse) {
>=20
> Shouldn=E2=80=99t matter in practice, but I think evaluating =
extent->entry_size
> would be more natural.

I just wanted to make it more clear that we are dealing with the =
seSparse format.
But maybe in this case I should evaluate extent->entry_size and add =
assert on
extent->sesparse inside the uint64_t case?
WDYT?

>=20
>> +            le64_to_cpus((uint64_t *)extent->l1_table + i);
>> +        } else {
>> +            le32_to_cpus((uint32_t *)extent->l1_table + i);
>> +        }
>>     }
>>=20
>>     if (extent->l1_backup_table_offset) {
>> +        assert(!extent->sesparse);
>>         extent->l1_backup_table =3D g_try_malloc(l1_size);
>>         if (l1_size && extent->l1_backup_table =3D=3D NULL) {
>>             ret =3D -ENOMEM;
>> @@ -524,7 +574,7 @@ static int vmdk_init_tables(BlockDriverState *bs, =
VmdkExtent *extent,
>>     }
>>=20
>>     extent->l2_cache =3D
>> -        g_new(uint32_t, extent->l2_size * L2_CACHE_SIZE);
>> +        g_malloc(extent->entry_size * extent->l2_size * =
L2_CACHE_SIZE);
>>     return 0;
>>  fail_l1b:
>>     g_free(extent->l1_backup_table);
>> @@ -570,6 +620,331 @@ static int =
vmdk_open_vmfs_sparse(BlockDriverState *bs,
>>     return ret;
>> }
>>=20
>> +#define SESPARSE_CONST_HEADER_MAGIC 0x00000000cafebabe
>> +#define SESPARSE_VOLATILE_HEADER_MAGIC 0x00000000cafecafe
>=20
> The upper 32 bit are 0, so it doesn=E2=80=99t really matter, but =
still, if these
> are 64-bit constants (which they are), they should have a 64-bit type
> (e.g. UINT64_C(0x00000000cafebabe)).  (According to my very personal
> taste at least.)

Sure, I=E2=80=99ll do that

>=20
>> +
>> +static const char zero_pad[BDRV_SECTOR_SIZE];
>> +
>> +/* Strict checks - format not officially documented */
>> +static int check_se_sparse_const_header(VMDKSESparseConstHeader =
*header,
>> +                                        Error **errp)
>> +{
>> +    uint64_t grain_table_coverage;
>> +    uint64_t needed_grain_tables;
>> +    uint64_t needed_grain_dir_size;
>> +    uint64_t needed_grain_tables_size;
>> +    uint64_t needed_free_bitmap_size;
>> +
>> +    header->magic =3D le64_to_cpu(header->magic);
>> +    header->version =3D le64_to_cpu(header->version);
>> +    header->grain_size =3D le64_to_cpu(header->grain_size);
>> +    header->grain_table_size =3D =
le64_to_cpu(header->grain_table_size);
>> +    header->flags =3D le64_to_cpu(header->flags);
>> +    header->reserved1 =3D le64_to_cpu(header->reserved1);
>> +    header->reserved2 =3D le64_to_cpu(header->reserved2);
>> +    header->reserved3 =3D le64_to_cpu(header->reserved3);
>> +    header->reserved4 =3D le64_to_cpu(header->reserved4);
>> +
>> +    header->volatile_header_offset =3D
>> +        le64_to_cpu(header->volatile_header_offset);
>> +    header->volatile_header_size =3D =
le64_to_cpu(header->volatile_header_size);
>> +
>> +    header->journal_header_offset =3D =
le64_to_cpu(header->journal_header_offset);
>> +    header->journal_header_size =3D =
le64_to_cpu(header->journal_header_size);
>> +
>> +    header->journal_offset =3D le64_to_cpu(header->journal_offset);
>> +    header->journal_size =3D le64_to_cpu(header->journal_size);
>> +
>> +    header->grain_dir_offset =3D =
le64_to_cpu(header->grain_dir_offset);
>> +    header->grain_dir_size =3D le64_to_cpu(header->grain_dir_size);
>> +
>> +    header->grain_tables_offset =3D =
le64_to_cpu(header->grain_tables_offset);
>> +    header->grain_tables_size =3D =
le64_to_cpu(header->grain_tables_size);
>> +
>> +    header->free_bitmap_offset =3D =
le64_to_cpu(header->free_bitmap_offset);
>> +    header->free_bitmap_size =3D =
le64_to_cpu(header->free_bitmap_size);
>> +
>> +    header->backmap_offset =3D le64_to_cpu(header->backmap_offset);
>> +    header->backmap_size =3D le64_to_cpu(header->backmap_size);
>> +
>> +    header->grains_offset =3D le64_to_cpu(header->grains_offset);
>> +    header->grains_size =3D le64_to_cpu(header->grains_size);
>> +
>> +    if (header->magic !=3D SESPARSE_CONST_HEADER_MAGIC) {
>> +        error_setg(errp, "Bad const header magic: 0x%016" PRIx64,
>> +                   header->magic);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (header->version !=3D 0x0000000200000001) {
>> +        error_setg(errp, "Unsupported version: 0x%016" PRIx64,
>> +                   header->version);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->grain_size !=3D 8) {
>> +        error_setg(errp, "Unsupported grain size: %" PRIu64,
>> +                   header->grain_size);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->grain_table_size !=3D 64) {
>> +        error_setg(errp, "Unsupported grain table size: %" PRIu64,
>> +                   header->grain_table_size);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->flags !=3D 0) {
>> +        error_setg(errp, "Unsupported flags: 0x%016" PRIx64,
>> +                   header->flags);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->reserved1 !=3D 0 || header->reserved2 !=3D 0 ||
>> +        header->reserved3 !=3D 0 || header->reserved4 !=3D 0) {
>> +        error_setg(errp, "Unsupported reserved bits:"
>> +                   " 0x%016" PRIx64 " 0x%016" PRIx64
>> +                   " 0x%016" PRIx64 " 0x%016" PRIx64,
>> +                   header->reserved1, header->reserved2,
>> +                   header->reserved3, header->reserved4);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->volatile_header_offset !=3D 1) {
>> +        error_setg(errp, "Unsupported volatile header offset: %" =
PRIu64,
>> +                   header->volatile_header_offset);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->volatile_header_size !=3D 1) {
>> +        error_setg(errp, "Unsupported volatile header size: %" =
PRIu64,
>> +                   header->volatile_header_size);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->journal_header_offset !=3D 2) {
>> +        error_setg(errp, "Unsupported journal header offset: %" =
PRIu64,
>> +                   header->journal_header_offset);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->journal_header_size !=3D 2) {
>> +        error_setg(errp, "Unsupported journal header size: %" =
PRIu64,
>> +                   header->journal_header_size);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->journal_offset !=3D 2048) {
>> +        error_setg(errp, "Unsupported journal offset: %" PRIu64,
>> +                   header->journal_offset);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->journal_size !=3D 2048) {
>> +        error_setg(errp, "Unsupported journal size: %" PRIu64,
>> +                   header->journal_size);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    if (header->grain_dir_offset !=3D 4096) {
>> +        error_setg(errp, "Unsupported grain directory offset: %" =
PRIu64,
>> +                   header->grain_dir_offset);
>> +        return -ENOTSUP;
>> +    }
>=20
> Do these values (metadata structure offsets and sizes) really matter?

Not really, these are the values that I saw appear in 10MB, 150GB and =
6TB
snapshots, they never change.
All of the checks in this function are just for =E2=80=9Cstrictness=E2=80=9D=
 and can be removed.
I just wanted to include them at least in the v1 series to make the =
format more
clear and to not support vmdk's that give other values under the =
assumption
that the format might misbehave in other parts too.
They can be removed (maybe I=E2=80=99ll keep the version check in any =
case) or we
can keep them and remove them at any later point.
WDYT?

>=20
>> +    /* in sectors */
>> +    grain_table_coverage =3D ((header->grain_table_size *
>=20
> Hm, if header->grain_table_size is measured in sectors, it=E2=80=99d =
probably be
> better to rename it to grain_table_sectors or something.
>=20
> (=E2=80=9Csize=E2=80=9D is usually in bytes; sometimes it=E2=80=99s =
the number of entries, but
> that=E2=80=99s already kind of weird, I think)

grain_table_sectors is not a good name since it is not the number of =
sectors
a grain table uses but the number of sectors it covers.
grain_table_coverage_sectors is a better name but a bit too long.
I can change grain_table_* to gt_* and grain_dir_* to gd_* but they seem =
too
similar and confusing.
WDYT?

>=20
>> +                             BDRV_SECTOR_SIZE / sizeof(uint64_t)) *
>> +                            header->grain_size);
>> +    needed_grain_tables =3D header->capacity / grain_table_coverage;
>> +    needed_grain_dir_size =3D DIV_ROUND_UP(needed_grain_tables * =
sizeof(uint64_t),
>> +                                         BDRV_SECTOR_SIZE);
>> +    needed_grain_dir_size =3D ROUND_UP(needed_grain_dir_size, 2048);
>> +
>> +    if (header->grain_dir_size !=3D needed_grain_dir_size) {
>=20
> Wouldn=E2=80=99t it suffice to check that header->grain_dir_size >=3D
> needed_grain_dir_size?  (The ROUND_UP() would become unnecessary, =
then.)
>=20
> (And also, maybe s/grain_dir_size/grain_dir_sectors/)

This is how VMware works - they round up the size to 2048 sectors for =
the
needed_grain_dir_sectors - so I just make sure the math adds up.
As said before, all of these checks are just for =E2=80=9Cstrictness=E2=80=
=9D.

>=20
>> +        error_setg(errp, "Invalid grain directory size: %" PRIu64
>> +                   ", needed: %" PRIu64,
>> +                   header->grain_dir_size, needed_grain_dir_size);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (header->grain_tables_offset !=3D
>> +        header->grain_dir_offset + header->grain_dir_size) {
>> +        error_setg(errp, "Grain directory must be followed by grain =
tables");
>> +        return -EINVAL;
>> +    }
>> +
>> +    needed_grain_tables_size =3D needed_grain_tables * =
header->grain_table_size;
>> +    needed_grain_tables_size =3D ROUND_UP(needed_grain_tables_size, =
2048);
>> +
>> +    if (header->grain_tables_size !=3D needed_grain_tables_size) {
>> +        error_setg(errp, "Invalid grain tables size: %" PRIu64
>> +                   ", needed: %" PRIu64,
>> +                   header->grain_tables_size, =
needed_grain_tables_size);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (header->free_bitmap_offset !=3D
>> +        header->grain_tables_offset + header->grain_tables_size) {
>> +        error_setg(errp, "Grain tables must be followed by free =
bitmap");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* in bits */
>> +    needed_free_bitmap_size =3D DIV_ROUND_UP(header->capacity,
>> +                                           header->grain_size);
>> +    /* in bytes */
>> +    needed_free_bitmap_size =3D =
DIV_ROUND_UP(needed_free_bitmap_size,
>> +                                           BITS_PER_BYTE);
>> +    /* in sectors */
>> +    needed_free_bitmap_size =3D =
DIV_ROUND_UP(needed_free_bitmap_size,
>> +                                           BDRV_SECTOR_SIZE);
>> +    needed_free_bitmap_size =3D ROUND_UP(needed_free_bitmap_size, =
2048);
>=20
> Er, now this is really confusing.  I=E2=80=99d start with the size in =
bytes:
>=20
>> needed_free_bitmap_size =3D DIV_ROUND_UP(header->capacity,
>>                                       header->grain_size * =
BITS_PER_BYTE);
>=20
> and then translate it to sectors, but use a new variable for it
> (needed_free_bitmap_sectors).

I=E2=80=99ll do that

>=20
>> +
>> +    if (header->free_bitmap_size !=3D needed_free_bitmap_size) {
>=20
> Again, I suppose just checking that header->free_bitmap_size >=3D
> needed_free_bitmap_size should be enough, I think.

Just for strictness, as said above.

>=20
>> +        error_setg(errp, "Invalid free bitmap size: %" PRIu64
>> +                   ", needed: %" PRIu64,
>> +                   header->free_bitmap_size, =
needed_free_bitmap_size);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (header->backmap_offset !=3D
>> +        header->free_bitmap_offset + header->free_bitmap_size) {
>> +        error_setg(errp, "Free bitmap must be followed by backmap");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (header->backmap_size !=3D header->grain_tables_size) {
>> +        error_setg(errp, "Invalid backmap size: %" PRIu64
>> +                   ", needed: %" PRIu64,
>> +                   header->backmap_size, header->grain_tables_size);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (header->grains_offset !=3D
>> +        header->backmap_offset + header->backmap_size) {
>> +        error_setg(errp, "Backmap must be followed by grains");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (header->grains_size !=3D header->capacity) {
>> +        error_setg(errp, "Invalid grains size: %" PRIu64
>> +                   ", needed: %" PRIu64,
>> +                   header->grains_size, header->capacity);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* check that padding is 0 */
>> +    if (memcmp(header->pad, zero_pad, sizeof(header->pad))) {
>=20
> buffer_is_zero() should be sufficient.

Great! I=E2=80=99ll use it

>=20
>> +        error_setg(errp, "Unsupported non-zero const header =
padding");
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int =
check_se_sparse_volatile_header(VMDKSESparseVolatileHeader *header,
>> +                                           Error **errp)
>> +{
>> +    header->magic =3D le64_to_cpu(header->magic);
>> +    header->free_gt_number =3D le64_to_cpu(header->free_gt_number);
>> +    header->next_txn_seq_number =3D =
le64_to_cpu(header->next_txn_seq_number);
>> +    header->replay_journal =3D le64_to_cpu(header->replay_journal);
>> +
>> +    if (header->magic !=3D SESPARSE_VOLATILE_HEADER_MAGIC) {
>> +        error_setg(errp, "Bad volatile header magic: 0x%016" PRIx64,
>> +                   header->magic);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (header->replay_journal) {
>> +        error_setg(errp, "Replaying journal not supported");
>=20
> Hmmm, maybe "Image is dirty, replaying journal not supported=E2=80=9D?

Even better

>=20
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    /* check that padding is 0 */
>> +    if (memcmp(header->pad, zero_pad, sizeof(header->pad))) {
>> +        error_setg(errp, "Unsupported non-zero volatile header =
padding");
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int vmdk_open_se_sparse(BlockDriverState *bs,
>> +                               BdrvChild *file,
>> +                               int flags, Error **errp)
>> +{
>> +    int ret;
>> +    VMDKSESparseConstHeader const_header;
>> +    VMDKSESparseVolatileHeader volatile_header;
>> +    VmdkExtent *extent;
>> +
>> +    assert(sizeof(const_header) =3D=3D BDRV_SECTOR_SIZE);
>> +
>=20
> [1] I think if you put a
>=20
> ret =3D bdrv_apply_auto_read_only(bs,
>    "No write support for seSparse images available", errp);
> if (ret < 0) {
>    return ret;
> }
>=20
> here, that should do the trick.

I=E2=80=99ll do that, see first comment.

>=20
>> +    ret =3D bdrv_pread(file, 0, &const_header, =
sizeof(const_header));
>> +    if (ret < 0) {
>> +        bdrv_refresh_filename(file->bs);
>> +        error_setg_errno(errp, -ret,
>> +                         "Could not read const header from file =
'%s'",
>> +                         file->bs->filename);
>> +        return ret;
>> +    }
>> +
>> +    /* check const header */
>> +    ret =3D check_se_sparse_const_header(&const_header, errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    assert(sizeof(volatile_header) =3D=3D BDRV_SECTOR_SIZE);
>> +
>> +    ret =3D bdrv_pread(file,
>> +                     const_header.volatile_header_offset * =
BDRV_SECTOR_SIZE,
>> +                     &volatile_header, sizeof(volatile_header));
>> +    if (ret < 0) {
>> +        bdrv_refresh_filename(file->bs);
>> +        error_setg_errno(errp, -ret,
>> +                         "Could not read volatile header from file =
'%s'",
>> +                         file->bs->filename);
>> +        return ret;
>> +    }
>> +
>> +    /* check volatile header */
>> +    ret =3D check_se_sparse_volatile_header(&volatile_header, errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    ret =3D vmdk_add_extent(bs, file, false,
>> +                          const_header.capacity,
>> +                          const_header.grain_dir_offset * =
BDRV_SECTOR_SIZE,
>> +                          0,
>> +                          const_header.grain_dir_size *
>> +                          BDRV_SECTOR_SIZE / sizeof(uint64_t),
>> +                          const_header.grain_table_size *
>> +                          BDRV_SECTOR_SIZE / sizeof(uint64_t),
>> +                          const_header.grain_size,
>> +                          &extent,
>> +                          errp);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>> +    extent->sesparse =3D true;
>> +    extent->sesparse_l2_tables_offset =3D =
const_header.grain_tables_offset;
>> +    extent->sesparse_clusters_offset =3D const_header.grains_offset;
>> +    extent->entry_size =3D sizeof(uint64_t);
>> +
>> +    ret =3D vmdk_init_tables(bs, extent, errp);
>> +    if (ret) {
>> +        /* free extent allocated by vmdk_add_extent */
>> +        vmdk_free_last_extent(bs);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> static int vmdk_open_desc_file(BlockDriverState *bs, int flags, char =
*buf,
>>                                QDict *options, Error **errp);
>>=20
>> @@ -847,6 +1222,7 @@ static int vmdk_parse_extents(const char *desc, =
BlockDriverState *bs,
>>          * RW [size in sectors] SPARSE "file-name.vmdk"
>>          * RW [size in sectors] VMFS "file-name.vmdk"
>>          * RW [size in sectors] VMFSSPARSE "file-name.vmdk"
>> +         * RW [size in sectors] SESPARSE "file-name.vmdk"
>>          */
>>         flat_offset =3D -1;
>>         matches =3D sscanf(p, "%10s %" SCNd64 " %10s =
\"%511[^\n\r\"]\" %" SCNd64,
>> @@ -869,7 +1245,8 @@ static int vmdk_parse_extents(const char *desc, =
BlockDriverState *bs,
>>=20
>>         if (sectors <=3D 0 ||
>>             (strcmp(type, "FLAT") && strcmp(type, "SPARSE") &&
>> -             strcmp(type, "VMFS") && strcmp(type, "VMFSSPARSE")) ||
>> +             strcmp(type, "VMFS") && strcmp(type, "VMFSSPARSE") &&
>> +             strcmp(type, "SESPARSE")) ||
>>             (strcmp(access, "RW"))) {
>>             continue;
>>         }
>> @@ -922,6 +1299,13 @@ static int vmdk_parse_extents(const char *desc, =
BlockDriverState *bs,
>>                 return ret;
>>             }
>>             extent =3D &s->extents[s->num_extents - 1];
>> +        } else if (!strcmp(type, "SESPARSE")) {
>> +            ret =3D vmdk_open_se_sparse(bs, extent_file, =
bs->open_flags, errp);
>> +            if (ret) {
>> +                bdrv_unref_child(bs, extent_file);
>> +                return ret;
>> +            }
>> +            extent =3D &s->extents[s->num_extents - 1];
>>         } else {
>>             error_setg(errp, "Unsupported extent type '%s'", type);
>>             bdrv_unref_child(bs, extent_file);
>> @@ -956,6 +1340,7 @@ static int vmdk_open_desc_file(BlockDriverState =
*bs, int flags, char *buf,
>>     if (strcmp(ct, "monolithicFlat") &&
>>         strcmp(ct, "vmfs") &&
>>         strcmp(ct, "vmfsSparse") &&
>> +        strcmp(ct, "seSparse") &&
>>         strcmp(ct, "twoGbMaxExtentSparse") &&
>>         strcmp(ct, "twoGbMaxExtentFlat")) {
>>         error_setg(errp, "Unsupported image type '%s'", ct);
>> @@ -1206,10 +1591,12 @@ static int =
get_cluster_offset(BlockDriverState *bs,
>> {
>>     unsigned int l1_index, l2_offset, l2_index;
>>     int min_index, i, j;
>> -    uint32_t min_count, *l2_table;
>> +    uint32_t min_count;
>> +    void *l2_table;
>>     bool zeroed =3D false;
>>     int64_t ret;
>>     int64_t cluster_sector;
>> +    unsigned int l2_size_bytes =3D extent->l2_size * =
extent->entry_size;
>>=20
>>     if (m_data) {
>>         m_data->valid =3D 0;
>> @@ -1224,7 +1611,31 @@ static int get_cluster_offset(BlockDriverState =
*bs,
>>     if (l1_index >=3D extent->l1_size) {
>>         return VMDK_ERROR;
>>     }
>> -    l2_offset =3D extent->l1_table[l1_index];
>> +    if (extent->sesparse) {
>=20
> Maybe add assertions that extent->entry_size =3D=3D 8 here and... [2]

Sure

>=20
>> +        uint64_t l2_offset_u64 =3D ((uint64_t =
*)extent->l1_table)[l1_index];
>> +        if (l2_offset_u64 =3D=3D 0) {
>> +            l2_offset =3D 0;
>> +        } else if ((l2_offset_u64 & 0xffffffff00000000) !=3D =
0x1000000000000000) {
>> +            /*
>> +             * Top most nibble is 0x1 if grain table is allocated.
>> +             * strict check - top most 4 bytes must be 0x10000000 =
since max
>> +             * supported size is 64TB for disk - so no more than =
64TB / 16MB
>> +             * grain directories which is smaller than uint32,
>> +             * where 16MB is the only supported default grain table =
coverage.
>> +             */
>> +            return VMDK_ERROR;
>> +        } else {
>> +            l2_offset_u64 =3D l2_offset_u64 & 0x00000000ffffffff;
>> +            l2_offset_u64 =3D extent->sesparse_l2_tables_offset +
>> +                l2_offset_u64 * l2_size_bytes / BDRV_SECTOR_SIZE;
>> +            if (l2_offset_u64 > 0x00000000ffffffff) {
>> +                return VMDK_ERROR;
>> +            }
>> +            l2_offset =3D (unsigned int)(l2_offset_u64);
>> +        }
>> +    } else {
>=20
> [2] ...that extent->entry_size =3D=3D 4 here?

Sure

>=20
>> +        l2_offset =3D ((uint32_t *)extent->l1_table)[l1_index];
>> +    }
>>     if (!l2_offset) {
>>         return VMDK_UNALLOC;
>>     }
>> @@ -1236,7 +1647,7 @@ static int get_cluster_offset(BlockDriverState =
*bs,
>>                     extent->l2_cache_counts[j] >>=3D 1;
>>                 }
>>             }
>> -            l2_table =3D extent->l2_cache + (i * extent->l2_size);
>> +            l2_table =3D (char *)extent->l2_cache + (i * =
l2_size_bytes);
>>             goto found;
>>         }
>>     }
>> @@ -1249,13 +1660,13 @@ static int =
get_cluster_offset(BlockDriverState *bs,
>>             min_index =3D i;
>>         }
>>     }
>> -    l2_table =3D extent->l2_cache + (min_index * extent->l2_size);
>> +    l2_table =3D (char *)extent->l2_cache + (min_index * =
l2_size_bytes);
>>     BLKDBG_EVENT(extent->file, BLKDBG_L2_LOAD);
>>     if (bdrv_pread(extent->file,
>>                 (int64_t)l2_offset * 512,
>>                 l2_table,
>> -                extent->l2_size * sizeof(uint32_t)
>> -            ) !=3D extent->l2_size * sizeof(uint32_t)) {
>> +                l2_size_bytes
>> +            ) !=3D l2_size_bytes) {
>>         return VMDK_ERROR;
>>     }
>>=20
>> @@ -1263,16 +1674,45 @@ static int =
get_cluster_offset(BlockDriverState *bs,
>>     extent->l2_cache_counts[min_index] =3D 1;
>>  found:
>>     l2_index =3D ((offset >> 9) / extent->cluster_sectors) % =
extent->l2_size;
>> -    cluster_sector =3D le32_to_cpu(l2_table[l2_index]);
>>=20
>> -    if (extent->has_zero_grain && cluster_sector =3D=3D =
VMDK_GTE_ZEROED) {
>> -        zeroed =3D true;
>> +    if (extent->sesparse) {
>> +        cluster_sector =3D le64_to_cpu(((uint64_t =
*)l2_table)[l2_index]);
>> +        switch (cluster_sector & 0xf000000000000000) {
>> +        case 0x0000000000000000:
>> +            /* unallocated grain */
>> +            if (cluster_sector !=3D 0) {
>> +                return VMDK_ERROR;
>> +            }
>> +            break;
>> +        case 0x1000000000000000:
>> +            /* scsi-unmapped grain - fallthrough */
>> +        case 0x2000000000000000:
>> +            /* zero grain */
>> +            zeroed =3D true;
>> +            break;
>> +        case 0x3000000000000000:
>> +            /* allocated grain */
>> +            cluster_sector =3D (((cluster_sector & =
0x0fff000000000000) >> 48) |
>> +                              ((cluster_sector & 0x0000ffffffffffff) =
<< 12));
>=20
> That=E2=80=99s just insane.  I trust you, though.

Yea, very weird math, I installed several operating systems on sesparse
snapshots, then used qemu convert/commit and tested the results -
all of them booted so I guess this really works :-)

>=20
>> +            cluster_sector =3D extent->sesparse_clusters_offset +
>> +                cluster_sector * extent->cluster_sectors;
>> +            break;
>> +        default:
>> +            return VMDK_ERROR;
>> +        }
>> +    } else {
>> +        cluster_sector =3D le32_to_cpu(((uint32_t =
*)l2_table)[l2_index]);
>> +
>> +        if (extent->has_zero_grain && cluster_sector =3D=3D =
VMDK_GTE_ZEROED) {
>> +            zeroed =3D true;
>> +        }
>>     }
>>=20
>>     if (!cluster_sector || zeroed) {
>>         if (!allocate) {
>>             return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
>>         }
>> +        assert(!extent->sesparse);
>>=20
>>         if (extent->next_cluster_sector >=3D VMDK_EXTENT_MAX_SECTORS) =
{
>>             return VMDK_ERROR;
>> @@ -1296,7 +1736,7 @@ static int get_cluster_offset(BlockDriverState =
*bs,
>>             m_data->l1_index =3D l1_index;
>>             m_data->l2_index =3D l2_index;
>>             m_data->l2_offset =3D l2_offset;
>> -            m_data->l2_cache_entry =3D &l2_table[l2_index];
>> +            m_data->l2_cache_entry =3D ((uint32_t *)l2_table) + =
l2_index;
>>         }
>>     }
>>     *cluster_offset =3D cluster_sector << BDRV_SECTOR_BITS;
>> @@ -1622,6 +2062,9 @@ static int vmdk_pwritev(BlockDriverState *bs, =
uint64_t offset,
>>         if (!extent) {
>>             return -EIO;
>>         }
>> +        if (extent->sesparse) {
>> +            return -ENOTSUP;
>> +        }
>=20
> ([1] This should still stay here, even with =
bdrv_apply_auto_read_only()
> above.)

Just as I thought, great.

>=20
>>         offset_in_cluster =3D vmdk_find_offset_in_cluster(extent, =
offset);
>>         n_bytes =3D MIN(bytes, extent->cluster_sectors * =
BDRV_SECTOR_SIZE
>>                              - offset_in_cluster);
>>=20
>=20
> Overall, looks reasonable to me.  Then again, I have no clue of the
> format and I trust you that it works.
>=20
> Max

Sam

