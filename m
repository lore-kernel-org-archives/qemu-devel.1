Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54BFC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615CB2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qq6cJZgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615CB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3Kk-0006YA-H6
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iz3K1-0005w7-1t
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iz3Jy-0000Ul-NT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:53:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iz3Jy-0000Rx-J7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580842393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PvQUVGEpWZtnw5ZVuOyuLfl4ut8rV3zCC5kFU1P8938=;
 b=Qq6cJZgC9hCDauorol9WEIY25U4m6495bU/Xrckr2Wfeg9xYZ0hfukptww8axpYg4810iB
 yRoyrkN0O7YyEt7duw4WrvVnhy/7gkY2QnH8PTgFlQrPK0mS264Q4qO9IZ/RRRiHCEB6bX
 Dy5QZ5g4FyJyXc7vkVIjdMe8BcdqJu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-g1rKJgBMN8-V0gcfGtQbjQ-1; Tue, 04 Feb 2020 13:53:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78C871085925;
 Tue,  4 Feb 2020 18:53:08 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6C725D9E2;
 Tue,  4 Feb 2020 18:53:07 +0000 (UTC)
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <d5340381-8d5e-e8f9-2eb1-60bcfbb28186@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8574b42d-479e-ef72-ecab-4546b364adb6@redhat.com>
Date: Tue, 4 Feb 2020 12:53:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d5340381-8d5e-e8f9-2eb1-60bcfbb28186@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: g1rKJgBMN8-V0gcfGtQbjQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:32 AM, Max Reitz wrote:
> On 31.01.20 18:44, Eric Blake wrote:
>> Based-on: <20200124103458.1525982-2-david.edmondson@oracle.com>
>> ([PATCH v2 1/2] qemu-img: Add --target-is-zero to convert)
>>
>> I'm working on adding an NBD extension that reports whether an image
>> is already all zero when the client first connects.  I initially
>> thought I could write the NBD code to just call bdrv_has_zero_init(),
>> but that turned out to be a bad assumption that instead resulted in
>> this patch series.  The NBD patch will come later (and cross-posted to
>> the NBD protocol, libnbd, nbdkit, and qemu, as it will affect all four
>> repositories).
>=20
> We had a discussion about this on IRC, and as far as I remember I wasn=E2=
=80=99t
> quite sold on the =E2=80=9Cwhy=E2=80=9D.  So, again, I wonder why this is=
 needed.
>=20
> I mean, it does make intuitive sense to want to know whether an image is
> fully zero, but if I continue thinking about it I don=E2=80=99t know any =
case
> where we would need to figure it out and where we could accept =E2=80=9CW=
e don=E2=80=99t
> know=E2=80=9D as an answer.  So I=E2=80=99m looking for use cases, but th=
is cover letter
> doesn=E2=80=99t mention any.  (And from a quick glance I don=E2=80=99t se=
e this series
> using the flag, actually.)

Patch 10/17 has:

diff --git a/qemu-img.c b/qemu-img.c
index e60217e6c382..c8519a74f738 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1985,10 +1985,12 @@ static int convert_do_copy(ImgConvertState *s)
      int64_t sector_num =3D 0;

      /* Check whether we have zero initialisation or can get it=20
efficiently */
-    if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
-        !s->target_has_backing) {
-        s->has_zero_init =3D !!(bdrv_known_zeroes(blk_bs(s->target)) &
-                              BDRV_ZERO_CREATE);
+    if (!s->has_zero_init && s->min_sparse && !s->target_has_backing) {
+        ret =3D bdrv_known_zeroes(blk_bs(s->target));
+        if (ret & BDRV_ZERO_OPEN ||
+            (s->target_is_new && ret & BDRV_ZERO_CREATE)) {
+            s->has_zero_init =3D true;
+        }
      }

That's the use case: when copying into a destination file, it's useful=20
to know if the destination already reads as all zeroes, before=20
attempting a fallback to bdrv_make_zero(BDRV_REQ_NO_FALLBACK) or calls=20
to block status checking for holes.

>=20
> (We have a use case with convert -n to freshly created image files, but
> my position on this on IRC was that we want the --target-is-zero flag
> for that anyway: Auto-detection may always break, our preferred default
> behavior may always change, so if you want convert -n not to touch the
> target image except to write non-zero data from the source, we need a
> --target-is-zero flag and users need to use it.  Well, management
> layers, because I don=E2=80=99t think users would use convert -n anyway.
>=20
> And with --target-is-zero and users effectively having to use it, I
> don=E2=80=99t think that=E2=80=99s a good example of a use case.)

Yes, there will still be cases where you have to use --target-is-zero=20
because the image itself couldn't report that it already reads as=20
zeroes, but there are also enough cases where the destination is already=20
known to read zeroes and it's a shame to tell the user that 'you have to=20
add --target-is-zero to get faster copying even though we could have=20
inferred it on your behalf'.

>=20
> I suppose there is the point of blockdev-create + blockdev-mirror: This
> has exactly the same problem as convert -n.  But again, if you really
> want blockdev-mirror not just to force-zero the image, you probably need
> to tell it so explicitly (i.e., with a --target-is-zero flag for
> blockdev-mirror).
>=20
> (Well, I suppose we could save us a target-is-zero for mirror if we took
> this series and had a filter driver that force-reports BDRV_ZERO_OPEN.
> But, well, please no.)
>=20
> But maybe I=E2=80=99m just an idiot and there is no reason not to take th=
is
> series and make blockdev-create + blockdev-mirror do the sensible thing
> by default in most cases. *shrug*

My argument for taking the series _is_ that the common case can be made=20
more efficient without user effort.  Yes, we still need the knob for=20
when the common case isn't already smart enough, but the difference in=20
avoiding a pre-zeroing pass is noticeable when copying images around=20
(and more than just for qcow2 - my followup series to improve NBD is=20
similarly useful given how much work has already been invested in=20
mapping NBD into storage access over https in the upper layers like ovirt).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


