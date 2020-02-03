Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAD7C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC772080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0yiWaZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC772080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybFB-0007qN-GI
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iybEI-0006z1-JL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iybEH-00082W-93
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:53:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55278
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iybEH-00082F-5R
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580734408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdVN3Zi9ejxzn6Fb9EOp2ieVboK6viHxB7rMgqcVwO8=;
 b=I0yiWaZ6RVwZhQinqiUw6hMPl9XBU3b+8N0nQ7pRpjZPR2ggnGQ8KsNu3oUp3zKSaKxLcS
 U4RPq1LduI7cpe0P//ztMa0wIYz35V2Bn2TuNaRHaWqMbGBMgwJTUtHrqLSE7HWcmLwcYv
 2B8bCz3nox1A82AURR9L5TgVeAHx0VA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-gATivyekMmKwrtIV92WU-w-1; Mon, 03 Feb 2020 07:53:26 -0500
Received: by mail-qt1-f199.google.com with SMTP id e37so9813553qtk.7
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 04:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=WglZzTMNw7J4xeNlp3OUXtdB7aXTMzK+smoW8gtda7c=;
 b=f0TK6BfHnf9Fehrei4jhTGwvnIVrcOcSpgx3RXAy3i/Whgx+DoL3oRF+92BFw/5TAY
 shnS8vt1yhDDOO1eV/UF9HBzMygCRnrIGgyik9YbtSaEI5GNPp9CebYSwAgWKmswryqe
 o6nmwiOl59Qw6bjDKriA0EJxdtawphBtiemF+Vp6vzCCJqCqXNrbeSs989cHIlZa+rtA
 r+VCM0m5t7er8meo5gZneZoqfMn1N2Vebd4Hw7wUS+LLdfrwKnSAJu3RMe5AOampAOuD
 bEwu54tJa/UziJlzSYjCmWqitGGlvuoZmWqadUsYLk4lFStjrwzDwuNbfeXo+fcyJMB2
 Y7Ug==
X-Gm-Message-State: APjAAAUq0Qo73c5E5HBSIR5jzPFkbZ/YMph7bgRF1nmMuAmSxlnfUX91
 RtInbkLn9I/hCIGwdJU2E8GtzcfuLZj5elUPWkLKQmiXpH5cgm3f6RLaP3W9I90KbFQx5CMUuZn
 j6cnaDJNq2uzDSEM=
X-Received: by 2002:a37:a958:: with SMTP id s85mr8963480qke.243.1580734405875; 
 Mon, 03 Feb 2020 04:53:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzaoky7IObG+4FFBwo0mrO64PyRihks2+7pFijQYWzetWZVBCJAW/EGfsYggreJZ0wlh4bmKg==
X-Received: by 2002:a37:a958:: with SMTP id s85mr8963460qke.243.1580734405602; 
 Mon, 03 Feb 2020 04:53:25 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id s20sm9065388qkg.131.2020.02.03.04.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 04:53:24 -0800 (PST)
Date: Mon, 3 Feb 2020 07:53:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200203075246-mutt-send-email-mst@kernel.org>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
 <20200130105235.GC176651@stefanha-x1.localdomain>
 <20200203102529.3op54zggtquoguuo@dritchie>
 <20200203105744.GD1922177@redhat.com>
 <20200203113949.hnjuqzkrqqwst54e@dritchie>
MIME-Version: 1.0
In-Reply-To: <20200203113949.hnjuqzkrqqwst54e@dritchie>
X-MC-Unique: gATivyekMmKwrtIV92WU-w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 12:39:49PM +0100, Sergio Lopez wrote:
> On Mon, Feb 03, 2020 at 10:57:44AM +0000, Daniel P. Berrang=E9 wrote:
> > On Mon, Feb 03, 2020 at 11:25:29AM +0100, Sergio Lopez wrote:
> > > On Thu, Jan 30, 2020 at 10:52:35AM +0000, Stefan Hajnoczi wrote:
> > > > On Thu, Jan 30, 2020 at 01:29:16AM +0100, Paolo Bonzini wrote:
> > > > > On 29/01/20 16:44, Stefan Hajnoczi wrote:
> > > > > > On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote:
> > > > > >> On Fri, 24 Jan 2020 10:01:57 +0000
> > > > > >> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > > > >>> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIO=
PCIProxy *vpci_dev, Error **errp)
> > > > > >>>  {
> > > > > >>>      VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
> > > > > >>>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > > > > >>> -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> > > > > >>> +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_ob=
j.conf;
> > > > > >>> +
> > > > > >>> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPI=
s */
> > > > > >>> +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES)=
 {
> > > > > >>> +        conf->num_queues =3D current_machine->smp.cpus;
> > > > > >> This now maps the request vqs 1:1 to the vcpus. What about the=
 fixed
> > > > > >> vqs? If they don't really matter, amend the comment to explain=
 that?
> > > > > > The fixed vqs don't matter.  They are typically not involved in=
 the data
> > > > > > path, only the control path where performance doesn't matter.
> > > > >=20
> > > > > Should we put a limit on the number of vCPUs?  For anything above=
 ~128
> > > > > the guest is probably not going to be disk or network bound.
> > > >=20
> > > > Michael Tsirkin pointed out there's a hard limit of VIRTIO_QUEUE_MA=
X
> > > > (1024).  We need to at least stay under that limit.
> > > >=20
> > > > Should the guest have >128 virtqueues?  Each virtqueue requires gue=
st
> > > > RAM and 2 host eventfds.  Eventually these resource requirements wi=
ll
> > > > become a scalability problem, but how do we choose a hard limit and=
 what
> > > > happens to guest performance above that limit?
> > >=20
> > > From the UX perspective, I think it's safer to use a rather low upper
> > > limit for the automatic configuration.
> > >=20
> > > Users of large VMs (>=3D32 vCPUs) aiming for the optimal performance =
are
> > > already facing the need of manually tuning (or relying on a software
> > > to do that for them) other aspects of it, like vNUMA, IOThreads and
> > > CPU pinning, so I don't think we should focus on this group.
> >=20
> > Whether they're runing manually, or relying on software to tune for
> > them, we (QEMU maintainers) still need to provide credible guidance
> > on what todo with tuning for large CPU counts. Without clear info
> > from QEMU, it just descends into hearsay and guesswork, both of which
> > approaches leave QEMU looking bad.
>=20
> I agree. Good documentation, ideally with some benchmarks, and safe
> defaults sound like a good approach to me.
>=20
> > So I think we need to, at the very least, make a clear statement here
> > about what tuning approach should be applied vCPU count gets high,
> > and probably even apply that  as a default out of the box approach.
>=20
> In general, I would agree, but in this particular case the
> optimization has an impact on something outside's QEMU control (host's
> resources), so we lack the information needed to make a proper guess.
>=20
> My main concern here is users upgrading QEMU to hit some kind of crash
> or performance issue, without having touched their VM config. And
> let's not forget that Stefan said in the cover that this amounts to a
> 1-4% improvement on 4k operations on an SSD, and I guess that's with
> iodepth=3D1. I suspect with a larger block size and/or higher iodepth
> the improvement will be barely noticeable, which means it'll only have
> a positive impact on users running DB/OLTP or similar workloads on
> dedicated, directly attached, low-latency storage.
>=20
> But don't get me wrong, this is a *good* optimization. It's just I
> think we should play safe here.
>=20
> Sergio.

Yea I think a bit more benchmarking than with 4 vcpus
so at least we can see the trend can't hurt.


