Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DDAC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6AB2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R30m+9So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6AB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEla-00054g-6O
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iBEk5-0003z5-9W
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iBEk4-0007Gt-5F
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:58:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iBEk4-0007Gh-06
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:58:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so5914923wrj.6
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xPMXD5KX00qD6uSAY0k7K2Kn4ysxIjRzLnGLl+jnIEA=;
 b=R30m+9So7rEoqXsgptvcrn7HHOmwlDKKjoIEz36C3avv5MlHqwHNG4sy4vaD9RLD+y
 GyQXAfdV9G2+y2h6XdZC5Q7ytrCwbP9njEMpgUTC8JNUC3N3dbTEStNxPs6i1Kap/6Af
 haKfsv2l49A0e5IK6VIrIOUFQNIbAIyv6pxxQJI6DOnS2lJZ+7dzW3OlplDvlgygAQJg
 plFDgOlCSMItQBk+cAH/qda0uVMGckL7XTd/9BPZJjHiyawMwY8sss4mQjG4C82k1U+3
 FIY0/Fj1LfNRzYT2JZhlvOD7/d7ZI4klf22PqJTlHh/+2KAeFNj+4UywATdOku+fwC5t
 jnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xPMXD5KX00qD6uSAY0k7K2Kn4ysxIjRzLnGLl+jnIEA=;
 b=AGsu114ndsecKTpFVUmv6fdvaiBTva91B9GI49WHgoZMDjysCtUvFdftw07Cg6GuXR
 6YvQMKx+2hD+PErJzFkcT98EihZUhI/A9oEGdter7XAXz3/i0o2+Snl//Kdn8xidIjxS
 WCfN9Snlrk51sbv6wcatb4bS4IGgr5m2EXtEZ4EbaX5U/QSQH+ompWw8w+LW2jPto++H
 S3h3uP+5MoHq5XXsLeF1Lpkd6SORwVBtDW5F4S6B26vrlMjRH1BpvnlqqkM6xPunARAf
 DXzu4RW97OJxEpd6JQUX2ZTt3rOZMmBZOumxGRYIjApGP8YsnCQUxN+s+pQjSqRMpbRZ
 25hw==
X-Gm-Message-State: APjAAAW0dlNeI7tVpzsSj83OPqvtAbIRmDs1Gh9cUax1jmQweZosNnSA
 PVmK2JkYa373B4xB728c49k=
X-Google-Smtp-Source: APXvYqwEhXoxyyMnk84fXEb1BR7wFW31u+8cntc4Mt/yjZ/mSAlNA8BNtdudSrtiEVFo+wlDWeW4Nw==
X-Received: by 2002:adf:f151:: with SMTP id y17mr10656925wro.244.1568969894890; 
 Fri, 20 Sep 2019 01:58:14 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t123sm1465791wma.40.2019.09.20.01.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 01:58:13 -0700 (PDT)
Date: Fri, 20 Sep 2019 09:58:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: handle NOFD flag in
 call/kick/err better
Message-ID: <20190920085812.GF14365@stefanha-x1.localdomain>
References: <20190917122559.15555-1-johannes@sipsolutions.net>
 <20190918093932.GC26027@stefanha-x1.localdomain>
 <317365a128caca1e683b94677d93dea98c2928c2.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <317365a128caca1e683b94677d93dea98c2928c2.camel@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 11:49:14AM +0200, Johannes Berg wrote:
> On Wed, 2019-09-18 at 10:39 +0100, Stefan Hajnoczi wrote:
> >=20
> > >  vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
> > >  {
> > >      int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
> > > +    bool nofd =3D vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
> > > =20
> > >      if (index >=3D dev->max_queues) {
> > >          vmsg_close_fds(vmsg);
> > > @@ -927,8 +928,12 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg=
 *vmsg)
> > >          return false;
> > >      }
> > > =20
> > > -    if (vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK ||
> > > -        vmsg->fd_num !=3D 1) {
> > > +    if (nofd) {
> > > +        vmsg_close_fds(vmsg);
> > > +        return true;
> > > +    }
>=20
> So in this particular code you quoted, I actually just aligned to have
> the same "bool nofd" variable - and I made it return "true" when no FD
> was given.
>=20
> It couldn't make use of what you proposed:
>=20
> > With the following change to vmsg_close_fds():
> >=20
> >   for (i =3D 0; i < vmsg->fd_num; i++) {
> >       close(vmsg->fds[i]);
> >   }
> > + for (i =3D 0; i < sizeof(vmsg->fd_num) / sizeof(vmsg->fd_num[0]); i++=
) {
> > +     vmsg->fds[i] =3D -1;
> > + }
> > + vmsg->fd_num =3D 0;
> >=20
> > ...the message handler functions below can use vmsg->fds[0] (-1) without
> > worrying about NOFD.  This makes the code simpler.
>=20
> because fd_num !=3D 1 leads to the original code returning false, which
> leads to the ring not getting started in vu_set_vring_kick_exec(). So we
> need the special code here, can be argued if I should pull out the test
> into the "bool nofd" variable or not ... *shrug*
>=20
> The changes in vu_set_vring_kick_exec() and vu_set_vring_err_exec()
> would indeed then not be necessary, but in vu_set_vring_call_exec() we
> should still avoid the eventfd_write() if it's going to get -1.
>=20
>=20
> So, yeah - could be a bit simpler there. I'd say being explicit here is
> easier to understand and thus nicer, but your (or Michael's I guess?)
> call.

Yeah, there is a trade-off to hiding NOFD and if what I proposed isn't
convincing then it wasn't a good proposal :-):

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2ElKQACgkQnKSrs4Gr
c8h+mAgAiFisHbmfxdCmgzXN3uiHVl6bbv+AMUu0aEtUD0EaW8IrWt8VcL0Gfzw/
vp2B1o5QpCGjOcwdx6T/8Hg19jkvKRsA3zcfZIyBdrRreU4lSymjukpFh2IuMfLN
C0gvioQty1YS+fNG1IFxAuyAzogqrgqE87+gMy8oZ0piS+HN9r8ApT1UPcpUKQK8
P8dpi1LexoD7G7OxFq7Mi0bwJ+WJW4MxMfnTwV6TABMhboC1eDhDNq/fef5klmW4
YExuzI//LAV1iz+2/CPCGB9pxw1UuHwSdkZUvxX77os8uJEa5z+YaOUFIPTLmlWf
c8Drep9Q+FdYyz9fdH8DjYCGBlXLZQ==
=41B0
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--

