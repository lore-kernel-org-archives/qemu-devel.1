Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3F6C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3ED20936
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0RkzlhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3ED20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kabZR-00050j-CG
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 04:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kabUP-0003Iu-CU
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kabUJ-00059a-NH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604568201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7B2ZskbvPbFLETwxQ8DCE8oN2CPYHqFwRVEUrmZ4OPo=;
 b=Z0RkzlhEuVMtoCWrEVCCveuWttw9v+jdyp1OFI3K0Dsue5c1/nCT2JHzuF0w9Eps5BIqTJ
 Wr+cXI+jNuBAr63RGCpyX7A/u7wfpt8wfTWeHAa3NmO74H3fij0UmzGJunzYo2kNc/Dy/g
 kYW4lZFLFbcEsMqoAWeZCqinl4XbhcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-TmybaICIPOS7bSmOcn5PdA-1; Thu, 05 Nov 2020 04:23:20 -0500
X-MC-Unique: TmybaICIPOS7bSmOcn5PdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86DAE1007464;
 Thu,  5 Nov 2020 09:23:18 +0000 (UTC)
Received: from starship (unknown [10.35.207.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 883FD100164C;
 Thu,  5 Nov 2020 09:23:11 +0000 (UTC)
Message-ID: <7d08dffcfaab921aaf13082d52d7cc6adbeccd93.camel@redhat.com>
Subject: Re: [PATCH 1/5] file-posix: split hdev_refresh_limits from
 raw_refresh_limits
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Tom Yan <tom.ty89@gmail.com>
Date: Thu, 05 Nov 2020 11:23:10 +0200
In-Reply-To: <CAGnHSEmDa4Sbv0D+RB8zz=o2C77ZdA-M13=bfbSZ+TZucNZpGw@mail.gmail.com>
References: <20201104173217.417538-1-mlevitsk@redhat.com>
 <20201104173217.417538-2-mlevitsk@redhat.com>
 <CAGnHSEmDa4Sbv0D+RB8zz=o2C77ZdA-M13=bfbSZ+TZucNZpGw@mail.gmail.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-11-05 at 13:44 +0800, Tom Yan wrote:
> Actually I made a mistake in this. BLKSECTGET (the one in the block
> layer) returns the number of "sectors", which is "defined" as 512-byte
> block. So we shouldn't use BLKSSZGET here, but simply 512 (1 << 9).
> See logical_to_sectors() in sd.h of the kernel.
I see it now. I'll respin the patches in a few days I guess after the rest
of the patches are reviewed.

Best regards,
	Maxim Levitsky

> 
> On Thu, 5 Nov 2020 at 01:32, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > From: Tom Yan <tom.ty89@gmail.com>
> > 
> > We can and should get max transfer length and max segments for all host
> > devices / cdroms (on Linux).
> > 
> > Also use MIN_NON_ZERO instead when we clamp max transfer length against
> > max segments.
> > 
> > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 45 insertions(+), 16 deletions(-)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index c63926d592..6581f41b2b 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1162,6 +1162,12 @@ static void raw_reopen_abort(BDRVReopenState *state)
> > 
> >  static int sg_get_max_transfer_length(int fd)
> >  {
> > +    /*
> > +     * BLKSECTGET for /dev/sg* character devices incorrectly returns
> > +     * the max transfer size in bytes (rather than in blocks).
> > +     * Also note that /dev/sg* doesn't support BLKSSZGET ioctl.
> > +     */
> > +
> >  #ifdef BLKSECTGET
> >      int max_bytes = 0;
> > 
> > @@ -1175,7 +1181,24 @@ static int sg_get_max_transfer_length(int fd)
> >  #endif
> >  }
> > 
> > -static int sg_get_max_segments(int fd)
> > +static int get_max_transfer_length(int fd)
> > +{
> > +#if defined(BLKSECTGET) && defined(BLKSSZGET)
> > +    int sect = 0;
> > +    int ssz = 0;
> > +
> > +    if (ioctl(fd, BLKSECTGET, &sect) == 0 &&
> > +        ioctl(fd, BLKSSZGET, &ssz) == 0) {
> > +        return sect * ssz;
> > +    } else {
> > +        return -errno;
> > +    }
> > +#else
> > +    return -ENOSYS;
> > +#endif
> > +}
> > +
> > +static int get_max_segments(int fd)
> >  {
> >  #ifdef CONFIG_LINUX
> >      char buf[32];
> > @@ -1230,23 +1253,29 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
> >  {
> >      BDRVRawState *s = bs->opaque;
> > 
> > -    if (bs->sg) {
> > -        int ret = sg_get_max_transfer_length(s->fd);
> > +    raw_probe_alignment(bs, s->fd, errp);
> > +    bs->bl.min_mem_alignment = s->buf_align;
> > +    bs->bl.opt_mem_alignment = MAX(s->buf_align, qemu_real_host_page_size);
> > +}
> > 
> > -        if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
> > -            bs->bl.max_transfer = pow2floor(ret);
> > -        }
> > +static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
> > +{
> > +    BDRVRawState *s = bs->opaque;
> > 
> > -        ret = sg_get_max_segments(s->fd);
> > -        if (ret > 0) {
> > -            bs->bl.max_transfer = MIN(bs->bl.max_transfer,
> > -                                      ret * qemu_real_host_page_size);
> > -        }
> > +    int ret = bs->sg ? sg_get_max_transfer_length(s->fd) :
> > +                       get_max_transfer_length(s->fd);
> > +
> > +    if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
> > +        bs->bl.max_transfer = pow2floor(ret);
> >      }
> > 
> > -    raw_probe_alignment(bs, s->fd, errp);
> > -    bs->bl.min_mem_alignment = s->buf_align;
> > -    bs->bl.opt_mem_alignment = MAX(s->buf_align, qemu_real_host_page_size);
> > +    ret = get_max_segments(s->fd);
> > +    if (ret > 0) {
> > +        bs->bl.max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
> > +                                           ret * qemu_real_host_page_size);
> > +    }
> > +
> > +    raw_refresh_limits(bs, errp);
> >  }
> > 
> >  static int check_for_dasd(int fd)
> > @@ -3600,7 +3629,7 @@ static BlockDriver bdrv_host_device = {
> >      .bdrv_co_pdiscard       = hdev_co_pdiscard,
> >      .bdrv_co_copy_range_from = raw_co_copy_range_from,
> >      .bdrv_co_copy_range_to  = raw_co_copy_range_to,
> > -    .bdrv_refresh_limits = raw_refresh_limits,
> > +    .bdrv_refresh_limits = hdev_refresh_limits,
> >      .bdrv_io_plug = raw_aio_plug,
> >      .bdrv_io_unplug = raw_aio_unplug,
> >      .bdrv_attach_aio_context = raw_aio_attach_aio_context,
> > @@ -3724,7 +3753,7 @@ static BlockDriver bdrv_host_cdrom = {
> >      .bdrv_co_preadv         = raw_co_preadv,
> >      .bdrv_co_pwritev        = raw_co_pwritev,
> >      .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
> > -    .bdrv_refresh_limits = raw_refresh_limits,
> > +    .bdrv_refresh_limits = hdev_refresh_limits,
> >      .bdrv_io_plug = raw_aio_plug,
> >      .bdrv_io_unplug = raw_aio_unplug,
> >      .bdrv_attach_aio_context = raw_aio_attach_aio_context,
> > --
> > 2.26.2
> > 



