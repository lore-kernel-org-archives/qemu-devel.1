Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A8CC4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17F0206DB
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 08:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17F0206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOd4z-0004rH-GQ
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 04:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kOd4K-0004SY-3n
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:39:04 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:52575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kOd4H-0002dK-GN
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 04:39:03 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.76])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4BA3C6197B53;
 Sat,  3 Oct 2020 10:38:50 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sat, 3 Oct 2020
 10:38:49 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005e6880fe4-ca63-4cea-b120-8e938ba0c296,
 3345FDB4B62F999A850A9D5BF875A94D2EA020F3) smtp.auth=groug@kaod.org
Date: Sat, 3 Oct 2020 10:38:48 +0200
From: Greg Kurz <groug@kaod.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/2] vhost: Don't call log_access_ok() when using IOTLB
Message-ID: <20201003103848.766c7442@bahia.lan>
In-Reply-To: <d9dae1ed-49a4-909a-6840-ae46a4ffdffc@redhat.com>
References: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
 <160139704424.162128.7839027287942194310.stgit@bahia.lan>
 <d9dae1ed-49a4-909a-6840-ae46a4ffdffc@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 7085d870-f704-48ed-abc4-e9fdc74ba25a
X-Ovh-Tracer-Id: 4078572412553632108
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrfeekgddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 04:38:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, netdev@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>, virtualization@lists.linux-foundation.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 3 Oct 2020 09:58:59 +0800
Jason Wang <jasowang@redhat.com> wrote:

>=20
> On 2020/9/30 =E4=B8=8A=E5=8D=8812:30, Greg Kurz wrote:
> > When the IOTLB device is enabled, the log_guest_addr that is passed by
> > userspace to the VHOST_SET_VRING_ADDR ioctl, and which is then written
> > to vq->log_addr, is a GIOVA. All writes to this address are translated
> > by log_user() to writes to an HVA, and then ultimately logged through
> > the corresponding GPAs in log_write_hva(). No logging will ever occur
> > with vq->log_addr in this case. It is thus wrong to pass vq->log_addr
> > and log_guest_addr to log_access_vq() which assumes they are actual
> > GPAs.
> >
> > Introduce a new vq_log_used_access_ok() helper that only checks accesses
> > to the log for the used structure when there isn't an IOTLB device arou=
nd.
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   drivers/vhost/vhost.c |   23 +++++++++++++++++++----
> >   1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index c3b49975dc28..5996e32fa818 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1370,6 +1370,20 @@ bool vhost_log_access_ok(struct vhost_dev *dev)
> >   }
> >   EXPORT_SYMBOL_GPL(vhost_log_access_ok);
> >  =20
> > +static bool vq_log_used_access_ok(struct vhost_virtqueue *vq,
> > +				  void __user *log_base,
> > +				  bool log_used,
> > +				  u64 log_addr,
> > +				  size_t log_size)
> > +{
> > +	/* If an IOTLB device is present, log_addr is a GIOVA that
> > +	 * will never be logged by log_used(). */
> > +	if (vq->iotlb)
> > +		return true;
> > +
> > +	return !log_used || log_access_ok(log_base, log_addr, log_size);
> > +}
> > +
> >   /* Verify access for write logging. */
> >   /* Caller should have vq mutex and device mutex */
> >   static bool vq_log_access_ok(struct vhost_virtqueue *vq,
> > @@ -1377,8 +1391,8 @@ static bool vq_log_access_ok(struct vhost_virtque=
ue *vq,
> >   {
> >   	return vq_memory_access_ok(log_base, vq->umem,
> >   				   vhost_has_feature(vq, VHOST_F_LOG_ALL)) &&
> > -		(!vq->log_used || log_access_ok(log_base, vq->log_addr,
> > -				  vhost_get_used_size(vq, vq->num)));
> > +		vq_log_used_access_ok(vq, log_base, vq->log_used, vq->log_addr,
> > +				      vhost_get_used_size(vq, vq->num));
> >   }
> >  =20
> >   /* Can we start vq? */
> > @@ -1517,8 +1531,9 @@ static long vhost_vring_set_addr(struct vhost_dev=
 *d,
> >   			return -EINVAL;
> >  =20
> >   		/* Also validate log access for used ring if enabled. */
> > -		if ((a.flags & (0x1 << VHOST_VRING_F_LOG)) &&
> > -			!log_access_ok(vq->log_base, a.log_guest_addr,
> > +		if (!vq_log_used_access_ok(vq, vq->log_base,
> > +				a.flags & (0x1 << VHOST_VRING_F_LOG),
> > +				a.log_guest_addr,
> >   				sizeof *vq->used +
> >   				vq->num * sizeof *vq->used->ring))
>=20
>=20
> It looks to me that we should use vhost_get_used_size() which takes=20
> event into account.
>=20
> Any reason that we can't reuse vq_log_access_ok() here?
>=20

No reason indeed but I'll fix this in a preliminary patch, and
send a v2 shortly.

Cheers,

--
Greg

> Thanks
>=20
>=20
> >   			return -EINVAL;
> >
> >
>=20


