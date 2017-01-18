Received: from eggs.gnu.org ([2001:4830:134:3::10]:54992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTdhh-0004JT-VJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 19:02:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cTdhe-0002JF-UB
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 19:02:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cTdhe-0002IY-Oo
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 19:02:14 -0500
Date: Wed, 18 Jan 2017 08:02:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170118000208.GA31883@lemon.Home>
References: <20170116160730.4696-1-famz@redhat.com>
	<20170116160730.4696-3-famz@redhat.com>
	<20170117105405.GE4265@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170117105405.GE4265@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-scsi: Implement fc_host feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 01/17 10:54, Stefan Hajnoczi wrote:
> On Tue, Jan 17, 2017 at 12:07:30AM +0800, Fam Zheng wrote:
> >  static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
> >  {
> >      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> >      VirtIOSCSI *s = VIRTIO_SCSI(dev);
> > +    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
> >      Error *err = NULL;
> >  
> > +    if (vs->conf.fc_host) {
> > +        if (!strcmp(vs->conf.fc_host, "off")) {
> > +            vs->conf.primary_wwpn = 0;
> > +            vs->conf.primary_wwnn = 0;
> > +            vs->conf.secondary_wwpn = 0;
> > +            vs->conf.secondary_wwnn = 0;
> > +        } else if (!strcmp(vs->conf.fc_host, "primary") ||
> > +                   !strcmp(vs->conf.fc_host, "secondary")) {
> > +            virtio_add_feature(&vdev->host_features, VIRTIO_SCSI_F_FC_HOST);
> > +            vs->conf.primary_active = !strcmp(vs->conf.fc_host, "primary");
> > +            if (!vs->conf.primary_wwpn) {
> > +                error_setg(errp, "fc_host enabled but primary_wwpn not set");
> > +                return;
> > +            }
> > +            if (!vs->conf.primary_wwnn) {
> > +                error_setg(errp, "fc_host enabled but primary_wwnn not set");
> > +                return;
> > +            }
> > +            if (!vs->conf.secondary_wwpn) {
> > +                error_setg(errp, "fc_host enabled but secondary_wwpn not set");
> > +                return;
> > +            }
> > +            if (!vs->conf.secondary_wwnn) {
> > +                error_setg(errp, "fc_host enabled but secondary_wwnn not set");
> > +                return;
> > +            }
> > +            s->vm_state_change =
> > +                qemu_add_vm_change_state_handler(virtio_scsi_vm_state_change, s);
> 
> Missing qemu_del_vm_change_state_handler() in .unrealize() and in error
> code paths in this function.

Will fix it. Thanks!

Fam
