Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A50C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78876206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/vCZftZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78876206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSZk-000597-Kb
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37162 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQSXU-0002xp-UI
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:16:29 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jQSXT-0003Uu-S2
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:16:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jQSXT-0003Tf-FH
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587374185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lY4wfyut/JU5mmYNCKYykJOXyxR2SNS+80HzUksSqKE=;
 b=e/vCZftZfZpnSIS1KE16nMpltgHhhTCin2lKIN0nXSOjsvnHmDWBQJ3b1Yi+3Qs+9IzrZZ
 3q8bOwqOOknduYZibCQmwrExlo6ltlP7kC31lFWOK2crGJxyjmifpR/ZaoEnVOLiX98BLE
 +XLU65vuFd6aG8NqknKiUuWmHhPfoRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-e94MS30ZMIGPfWnMen3tPw-1; Mon, 20 Apr 2020 05:16:24 -0400
X-MC-Unique: e94MS30ZMIGPfWnMen3tPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137EB800D5C;
 Mon, 20 Apr 2020 09:16:23 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCEDD60C80;
 Mon, 20 Apr 2020 09:16:21 +0000 (UTC)
Message-ID: <0a3b05c0bad124550f3f3bdde0eb224a6b9a7744.camel@redhat.com>
Subject: Re: [PATCH 1/1] block/crypto: better error message when creating
 too large files
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 20 Apr 2020 12:16:20 +0300
In-Reply-To: <20200420090253.GA6237@linux.fritz.box>
References: <20200416095019.4406-1-mlevitsk@redhat.com>
 <20200416095019.4406-2-mlevitsk@redhat.com>
 <20200420090253.GA6237@linux.fritz.box>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-04-20 at 11:02 +0200, Kevin Wolf wrote:
> Am 16.04.2020 um 11:50 hat Maxim Levitsky geschrieben:
> > Currently if you attampt to create too large file with luks you
> > get the following error message:
> >=20
> > Formatting 'test.luks', fmt=3Dluks size=3D17592186044416 key-secret=3Ds=
ec0
> > qemu-img: test.luks: Could not resize file: File too large
> >=20
> > While for raw format the error message is
> > qemu-img: test.img: The image size is too large for file format 'raw'
> >=20
> >=20
> > The reason for this is that qemu-img checks for errno of the failure,
> > and presents the later error when it is -EFBIG
> >=20
> > However crypto generic code 'swallows' the errno and replaces it
> > with -EIO.
> >=20
> > As an attempt to make it better, we can make luks driver,
> > detect -EFBIG and in this case present a better error message,
> > which is what this patch does
> >=20
> > The new error message is:
> >=20
> > qemu-img: error creating test.luks: The requested file size is too larg=
e
> >=20
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534898
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  block/crypto.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index d577f89659..1b604beb30 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -104,18 +104,35 @@ static ssize_t block_crypto_init_func(QCryptoBloc=
k *block,
> >                                        Error **errp)
> >  {
> >      struct BlockCryptoCreateData *data =3D opaque;
> > +    Error *local_error =3D NULL;
> > +    int ret;
> > =20
> >      if (data->size > INT64_MAX || headerlen > INT64_MAX - data->size) =
{
> > -        error_setg(errp, "The requested file size is too large");
> > -        return -EFBIG;
> > +        ret =3D -EFBIG;
> > +        goto error;
> >      }
> > =20
> >      /* User provided size should reflect amount of space made
> >       * available to the guest, so we must take account of that
> >       * which will be used by the crypto header
> >       */
> > -    return blk_truncate(data->blk, data->size + headerlen, false,
> > +    ret =3D blk_truncate(data->blk, data->size + headerlen, false,
> >                          data->prealloc, errp);
>=20
> I think you intended to use &local_error (which is by the way spelt
> local_err in most other places) here instead of passing errp and never
> assigning local_err at all.

Absolutely. This is very old patch that I used to keep with the LUKs patchs=
et,
and I remember I rebased it few times. I probably didn't fix a conflict cor=
rectly or so.

Best regards,
=09Maxim Levitsky

>=20
> Kevin
>=20
> > +
> > +    if (ret >=3D 0) {
> > +        return ret;
> > +    }
> > +
> > +error:
> > +    if (ret =3D=3D -EFBIG) {
> > +        /* Replace the error message with a better one */
> > +        error_free(local_error);
> > +        error_setg(errp, "The requested file size is too large");
> > +    } else {
> > +        error_propagate(errp, local_error);
> > +    }
> > +
> > +    return ret;
> >  }
> > =20
> > =20
> > --=20
> > 2.17.2
> >=20



