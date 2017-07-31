Received: from eggs.gnu.org ([2001:4830:134:3::10]:44436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dcDj8-0001Xb-AE
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dcDj5-00015H-Kv
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:39:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dcDj5-00013G-BS
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 12:39:27 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6VGdInb019729
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 12:39:24 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c256w2d4m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 12:39:23 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 31 Jul 2017 10:39:23 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170731175139.5d569df6@bahia.lan>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1501119055-4060-3-git-send-email-mdroth@linux.vnet.ibm.com>
	<20170731175139.5d569df6@bahia.lan>
Date: Mon, 31 Jul 2017 11:39:13 -0500
Message-Id: <150151915325.13537.10448083238606290383@loki>
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/3] Revert "qdev: Free QemuOpts
 when the QOM path goes away"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, armbru@redhat.com

Quoting Greg Kurz (2017-07-31 10:51:39)
> On Wed, 26 Jul 2017 20:30:54 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> =

> > This reverts commit abed886ec60cf239a03515cf0b30fb11fa964c44.
> > =

> > This patch originally addressed an issue where a DEVICE_DELETED
> > event could be emitted (in device_unparent()) before a Device's
> > QemuOpts were cleaned up (in device_finalize()), leading to a
> > "duplicate ID" error if management attempted to immediately add
> > a device with the same ID in response to the DEVICE_DELETED event.
> > =

> > An alternative will be implemented in a subsequent patch where we
> > defer the DEVICE_DELETED event until device_finalize(), which would
> > also prevent the race, so we revert the original fix in preparation.
> > =

> =

> Do you really need to revert abed886ec60cf239a03515cf0b30fb11fa964c44 ?
> =

> IIUC, the purpose of this series is to fix/workaround the VFIO cleanup is=
sue.
> Even if it also relates to when we emit DEVICE_DELETED, it isn't exactly =
the
> same problem here, is it ?

That's true, but since the implementation of the VFIO fix requires
moving qemu_opts_del() to back to finalize(), and since that
effectively reverts the change made in abed88, I figured it was
better to revert the patch directly as opposed as a side-effect
of patch 3.

> =

> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> >  hw/core/qdev.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > =

> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index a64b35c..08c4061 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -1067,6 +1067,7 @@ static void device_finalize(Object *obj)
> >      NamedGPIOList *ngl, *next;
> >  =

> >      DeviceState *dev =3D DEVICE(obj);
> > +    qemu_opts_del(dev->opts);
> >  =

> >      QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
> >          QLIST_REMOVE(ngl, node);
> > @@ -1116,9 +1117,6 @@ static void device_unparent(Object *obj)
> >          g_free(dev->canonical_path);
> >          dev->canonical_path =3D NULL;
> >      }
> > -
> > -    qemu_opts_del(dev->opts);
> > -    dev->opts =3D NULL;
> >  }
> >  =

> >  static void device_class_init(ObjectClass *class, void *data)
>=20
