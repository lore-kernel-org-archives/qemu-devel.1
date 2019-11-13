Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4792FC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02171222CD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5CPXU4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02171222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUsYq-0002VE-5u
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 08:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iUsXy-0001bj-OR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iUsXx-00027X-4A
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:18:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iUsXw-00027L-VI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 08:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573651136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtM5CTkFoMI/rgkVcp/hADsYNz/skobOW8WA2LjEvP4=;
 b=E5CPXU4YoJvgDSTqvaJyxxNkzTuxYbNtvq0lNlV0vZmo7tnM0xB66xF5Dj/xQxwPVafnVV
 RZbTTY7hB3cRt4EjehkuQ3zfQMKUhgXpFt0l2o2o8BN/q3vuckHRp2eZ2H+OLOOzJapxu6
 vmBw/5VRsjc9Ri9XFisrTYqtJziLSFk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-Z5RVcwf9M9e8H30xTJ-JBg-1; Wed, 13 Nov 2019 08:18:54 -0500
Received: by mail-qt1-f197.google.com with SMTP id h39so1308788qth.13
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 05:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0qau/RZPzQoqrsLq0P0Kb0BFLq9LChotw1B5jAexE6U=;
 b=Lm7aQ/gUQUQ5CkfiPXY3lUypSywRw155XToMBamo1DKw1u+kpvQve73m8yKgvH8gdE
 foxg0b3Ms2WcpU5KSj/pOdWIATd2hzA5XaEGPpCuhm4FTVc0STTRwNS9ISv6ULZdpnqf
 52clLtVMp6zsb5/4Mw5a8GWw04RThTFl95EJ69Ylh9PlrXF3gZ1GeuiHVYtzu3IG3zn6
 9QnEh60j4cy6cTzhTAjnIhs/GsQis8elDd1DwS+6fWWIsE9cy3nD6G6ms3/Pe3Cbkgkc
 CKppG0ENOcOupoJsIuVnK9qHObx+jmfQn/N/vXcDp6YaIMbNAyuKI2eHpS+PQ+q6WKuZ
 iOEA==
X-Gm-Message-State: APjAAAXTJDjciyYqInyPSYO4JWuO9TpXXb+E3HVw1pSeDgLr5mQAi1ZK
 eblg4fwevpt3vsViVwsPlHRqOJ6nQ72PI2TAE7fgYM6KIOIFIlf8uKyVqCSQCHiYdaj0YplJUWt
 e7S0B+Dm/NlOOfQY=
X-Received: by 2002:ac8:73ce:: with SMTP id v14mr2522516qtp.136.1573651134217; 
 Wed, 13 Nov 2019 05:18:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvbaaNJr8gORFTBNRmKWmzH85SLZMJaolm6I2QVHfz2hMyr8qwcbSCB6KiKBlxmPoAkWMoXA==
X-Received: by 2002:ac8:73ce:: with SMTP id v14mr2522485qtp.136.1573651133875; 
 Wed, 13 Nov 2019 05:18:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id s44sm1295535qts.22.2019.11.13.05.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 05:18:52 -0800 (PST)
Date: Wed, 13 Nov 2019 08:18:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Message-ID: <20191113081108-mutt-send-email-mst@kernel.org>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191023172005-mutt-send-email-mst@kernel.org>
 <42b80a75-6ab4-5123-bbf5-eee21c2841ac@virtuozzo.com>
 <20191106065816-mutt-send-email-mst@kernel.org>
 <650b229d-34d6-f9a5-6a52-d7b5892a2c0c@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <650b229d-34d6-f9a5-6a52-d7b5892a2c0c@virtuozzo.com>
X-MC-Unique: Z5RVcwf9M9e8H30xTJ-JBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 13, 2019 at 12:38:48PM +0000, Denis Plotnikov wrote:
>=20
>=20
> On 06.11.2019 15:03, Michael S. Tsirkin wrote:
> > On Thu, Oct 24, 2019 at 11:34:34AM +0000, Denis Lunev wrote:
> >> On 10/24/19 12:28 AM, Michael S. Tsirkin wrote:
> >>> On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
> >>>> From: "Denis V. Lunev" <den@openvz.org>
> >>>>
> >>>> Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
> >>>> field reported by SCSI controler. Thus typical sequential read with
> >>>> 1 MB size results in the following pattern of the IO from the guest:
> >>>>    8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd=
]
> >>>>    8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd=
]
> >>>>    8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
> >>>>    8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
> >>>>    8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
> >>>>    8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
> >>>> The IO was generated by
> >>>>    dd if=3D/dev/sda of=3D/dev/null bs=3D1024 iflag=3Ddirect
> >>>>
> >>>> This effectively means that on rotational disks we will observe 3 IO=
PS
> >>>> for each 2 MBs processed. This definitely negatively affects both
> >>>> guest and host IO performance.
> >>>>
> >>>> The cure is relatively simple - we should report lengthy scatter-gat=
her
> >>>> ability of the SCSI controller. Fortunately the situation here is ve=
ry
> >>>> good. VirtIO transport layer can accomodate 1024 items in one reques=
t
> >>>> while we are using only 128. This situation is present since almost
> >>>> very beginning. 2 items are dedicated for request metadata thus we
> >>>> should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
> >>>>
> >>>> The following pattern is observed after the patch:
> >>>>    8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd=
]
> >>>>    8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd=
]
> >>>>    8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
> >>>>    8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
> >>>> which is much better.
> >>>>
> >>>> The dark side of this patch is that we are tweaking guest visible
> >>>> parameter, though this should be relatively safe as above transport
> >>>> layer support is present in QEMU/host Linux for a very long time.
> >>>> The patch adds configurable property for VirtIO SCSI with a new defa=
ult
> >>>> and hardcode option for VirtBlock which does not provide good
> >>>> configurable framework.
> >>>>
> >>>> Unfortunately the commit can not be applied as is. For the real cure=
 we
> >>>> need guest to be fixed to accomodate that queue length, which is don=
e
> >>>> only in the latest 4.14 kernel. Thus we are going to expose the prop=
erty
> >>>> and tweak it on machine type level.
> >>>>
> >>>> The problem with the old kernels is that they have
> >>>> max_segments <=3D virtqueue_size restriction which cause the guest
> >>>> crashing in the case of violation.
> >>> This isn't just in the guests: virtio spec also seems to imply this,
> >>> or at least be vague on this point.
> >>>
> >>> So I think it'll need a feature bit.
> >>> Doing that in a safe way will also allow being compatible with old gu=
ests.
> >>>
> >>> The only downside is it's a bit more work as we need to
> >>> spec this out and add guest support.
> >>>
> >>>> To fix the case described above in the old kernels we can increase
> >>>> virtqueue_size to 256 and max_segments to 254. The pitfall here is
> >>>> that seabios allows the virtqueue_size-s < 128, however, the seabios
> >>>> patch extending that value to 256 is pending.
> >>> And the fix here is just to limit large vq size to virtio 1.0.
> >>> In that mode it's fine I think:
> >>>
> >>>
> >>>     /* check if the queue is available */
> >>>     if (vp->use_modern) {
> >>>         num =3D vp_read(&vp->common, virtio_pci_common_cfg, queue_siz=
e);
> >>>         if (num > MAX_QUEUE_NUM) {
> >>>             vp_write(&vp->common, virtio_pci_common_cfg, queue_size,
> >>>                      MAX_QUEUE_NUM);
> >>>             num =3D vp_read(&vp->common, virtio_pci_common_cfg, queue=
_size);
> >>>         }
> >>>     } else {
> >>>         num =3D vp_read(&vp->legacy, virtio_pci_legacy, queue_num);
> >>>     }
> >> you mean to put the code like this into virtio_pci_realize() inside QE=
MU?
> >>
> >> If no, can you pls clarify which component should be touched.
> >>
> >> Den
> > I mean:
> >   - add an API to change the default queue size
> >   - add a validate features callback, in there check and for modern
> >     flag set in features increase the queue size
> >
> > maybe all this is too much work, we could block this
> > for transitional devices, but your patch does not do it,
> > you need to check that legacy is enabled not that modern
> > is not disabled.
> To develop the idea of how to adjust queue size further I'd like to=20
> summarize what we have:
>=20
> 1. Variatly of gusts without(?) queue size limitations which can support=
=20
> queue sizes up to MAX(1024)
>=20
> 2. seabios setups with two possible max queue size limitations: 128 and=
=20
> 256 (recently commited)
>=20
> 3. non-sebios setups with unknown max queue-size limitations
>=20
> Taking into account that queue size may be limited in bios(efi), to=20
> safely support gueue sizes > 128 we need to distinguish those how can=20
> support greater_than_128 from those who can't.
> seabios potentially can't do it, so, as far as I understood, the idea is=
=20
> to start with queue size=3D128 and then increase the queue size when the=
=20
> guest driver is engaged.
>=20
> To achieve that, we need to
>=20
> 1.=A0 understand, which driver is currently working with a virtio device:=
=20
> seabios, guest, other. Things
>  =A0=A0=A0 here are quite complex, since we can't modify any guest, seabi=
os or=20
> other drivers to explicitly tell
>  =A0=A0=A0 that=A0 to device

Anyone negotiating VIRTIO_1

> 2. be able to increase queue size dynamically (re-create queues?). At=20
> the time, this functionality
>  =A0=A0 is absent, at least in qemu virtio-scsi.
>  =A0=A0 Is it possible by design?

Why not, it's just an array.
This is what I meant when I said we need an API to resize a queue.

> 3. choose a place for queue size extending (re-creation).=20
> VirtioDeviceClass->reset?

Definitely not reset, that gets you back to original state.

> I actually don't know how to do it reliably, so would really appreciate=
=20
> sone help or advice.

validate features sounds like a good place.
this is why I wrote "add a validate features callback".

>=20
> You've mentioned that old seabios won't use the modern interface, so=20
> would it be ok, if we
>=20
>  =A0=A0=A0 * define DEFAULT_QUEUE_SIZE =3D 128
>  =A0=A0=A0 * leave queues creation as is at VirtioDeviceClass->realize()
>  =A0=A0=A0=A0=A0 with queue_size =3D conf.queue_size
>  =A0=A0=A0 * on VirtioDeviceClass->reset() we check if the device accesse=
d=20
> through "legacy" interface
>  =A0=A0=A0=A0=A0 if so, then (in pseudocode)
>  =A0=A0=A0=A0=A0=A0=A0=A0 if (current_queue_size > DEFAULT_QUEUE_SIZE) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (queue in all_queues) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reduce_queue_size(queue=
, DEFAULT_QUEUE_SIZE) //=20
> recreate_queue() ?
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0 else
>  =A0=A0=A0=A0=A0=A0=A0=A0 if (conf.queue_size > current_queue_size) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (queue in all_queues) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 increase_queue_size(que=
ue, conf.queue_size)
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> Might this approach work? Does it what you meant?
>=20
> Denis


I don't think you can do anything useful in reset.  We need to check
features after they have been negotiated.  So we'd start with a small
queue min(DEFAULT_QUEUE_SIZE, current_queue_size)?
and if VIRTIO_1 is set increase the size.

This is very compatible but it is certainly ugly as we are
second-guessing the user.


Simpler idea: add a new property that is simply
unsupported with legacy.  E.g.  "modern-queue-size" ?
If someone sets it, legacy must be disabled otherwise we fail.

Way less compatible but hey.


> >
> >
> >
>=20


