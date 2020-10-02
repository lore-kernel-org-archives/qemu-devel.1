Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FE3C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D567206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Scaotr+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D567206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLQa-000805-IE
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kOLPn-0007Zy-4U
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kOLPl-0006Vy-Ba
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601646478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+2ResME6lZ6n86fO1xRsrDcdeHaTr9VKZeazux5P5E=;
 b=Scaotr+zEI4K6+QvvP8OIc80OcHWjtNQ6dzppXpY9RkwNT0eFfcwESbIwq71NOSt/DyqXd
 CKHvh2yOxK0ST6G0UH2BsmmHGFG2eJWzVlfPvIHIFXdhXrbOoyCDd/xtHAs6+KAIJXmQAb
 KysTV12zVz/rhkTmE1gykPH0gI9kfs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-_YVsT83EMsSZcj9io_TFMA-1; Fri, 02 Oct 2020 09:47:56 -0400
X-MC-Unique: _YVsT83EMsSZcj9io_TFMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F0F9427C4;
 Fri,  2 Oct 2020 13:47:55 +0000 (UTC)
Received: from localhost (ovpn-114-195.ams2.redhat.com [10.36.114.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0877778809;
 Fri,  2 Oct 2020 13:47:54 +0000 (UTC)
Date: Fri, 2 Oct 2020 14:47:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/2] block/export: add vhost-user-blk multi-queue support
Message-ID: <20201002134753.GC579943@stefanha-x1.localdomain>
References: <20201001144604.559733-1-stefanha@redhat.com>
 <20201001144604.559733-2-stefanha@redhat.com>
 <87tuvdry4o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87tuvdry4o.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 07:32:39AM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>=20
> > Allow the number of queues to be configured using --export
> > vhost-user-blk,num-queues=3DN. This setting should match the QEMU --dev=
ice
> > vhost-user-blk-pci,num-queues=3DN setting but QEMU vhost-user-blk.c low=
ers
> > its own value if the vhost-user-blk backend offers fewer queues than
> > QEMU.
> >
> > The vhost-user-blk-server.c code is already capable of multi-queue. All
> > virtqueue processing runs in the same AioContext. No new locking is
> > needed.
> >
> > Add the num-queues=3DN option and set the VIRTIO_BLK_F_MQ feature bit.
> > Note that the feature bit only announces the presence of the num_queues
> > configuration space field. It does not promise that there is more than =
1
> > virtqueue, so we can set it unconditionally.
> >
> > I tested multi-queue by running a random read fio test with numjobs=3D4=
 on
> > an -smp 4 guest. After the benchmark finished the guest /proc/interrupt=
s
> > file showed activity on all 4 virtio-blk MSI-X. The /sys/block/vda/mq/
> > directory shows that Linux blk-mq has 4 queues configured.
> >
> > An automated test is included in the next commit.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qapi/block-export.json               |  6 +++++-
> >  block/export/vhost-user-blk-server.c | 24 ++++++++++++++++++------
> >  2 files changed, 23 insertions(+), 7 deletions(-)
> >
> > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > index a793e34af9..17020de257 100644
> > --- a/qapi/block-export.json
> > +++ b/qapi/block-export.json
> > @@ -93,11 +93,15 @@
> >  #        SocketAddress types are supported. Passed fds must be UNIX do=
main
> >  #        sockets.
> >  # @logical-block-size: Logical block size in bytes. Defaults to 512 by=
tes.
> > +# @num-queues: Number of request virtqueues. Must be greater than 0. D=
efaults
> > +#              to 1.
> >  #
> >  # Since: 5.2
> >  ##
> >  { 'struct': 'BlockExportOptionsVhostUserBlk',
> > -  'data': { 'addr': 'SocketAddress', '*logical-block-size': 'size' } }
> > +  'data': { 'addr': 'SocketAddress',
> > +=09    '*logical-block-size': 'size',
>=20
> Tab damage.

Oops, thanks! I have updated my editor configuration to use 4-space
indents for .json files :).

> > +            '*num-queues': 'uint16'} }
>=20
> Out of curiosity: what made you pick 16 bit signed?  net.json uses both
> 32 and 64 bit signed.  Odd...

struct virtio_blk_config {
    __u16 num_queues;
}

Also, virtio-pci and virtio-ccw use 16-bit types for the queue count.

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl93L4kACgkQnKSrs4Gr
c8h4xggAgaeXRLwDpejl34j/F2yZKgTjk0SDM99OYJQHWWEu44M05GXv+JE50GAl
N0THTADXrGC2/92dD/fUK6boDW/ykg4GuVv2Jb2hAS+mBwXbAJOFRHQxTPKopgZH
cCIN5kxeLYbivxdOdaHHRNHS6pLtucL/iNsE2jLFfummGMat10DnyEDf6tT5cK1X
8vnBaj6AFQF8CD7uU5rfMzMXnaCCUNeCyMs16+DzN2p2jf1o51BVIedtQu3Xa0Ts
/MdHvi/h+lJk0HeTk4H96tigXR1ndyTc5sBGLIjHxvAptSZDE2ExG8fj4F3ZhKZP
X7gmQtTox/B7ALGGTZdWMNOfD+Rz6A==
=jRaj
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--


