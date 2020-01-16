Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91BAC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFE120748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 07:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFE120748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irzLT-0000Zd-IP
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 02:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irzKr-00008f-Sv
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irzKn-0001P4-1B
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:12:57 -0500
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:55685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1irzKm-0001Mz-I1
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 02:12:52 -0500
Received: from yt-mxoi2.gw.nic.fujitsu.com (unknown [192.168.229.69]) by
 mgwym03.jp.fujitsu.com with smtp
 id 1a69_0058_6e0dcb08_8652_4e23_915f_b641fcbd9753;
 Thu, 16 Jan 2020 16:12:41 +0900
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
 (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0C00AAC00C5
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:12:41 +0900 (JST)
Received: from G01JPEXCHYT13.g01.fujitsu.local
 (G01JPEXCHYT13.g01.fujitsu.local [10.128.194.52])
 by g01jpfmpwyt02.exch.g01.fujitsu.local (Postfix) with ESMTP id ECC975842DA;
 Thu, 16 Jan 2020 16:12:39 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHYT13.g01.fujitsu.local (10.128.194.52) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 16:12:39 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 071/104] virtiofsd: extract root inode init into
 setup_root()
Date: Thu, 16 Jan 2020 16:20:37 +0900
Message-ID: <20200116072037.28976-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-72-dgilbert@redhat.com>
References: <20191212163904.159893-72-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.128.242.42
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
Cc: misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> Inititialize the root inode in a single place.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index ef8b88e3d1..0f33c3c5e9 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2336,6 +2336,29 @@ static void log_func(enum fuse_log_level level, const char *_fmt, va_list ap)
>      }
>  }
>  
> +static void setup_root(struct lo_data *lo, struct lo_inode *root)
> +{
> +    int fd, res;
> +    struct stat stat;
> +
> +    fd = open("/", O_PATH);
> +    if (fd == -1) {
> +        fuse_log(FUSE_LOG_ERR, "open(%s, O_PATH): %m\n", lo->source);
> +        exit(1);
> +    }
> +
> +    res = fstatat(fd, "", &stat, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
> +    if (res == -1) {
> +        fuse_log(FUSE_LOG_ERR, "fstatat(%s): %m\n", lo->source);
> +        exit(1);
> +    }
> +
> +    root->fd = fd;
> +    root->ino = stat.st_ino;
> +    root->dev = stat.st_dev;
> +    root->refcount = 2;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>      struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
> @@ -2411,8 +2434,6 @@ int main(int argc, char *argv[])
>      if (lo.debug) {
>          current_log_level = FUSE_LOG_DEBUG;
>      }
> -    lo.root.refcount = 2;
> -
>      if (lo.source) {
>          struct stat stat;
>          int res;
> @@ -2480,6 +2501,7 @@ int main(int argc, char *argv[])
>  
>      setup_sandbox(&lo, se, opts.syslog);
>  
> +    setup_root(&lo, &lo.root);
>      /* Block until ctrl+c or fusermount -u */
>      ret = virtio_loop(se);

Following block still remains in main():
2933    lo.root.is_symlink = false;
...
2952    lo.root.fd = open(lo.source, O_PATH);
2953
2954    if (lo.root.fd == -1) {
2955        fuse_log(FUSE_LOG_ERR, "open(\"%s\", O_PATH): %m\n", lo.source);
2956        exit(1);
2957    }

L.2933 should be included in lo_setup_root() and can we just remove L.2952-2957?

Thanks,
Misono

