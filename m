Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3D3C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6CA20730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6CA20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is3dg-0002Cb-L5
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1is3d2-0001QR-W5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1is3cy-0002tD-Mg
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:48:00 -0500
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:24020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1is3cx-0002pP-WA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:47:56 -0500
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by
 mgwym03.jp.fujitsu.com with smtp
 id 2a40_6602_fc948adb_3aa9_4dd4_a59b_c3ee697d68cc;
 Thu, 16 Jan 2020 20:47:45 +0900
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
 (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3708BAC010A
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 20:47:45 +0900 (JST)
Received: from G01JPEXCHYT14.g01.fujitsu.local
 (G01JPEXCHYT14.g01.fujitsu.local [10.128.194.53])
 by g01jpfmpwyt01.exch.g01.fujitsu.local (Postfix) with ESMTP id 347396D677E;
 Thu, 16 Jan 2020 20:47:44 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 G01JPEXCHYT14.g01.fujitsu.local (10.128.194.53) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 20:47:43 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 072/104] virtiofsd: passthrough_ll: fix refcounting on
 remove/rename
Date: Thu, 16 Jan 2020 20:56:03 +0900
Message-ID: <20200116115603.5415-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-73-dgilbert@redhat.com>
References: <20191212163904.159893-73-dgilbert@redhat.com>
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
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

I'm not familiar with qemu convention but shouldn't we put
at least one line of description like linux kernel?

For code itself:
 Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

> ---
>  tools/virtiofsd/passthrough_ll.c | 50 +++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 0f33c3c5e9..1b84d4f313 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -1077,17 +1077,42 @@ out_err:
>      fuse_reply_err(req, saverr);
>  }
>  
> +static struct lo_inode *lookup_name(fuse_req_t req, fuse_ino_t parent,
> +                                    const char *name)
> +{
> +    int res;
> +    struct stat attr;
> +
> +    res = fstatat(lo_fd(req, parent), name, &attr,
> +                  AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
> +    if (res == -1) {
> +        return NULL;
> +    }
> +
> +    return lo_find(lo_data(req), &attr);
> +}
> +
>  static void lo_rmdir(fuse_req_t req, fuse_ino_t parent, const char *name)
>  {
>      int res;
> +    struct lo_inode *inode;
> +    struct lo_data *lo = lo_data(req);
> +
>      if (!is_safe_path_component(name)) {
>          fuse_reply_err(req, EINVAL);
>          return;
>      }
>  
> +    inode = lookup_name(req, parent, name);
> +    if (!inode) {
> +        fuse_reply_err(req, EIO);
> +        return;
> +    }
> +
>      res = unlinkat(lo_fd(req, parent), name, AT_REMOVEDIR);
>  
>      fuse_reply_err(req, res == -1 ? errno : 0);
> +    unref_inode_lolocked(lo, inode, 1);
>  }
>  
>  static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *name,
> @@ -1095,12 +1120,23 @@ static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *name,
>                        unsigned int flags)
>  {
>      int res;
> +    struct lo_inode *oldinode;
> +    struct lo_inode *newinode;
> +    struct lo_data *lo = lo_data(req);
>  
>      if (!is_safe_path_component(name) || !is_safe_path_component(newname)) {
>          fuse_reply_err(req, EINVAL);
>          return;
>      }
>  
> +    oldinode = lookup_name(req, parent, name);
> +    newinode = lookup_name(req, newparent, newname);
> +
> +    if (!oldinode) {
> +        fuse_reply_err(req, EIO);
> +        goto out;
> +    }
> +
>      if (flags) {
>  #ifndef SYS_renameat2
>          fuse_reply_err(req, EINVAL);
> @@ -1113,26 +1149,38 @@ static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *name,
>              fuse_reply_err(req, res == -1 ? errno : 0);
>          }
>  #endif
> -        return;
> +        goto out;
>      }
>  
>      res = renameat(lo_fd(req, parent), name, lo_fd(req, newparent), newname);
>  
>      fuse_reply_err(req, res == -1 ? errno : 0);
> +out:
> +    unref_inode_lolocked(lo, oldinode, 1);
> +    unref_inode_lolocked(lo, newinode, 1);
>  }
>  
>  static void lo_unlink(fuse_req_t req, fuse_ino_t parent, const char *name)
>  {
>      int res;
> +    struct lo_inode *inode;
> +    struct lo_data *lo = lo_data(req);
>  
>      if (!is_safe_path_component(name)) {
>          fuse_reply_err(req, EINVAL);
>          return;
>      }
>  
> +    inode = lookup_name(req, parent, name);
> +    if (!inode) {
> +        fuse_reply_err(req, EIO);
> +        return;
> +    }
> +
>      res = unlinkat(lo_fd(req, parent), name, 0);
>  
>      fuse_reply_err(req, res == -1 ? errno : 0);
> +    unref_inode_lolocked(lo, inode, 1);
>  }
>  
>  static void unref_inode_lolocked(struct lo_data *lo, struct lo_inode *inode,
> -- 
> 2.23.0

