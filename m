Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5273C433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 17:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E198A20709
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 17:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdpngMK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E198A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEy8T-00015e-PZ
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 13:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kEy7c-00004y-PD
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 13:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kEy7a-00041J-Lr
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 13:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599411989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gg/BhTLVMSyzuOCbki0KMz8sMD13S77XsVcjIOri7cY=;
 b=WdpngMK8oYdWiT+HV3Yuhdb9Koy+fhesUzcMKt10Yb8aUdyZMXY0kv1SpucMJxkI4DYvU7
 zkEUrgF4pkYUlh07Ohmy4Z7kI+nZAZDiQlNRusv13+vJXzRbd8Bm7tT3FpPUvARBEcLzSk
 XQlslB8uEgb8PBARZz8e7Ly+YlQmDGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-FVtrKOIxNti7AO8TX18iBw-1; Sun, 06 Sep 2020 13:06:24 -0400
X-MC-Unique: FVtrKOIxNti7AO8TX18iBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96513801AC5;
 Sun,  6 Sep 2020 17:06:23 +0000 (UTC)
Received: from starship (unknown [10.35.206.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0698E19C4F;
 Sun,  6 Sep 2020 17:05:53 +0000 (UTC)
Message-ID: <46216704388f0c33c18e3a1d54505ab5e71c8cb2.camel@redhat.com>
Subject: Re: [PATCH v4 2/2] file-posix: add sg_get_max_segments that
 actually works with sg
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Tom Yan <tom.ty89@gmail.com>, eblake@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, anielhb@linux.vnet.ibm.com, kwolf@redhat.com,
 mreitz@redhat.com
Date: Sun, 06 Sep 2020 20:05:44 +0300
In-Reply-To: <CAGnHSEkdTBBdT-Dm1Ztazq-ZxkLU5zq=3kYa_uiqna2uzm0Gkg@mail.gmail.com>
References: <20200904020907.241550-1-tom.ty89@gmail.com>
 <20200904020907.241550-2-tom.ty89@gmail.com>
 <CAGnHSEnF--OJ9biTx_ZxgqizVtr+0rBL8o-b9wY9+XNsnLPV=A@mail.gmail.com>
 <CAGnHSE=qnj8a8qaS6eiFdevp6ya0GjqXHuDgAV12B0tEAajddg@mail.gmail.com>
 <f5f5a6e2f4cc75c84e1364ab1276ee22aa5e3748.camel@redhat.com>
 <CAGnHSEkdTBBdT-Dm1Ztazq-ZxkLU5zq=3kYa_uiqna2uzm0Gkg@mail.gmail.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 13:06:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2020-09-06 at 23:26 +0800, Tom Yan wrote:
> I don't disagree with your proposal, but the thing is, do we even need
> another field/limit for case 1? For example, do we *really* need to
> clamp sizes[2] (NBD_INFO_BLOCK_SIZE) in nbd/server.c and
> max_io_sectors (SCSIBlockLimits) in hw/scsi/scsi-disk.c to to any kind
> of "dynamic" limit?

It depends on if we have other block drivers that have IO segment/max transfer sizes,
that we need to enforce, other than the SG_IO case.

Knowing that the commit that added these limits to file-posix, which I was fixing is relatively
new, I guess there are other cases for these limits.

I'll check this tomorrow.

> 
> Either way I can add another field (`max_pwrite`, maybe?) to
> BlockLimits, as an infrastructure/hint, but what should be switched to
> it, and what value should each block driver set it to, is probably
> beyond what I can take.

Implementation wise, I think I can do this, but I'll wait few days for the
feedback on my proposal.

Thanks for finding this bug!

Best regards,
	Maxim Levitsky

> 
> IMHO my patches should be merged first (they are really just fixing a
> regression and some bugs). If anyone finds it necessary and is capable
> and willing to fix the insufficiency of BlockLimits, they can do it
> afterwards with another patch series as an improvement. I can add a
> patch to remove the clamping in nbd/server.c as a perhaps-temporary
> measure to address the original issue, if desired.
> 
> On Sun, 6 Sep 2020 at 20:53, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > On Sun, 2020-09-06 at 19:04 +0800, Tom Yan wrote:
> > > Maybe you want to add some condition for this:
> > > https://github.com/qemu/qemu/blob/v5.1.0/nbd/server.c#L659
> > > Or not clamp it at all.
> > > 
> > > On Sun, 6 Sep 2020 at 18:58, Tom Yan <tom.ty89@gmail.com> wrote:
> > > > In commit 867eccfed84f96b54f4a432c510a02c2ce03b430, Levitsky appears
> > > > to have assumed that the only "SCSI Passthrough" is `-device
> > > > scsi-generic`, while the fact is there's also `-device scsi-block`
> > > > (passthrough without the sg driver). Unlike `-device scsi-hd`, getting
> > > > max_sectors is necessary to it (more precisely, hw_max_sectors might
> > > > what matters, but BLKSECTGET reports max_sectors, so).
> > > > 
> > > > I'm unsure about how qemu-nbd works, but the commit clearly wasn't the
> > > > right approach to fix the original issue it addresses. (It should for
> > > > example ignore the max_transfer if it will never matter in to it, or
> > > > overrides it in certain cases; when I glimpsed over
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=1647104, I don't see how
> > > > it could be file-posix problem when it is reporting the right thing,
> > > > regardless of whether "removing" the code helps.)
> > > > 
> > > > I don't think we want to "mark" `-device scsi-block` as sg either. It
> > > > will probably bring even more unexpected problems, because they are
> > > > literally different sets of things behind the scene / in the kernel.
> > 
> > Yes, I did overlook the fact that scsi-block is kind of hybrid passthough device,
> > doing SG_IO for some things and regular IO for others.
> > 
> > I don't think that my approach was wrong way to fix the problem, but as you found
> > out, abusing 'bs->sg' hack (which I would be very happy to remove completely)
> > wasn't a good idea.
> > I actualy was aware of scsi-block and that it does SG_IO but it
> > was forgotten some where on the way.
> > 
> > So in summary what the problem is and what I think is the right solution:
> > 
> > 
> > Each qemu block driver exposes block limits and assumes that they are the same
> > for two IO interfaces the block driver can expose:
> > 
> > 1. Regular qemu blk_pread/pwrite alike functions
> > 2. blk_ioctl (tiny wrapper against SG_IO), supported by posix-raw on
> >    host block devices/sg char devices, and by iscsi
> > 
> > The problem is that these two interfaces can have different block limits.
> > 
> > I don't know about iscsi, but for files, doing regular IO is always unlimited,
> > since it passes through the kernel block layer and segemented there on
> > demand which is faster that doing it in userspace, while SG_IO is passed as is
> > to the underlying SCSI device and lacks this segmentation.
> > 
> > Regardless of how NBD uses these limits, I think that these limits should be correctly
> > exposed by the block drivers, and therefore I propose is that each qemu block driver
> > would expose a pair of block limits.
> > One for the regular block IO, and other for SG_IO.
> > 
> > Then block driver clients (like scsi devices that you mention, nbd, etc)
> > can choose which limit to use, depending on which IO api they use.
> > The scsi-generic, and scsi-block can use the SG_IO limits,
> > while the rest  can use the normal (unlimited for file I/O) limits, including the NBD.
> > 
> > Best regards,
> >         Maxim Levitsky
> > 
> > > > On Fri, 4 Sep 2020 at 10:09, Tom Yan <tom.ty89@gmail.com> wrote:
> > > > > sg devices have different major/minor than their corresponding
> > > > > block devices. Using sysfs to get max segments never really worked
> > > > > for them.
> > > > > 
> > > > > Fortunately the sg driver provides an ioctl to get sg_tablesize,
> > > > > which is apparently equivalent to max segments.
> > > > > 
> > > > > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > > > > ---
> > > > >  block/file-posix.c | 17 ++++++++++++++++-
> > > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > > > index 411a23cf99..9e37594145 100644
> > > > > --- a/block/file-posix.c
> > > > > +++ b/block/file-posix.c
> > > > > @@ -1178,6 +1178,21 @@ static int sg_get_max_transfer_length(int fd)
> > > > >  #endif
> > > > >  }
> > > > > 
> > > > > +static int sg_get_max_segments(int fd)
> > > > > +{
> > > > > +#ifdef SG_GET_SG_TABLESIZE
> > > > > +    long max_segments = 0;
> > > > > +
> > > > > +    if (ioctl(fd, SG_GET_SG_TABLESIZE, &max_segments) == 0) {
> > > > > +        return max_segments;
> > > > > +    } else {
> > > > > +        return -errno;
> > > > > +    }
> > > > > +#else
> > > > > +    return -ENOSYS;
> > > > > +#endif
> > > > > +}
> > > > > +
> > > > >  static int get_max_transfer_length(int fd)
> > > > >  {
> > > > >  #if defined(BLKSECTGET) && defined(BLKSSZGET)
> > > > > @@ -1268,7 +1283,7 @@ static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
> > > > >          bs->bl.max_transfer = pow2floor(ret);
> > > > >      }
> > > > > 
> > > > > -    ret = get_max_segments(s->fd);
> > > > > +    ret = bs->sg ? sg_get_max_segments(s->fd) : get_max_segments(s->fd);
> > > > >      if (ret > 0) {
> > > > >          bs->bl.max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
> > > > >                                             ret * qemu_real_host_page_size);
> > > > > --
> > > > > 2.28.0
> > > > > 



