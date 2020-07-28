Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF46C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F6420775
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="HlzWGOPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F6420775
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MCB-00042H-10
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k0MBa-0003b0-8z
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:46:14 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:41583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k0MBY-0003tU-86
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=0+KZaxZNw8gALD6Nt5gdFX0qHQHN8wWjUGpwg6VNZ/w=; b=HlzWGOPH4KD0tO+f5aYBsyoOnP
 D8c/F/3HJRoiX6uphB47OF8skiFxUBO3V78rVgG6W7Ccihvfwr2cVqrhox5Ecdg34+3O0tJE+x+9l
 3VlpPmDo/IcMBdev4qs0l32+DfmvXCS+7SXy0qgHgkwcjgNoh0S+k/nG/MqVg11ZzjGJetde6qzB9
 NeRsoT6BNOwuI4LsaJE5A4qYZbVLRSr/FsuHl3SE8xNt+eH03YRnw920OgSdQULsAx+mLBbOkvIts
 YmSvaBMednPZM7thxqAhJOvNWziACwwbNH9+V9IZPkvOHgM2kxjVFoGzqX0tFXMqLuxmyyEW/hmuk
 EA3YFs0A==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v7 5/6] 9pfs: differentiate readdir lock between 9P2000.u
 vs. 9P2000.L
Date: Tue, 28 Jul 2020 11:46:09 +0200
Message-ID: <5466858.CMtu22SHpU@silver>
In-Reply-To: <abccfcad6764986c8442f2163de618af11232475.1595166227.git.qemu_oss@crudebyte.com>
References: <cover.1595166227.git.qemu_oss@crudebyte.com>
 <abccfcad6764986c8442f2163de618af11232475.1595166227.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 04:33:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sonntag, 19. Juli 2020 15:20:11 CEST Christian Schoenebeck wrote:
> Previous patch suggests that it might make sense to use a different mutex
> type now while handling readdir requests, depending on the precise
> protocol variant, as v9fs_do_readdir_with_stat() (used by 9P2000.u) uses
> a CoMutex to avoid deadlocks that might happen with QemuMutex otherwise,
> whereas do_readdir_many() (used by 9P2000.L) should better use a
> QemuMutex, as the precise behaviour of a failed CoMutex lock on fs driver
> side would not be clear.
> 
> This patch is just intended as transitional measure, as currently 9P2000.u
> vs. 9P2000.L implementations currently differ where the main logic of
> fetching directory entries is located at (9P2000.u still being more top
> half focused, while 9P2000.L already being bottom half focused in regards
> to fetching directory entries that is).
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c |  4 ++--
>  hw/9pfs/9p.h | 27 ++++++++++++++++++++++-----
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index cc4094b971..a0881ddc88 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -314,8 +314,8 @@ static V9fsFidState *alloc_fid(V9fsState *s, int32_t
> fid) f->next = s->fid_list;
>      s->fid_list = f;
> 
> -    v9fs_readdir_init(&f->fs.dir);
> -    v9fs_readdir_init(&f->fs_reclaim.dir);
> +    v9fs_readdir_init(s->proto_version, &f->fs.dir);
> +    v9fs_readdir_init(s->proto_version, &f->fs_reclaim.dir);
> 
>      return f;
>  }
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 93b7030edf..3dd1b50b1a 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -197,22 +197,39 @@ typedef struct V9fsXattr
> 
>  typedef struct V9fsDir {
>      DIR *stream;
> -    CoMutex readdir_mutex;
> +    P9ProtoVersion proto_version;
> +    /* readdir mutex type used for 9P2000.u protocol variant */
> +    CoMutex readdir_mutex_u;
> +    /* readdir mutex type used for 9P2000.L protocol variant */
> +    QemuMutex readdir_mutex_L;
>  } V9fsDir;
> 
>  static inline void v9fs_readdir_lock(V9fsDir *dir)
>  {
> -    qemu_co_mutex_lock(&dir->readdir_mutex);
> +    if (dir->proto_version == V9FS_PROTO_2000U) {
> +        qemu_co_mutex_lock(&dir->readdir_mutex_u);
> +    } else {
> +        qemu_mutex_lock(&dir->readdir_mutex_L);
> +    }
>  }

I wonder whether I should make a minor addition to this patch: returnig an 
error to client if client sends T_readdir while not having opened the session 
as 9P2000.L, and likewise returning an error if client sends T_read on a 
directory while not using a 9P2000.u session. That would prevent the 
thoretical issue of a broken client using the wrong mutex type.

It's maybe overkill, since the plan was actually to bury this patch in git 
history by subsequently removing the lock entirely, but as I am preparing a v8 
anyway, and this is like 2 lines more, so probably not a big deal to add it.

>  static inline void v9fs_readdir_unlock(V9fsDir *dir)
>  {
> -    qemu_co_mutex_unlock(&dir->readdir_mutex);
> +    if (dir->proto_version == V9FS_PROTO_2000U) {
> +        qemu_co_mutex_unlock(&dir->readdir_mutex_u);
> +    } else {
> +        qemu_mutex_unlock(&dir->readdir_mutex_L);
> +    }
>  }
> 
> -static inline void v9fs_readdir_init(V9fsDir *dir)
> +static inline void v9fs_readdir_init(P9ProtoVersion proto_version, V9fsDir
> *dir) {
> -    qemu_co_mutex_init(&dir->readdir_mutex);
> +    dir->proto_version = proto_version;
> +    if (proto_version == V9FS_PROTO_2000U) {
> +        qemu_co_mutex_init(&dir->readdir_mutex_u);
> +    } else {
> +        qemu_mutex_init(&dir->readdir_mutex_L);
> +    }
>  }
> 
>  /**

Best regards,
Christian Schoenebeck



