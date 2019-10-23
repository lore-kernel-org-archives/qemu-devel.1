Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E5CCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE43621872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8LSgLod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE43621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNHV2-0007n4-Hc
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNHRu-00062V-7f
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNHRs-0002Hn-A8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:17:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29183
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNHRs-0002HP-5V
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571840234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCWi650KXxhF9clRdjSw8yXJy9Tued2UwP4ryegdWRE=;
 b=Y8LSgLodRyuizZj/Z79Y8VtpxJi3PA+VGjXFEMMCbAsIHkRx90PTHKB5FgvjrUgAS0vy/4
 ravSrIJ9/123xjc9XZqqhvutXc+4ZqHTVa95S/er+Oag1M4WPmf498e7b8vBRMCqmdDOfN
 XUTBE5skc12WVHL9JVIF7pZ/+uYFG1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-0UoROc8GOqWgvaSbZfj5kw-1; Wed, 23 Oct 2019 10:17:09 -0400
X-MC-Unique: 0UoROc8GOqWgvaSbZfj5kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7AB21005500;
 Wed, 23 Oct 2019 14:17:07 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AC051001B05;
 Wed, 23 Oct 2019 14:17:02 +0000 (UTC)
Date: Wed, 23 Oct 2019 15:17:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Denis Lunev <den@virtuozzo.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Message-ID: <20191023141701.GD9574@stefanha-x1.localdomain>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191021132455.GH22659@stefanha-x1.localdomain>
 <c5b0761d-496d-eabc-bb87-2fd70e89577c@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <c5b0761d-496d-eabc-bb87-2fd70e89577c@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 04:01:57AM +0000, Denis Lunev wrote:
> On 10/21/19 4:24 PM, Stefan Hajnoczi wrote:
> > On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
> >> From: "Denis V. Lunev" <den@openvz.org>
> >>
> >> Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
> >> field reported by SCSI controler. Thus typical sequential read with
> >> 1 MB size results in the following pattern of the IO from the guest:
> >>   8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd]
> >>   8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd]
> >>   8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
> >>   8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
> >>   8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
> >>   8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
> >> The IO was generated by
> >>   dd if=3D/dev/sda of=3D/dev/null bs=3D1024 iflag=3Ddirect
> >>
> >> This effectively means that on rotational disks we will observe 3 IOPS
> >> for each 2 MBs processed. This definitely negatively affects both
> >> guest and host IO performance.
> >>
> >> The cure is relatively simple - we should report lengthy scatter-gathe=
r
> >> ability of the SCSI controller. Fortunately the situation here is very
> >> good. VirtIO transport layer can accomodate 1024 items in one request
> >> while we are using only 128. This situation is present since almost
> >> very beginning. 2 items are dedicated for request metadata thus we
> >> should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
> >>
> >> The following pattern is observed after the patch:
> >>   8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd]
> >>   8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd]
> >>   8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
> >>   8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
> >> which is much better.
> >>
> >> The dark side of this patch is that we are tweaking guest visible
> >> parameter, though this should be relatively safe as above transport
> >> layer support is present in QEMU/host Linux for a very long time.
> >> The patch adds configurable property for VirtIO SCSI with a new defaul=
t
> >> and hardcode option for VirtBlock which does not provide good
> >> configurable framework.
> >>
> >> Unfortunately the commit can not be applied as is. For the real cure w=
e
> >> need guest to be fixed to accomodate that queue length, which is done
> >> only in the latest 4.14 kernel. Thus we are going to expose the proper=
ty
> >> and tweak it on machine type level.
> >>
> >> The problem with the old kernels is that they have
> >> max_segments <=3D virtqueue_size restriction which cause the guest
> >> crashing in the case of violation.
> >> To fix the case described above in the old kernels we can increase
> >> virtqueue_size to 256 and max_segments to 254. The pitfall here is
> >> that seabios allows the virtqueue_size-s < 128, however, the seabios
> >> patch extending that value to 256 is pending.
> > If I understand correctly you are relying on Indirect Descriptor suppor=
t
> > in the guest driver in order to exceed the Virtqueue Descriptor Table
> > size.
> >
> > Unfortunately the "max_segments <=3D virtqueue_size restriction" is
> > required by the VIRTIO 1.1 specification:
> >
> >   2.6.5.3.1 Driver Requirements: Indirect Descriptors
> >
> >   A driver MUST NOT create a descriptor chain longer than the Queue
> >   Size of the device.
> >
> > So this idea seems to be in violation of the specification?
> >
> > There is a bug in hw/block/virtio-blk.c:virtio_blk_update_config() and
> > hw/scsi/virtio-scsi.c:virtio_scsi_get_config():
> >
> >   virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
> >
> > This number should be the minimum of blk_get_max_iov() and
> > virtio_queue_get_num(), minus 2 for the header and footer.
> >
> > I looked at the Linux SCSI driver code and it seems each HBA has a
> > single max_segments number - it does not vary on a per-device basis.
> > This could be a problem if two host block device with different
> > max_segments are exposed to the guest through the same virtio-scsi
> > controller.  Another bug? :(
> >
> > Anyway, if you want ~1024 descriptors you should set Queue Size to 1024=
.
> > I don't see a spec-compliant way of doing it otherwise.  Hopefully I
> > have overlooked something and there is a nice way to solve this.
> >
> > Stefan
> you are perfectly correct. We need actually 3 changes to improve
> guest behavior:
> 1) This patch, which adds property but does not change anything
> =A0=A0=A0 useful

This patch is problematic because it causes existing guest drivers to
violate the VIRTIO specification (or fail) if the value is set too high.
In addition, it does not take into account the virtqueue size so the
default value is too low when the user sets -device ...,queue-size=3D1024.

Let's calculate blkcfg.seg_max based on the virtqueue size as mentioned
in my previous email instead.

There is one caveat with my suggestion: drivers are allowed to access
VIRTIO Configuration Space before virtqueue setup has determined the
final size.  Therefore the value of this field can change after
virtqueue setup.  Drivers that set a custom virtqueue size would need to
read the value after virtqueue setup.  (Linux drivers do not modify the
virtqueue size so it won't affect them.)

Stefan

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2wYN0ACgkQnKSrs4Gr
c8iWbQgAqnK2yQfAU+tG5ZOis0G5L2LYQHL0qVXjoBsatTP4fIBKk8X1DeRxXAim
lXZrQEGj1VTvejAK72r0nU6Q5IYY9lgboHCMgmsUTuDYxNaOF/UTAUDtAZm64HEt
r2lmsQxxOE5kgwRqwQZ736r2zGgWAnkJNmd1J+1f4x1qzDlydLaRQkHDcwaiJQTr
+EhhMu3XAerpfUBxQpsOUPaXDI7Qs2YptcyTIcJbG5Ky++MjA6nAiP/VFUu6/eBu
3UW5IwwNDCPtUjVYwfHd8PRNg3ovooj6edT5uEjrFRaMmP6xa4QzsvoJaNS6LHTp
v2l4uk1Pw+4qDAs6LV+gJOpmpt7IOQ==
=pPG6
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--


