Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC68C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6FB20721
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxbHKAwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6FB20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeRE5-000768-1x
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jeR6s-0003kG-O2
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:34:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jeR6r-0007nD-2E
 for qemu-devel@nongnu.org; Thu, 28 May 2020 18:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590705282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGEMI9Vj4Mh8n+qQYr8YPoyEED1uKKipY2p67IVhIE0=;
 b=JxbHKAwiMR5ftIi5UtrTGYKHuS7D2r5PHCJ/LmGGSzoHQ+ZTVlWjbNMOgwbVHcwNo9AIZA
 qiC7mGerqdXzVdoYTdvfUKi6JUsgY/C8tnhYjQyf9LfWbXdfcTt/ElA9+AkvS/5680FfmH
 hLvOuZifr02LzfUyPED6BiNrUaTRJUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-Hht4diWUP3GMYYsiACn6Hg-1; Thu, 28 May 2020 18:34:41 -0400
X-MC-Unique: Hht4diWUP3GMYYsiACn6Hg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6362180183C
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 22:34:40 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 667C75D9EF;
 Thu, 28 May 2020 22:34:34 +0000 (UTC)
Date: Thu, 28 May 2020 16:34:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] hw/vfio/common: Trace in which mode a IOMMU is opened
Message-ID: <20200528163434.2a65513b@x1.home>
In-Reply-To: <20200527165330.GG1194141@xz-x1>
References: <20200526173542.28710-1-philmd@redhat.com>
 <6c7c445d-0335-f67d-bb72-5b0c046bb247@redhat.com>
 <24f88212-9b32-b6dc-fcd4-685cde8bf5d7@redhat.com>
 <864ac8ab-e21e-393e-d1eb-08b3c4579bbf@redhat.com>
 <20200527161603.GF1194141@xz-x1>
 <3e364895-e5e5-09fe-ee8c-782f3632e2b8@redhat.com>
 <20200527165330.GG1194141@xz-x1>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 17:42:57
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
Cc: Auger Eric <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 May 2020 12:53:30 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Wed, May 27, 2020 at 06:27:38PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 5/27/20 6:16 PM, Peter Xu wrote: =20
> > > On Wed, May 27, 2020 at 05:53:16PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote: =20
> > >>>>> +    for (i =3D 0; i < ARRAY_SIZE(iommu); i++) {
> > >>>>> +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].=
type)) {
> > >>>>> +            trace_vfio_get_iommu_type(iommu[i].type, iommu[i].na=
me); =20
> > >>>> Just wondering why you want to trace the type as you now have the =
name
> > >>>> string. =20
> > >>>
> > >>> You are right :)
> > >>> =20
> > >>>>> +            return iommu[i].type;
> > >>>>>          }
> > >>>>>      }
> > >>>>> +    trace_vfio_get_iommu_type(-1, "Not available or not supporte=
d"); =20
> > >>>> nit: from a debugging pov, this may be not needed as
> > >>>> vfio_get_group/vfio_connect_container() fails and this leads to an=
 error
> > >>>> output. =20
> > >>
> > >> But you can reach this for example using No-IOMMU. If you don't mind=
, I
> > >> find having this information in the trace log clearer. =20
> > >=20
> > > I kinda agree with Eric - AFAICT QEMU vfio-pci don't work with no-iom=
mu, then
> > > it seems meaningless to trace it...
> > >=20
> > > I'm not sure whether this trace is extremely helpful because syscalls=
 like this
> > > could be easily traced by things like strace or bpftrace as general t=
ools (and
> > > this information should be a one-time thing rather than dynamically c=
hanging),
> > > no strong opinion though.  Also, if we want to dump something, maybe =
it's
> > > better to do in vfio_init_container() after vfio_get_iommu_type() suc=
ceeded, so
> > > we dump which container is enabled with what type of iommu. =20
> >=20
> > OK. I'm a recent VFIO user so maybe I am not using the good information=
.
> >=20
> > This trace helps me while working on a new device feature, I didn't
> > thought about gathering it in a production because there I'd expect
> > things to work.
> >=20
> > Now in my case what I want is to know is if I'm using a v1 or v2 type.
> > Maybe this information is already available in /proc or /sys and we
> > don't need this patch... =20

You're using v2 unless you're on a very old kernel.

> I don't know such /proc or /sys, so maybe it's still useful. I guess Alex=
 would
> have the best judgement. The strace/bpftrace things are not really reason=
s I
> found to nak this patch, but just something I thought first that could be
> easier when any of us wants to peak at those information, probably someth=
ing
> just FYI. :-)

I appreciate good trace code, but I don't appreciate code bloat for the
sake of tracing, which is what I'd consider the name fields here.  Do
it in the trace-event or require that the user needs to cross reference
the header to turn the integer type into a name themselves.  Thanks,

Alex


