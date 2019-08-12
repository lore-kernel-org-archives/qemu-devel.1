Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A97C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B8120665
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B8120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxBFS-0000wX-DV
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 10:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33889)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hxBEu-0008Oj-NF
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hxBEt-0004eG-7J
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:24:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43963)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hxBEp-0004dC-Nn; Mon, 12 Aug 2019 10:23:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 052C73003A49;
 Mon, 12 Aug 2019 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-66.ams2.redhat.com
 [10.36.116.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C553C60CDA;
 Mon, 12 Aug 2019 14:23:53 +0000 (UTC)
Date: Mon, 12 Aug 2019 16:23:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nir Soffer <nirsof@gmail.com>
Message-ID: <20190812142352.GB6400@localhost.localdomain>
References: <20190811205024.19482-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811205024.19482-1-nsoffer@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 12 Aug 2019 14:23:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] block: posix: Handle undetectable
 alignment
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
Cc: Nir Soffer <nsoffer@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.08.2019 um 22:50 hat Nir Soffer geschrieben:
> In some cases buf_align or request_alignment cannot be detected:
> 
> - With Gluster, buf_align cannot be detected since the actual I/O is
>   done on Gluster server, and qemu buffer alignment does not matter.

If it doesn't matter, the best value would be buf_align = 1.

> - With local XFS filesystem, buf_align cannot be detected if reading
>   from unallocated area.

Here, we actually do need alignment, but it's unknown whether it would
be 512 or 4096 or something entirely. Failing to align requests
correctly results in I/O errors.

> - With Gluster backed by XFS, request_alignment cannot be detected if
>   reading from unallocated area.

This is like buf_align for XFS: We don't know the right value, but
getting it wrong causes I/O errors.

> - With NFS, the server does not use direct I/O, so both buf_align
>   cannot be detected.

This suggests that byte-aligned requests are fine for NFS, i.e.
buf_align = request_alignment = 1 would be optimal in this case.

> These cases seems to work when storage sector size is 512 bytes, because
> the current code starts checking align=512. If the check succeeds
> because alignment cannot be detected we use 512. But this does not work
> for storage with 4k sector size.
> 
> Practically the alignment requirements are the same for buffer
> alignment, buffer length, and offset in file. So in case we cannot
> detect buf_align, we can use request alignment. If we cannot detect
> request alignment, we can fallback to a safe value.

This makes sense in general.

What the commit message doesn't explain, but probably should do is how
we determine whether we could successfully detect request alignment. The
approach taken here is that a detected alignment of 1 is understood as
failure to detect the real alignment.

With cases 2 and 3 this gives the desird result; however for cases 1 and
4, an alignment of 1 would be the actual correct value, and the new
probing algorithm results in a worse result.

However, since the negative effect of the old algorithm in cases 2 and 3
is I/O errors whereas the effect of the new one in cases 1 and 4 is just
degraded performance for I/O that isn't 4k aligned, the new approch is
still preferable.

I think we need to make this tradeoff clearer in the commit message and
the comment in the code, but the approach is reasonable enough.

> With this change:
> 
> - Provisioning VM and copying disks on local XFS and Gluster with 4k
>   sector size works, resolving bugs [1],[2].
> 
> - With NFS we fallback to buf_align and request_alignment of 4096
>   instead of 512. This may cause unneeded data copying, but so far I see
>   better performance with this change.
> 
> [1] https://bugzilla.redhat.com/1737256
> [2] https://bugzilla.redhat.com/1738657
> 
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
> 
> v1 was a minimal hack; this version is a more generic fix that works for
> any storage without requiring users to allocate the first block of an
> image. Allocting the first block of an image is still a good idea since
> it allows detecting the right alignment in some cases.
> 
> v1 could also affect cases when we could detect buf_align to use
> request_alignment instead; v2 will only affect cases when buf_align or
> request_alignment cannot be detected.
> 
> v1 was hare:
> https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00133.html
> 
>  block/file-posix.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index f33b542b33..511468f166 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -323,6 +323,7 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
>      BDRVRawState *s = bs->opaque;
>      char *buf;
>      size_t max_align = MAX(MAX_BLOCKSIZE, getpagesize());
> +    size_t alignments[] = {1, 512, 1024, 2048, 4096};
>  
>      /* For SCSI generic devices the alignment is not really used.
>         With buffered I/O, we don't have any restrictions. */
> @@ -349,25 +350,42 @@ static void raw_probe_alignment(BlockDriverState *bs, int fd, Error **errp)
>      }
>  #endif
>  
> -    /* If we could not get the sizes so far, we can only guess them */
> -    if (!s->buf_align) {
> +    /*
> +     * If we could not get the sizes so far, we can only guess them. First try
> +     * to detect request alignment, since it is more likely to succeed. Then
> +     * try to detect buf_align, which cannot be detected in some cases (e.g.
> +     * Gluster). If buf_align cannot be detected, we fallback to the value of
> +     * request_alignment.
> +     */
> +
> +    if (!bs->bl.request_alignment) {
> +        int i;
>          size_t align;
> -        buf = qemu_memalign(max_align, 2 * max_align);
> -        for (align = 512; align <= max_align; align <<= 1) {
> -            if (raw_is_io_aligned(fd, buf + align, max_align)) {
> -                s->buf_align = align;
> +        buf = qemu_memalign(max_align, max_align);
> +        for (i = 0; i < ARRAY_SIZE(alignments); i++) {
> +            align = alignments[i];
> +            if (raw_is_io_aligned(fd, buf, align)) {
> +                /* Fallback to safe value. */
> +                bs->bl.request_alignment = (align != 1) ? align : max_align;
>                  break;
>              }
>          }
>          qemu_vfree(buf);
>      }
>  
> -    if (!bs->bl.request_alignment) {
> +    if (!s->buf_align) {
> +        int i;
>          size_t align;
> -        buf = qemu_memalign(s->buf_align, max_align);
> -        for (align = 512; align <= max_align; align <<= 1) {
> -            if (raw_is_io_aligned(fd, buf, align)) {
> -                bs->bl.request_alignment = align;
> +        buf = qemu_memalign(max_align, 2 * max_align);
> +        for (i = 0; i < ARRAY_SIZE(alignments); i++) {
> +            align = alignments[i];
> +            if (raw_is_io_aligned(fd, buf + align, max_align)) {
> +                /* Fallback to request_aligment or safe value. */
> +                s->buf_align = (align != 1)
> +                    ? align
> +                    : (bs->bl.request_alignment != 0)
> +                        ? bs->bl.request_alignment
> +                        : max_align;

Nested ternary operators over five lines aren't that readable any more.
I'd suggest using at least one more if:

    if (align != 1) {
        s->buf_align = align;
    } else {
        s->buf_slign = bs->bl.request_alignment ?: max_align;
    }

In fact, is checking bs->bl.request_alignment for 0 even worth it here?
If it's 0, we failed to find any working configuration and will return
an error anyway. Then it doesn't matter if s->buf_align becomes 0, too.

Kevin

