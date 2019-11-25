Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C8CC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB82D20836
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPb6n+u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB82D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGLT-0002nG-PG
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iZGJk-0000vm-Qy
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iZGJi-0004YN-Rl
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:30:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iZGJi-0004XI-KW
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574695816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZbiYLayArMquGA5JBDU6i7utj9gksE3W3AxwNDmDq4=;
 b=hPb6n+u6PcDXjKyXuaGFLrwpp5uQZcnWPR8FQavvmuVCiz/aMbVLuX00cIyLANKcFhlHkh
 zgaPNEF1e0A9A8u3+wdEnkkp/FxVsR4vQW2P/4PfPihpHUj6aiy6ZHFudUBWRBTTr1PlXk
 vJF3ZOVBWfLh/pYKOp+D+ArIuS4g3yc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-X0Gl7k1nPcmyOk62aJJq7Q-1; Mon, 25 Nov 2019 10:30:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C0A9911E8;
 Mon, 25 Nov 2019 15:30:13 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99ECE75E2C;
 Mon, 25 Nov 2019 15:30:12 +0000 (UTC)
Date: Mon, 25 Nov 2019 12:30:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 1/2] qdev-properties-system: extend set_pionter for
 unrealized devices
Message-ID: <20191125153011.GL4438@habkost.net>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-2-dplotnikov@virtuozzo.com>
 <20191118185453.GC3812@habkost.net>
 <d5d3ac62-4f46-08d6-bf66-620e410fa954@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <d5d3ac62-4f46-08d6-bf66-620e410fa954@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: X0Gl7k1nPcmyOk62aJJq7Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 11:36:30AM +0000, Denis Plotnikov wrote:
>=20
>=20
> On 18.11.2019 21:54, Eduardo Habkost wrote:
> > On Sun, Nov 10, 2019 at 10:03:09PM +0300, Denis Plotnikov wrote:
> >> Some device's property can be changed if the device has been already
> >> realized. For example, it could be "drive" property of a scsi disk dev=
ice.
> >>
> >> So far, set_pointer could operate only on a relized device. The patch
> >> extends its interface for operation on an unrealized device.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >> ---
> >>   hw/core/qdev-properties-system.c | 32 +++++++++++++++++++++---------=
--
> >>   1 file changed, 21 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-propertie=
s-system.c
> >> index ba412dd2ca..c534590dcd 100644
> >> --- a/hw/core/qdev-properties-system.c
> >> +++ b/hw/core/qdev-properties-system.c
> >> @@ -38,9 +38,14 @@ static void get_pointer(Object *obj, Visitor *v, Pr=
operty *prop,
> >>   }
> >>  =20
> >>   static void set_pointer(Object *obj, Visitor *v, Property *prop,
> >> -                        void (*parse)(DeviceState *dev, const char *s=
tr,
> >> -                                      void **ptr, const char *propnam=
e,
> >> -                                      Error **errp),
> >> +                        void (*parse_realized)(DeviceState *dev,
> >> +                                               const char *str, void =
**ptr,
> >> +                                               const char *propname,
> >> +                                               Error **errp),
> >> +                        void (*parse_unrealized)(DeviceState *dev,
> >> +                                                 const char *str, voi=
d **ptr,
> >> +                                                 const char *propname=
,
> >> +                                                 Error **errp),
> >>                           const char *name, Error **errp)
> > Wouldn't it be simpler to just add a PropertyInfo::allow_set_after_real=
ize
> > bool field, and call the same setter function?  Then you can
> > simply change do_parse_drive() to check if realized is true.
> May be, but I thought It would be more clear to have a separate callback=
=20
> for all the devices supporting the property setting when realized.
> Also the "drive" property setting on realized and non-realized device a=
=20
> little bit different: in the realized case the setter function expects=20
> to get
> BlockDriverState only, when in the unrealized case the setter can accept=
=20
> both BlockBackend and BlockDriverState. Also, in the unrealized case the=
=20
> setter function doesn't expect to have a device with an empty BlockBacken=
d.
> I decided that extending do_parse_drive would make it more complex for=20
> understanding. That's why I made two separate functions for both cases.

I understand you might want two separate functions in the
specific case of drive.  You can still call different
functions after checking dev->realized inside do_parse_drive().

My point was that you don't need to make set_pointer() require
two separate function pointers just to propagate 1 bit of
information that is already available in DeviceState.  In patch
2/2 you had to create 4 different copies of parse_drive*()
because of this.


>=20
> I'd like to mention that I have a few concerns about=20
> do_parse_drive_realized (please see the next patch from the series) and=
=20
> I'd like them to be reviewed as well. After that, may be it would be=20
> better to go the way you suggested.

In the case if your questions in patch 2/2, I'm afraid I don't
know the answers and we need help from the block maintainers.

--=20
Eduardo


