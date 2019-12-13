Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EB2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA57A206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJbxm+y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA57A206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifiGm-0007WO-QV
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ifiFl-0006YH-0t
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ifiFj-0006uZ-7n
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:32:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ifiFj-0006tC-2w
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576233172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOCdB0c5fzlCQanjy/QmP8Z47wn6/FFZG+nzGiu2M9I=;
 b=IJbxm+y+UX5qi4BLrDxuLsgLlWu3eF1HNL08PBhP/d2nrIOsNgLstoaKiK8nUx1VA7mQU1
 Kz/+KK0yFGYbWBXizikJq7aZN/1iA6UbJfdVmVfqdHAyzWkKhyx1f5Imx3lCdL5n7oQpvS
 YgGYImUIgUdUh1HC551MIQoLg01nWgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-_vNYTWwmOdGtyCA1vPcUSw-1; Fri, 13 Dec 2019 05:32:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41AD6800D54;
 Fri, 13 Dec 2019 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-153.ams2.redhat.com
 [10.36.117.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC4176764A;
 Fri, 13 Dec 2019 10:32:47 +0000 (UTC)
Date: Fri, 13 Dec 2019 11:32:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 2/2] block: allow to set 'drive' property on a
 realized block device
Message-ID: <20191213103246.GB3428@localhost.localdomain>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-3-dplotnikov@virtuozzo.com>
 <c19343f9-73b2-89a4-2b7d-b101a0b20016@virtuozzo.com>
 <c38c1301-a28f-baf1-d441-ae8c7205feb1@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <c38c1301-a28f-baf1-d441-ae8c7205feb1@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _vNYTWwmOdGtyCA1vPcUSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.11.2019 um 11:50 hat Denis Plotnikov geschrieben:
>=20
>=20
> On 10.11.2019 22:08, Denis Plotnikov wrote:
> >
> > On 10.11.2019 22:03, Denis Plotnikov wrote:
> >> This allows to change (replace) the file on a block device and is usef=
ul
> >> to workaround exclusive file access restrictions, e.g. to implement VM
> >> migration with a shared disk stored on some storage with the exclusive
> >> file opening model: a destination VM is started waiting for incomming
> >> migration with a fake image drive, and later, on the last migration
> >> phase, the fake image file is replaced with the real one.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >> ---
> >> =A0 hw/core/qdev-properties-system.c | 89 +++++++++++++++++++++++++++-=
----
> >> =A0 1 file changed, 77 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/hw/core/qdev-properties-system.c=20
> >> b/hw/core/qdev-properties-system.c
> >> index c534590dcd..aaab1370a4 100644
> >> --- a/hw/core/qdev-properties-system.c
> >> +++ b/hw/core/qdev-properties-system.c
> >> @@ -79,8 +79,55 @@ static void set_pointer(Object *obj, Visitor *v,=20
> >> Property *prop,
> >> =A0 =A0 /* --- drive --- */
> >> =A0 -static void do_parse_drive(DeviceState *dev, const char *str, voi=
d=20
> >> **ptr,
> >> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 const char *propname, bool iothread,=20
> >> Error **errp)
> >> +static void do_parse_drive_realized(DeviceState *dev, const char *str=
,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 void **ptr, const char *propname,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool iothread, Error **errp)
> >> +{
> >> +=A0=A0=A0 BlockBackend *blk =3D *ptr;
> >> +=A0=A0=A0 BlockDriverState *bs =3D bdrv_lookup_bs(NULL, str, NULL);
> >> +=A0=A0=A0 int ret;
> >> +=A0=A0=A0 bool blk_created =3D false;
> >> +
> >> +=A0=A0=A0 if (!bs) {
> >> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "Can't find blockdev '%s'", st=
r);
> >> +=A0=A0=A0=A0=A0=A0=A0 return;
> >> +=A0=A0=A0 }
> >> +
> >> +=A0=A0=A0 if (!blk) {
> >> +=A0=A0=A0=A0=A0=A0=A0 AioContext *ctx =3D iothread ? bdrv_get_aio_con=
text(bs) :
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_get_aio_context();
> >> +=A0=A0=A0=A0=A0=A0=A0 blk =3D blk_new(ctx, BLK_PERM_ALL, BLK_PERM_ALL=
);
> >> +=A0=A0=A0=A0=A0=A0=A0 blk_created =3D true;
> >
> > Actually, I have concerns about situation where blk=3Dnull.
> >
> > Is there any case when scsi-hd (or others) doesn't have a blk assigned=
=20
> > and it's legal?

No, block devices will always have a BlockBackend, even if it doesn't
have a root node inserted.

> >> +=A0=A0=A0 } else {
> >> +=A0=A0=A0=A0=A0=A0=A0 if (blk_bs(blk)) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_remove_bs(blk);
> >> +=A0=A0=A0=A0=A0=A0=A0 }
> >> +=A0=A0=A0 }
> >> +
> >> +=A0=A0=A0 ret =3D blk_insert_bs(blk, bs, errp);
> >> +
> >> +=A0=A0=A0 if (!ret && blk_created) {
> >> +=A0=A0=A0=A0=A0=A0=A0 if (blk_attach_dev(blk, dev) < 0) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Shouldn't be any errors here s=
ince we just created
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the new blk because the device=
 doesn't have any.
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Leave the message here in case=
 blk_attach_dev is changed
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "Can't attach d=
rive '%s' to device '%s'",
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 str, object_get_typename(OBJECT(dev)));
> >> +=A0=A0=A0=A0=A0=A0=A0 } else {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *ptr =3D blk;
> >> +=A0=A0=A0=A0=A0=A0=A0 }
> >> +=A0=A0=A0 }
> Another problem here, is that the "size" of the device dev may not match=
=20
> after setting a drive.
> So, we should update it after the drive setting.
> It was found, that it could be done by calling=20
> BlockDevOps.bdrv_parent_cb_resize.
>=20
> But I have some concerns about doing it so. In the case of virtio scsi=20
> disk we have the following callstack
>=20
>  =A0=A0=A0 bdrv_parent_cb_resize calls() ->
>  =A0 =A0=A0=A0=A0=A0 scsi_device_report_change(dev, SENSE_CODE(CAPACITY_C=
HANGED)) ->
>  =A0 =A0 =A0 =A0 =A0 =A0 virtio_scsi_change ->
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 virtio_scsi_push_event(s, =
dev, VIRTIO_SCSI_T_PARAM_CHANGE,
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sense.asc |=20
> (sense.ascq << 8));

I think the safest option for now (and which should solve the case you
want to address) is checking whether old and new size match and
returning an error otherwise.

> virtio_scsi_change=A0 pushes the event to the guest to make the guest
> ask for size refreshing.  If I'm not mistaken, here we can get a race
> condition when some another request is processed with an unchanged
> size and then the size changing request is processed.

I think this is actually a problem even without resizing: We need to
quiesce the device between removing the old root and inserting the new
one. They way to achieve this is probably by splitting blk_drain() into
a blk_drain_begin()/end() and then draining the BlockBackend here while
we're working on it.

Kevin


