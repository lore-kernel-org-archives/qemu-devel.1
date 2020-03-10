Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2074CC18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C9A20674
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCiErY3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C9A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60415 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBePL-0003ES-78
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBeOU-0002nr-86
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBeOS-0000iX-Gi
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:53:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59914
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBeOS-0000e6-5z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583844835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ur0BoRMxbPbOiTFBR5345OMILTdPYKQ2fCf+jly9Jwk=;
 b=bCiErY3qQjrWpTcqBh3dK7eUbhBD3cL6iIejJ7avI93Esh6SEdNVCABLucaAfTDXNvIQyY
 3dgdmCKwrs1gTZUToucOhboXxAn1c5EesfCXCMFIZB0lZmS5vf23sfaBHhcgbupa1mS42Y
 PaP56LufO15EtZhEVL5gGSTlCS+cZFs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-qmYWTkJ5NY-VU7jMXvgRWg-1; Tue, 10 Mar 2020 08:53:53 -0400
X-MC-Unique: qmYWTkJ5NY-VU7jMXvgRWg-1
Received: by mail-qt1-f199.google.com with SMTP id k20so9029985qtm.11
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MPSUgjKUKIpncu4u/o4N26CFuFLYY1NmtWxe6gLBqRk=;
 b=V4p9OvkKZkTsMbe7nW01CGtf94F5s4Ln1cwbHLHP5xZsb5z5JLit/H7trfb67nbfTH
 xm0bOB30yHSc/EXOx/rGujKkgs7lullOU1YvLiz6SbfV0gZREl+wHUFC5KmH4nWwLKhM
 hlyEtUugz2d0TTbZF/8hPrKbhq49KvZrjOmW4D2ykw6bnmGw904QBt4uOpuicbgty+mQ
 /Ca840EFxvEq3WjmXGaGLihIgK8B0uwfRx2xkpgUnZ3HI7Jm4yw0YVRYjOKnJT0/KrTQ
 jO6+MQfIH3oKMKOMppSmJF1g83FT2jh5fYuVF9Q0QhkKD/KpUhlhkk6LTPHpL237TVbA
 4VZA==
X-Gm-Message-State: ANhLgQ2wuTWsRE774CDszsfMmV5VbhaEFnT8UEqksYcF4F7Kl50t8kgx
 JNm/mUFQB2WIEgfqEZuNEImo208oBfQwIiZf9WTt3WFnEsC7zbmCFpz5y4aDto+HllK4sNkV1C7
 IPz3ZdC8LnoooLYs=
X-Received: by 2002:a05:620a:2085:: with SMTP id
 e5mr19210642qka.492.1583844832984; 
 Tue, 10 Mar 2020 05:53:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvTdRIfkKALKmFz6naqmzIXqBqfmvuR/Adb6ZXI9mZex/lMLkJqTfSA3SNLS6/4Dksj+gbQ0g==
X-Received: by 2002:a05:620a:2085:: with SMTP id
 e5mr19210631qka.492.1583844832642; 
 Tue, 10 Mar 2020 05:53:52 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id j11sm22872394qtc.91.2020.03.10.05.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 05:53:51 -0700 (PDT)
Date: Tue, 10 Mar 2020 08:53:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310084758-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
MIME-Version: 1.0
In-Reply-To: <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 02:43:51PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 14:35, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 02:25:28PM +0200, Liran Alon wrote:
> > > On 10/03/2020 14:14, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
> > > > > As can be seen from VmCheck_GetVersion() in open-vm-tools code,
> > > > > CMD_GETVERSION should return VMX type in ECX register.
> > > > >=20
> > > > > Default is to fake host as VMware ESX server. But user can contro=
l
> > > > > this value by "-global vmport.vmx-type=3DX".
> > > > >=20
> > > > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > > ---
> > > > >    hw/i386/vmport.c | 13 +++++++++++++
> > > > >    1 file changed, 13 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
> > > > > index a2c8ff4b59cf..c03f57f2f636 100644
> > > > > --- a/hw/i386/vmport.c
> > > > > +++ b/hw/i386/vmport.c
> > > > > @@ -36,6 +36,15 @@
> > > > >    #define VMPORT_ENTRIES 0x2c
> > > > >    #define VMPORT_MAGIC   0x564D5868
> > > > > +typedef enum {
> > > > > +   VMX_TYPE_UNSET =3D 0,
> > > > > +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware Expre=
ss */
> > > > > +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
> > > > > +   VMX_TYPE_WGS,        /* Deprecated type used for VMware Serve=
r */
> > > > > +   VMX_TYPE_WORKSTATION,
> > > > > +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for A=
CE 1.x */
> > > > > +} VMX_Type;
> > > > > +
> > > > Is this really VMX type? And do users care what it is?
> > > This enum is copied from open-vm-tools source code
> > > (lib/include/vm_version.h). This is how it's called in VMware Tools
> > > terminology... Don't blame me :)
> > I don't even want to go look at it to check license compatibility, but
> > IMHO that's just another reason to avoid copying it.
> > Copying bad code isn't a good idea unless needed for
> > compatibility.
> Preserving original VMware terminology makes sense and is preferred in my
> opinion. I think diverging from it is more confusing.

Yea tell it to people who got in hot water because they copied
some variable names to avoid confusion. Oh wait.

This is not an official terminology I think.
So please just make it make sense by itself, and make it
easy to research.

> >=20
> >=20
> > > > Also, how about friendlier string values so people don't need to
> > > > figure out code numbers?
> > > I could have defined a new PropertyInfo struct in hw/core/qdev-proper=
ties.c
> > > for this enum and then define a proper macro in qdev-properties.h.
> > > But it seems like an overkill for a value that is suppose to rarely b=
e
> > > changed. So I thought this should suffice for now for user-experience
> > > perspective.
> > > If you think otherwise, I can do what I just suggested above.
> > >=20
> > > -Liran
> > I think that's better, and this allows you to use official
> > product names that people can relate to.
> Ok. Will do...
> >=20
> > Alternatively just drop this enum completely.  As far as you are
> > concerned it's just a number VM executable gives together with the
> > version, right?  We don't even need the enum, just set it to 2 and add =
a
> > code comment saying it's esx server.
> I could do the latter alternative but why? It just hides information
> original patch author (myself) know about where this value comes from.
> I don't see a reason to hide information from future code maintainers.
> Similar to defining all flags of a given flag-field even if we use only a
> subset of it.
>=20
> -Liran

That belongs in a code comment. Removes need to follow silly names from
unrelated and possibly incompatible license.  By comparison dead code is
dead code.  But sure, if you want to code up user friendly names, that's
ok too. But do follow official names then please, not something lifted
from some piece of code.

--=20
MST


