Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67753C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281FF20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BggxQBNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281FF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6YF-0006yy-61
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU6Wv-0005nO-O2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU6Wu-0005br-1K
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:34:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jU6Wt-0005bk-Iw
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588242894;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aezKVauiUB33eCn1QG7NpnGTzrOUwf3IA3Rp0Jxx93Q=;
 b=BggxQBNP67F8xl7SA7YURNjD0PeMDWot0NnVwkhjIFR9hUDBoxw3jot/4hjibs6fJ5YJPI
 TiXn5CZCapq7jlsjor+Ny0ugQMlyV1dnVkPw0KeJCHFbxwMLa6rQh1kpcXqC2MFFVfy+4a
 v6/um/vwWiS3SIxvxKlb9+z5QAObK7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-w7JcFPQ8OZ6XLgvEC2K5Hw-1; Thu, 30 Apr 2020 06:34:47 -0400
X-MC-Unique: w7JcFPQ8OZ6XLgvEC2K5Hw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D9931005510;
 Thu, 30 Apr 2020 10:34:46 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2D0D60BF4;
 Thu, 30 Apr 2020 10:34:40 +0000 (UTC)
Date: Thu, 30 Apr 2020 11:34:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Configuring onboard devices (was: Failing property setters +
 hardwired devices + -global = a bad day)
Message-ID: <20200430103437.GI2084570@redhat.com>
References: <87mu6uia5i.fsf@dusky.pond.sub.org>
 <20200429155719.GL1495129@redhat.com>
 <87k11xh2kq.fsf@dusky.pond.sub.org>
 <CAFEAcA9-oxkMD-kJ1z12d4K1S_Jaz7Wj6_38Ah7ChSaBfQNkkA@mail.gmail.com>
 <87tv11e1en.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87tv11e1en.fsf_-_@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 12:03:12PM +0200, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On Thu, 30 Apr 2020 at 08:09, Markus Armbruster <armbru@redhat.com> wro=
te:
> >> Our means to configure onboard devices are weak.  We sidestepped this
> >> for isa-fdc by taking it off the board, and thus make -device work.
> >
> > This seems to be a general dynamic: the x86 pc machine works
> > via -device options (or is changed so it can work that way);
> > and then people propose dropping/deprecating/etc the config
> > options that work with onboard devices, without providing
> > clear solutions/instructions on how the command line needs
> > to change/etc for the mass of boards which are not the x86
> > pc machine and which do have a lot of onboard devices which
> > can't be handled via -device.
> >
> > So my gut reaction to the "we should deprecate -global"
> > suggestions in this thread was a bit "here we go again"...
> > What works for x86 or even "what is sufficient for libvirt"
> > doesn't necessarily cover all the cases.
>=20
> Such shortsighted proposals have been made, but don't think it's what
> we're doing here.
>=20
> You're 100% right in that we do need to configure onboard devices.
> -global is a terrible way to do it, though: it applies to *all* devices
> of a kind.  What if the board has more than one?  What if the can add
> more?


> Any better ideas for letting users configure onboard devices?

All the devices in QEMU form a tree, as reported by "info qtree".
So, IIUC, the challenge is to provide a way to uniquely identify
any node in the tree.

Devices configured by the user/mgmt app will have an "id" property
but most built-in devices will not have any "id". In addition even
user configured devices may create multiple sub-nodes in the tree
without "id" parameters.

Uniquely referencing nodes in a tee is a solved problem though,
even without "id" parameters. The XPath query languages shows
this for XML.

-global defines a query language based on the object type, and
property name which is insufficiently flexible

-set defines a query language based on the object type and ID
value and property name(s) which is again insufficiently flexible.


We "merely" need a new query language targetted to QEMU's qtree
structure, which we can expose in the CLI that gives unique access
to every possible property.

Here is the truncated 'info qtree' for a running guest of mine:

bus: main-system-bus
  type System
  dev: kvm-ioapic, id ""
    gpio-in "" 24
    gsi_base =3D 0 (0x0)
    mmio 00000000fec00000/0000000000001000
  dev: i440FX-pcihost, id ""
    pci-hole64-size =3D 2147483648 (2 GiB)
    short_root_bus =3D 0 (0x0)
    x-pci-hole64-fix =3D false
    bus: pci.0
      type PCI
      dev: virtio-balloon-pci, id "balloon0"
        disable-legacy =3D "off"
        disable-modern =3D true
        class =3D 255 (0xff)
        virtio-pci-bus-master-bug-migration =3D false
        migrate-extra =3D false
        modern-pio-notify =3D false
        x-disable-pcie =3D true
        page-per-vq =3D true
        x-ignore-backend-features =3D true
        ats =3D false
        x-pcie-deverr-init =3D false
        x-pcie-lnkctl-init =3D false
        x-pcie-pm-init =3D false
        addr =3D 08.0
        romfile =3D ""
        rombar =3D 1 (0x1)
        multifunction =3D false
        command_serr_enable =3D true
        x-pcie-lnksta-dllla =3D true
        x-pcie-extcap-init =3D false
        class Class 00ff, addr 00:08.0, pci id 1af4:1002 (sub 1af4:0005)
        bar 0: i/o at 0xc100 [0xc11f]
        bus: virtio-bus
          type virtio-pci-bus
          dev: virtio-balloon-device, id ""
            deflate-on-oom =3D false
            free-page-hint =3D false
            qemu-4-0-config-size =3D false
            iothread =3D ""
            indirect_desc =3D true
            event_idx =3D true
            notify_on_empty =3D true
            any_layout =3D true
            iommu_platform =3D false
            use-started =3D false


Consider the problem is to set the "deflate-on-oom" property on
the balloon device.

To uniquely identify this we can have a string:

 /dev[1]/bus[pci/0]/dev[id=3Dballoon0]/bus[virtio-bus]/dev[0]/deflate-on-oo=
m=3Dtrue

If we consider that "id" values are unique, we can allow a simplication
by omitting everything before that part of the match - "//" could indicate
an omitted part like XPath allows, so we'd get

 //dev[id=3Dballoon0]/bus[virtio-bus]/dev[0]/deflate-on-oom=3Dtrue

There's only one bus, and one dev on that bus, so knowing this we can
simplify a bit more and still be a unique query, to get this:

 //dev[id=3Dballoon0]/bus/dev/deflate-on-oom=3Dtrue

Or even allow use of "//" in the middle too:

 //dev[id=3Dballoon0]//deflate-on-oom=3Dtrue

Which conceptually says

   "find the device with id balloon0 and set the property 'deflate-on-oom'
   on the first child node in the qtree that hsa such a property name"

I didn't say this would be pretty, and of course no one would seriously
use this syntax for the virtio-balloon device, as you'd just set the
property with -device. It should work for the many built-in devices
though.

Now just provide a new CLI arg

 $QEMU -qtree //dev[id=3Dballoon0]//deflate-on-oom=3Dtrue

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


