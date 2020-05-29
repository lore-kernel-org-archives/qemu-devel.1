Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B600CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7390E20810
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwuH/b00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7390E20810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZmw-0001GH-N9
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jeZlv-0008K5-1Y
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:49:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jeZlt-0006DA-Dp
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590738579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wW7P0B3R+4+rKqLNnMTBvWv2xgElyFTH5UY5U0oxHWc=;
 b=hwuH/b00f1/etqrhz1GX73xpl3f4k3enTitmvpcbGpuQrf0EL+ZSMol5yGX5Ie8u4xYs5r
 wOwsYCTpR3k6mKH75V5FiEvn2Miezd1FtANtLdcCwCJH0x4BfkmVj9BGAlbEk6m+D1Bhvc
 Yr8l5fLl91M+wZteuNAW8OGLNnfAzf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-qkF7PkzBO3-C_vPRp2n2Vw-1; Fri, 29 May 2020 03:49:37 -0400
X-MC-Unique: qkF7PkzBO3-C_vPRp2n2Vw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB2431800D42;
 Fri, 29 May 2020 07:49:35 +0000 (UTC)
Received: from localhost (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82D1B5D9D5;
 Fri, 29 May 2020 07:49:32 +0000 (UTC)
Date: Fri, 29 May 2020 09:49:31 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/7] block/nvme: poll queues without q->lock
Message-ID: <20200529074858.6kxtojzbg4ysqadf@dritchie>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-2-stefanha@redhat.com>
 <20200525080713.7kvgnlzvdbhfbowt@dritchie>
 <20200528152350.GI158218@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200528152350.GI158218@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ro22s6zoffsym3xr"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ro22s6zoffsym3xr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2020 at 04:23:50PM +0100, Stefan Hajnoczi wrote:
> On Mon, May 25, 2020 at 10:07:13AM +0200, Sergio Lopez wrote:
> > On Tue, May 19, 2020 at 06:11:32PM +0100, Stefan Hajnoczi wrote:
> > > A lot of CPU time is spent simply locking/unlocking q->lock during
> > > polling. Check for completion outside the lock to make q->lock disappear
> > > from the profile.
> > >
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  block/nvme.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/block/nvme.c b/block/nvme.c
> > > index eb2f54dd9d..7eb4512666 100644
> > > --- a/block/nvme.c
> > > +++ b/block/nvme.c
> > > @@ -512,6 +512,18 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
> > >
> > >      for (i = 0; i < s->nr_queues; i++) {
> > >          NVMeQueuePair *q = s->queues[i];
> > > +        const size_t cqe_offset = q->cq.head * NVME_CQ_ENTRY_BYTES;
> > > +        NvmeCqe *cqe = (NvmeCqe *)&q->cq.queue[cqe_offset];
> > > +
> > > +        /*
> > > +         * q->lock isn't needed for checking completion because
> > > +         * nvme_process_completion() only runs in the event loop thread and
> > > +         * cannot race with itself.
> > > +         */
> > > +        if ((le16_to_cpu(cqe->status) & 0x1) == q->cq_phase) {
> > > +            continue;
> > > +        }
> > > +
> >
> > IIUC, this is introducing an early check of the phase bit to determine
> > if there is something new in the queue.
> >
> > I'm fine with this optimization, but I have the feeling that the
> > comment doesn't properly describe it.
>
> I'm not sure I understand. The comment explains why it's safe not to
> take q->lock. Normally it would be taken. Without the comment readers
> could be confused why we ignore the locking rules here.
>
> As for documenting the cqe->status expression itself, I didn't think of
> explaining it since it's part of the theory of operation of this device.
> Any polling driver will do this, there's nothing QEMU-specific or
> unusual going on here.
>
> Would you like me to expand the comment explaining that NVMe polling
> consists of checking the phase bit of the latest cqe to check for
> readiness?
>
> Or maybe I misunderstood? :)

I was thinking of something like "Do an early check for
completions. We don't need q->lock here because
nvme_process_completion() only runs (...)"

Sergio.

--ro22s6zoffsym3xr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7QvooACgkQ9GknjS8M
AjUTcxAAjtaXbijSfZoQn7SXdi+3nUX0sLoY+SfNWsbLcyUZ9JEw0QXSk0rWb+30
N2ojfYkysCEreFoLamfaS9/JWA0J01Ehxpsjh6OIk02ifKYVLLlRkvG/I7ELi7BH
M7qrwC+qX9Z6QvkyvoFAUGJ70nW/XFETS2hDamp2RKvgJosU3Zbzlih2JiPi8vuo
SFj4jrvvoRwvQYcSctqjd6XPRSnC8YI7mwo0l4ap1Q0oUb9oTu7GFov3AgtbNXC+
B1STUAA/6+MH57Y7DAtx9uMThcQUpavKorGlubhXJGY+dJh9FyN2RYr4D7qhYC2T
TQye/CoA7UD02kEuH3r1VSOb7vJ0DaP4/sRlLKGcH4RPs2viSbTNYdijWyJQ0SHW
rk2gGE8wRWARqmkZglkGw483pJSnUdUNE8YaLi9aqYSL3JwCcqaoUgCCEtkFHPVD
IC1kOoxWHhYPdgnYCQrQ9cWXWKtKA915OnfkLahzDELuQfLd5tixUTB5YUlsiRVq
rR+aE70kmegCr636qrPLm1UuId4APecujxP5Qct2I+sjydPBAAtHlDOwc11+4g5u
o15W8uEL5ZqmHbKqclK8VUeELXVzghzI1UP3HuFM178e3izinTZupVYqjMRPpO0D
So7NyCyOuMYMMr6qkfDQk1hM6bfJjubqr9Oft1ELsfZgwtvR/M4=
=bfWz
-----END PGP SIGNATURE-----

--ro22s6zoffsym3xr--


