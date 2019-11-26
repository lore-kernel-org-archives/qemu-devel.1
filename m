Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C263C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F0A20835
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 16:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPC3jGDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F0A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZdt0-0002ym-CT
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 11:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZdrT-0001ZY-5e
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZdrQ-00033j-Sa
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:38:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51479
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZdrQ-00032m-KY
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 11:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574786323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bpcFjaJy0GHnHGJ21ToQBme4sQQ6ll8UvKdZv3KXfPA=;
 b=EPC3jGDnG2+8Hz+E1g12eZKLbtKE0KqWLPcMEUMKU56IQ5iqxp/n8Ep0T3z2Mtfq+eaVi6
 mdK+vj6k8DqRRa0eoAEWytzV0q85nMSDF77kQf8yK+ZhQAph8fJEuFUnkeM0kUoH/ghoUB
 WG0qx8IydqnqJ0qktsFawVrT1RIYQ58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-sU7WPv9iOvizIDiEjBhuzg-1; Tue, 26 Nov 2019 11:38:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B749D18B5F7F;
 Tue, 26 Nov 2019 16:38:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-171.ams2.redhat.com [10.36.117.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5D7666834;
 Tue, 26 Nov 2019 16:38:31 +0000 (UTC)
Date: Tue, 26 Nov 2019 17:38:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v0 1/2] qdev-properties-system: extend set_pionter for
 unrealized devices
Message-ID: <20191126163830.GD5889@linux.fritz.box>
References: <20191110190310.19799-1-dplotnikov@virtuozzo.com>
 <20191110190310.19799-2-dplotnikov@virtuozzo.com>
 <20191118185453.GC3812@habkost.net>
 <d5d3ac62-4f46-08d6-bf66-620e410fa954@virtuozzo.com>
 <20191125153011.GL4438@habkost.net>
 <e960b6a2-071a-781d-ba3f-18b315a538bd@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <e960b6a2-071a-781d-ba3f-18b315a538bd@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: sU7WPv9iOvizIDiEjBhuzg-1
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 26.11.2019 um 07:49 hat Denis Plotnikov geschrieben:
>=20
>=20
> On 25.11.2019 18:30, Eduardo Habkost wrote:
> > On Fri, Nov 22, 2019 at 11:36:30AM +0000, Denis Plotnikov wrote:
> >>
> >> On 18.11.2019 21:54, Eduardo Habkost wrote:
> >>> On Sun, Nov 10, 2019 at 10:03:09PM +0300, Denis Plotnikov wrote:
> >>>> Some device's property can be changed if the device has been already
> >>>> realized. For example, it could be "drive" property of a scsi disk d=
evice.
> >>>>
> >>>> So far, set_pointer could operate only on a relized device. The patc=
h
> >>>> extends its interface for operation on an unrealized device.
> >>>>
> >>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >>>> ---
> >>>>    hw/core/qdev-properties-system.c | 32 +++++++++++++++++++++------=
-----
> >>>>    1 file changed, 21 insertions(+), 11 deletions(-)
> >>>>
> >>>> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-propert=
ies-system.c
> >>>> index ba412dd2ca..c534590dcd 100644
> >>>> --- a/hw/core/qdev-properties-system.c
> >>>> +++ b/hw/core/qdev-properties-system.c
> >>>> @@ -38,9 +38,14 @@ static void get_pointer(Object *obj, Visitor *v, =
Property *prop,
> >>>>    }
> >>>>   =20
> >>>>    static void set_pointer(Object *obj, Visitor *v, Property *prop,
> >>>> -                        void (*parse)(DeviceState *dev, const char =
*str,
> >>>> -                                      void **ptr, const char *propn=
ame,
> >>>> -                                      Error **errp),
> >>>> +                        void (*parse_realized)(DeviceState *dev,
> >>>> +                                               const char *str, voi=
d **ptr,
> >>>> +                                               const char *propname=
,
> >>>> +                                               Error **errp),
> >>>> +                        void (*parse_unrealized)(DeviceState *dev,
> >>>> +                                                 const char *str, v=
oid **ptr,
> >>>> +                                                 const char *propna=
me,
> >>>> +                                                 Error **errp),
> >>>>                            const char *name, Error **errp)
> >>> Wouldn't it be simpler to just add a PropertyInfo::allow_set_after_re=
alize
> >>> bool field, and call the same setter function?  Then you can
> >>> simply change do_parse_drive() to check if realized is true.
> >> May be, but I thought It would be more clear to have a separate callba=
ck
> >> for all the devices supporting the property setting when realized.
> >> Also the "drive" property setting on realized and non-realized device =
a
> >> little bit different: in the realized case the setter function expects
> >> to get
> >> BlockDriverState only, when in the unrealized case the setter can acce=
pt
> >> both BlockBackend and BlockDriverState. Also, in the unrealized case t=
he
> >> setter function doesn't expect to have a device with an empty BlockBac=
kend.
> >> I decided that extending do_parse_drive would make it more complex for
> >> understanding. That's why I made two separate functions for both cases=
.
> > I understand you might want two separate functions in the
> > specific case of drive.  You can still call different
> > functions after checking dev->realized inside do_parse_drive().
> >
> > My point was that you don't need to make set_pointer() require
> > two separate function pointers just to propagate 1 bit of
> > information that is already available in DeviceState.  In patch
> > 2/2 you had to create 4 different copies of parse_drive*()
> > because of this.
> Yes, that's true. I wanted to suggest a more general way to deal with a=
=20
> device on realized and non-realized state.
> I may be too much and not necessary. May be we should wait for a=20
> feedback from the block maintainers?

I think I agree with Eduardo on this one. This is generic infrastructure
and we already see that it may require lots of wrapper functions that
call into the same function with different parameters. Checking
dev->realized where necessary can do the same.

I haven't had a closer look at the specific functions, but maybe
they can actually share the same implementation with just some
if (dev->realized) blocks.

Kevin


