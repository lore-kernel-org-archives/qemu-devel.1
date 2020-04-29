Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5B8C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2604C2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYVfk7zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2604C2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTpXD-00018U-BY
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 12:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jTpVI-0000BE-2X
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jTpV6-0005wy-RM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:24:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jTpV6-0005wP-B0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588177434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdeJ/LjBqcmMwgqLADqGPpDwIC7T029oFGE9YHRS4J0=;
 b=CYVfk7zwsWsLJI/b3/D7X/E0hs8dDMEzi8j2uP2O0YCBmQiOa2/eKj5h3/nx8UXasVjlNC
 w8ciOM2OdzNcJmzaX/NZsX2aRcKxJLx/lc1y+1DO0zMDXqHQy95dcFjHfnnu5wjXmn2ELw
 gu+TKHbCNnn+n2sFA5wB58l7GHVuEys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-ZDhRyw6UPkWcbW04JUNIsQ-1; Wed, 29 Apr 2020 12:23:52 -0400
X-MC-Unique: ZDhRyw6UPkWcbW04JUNIsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8269C835B40;
 Wed, 29 Apr 2020 16:23:51 +0000 (UTC)
Received: from localhost (ovpn-115-79.phx2.redhat.com [10.3.115.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5999A60FB9;
 Wed, 29 Apr 2020 16:23:48 +0000 (UTC)
Date: Wed, 29 Apr 2020 12:23:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Failing property setters + hardwired devices + -global = a bad day
Message-ID: <20200429162347.GI5244@habkost.net>
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <1915d102-9528-9c31-8a8c-a84f7842fbe9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1915d102-9528-9c31-8a8c-a84f7842fbe9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 05:39:20PM +0200, Paolo Bonzini wrote:
> On 29/04/20 17:28, Markus Armbruster wrote:
> > When an object gets created, its memory is zeroed, and then any class
> > properties with an ->init() are initialized with
> >=20
> >     obj->init(obj, prop);
> >=20
> > We have just one ->init():
> >=20
> >     void object_property_init_defval(Object *obj, ObjectProperty *prop)
> >=20
> > It initializes from ->defval using ->set().
> >=20
> > Aside: feels overengineered, but let's move on.
> >=20
> > For TYPE_DEVICE objects, "static" properties get initialized the same.
> >=20
> > Aside: if I know what "static" means, I'll be hanged.
>=20
> Originally these were the only properties that were part of the class
> rather than the object (so, not dynamic --> static).
>=20
> > I'd love to deprecate -global wholesale, but we can't as long as we
> > don't have better means to configure onboard devices.  Can we deprecate
> > its use with backend properties at least?
>=20
> I wouldn't mind deprecating -global wholesale, leaving the global/compat
> props code only for internal usage.

I would absolutely love to get rid of -global, but we need to
provide an alternative for users that rely on it.

libvirt, for example, has at least 15 virCommandAddArg*(...,
"-global", ...) calls in src/qemu/qemu_command.c:

src/qemu/qemu_command.c:2344:                virCommandAddArg(cmd, "-global=
");
src/qemu/qemu_command.c-2345-                virCommandAddArgFormat(cmd, "i=
sa-fdc.%s", backendStr);
src/qemu/qemu_command.c-2346-            }
src/qemu/qemu_command.c-2347-
src/qemu/qemu_command.c-2348-            if (bootindexStr) {
src/qemu/qemu_command.c:2349:                virCommandAddArg(cmd, "-global=
");
src/qemu/qemu_command.c-2350-                virCommandAddArgFormat(cmd, "i=
sa-fdc.%s", bootindexStr);
src/qemu/qemu_command.c-2351-            }
src/qemu/qemu_command.c-2352-        } else {
src/qemu/qemu_command.c-2353-            virBufferStrcat(&fdc_opts, backend=
Str, ",", NULL);
--
src/qemu/qemu_command.c:4174:    virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-4175-    optstr =3D qemuBuildNVRAMDevStr(def->nvram=
);
src/qemu/qemu_command.c-4176-    if (!optstr)
src/qemu/qemu_command.c-4177-        return -1;
src/qemu/qemu_command.c-4178-
--
src/qemu/qemu_command.c:4568:     * --global option and for that we need to=
 specify the device
src/qemu/qemu_command.c-4569-     * name the same as for --device option an=
d for that we need to
src/qemu/qemu_command.c-4570-     * use 'qemuDeviceVideo'.
src/qemu/qemu_command.c-4571-     *
src/qemu/qemu_command.c-4572-     * See 'Graphics Devices' section in docs/=
qdev-device-use.txt in
--
src/qemu/qemu_command.c:4586:            virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-4587-            virCommandAddArgFormat(cmd, "%s.ra=
m_size=3D%u",
src/qemu/qemu_command.c-4588-                                   dev, ram * =
1024);
src/qemu/qemu_command.c-4589-        }
src/qemu/qemu_command.c-4590-        if (vram) {
src/qemu/qemu_command.c:4591:            virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-4592-            virCommandAddArgFormat(cmd, "%s.vr=
am_size=3D%u",
src/qemu/qemu_command.c-4593-                                   dev, vram *=
 1024);
src/qemu/qemu_command.c-4594-        }
src/qemu/qemu_command.c-4595-        if (vram64 &&
--
src/qemu/qemu_command.c:4597:            virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-4598-            virCommandAddArgFormat(cmd, "%s.vr=
am64_size_mb=3D%u",
src/qemu/qemu_command.c-4599-                                   dev, vram64=
 / 1024);
src/qemu/qemu_command.c-4600-        }
src/qemu/qemu_command.c-4601-        if (vgamem &&
--
src/qemu/qemu_command.c:4603:            virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-4604-            virCommandAddArgFormat(cmd, "%s.vg=
amem_mb=3D%u",
src/qemu/qemu_command.c-4605-                                   dev, vgamem=
 / 1024);
src/qemu/qemu_command.c-4606-        }
src/qemu/qemu_command.c-4607-        if (heads &&
--
src/qemu/qemu_command.c:4609:            virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-4610-            virCommandAddArgFormat(cmd, "%s.ma=
x_outputs=3D%u",
src/qemu/qemu_command.c-4611-                                   dev, heads)=
;
src/qemu/qemu_command.c-4612-        }
src/qemu/qemu_command.c-4613-    }
--
src/qemu/qemu_command.c:4622:        virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-4623-        virCommandAddArgFormat(cmd, "%s.vgamem=
_mb=3D%u",
src/qemu/qemu_command.c-4624-                               dev, vram / 102=
4);
src/qemu/qemu_command.c-4625-    }
src/qemu/qemu_command.c-4626-
--
src/qemu/qemu_command.c:6278:                    virCommandAddArgList(cmd, =
"-global",
src/qemu/qemu_command.c-6279-                                         "kvm-=
pit.lost_tick_policy=3Ddelay", NULL);
src/qemu/qemu_command.c-6280-                break;
src/qemu/qemu_command.c-6281-            case VIR_DOMAIN_TIMER_TICKPOLICY_C=
ATCHUP:
src/qemu/qemu_command.c-6282-                /* Do nothing - qemuDomainDefV=
alidateClockTimers handled
--
src/qemu/qemu_command.c:6287:                    virCommandAddArgList(cmd, =
"-global",
src/qemu/qemu_command.c-6288-                                         "kvm-=
pit.lost_tick_policy=3Ddiscard", NULL);
src/qemu/qemu_command.c-6289-                break;
src/qemu/qemu_command.c-6290-            case VIR_DOMAIN_TIMER_TICKPOLICY_M=
ERGE:
src/qemu/qemu_command.c-6291-                /* no way to support this mode=
 for pit in qemu */
--
src/qemu/qemu_command.c:6346:        virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-6347-        virCommandAddArgFormat(cmd, "%s.disabl=
e_s3=3D%d",
src/qemu/qemu_command.c-6348-                               pm_object, def-=
>pm.s3 =3D=3D VIR_TRISTATE_BOOL_NO);
src/qemu/qemu_command.c-6349-    }
src/qemu/qemu_command.c-6350-
--
src/qemu/qemu_command.c:6358:        virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-6359-        virCommandAddArgFormat(cmd, "%s.disabl=
e_s4=3D%d",
src/qemu/qemu_command.c-6360-                               pm_object, def-=
>pm.s4 =3D=3D VIR_TRISTATE_BOOL_NO);
src/qemu/qemu_command.c-6361-    }
src/qemu/qemu_command.c-6362-
--
src/qemu/qemu_command.c:6508:            virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-6509-            virCommandAddArgFormat(cmd, "%s.pc=
i-hole64-size=3D%luK", hoststr,
src/qemu/qemu_command.c-6510-                                   cont->opts.=
pciopts.pcihole64size);
src/qemu/qemu_command.c-6511-        }
src/qemu/qemu_command.c-6512-    }
--
src/qemu/qemu_command.c:7191:    virCommandAddArg(cmd, "-global");
src/qemu/qemu_command.c-7192-
src/qemu/qemu_command.c-7193-    /* PostParse callback guarantees that the =
size is divisible by 1 MiB */
src/qemu/qemu_command.c-7194-    virCommandAddArgFormat(cmd, "mch.extended-=
tseg-mbytes=3D%llu",
src/qemu/qemu_command.c-7195-                           def->tseg_size >> 2=
0);
--
src/qemu/qemu_command.c:9109:                             "-global",
src/qemu/qemu_command.c-9110-                             "driver=3Dcfi.pfl=
ash01,property=3Dsecure,value=3Don",
src/qemu/qemu_command.c-9111-                             NULL);
src/qemu/qemu_command.c-9112-    }
src/qemu/qemu_command.c-9113-

--=20
Eduardo


