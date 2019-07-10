Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E118DC74A21
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 13:53:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE152084B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 13:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE152084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlD2F-00037K-Sy
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 09:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hlD0H-0001Ry-5c
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 09:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hlD0F-00046f-JE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 09:51:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hlD0B-0003zf-6U; Wed, 10 Jul 2019 09:51:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07446307D913;
 Wed, 10 Jul 2019 13:43:03 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4274A84952;
 Wed, 10 Jul 2019 13:43:00 +0000 (UTC)
Message-ID: <0ab783dd5362725b086cf2087a5015b1af0735ad.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 10 Jul 2019 16:43:00 +0300
In-Reply-To: <20190704124342.7753-2-mlevitsk@redhat.com>
References: <20190704124342.7753-1-mlevitsk@redhat.com>
 <20190704124342.7753-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 10 Jul 2019 13:43:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/1] raw-posix.c - use max transfer
 length / max segement count only for SCSI passthrough
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
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 John Ferlan <jferlan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-07-04 at 15:43 +0300, Maxim Levitsky wrote:
> Regular kernel block devices (/dev/sda*, /dev/nvme*, etc) don't have
> max segment size/max segment count hardware requirements exposed
> to the userspace, but rather the kernel block layer
> takes care to split the incoming requests that
> violate these requirements.
> 
> Allowing the kernel to do the splitting allows qemu to avoid
> various overheads that arise otherwise from this.
> 
> This is especially visible in nbd server,
> exposing as a raw file, a mostly empty qcow2 image over the net.
> In this case most of the reads by the remote user
> won't even hit the underlying kernel block device,
> and therefore most of the  overhead will be in the
> nbd traffic which increases significantly with lower max transfer size.
> 
> In addition to that even for local block device
> access the peformance improves a bit due to less
> traffic between qemu and the kernel when large
> transfer sizes are used (e.g for image conversion)
> 
> More info can be found at:
> https://bugzilla.redhat.com/show_bug.cgi?id=1647104
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/file-posix.c | 54 ++++++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index ab05b51a66..4479cc7ab4 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1038,15 +1038,13 @@ static void raw_reopen_abort(BDRVReopenState *state)
>      s->reopen_state = NULL;
>  }
>  
> -static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
> +static int sg_get_max_transfer_length(int fd)
>  {
>  #ifdef BLKSECTGET
>      int max_bytes = 0;
> -    short max_sectors = 0;
> -    if (bs->sg && ioctl(fd, BLKSECTGET, &max_bytes) == 0) {
> +
> +    if (ioctl(fd, BLKSECTGET, &max_bytes) == 0) {
>          return max_bytes;
> -    } else if (!bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) == 0) {
> -        return max_sectors << BDRV_SECTOR_BITS;
>      } else {
>          return -errno;
>      }
> @@ -1055,25 +1053,31 @@ static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
>  #endif
>  }
>  
> -static int hdev_get_max_segments(const struct stat *st)
> +static int sg_get_max_segments(int fd)
>  {
>  #ifdef CONFIG_LINUX
>      char buf[32];
>      const char *end;
> -    char *sysfspath;
> +    char *sysfspath = NULL;
>      int ret;
> -    int fd = -1;
> +    int sysfd = -1;
>      long max_segments;
> +    struct stat st;
> +
> +    if (fstat(fd, &st)) {
> +        ret = -errno;
> +        goto out;
> +    }
>  
>      sysfspath = g_strdup_printf("/sys/dev/block/%u:%u/queue/max_segments",
> -                                major(st->st_rdev), minor(st->st_rdev));
> -    fd = open(sysfspath, O_RDONLY);
> -    if (fd == -1) {
> +                                major(st.st_rdev), minor(st.st_rdev));
> +    sysfd = open(sysfspath, O_RDONLY);
> +    if (sysfd == -1) {
>          ret = -errno;
>          goto out;
>      }
>      do {
> -        ret = read(fd, buf, sizeof(buf) - 1);
> +        ret = read(sysfd, buf, sizeof(buf) - 1);
>      } while (ret == -1 && errno == EINTR);
>      if (ret < 0) {
>          ret = -errno;
> @@ -1090,8 +1094,8 @@ static int hdev_get_max_segments(const struct stat *st)
>      }
>  
>  out:
> -    if (fd != -1) {
> -        close(fd);
> +    if (sysfd != -1) {
> +        close(sysfd);
>      }
>      g_free(sysfspath);
>      return ret;
> @@ -1103,19 +1107,17 @@ out:
>  static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
>  {
>      BDRVRawState *s = bs->opaque;
> -    struct stat st;
>  
> -    if (!fstat(s->fd, &st)) {
> -        if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
> -            int ret = hdev_get_max_transfer_length(bs, s->fd);
> -            if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
> -                bs->bl.max_transfer = pow2floor(ret);
> -            }
> -            ret = hdev_get_max_segments(&st);
> -            if (ret > 0) {
> -                bs->bl.max_transfer = MIN(bs->bl.max_transfer,
> -                                          ret * getpagesize());
> -            }
> +    if (bs->sg) {
> +        int ret = sg_get_max_transfer_length(s->fd);
> +
> +        if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
> +            bs->bl.max_transfer = pow2floor(ret);
> +        }
> +
> +        ret = sg_get_max_segments(s->fd);
> +        if (ret > 0) {
> +            bs->bl.max_transfer = MIN(bs->bl.max_transfer, ret * getpagesize());
>          }
>      }
>  


Ping.

Best regards,
	Maxim Levitsky


