Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E38EC433F7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B30E20838
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YTU2c7nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B30E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzyiV-0006d1-Jv
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 04:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzyhs-0006BZ-Aw
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:42:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jzyhq-0006Gl-CK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595839317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b+LSf5nm5L/1miKDsrnYsMGuPjFFyPqJ6bR2S/AH87s=;
 b=YTU2c7nfOzPpK4vXMmvq/k641KmjGtvvlT8iiTCEUpyFfTehuTNQTh1/8V6+n/yut8s2+O
 YzqG4dwoIVFGGW1OiIDC7y7Zj5625FMLDv+8cxXuK2THDYLnJ9V1o+la5UV08OiH1jkIjw
 KhPVS7fuuvaVxPQzzoxryc/6eyL6xLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-KR1mewgOO7GN8oXbhcTNbg-1; Mon, 27 Jul 2020 04:41:55 -0400
X-MC-Unique: KR1mewgOO7GN8oXbhcTNbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34F99102CC41;
 Mon, 27 Jul 2020 08:41:52 +0000 (UTC)
Received: from gondolin (ovpn-112-210.ams2.redhat.com [10.36.112.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D031A69324;
 Mon, 27 Jul 2020 08:41:50 +0000 (UTC)
Date: Mon, 27 Jul 2020 10:41:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [BUG] vhost-vdpa: qemu-system-s390x crashes with second
 virtio-net-ccw device
Message-ID: <20200727104148.4ae49715.cohuck@redhat.com>
In-Reply-To: <676ce079-adf6-a279-c2ea-68f43146e2ac@redhat.com>
References: <20200724152718.4e1cbc9e.cohuck@redhat.com>
 <20200724092906-mutt-send-email-mst@kernel.org>
 <20200724165627.70c6dfd6.cohuck@redhat.com>
 <20200724111512-mutt-send-email-mst@kernel.org>
 <20200724173448.18773aec.cohuck@redhat.com>
 <5a0dfa0b-5a1d-e7d2-1785-8cca6ddb9db8@redhat.com>
 <20200727084310.7d29ec6d.cohuck@redhat.com>
 <676ce079-adf6-a279-c2ea-68f43146e2ac@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 15:38:12 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2020/7/27 =E4=B8=8B=E5=8D=882:43, Cornelia Huck wrote:
> > On Sat, 25 Jul 2020 08:40:07 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> > =20
> >> On 2020/7/24 =E4=B8=8B=E5=8D=8811:34, Cornelia Huck wrote: =20
> >>> On Fri, 24 Jul 2020 11:17:57 -0400
> >>> "Michael S. Tsirkin"<mst@redhat.com>  wrote:
> >>>    =20
> >>>> On Fri, Jul 24, 2020 at 04:56:27PM +0200, Cornelia Huck wrote: =20
> >>>>> On Fri, 24 Jul 2020 09:30:58 -0400
> >>>>> "Michael S. Tsirkin"<mst@redhat.com>  wrote:
> >>>>>        =20
> >>>>>> On Fri, Jul 24, 2020 at 03:27:18PM +0200, Cornelia Huck wrote: =20
> >>>>>>> When I start qemu with a second virtio-net-ccw device (i.e. addin=
g
> >>>>>>> -device virtio-net-ccw in addition to the autogenerated device), =
I get
> >>>>>>> a segfault. gdb points to
> >>>>>>>
> >>>>>>> #0  0x000055d6ab52681d in virtio_net_get_config (vdev=3D<optimize=
d out>,
> >>>>>>>       config=3D0x55d6ad9e3f80 "RT") at /home/cohuck/git/qemu/hw/n=
et/virtio-net.c:146
> >>>>>>> 146=09    if (nc->peer->info->type =3D=3D NET_CLIENT_DRIVER_VHOST=
_VDPA) {
> >>>>>>>
> >>>>>>> (backtrace doesn't go further) =20
> >>>>> The core was incomplete, but running under gdb directly shows that =
it
> >>>>> is just a bog-standard config space access (first for that device).
> >>>>>
> >>>>> The cause of the crash is that nc->peer is not set... no idea how t=
hat
> >>>>> can happen, not that familiar with that part of QEMU. (Should the c=
ode
> >>>>> check, or is that really something that should not happen?)
> >>>>>
> >>>>> What I don't understand is why it is set correctly for the first,
> >>>>> autogenerated virtio-net-ccw device, but not for the second one, an=
d
> >>>>> why virtio-net-pci doesn't show these problems. The only difference
> >>>>> between -ccw and -pci that comes to my mind here is that config spa=
ce
> >>>>> accesses for ccw are done via an asynchronous operation, so timing
> >>>>> might be different. =20
> >>>> Hopefully Jason has an idea. Could you post a full command line
> >>>> please? Do you need a working guest to trigger this? Does this trigg=
er
> >>>> on an x86 host? =20
> >>> Yes, it does trigger with tcg-on-x86 as well. I've been using
> >>>
> >>> s390x-softmmu/qemu-system-s390x -M s390-ccw-virtio,accel=3Dtcg -cpu q=
emu,zpci=3Don
> >>> -m 1024 -nographic -device virtio-scsi-ccw,id=3Dscsi0,devno=3Dfe.0.00=
01
> >>> -drive file=3D/path/to/image,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi=
0-0-0-0
> >>> -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=
=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D1
> >>> -device virtio-net-ccw
> >>>
> >>> It seems it needs the guest actually doing something with the nics; I
> >>> cannot reproduce the crash if I use the old advent calendar moon bugg=
y
> >>> image and just add a virtio-net-ccw device.
> >>>
> >>> (I don't think it's a problem with my local build, as I see the probl=
em
> >>> both on my laptop and on an LPAR.) =20
> >>
> >> It looks to me we forget the check the existence of peer.
> >>
> >> Please try the attached patch to see if it works. =20
> > Thanks, that patch gets my guest up and running again. So, FWIW,
> >
> > Tested-by: Cornelia Huck <cohuck@redhat.com>
> >
> > Any idea why this did not hit with virtio-net-pci (or the autogenerated
> > virtio-net-ccw device)? =20
>=20
>=20
> It can be hit with virtio-net-pci as well (just start without peer).

Hm, I had not been able to reproduce the crash with a 'naked' -device
virtio-net-pci. But checking seems to be the right idea anyway.

>=20
> For autogenerated virtio-net-cww, I think the reason is that it has=20
> already had a peer set.

Ok, that might well be.


