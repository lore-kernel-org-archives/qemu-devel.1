Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B69C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24692073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pup856iQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24692073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47578 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFyRT-0005rR-9u
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:02:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hFyQW-0005YR-6W
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hFyQU-00008N-Sh
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:01:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hFyQU-000075-Fo
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:01:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3F9x9pt117253; Mon, 15 Apr 2019 10:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=content-type :
	mime-version : subject : from : in-reply-to : date : cc :
	content-transfer-encoding : message-id : references : to;
	s=corp-2018-07-02; bh=lb7Tq2WSSuyzFAOaEL9PfgKQBQVQCYSentuCEMh4wXc=;
	b=pup856iQBLrfAEVLlKjEaHSEucvivE9gOkl0zKBbB32WBMK3JZjNj+ICCFS93U2IP1Bx
	TZE/8k5mVoR/r2s7mDmArRK2C7hmsuT32NBPmnMMUL/tmZJZQWIkq/idIfCGgzrNwUrY
	mm3j+bt+G8tbn//zD618+P3VBZeUhFbG4TSEFF7JOaejJbGWwT2soCpW/m39HfxYJ5po
	vCynRokmbnnY/R+mbqfYxeg7O/u4gCRjjIZv3bEK/0DyJ7QfEXOU/MZyFqM1lVHKaBQe
	tdVjGWyGSrWZ5S/9IzCOy2cMPHEUU4vdg1W56pj+/Ceqv0ojBTarPdwb+Ofcv/uir/TQ
	Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 2ru76t5neq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 10:01:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3FA0ujm149475; Mon, 15 Apr 2019 10:01:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 2ru4vsh34v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2019 10:01:18 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3FA1HO6020424;
	Mon, 15 Apr 2019 10:01:17 GMT
Received: from [10.0.5.57] (/213.57.127.10)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 15 Apr 2019 03:01:17 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20190415093725.GB29134@stefanha-x1.localdomain>
Date: Mon, 15 Apr 2019 13:01:13 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A34D426-BE46-47A4-98C9-FF812567B67E@oracle.com>
References: <20190321075545.14929-1-nir.weiner@oracle.com>
	<20190409142925.GG16944@stefanha-x1.localdomain>
	<AC01E2C2-1944-42C5-A944-220EE6F8A489@oracle.com>
	<20190415093725.GB29134@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904150071
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904150071
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-scsi: Support live migration
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
Cc: Nir Weiner <nir.weiner@oracle.com>, qemu-devel@nongnu.org,
	bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415100113.ydyD14PwELQlhDcgmX1gI-3J7NVSe-DimC7uQ3CCbko@z>



> On 15 Apr 2019, at 12:37, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> On Thu, Apr 11, 2019 at 01:45:06AM +0300, Liran Alon wrote:
>>=20
>>=20
>>> On 9 Apr 2019, at 17:29, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>=20
>>> On Thu, Mar 21, 2019 at 09:55:42AM +0200, Nir Weiner wrote:
>>>> Originally migration was not possible with vhost-scsi because
>>>> as part of migration, the source host target SCSI device state
>>>> needs to be saved and loaded into the destination host target SCSI
>>>> device. This cannot be done by QEMU.
>>>>=20
>>>> As this can be handled either by external orchestrator or by having
>>>> shared-storage (i.e. iSCSI), there is no reason to limit the
>>>> orchestrator from being able to explictly specify it wish to enable
>>>> migration even when VM have a vhost-scsi device.
>>>>=20
>>>> Liran Alon (1):
>>>> vhost-scsi: Allow user to enable migration
>>>>=20
>>>> Nir Weiner (2):
>>>> vhost-scsi: The vhost device should be stopped when the VM is not
>>>>   running
>>>> vhost-scsi: Add vmstate descriptor
>>>>=20
>>>> hw/scsi/vhost-scsi.c                  | 57 =
++++++++++++++++++++++-----
>>>> include/hw/virtio/vhost-scsi-common.h |  1 +
>>>> 2 files changed, 48 insertions(+), 10 deletions(-)
>>>=20
>>> What happens when migration is attempted while there is in-flight =
I/O in
>>> the vring?
>>>=20
>>> Stefan
>>=20
>> What do you define as =E2=80=9Cin-flight I/O=E2=80=9D? I think there =
is a need to separate the discussion here to multiple cases:
>>=20
>> 1) The I/O request was written to vring but guest have not yet =
written to doorbell:
>> This is the simplest case. No state is lost as the vring is migrated =
from source host to dest host as part of guest memory migration.
>> Also, the vring properties (E.g. Guest base address) is transferred =
from source host to dest host as part of vhost-scsi VMState.
>> (See patch 2/3 of series which adds VMSTATE_VIRTIO_DEVICE to =
vhost-scsi VMState which will cause virtio_save() to save vring on =
migration stream).
>>=20
>> 2) The I/O request was written to vring and the guest have written to =
doorbell:
>> The I/O request was submitted and processed by the vhost-scsi =
backend. Therefore, the I/O request was sent to the remote TGT server.
>> If the the TGT server has performed the write and returned ACK but =
the ACK was not received by guest, then guest is expected to initiate =
the write again.
>> (Similar to what happens for a momentary TGT server downtime / =
network downtime). So this isn=E2=80=99t suppose to be an issue.
>=20
> This scenario doesn't fit into the virtio-scsi model since each
> virtio-scsi request requires a response.  Otherwise there is a vring
> descriptor leak.
>=20
> If the migration scheme can leak vring descriptors then it is =
incorrect.
> Especially repeated migrations could cause the vring to become totally
> filled with leaked descriptors.
>=20
> I think the case you've described cannot happen based on the
> drivers/vhost/scsi.c code.  It seems that clearing the endpoint =
flushes
> and waits for inflight requests to complete.  The
> VHOST_SCSI_CLEAR_ENDPOINT ioctl blocks until the remote target has
> returned an ACK for all in-flight requests.

Hmm interesting. I missed this part and it seems that you are right.
(vhost_scsi_ioctl() -> vhost_scsi_clear_endpoint() -> vhost_scsi_flush()
which is called by QEMU=E2=80=99s vhost_scsi_set_status() -> =
vhost_scsi_stop() -> vhost_scsi_clear_endpoint() -> =
vhost_ops->vhost_scsi_clear_endpoint()).

>=20
> This patch series needs a clear explanation of how the running
> vhost_scsi.ko instance is quiesced such that:
>=20
> 1. Requests in-flight to the remote target are completed before
>   migration handover.  (Fancier approaches to live migration are
>   possible but this patch series doesn't seem to implement them, so we
>   need at least this basic guarantee for correctness.)

=46rom what I understand, this is guaranteed by the code-path mentioned =
above.=20

> 2. No further I/O requests are submitted to the remote target after =
the
>   vm stops running.

This is true because the VM at this point is stopped and the =
vhost-backend was also stopped.
See QEMU=E2=80=99s vhost_scsi_set_status() -> vhost_scsi_stop() -> =
vhost_scsi_common_stop() -> vhost_dev_stop().

> 3. No further guest memory access takes place after the vm stops =
running.

As the vhost-backend is stopped at this point, there cannot be further =
guest memory accesses.

>=20
> These properties are critical for correct vhost live migration and I'm
> not confident yet based on this patch series.  Please review the code
> (including kernel vhost code) and include an explanation in code
> comments (if possible) or commit descriptions.

I agree and we can submit a v2 patch series with better comments =
describing the above.
But do you think there is something missing from the above description? =
I think it should cover all your points.

Thanks for the insightful review,
-Liran

>=20
> Thanks,
> Stefan


