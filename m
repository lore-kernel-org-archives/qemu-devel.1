Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC03C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936BA20872
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkfTRyEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936BA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXExb-0003P8-IN
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 22:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kXEwl-0002qg-IW
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 22:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kXEwi-000802-HC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 22:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603766567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ny3axIesh+GLct4INx2y8Lq+lQfYyk+KEop+3QmOLFc=;
 b=YkfTRyEZcW6WS5sAZ1hKCTkEn+zutnJGNcPtDj5zBJfjcXBPdgTZz3VUd5mq7Qf1VNELkb
 C5uUHIYqKopQQ9gKMZVyieGbkyGanino+AuLxkyw1SpjENcff6/iSJ/RDCR6ez670jQuxP
 1ue6M4wAB5bQRNluq9QNaR0p4WbHpJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-Bmfwocj4MxiL7i8nPt6D2Q-1; Mon, 26 Oct 2020 22:42:45 -0400
X-MC-Unique: Bmfwocj4MxiL7i8nPt6D2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFBD45703C;
 Tue, 27 Oct 2020 02:42:43 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E60DE1992F;
 Tue, 27 Oct 2020 02:42:43 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9AD2E44A4A;
 Tue, 27 Oct 2020 02:42:43 +0000 (UTC)
Date: Mon, 26 Oct 2020 22:42:22 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Message-ID: <386403458.23348433.1603766542675.JavaMail.zimbra@redhat.com>
In-Reply-To: <CACLfguVsAtAe_KrKFH2wH+w62BbLahtRXU6nV53jFODPF6XxXw@mail.gmail.com>
References: <20201023091559.4858-1-lulu@redhat.com>
 <462e6df3-8a34-9cfb-0696-49481aba4d46@redhat.com>
 <1bd85488-7186-d869-9bc2-2536d23c1e78@redhat.com>
 <CACLfguVsAtAe_KrKFH2wH+w62BbLahtRXU6nV53jFODPF6XxXw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-net: Add check for mac address while peer is
 vdpa
MIME-Version: 1.0
X-Originating-IP: [10.68.5.20, 10.4.195.27]
Thread-Topic: virtio-net: Add check for mac address while peer is vdpa
Thread-Index: xkIQgxmAofuCrjQQOsrioumh42QVjA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 22:42:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Michael Tsirkin <mst@redhat.com>, qemu-stable@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> Hi jason
>=20
>=20
> On Mon, Oct 26, 2020 at 11:20 AM Jason Wang <jasowang@redhat.com> wrote:
>=20
> >
> > On 2020/10/26 =E4=B8=8A=E5=8D=8810:43, Jason Wang wrote:
> > >
> > > On 2020/10/23 =E4=B8=8B=E5=8D=885:15, Cindy Lu wrote:
> > >> Sometime vdpa get an all 0 mac address from the hardware, this will
> > >> cause the traffic down
> > >> So we add the check for this part.
> > >> if we get an 0 mac address we will use the default mac address inste=
ad
> > >>
> > >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >> ---
> > >>   hw/net/virtio-net.c | 7 ++++++-
> > >>   1 file changed, 6 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > >> index 9179013ac4..f1648fc47d 100644
> > >> --- a/hw/net/virtio-net.c
> > >> +++ b/hw/net/virtio-net.c
> > >> @@ -126,6 +126,7 @@ static void virtio_net_get_config(VirtIODevice
> > >> *vdev, uint8_t *config)
> > >>       VirtIONet *n =3D VIRTIO_NET(vdev);
> > >>       struct virtio_net_config netcfg;
> > >>       NetClientState *nc =3D qemu_get_queue(n->nic);
> > >> +    static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
> > >>         int ret =3D 0;
> > >>       memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> > >> @@ -151,7 +152,11 @@ static void virtio_net_get_config(VirtIODevice
> > >> *vdev, uint8_t *config)
> > >>           ret =3D vhost_net_get_config(get_vhost_net(nc->peer),
> > >> (uint8_t *)&netcfg,
> > >>                                      n->config_size);
> > >>           if (ret !=3D -1) {
> > >> -            memcpy(config, &netcfg, n->config_size);
> > >> +            if (memcmp(&netcfg.mac, &zero, sizeof(zero)) !=3D 0) {
> > >> +                memcpy(config, &netcfg, n->config_size);
> > >> +        } else {
> > >> +                error_report("Get an all zero mac address from
> > >> hardware");
> > >> +            }
> > >>           }
> > >>       }
> > >>   }
> > >
> > >
> > > Applied.
> > >
> > > Thanks
> > >
> > >
> >
> > Speak too fast. Some questions:
> >
> > 1) Any reason that you do such check or get_config() instead of doing i=
t
> > once in device initalization
> >
> get_config()  was called before the device realized.

Intersting, any reason that we need call get_config() even before
device is realized?

> If we check in the
> device initalization, the mac address is already overwritten to 0 and
> we lost the default mac address
> Also for my understanding. the mac address read from hardware should neve=
r
> been 0, so we need to check it every time we got it,

This sounds self-contradict.

> Just in case it will
> change to 0 and overwrite the mac address while the qemu running or some
> other case

This looks like a bug in the device or driver.

Even if this is true, you can only detect it via get_config(). And I
don't think we need to workaround a buggy device.

Thanks

>=20
> > 2) the indentation looks wrong
> >
> sure will fix this
>=20
> > 3) There's no need for an error here since we can workaround it
>=20
> sure, I will change it to log
>=20
> >
> >
>=20
>=20
> > Thanks
> >
> >
>=20


