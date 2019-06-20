Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956EAC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6621D2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tFq6cNfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6621D2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdtNr-0004iU-KS
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44383)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdtE6-0003QV-SN
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shmuel.eiderman@oracle.com>) id 1hdt6U-0006Bq-Jw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:11:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shmuel.eiderman@oracle.com>)
 id 1hdsu1-0001OE-Ap; Thu, 20 Jun 2019 04:58:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K8cbLH150687;
 Thu, 20 Jun 2019 08:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2018-07-02;
 bh=efbkROk+jcXECEnjenL9x8ykjENhkELp+ol6CnjH+Wc=;
 b=tFq6cNfIHXWjCkK5Y6G9HwWUMIRiiLC3TxnsF6faZM2qa4IuZaYiwtuWdm/L3aL1XvkJ
 RvCGZ+e4efXqc22vCxFYoN3qaYuMwgCZeQ6JqPXOBtew9FjYSxz0wz4wsN2sieWdlJDe
 /GTvEo2Zr6DrLwA5FLaatyEg3CoQ21JsxgXH0E+zb4xPNgp4f7tzOJDuz4teQgdrbaXe
 eHhkGXG8If2B1rlxxX/UCu2bRkwc7FvNgb3VfAqoCChaj60wR23w2XdmUDsbXvw3S6V6
 vLYCkOOYWTZgyStWh6XEdy2Es2MPAkM1Fxaj3pBUImxF4chK0prWN7PVna1d52Tij57Y vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2t7809fvqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 08:58:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5K8tMrT038528;
 Thu, 20 Jun 2019 08:56:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t7rdx2f4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Jun 2019 08:56:39 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5K8ubV8007719;
 Thu, 20 Jun 2019 08:56:38 GMT
Received: from [10.0.0.38] (/79.180.42.160)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 20 Jun 2019 01:49:06 -0700
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Message-Id: <342453D5-3F9C-4C78-B75D-D3ECC0310208@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date: Thu, 20 Jun 2019 11:48:53 +0300
In-Reply-To: <8d8af1b9-426a-780c-6240-9e20603e9008@redhat.com>
To: Max Reitz <mreitz@redhat.com>
References: <20190605121721.29815-1-shmuel.eiderman@oracle.com>
 <20190605121721.29815-4-shmuel.eiderman@oracle.com>
 <8d8af1b9-426a-780c-6240-9e20603e9008@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200066
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 3/3] vmdk: Add read-only support for
 seSparse snapshots
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, eyal.moscovici@oracle.com, qemu-block@nongnu.org,
 arbel.moshe@oracle.com, qemu-devel@nongnu.org, liran.alon@oracle.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 19 Jun 2019, at 20:12, Max Reitz <mreitz@redhat.com> wrote:
>=20
> On 05.06.19 14:17, Sam Eiderman wrote:
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
>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>> Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
>> ---
>> block/vmdk.c | 357 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 341 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/block/vmdk.c b/block/vmdk.c
>> index 931eb2759c..4377779635 100644
>> --- a/block/vmdk.c
>> +++ b/block/vmdk.c
>=20
> [...]
>=20
>> +static int vmdk_open_se_sparse(BlockDriverState *bs,
>> +                               BdrvChild *file,
>> +                               int flags, Error **errp)
>> +{
>> +    int ret;
>> +    VMDKSESparseConstHeader const_header;
>> +    VMDKSESparseVolatileHeader volatile_header;
>> +    VmdkExtent *extent;
>> +
>> +    if (flags & BDRV_O_RDWR) {
>> +        error_setg(errp, "No write support for seSparse images =
available");
>> +        return -ENOTSUP;
>> +    }
> Kind of works for me, but why not bdrv_apply_auto_read_only() like I =
had
> proposed?  The advantage is that this would make the node read-only if
> the user has specified auto-read-only=3Don instead of failing.
>=20

Ah, I have not realized that bdrv_apply_auto_read_only() is preferred.
I=E2=80=99ll send a v3.

Sam

> Max

