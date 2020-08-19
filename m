Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA2BC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E0B2067C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZUWEluE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E0B2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8J2O-0003Jy-30
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8J1V-0002rt-3N
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:00:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58376
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8J1R-0006sO-R4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597824034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fVRyIK6Wc5Kn2X6ij0hhSVkeLp1CoK6bxQVW77SIXJI=;
 b=HZUWEluEjT82f+lPl2pj5xA/kPvIIDGPc/lKoPoeOJ5xeIw2IPMSQl75q6cy64rWR08FTg
 GTiOLCiq21+P28dTsm2FMyMXjQlAGWTzbbKvA0K0tIcmkhrj4hF87xUTQZYEwet0QcWKRl
 IBxBnHseoO6DPTJEtOp1STYnjuVFz+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-kxBlyihEM-OKtCq2-lZsxg-1; Wed, 19 Aug 2020 04:00:32 -0400
X-MC-Unique: kxBlyihEM-OKtCq2-lZsxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1501640C0;
 Wed, 19 Aug 2020 08:00:30 +0000 (UTC)
Received: from localhost (ovpn-114-41.ams2.redhat.com [10.36.114.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58336101E247;
 Wed, 19 Aug 2020 08:00:03 +0000 (UTC)
Date: Wed, 19 Aug 2020 09:00:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v8 17/20] multi-process: heartbeat messages to remote
Message-ID: <20200819080001.GA334045@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
 <93b7566e5d565b9e5d8127849bb5be65057e25cc.1596217462.git.jag.raman@oracle.com>
 <20200811144130.GC18223@stefanha-x1.localdomain>
 <20200814230147.GA177362@heatpipe>
MIME-Version: 1.0
In-Reply-To: <20200814230147.GA177362@heatpipe>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:00:34
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, felipe@nutanix.com,
 thuth@redhat.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 dgilbert@redhat.com, alex.williamson@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 04:01:47PM -0700, Elena Ufimtseva wrote:
> On Tue, Aug 11, 2020 at 03:41:30PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Jul 31, 2020 at 02:20:24PM -0400, Jagannathan Raman wrote:
> > > @@ -343,3 +349,49 @@ static void probe_pci_info(PCIDevice *dev, Error=
 **errp)
> > >          }
> > >      }
> > >  }
> > > +
> > > +static void hb_msg(PCIProxyDev *dev)
> > > +{
> > > +    DeviceState *ds =3D DEVICE(dev);
> > > +    Error *local_err =3D NULL;
> > > +    MPQemuMsg msg =3D { 0 };
> > > +
> > > +    msg.cmd =3D PROXY_PING;
> > > +    msg.bytestream =3D 0;
> > > +    msg.size =3D 0;
> > > +
> > > +    (void)mpqemu_msg_send_and_await_reply(&msg, dev->ioc, &local_err=
);
> > > +    if (local_err) {
> > > +        error_report_err(local_err);
> > > +        qio_channel_close(dev->ioc, &local_err);
> > > +        error_setg(&error_fatal, "Lost contact with device %s", ds->=
id);
> > > +    }
> > > +}
> >=20
> > Here is my feedback from the last revision. Was this addressed?
> >
>=20
> Hi Stefan,
>=20
> Thank you for reviewing the patchset. In this version we decided to=20
> shutdown the guest when the heartbeat did not get a reply from the
> remote by setting the error_fatal.
> Should we approach it differently or you prefer us to get rid of the
> heartbeat in this form?

I think the only case that this patch handles is when the mpqemu channel
is closed.

The VM hangs when the channel is still open but the remote is
unresponsive. (mpqemu_msg_send_and_await_reply() calls aio_poll() with
the global mutex held so vcpus cannot make progress.)

The heartbeat mechanism needs to handle the case where the other side
isn't responding. It can't hang QEMU.

I suggest dropping this patch. It can be done later.

Stefan

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl883AEACgkQnKSrs4Gr
c8j6zAgAwVEo1sk/SMZFufOa0bLBWNplceo+tuBq0E9IXWpuIdwXFHm/TrLF6yBQ
ElLuT3DQTkYMRpvCkPc2D4+5op4MSRLpcdJACwTSxuxVIPEILufHoSZnb8+CdKBx
aSct0Rcn3fKPMwoFATow1SgxiAuZ/p8t/CK69FjdiXZpqU1Cx1tYhtYjkRSLLRsU
UxcRjdA7/XG4lmW0u9Z7zpaL6AXyZx+hXE6Fwlgl3nsGhvc1Dqsi459x0+6fvqMv
i3WTaSI3gpxOHZXy4zv5NaP3BtI98lwk/R87xr7m+WUeRu4Ayv3zPP2mX33/Yitv
39pOMFKV2pZuH69mofpAuI3FxlxBiw==
=MtD/
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--


