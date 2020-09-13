Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE95C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 18:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC0A2158C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 18:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk21IZdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC0A2158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHXE3-0003Sp-Ec
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 14:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHXDI-00025Q-Gr
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 14:59:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56904
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHXDF-0004hJ-Gu
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 14:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600023536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CSjuQyAcrZWe4kAZgtkiUjl7JV2n0L7j/NPynspl3dQ=;
 b=Lk21IZdrATA+q6PhZcfQL+PxXsCSSqKhatGWYzq/dhSzmVw/aHSZ+VyLJ7LMK5JzW0tPTl
 ZgINolkePRWDCJGHuHIjSBVOO1F/sAl6xotuIqCcxUgIk/LkCPVs+nfSc/jzyG/SFO7D68
 Mp6twRiWgZvKehyyPlcsnXvpZ/CwXKc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-z1GZTHzEM--9PMfarpW74g-1; Sun, 13 Sep 2020 14:58:54 -0400
X-MC-Unique: z1GZTHzEM--9PMfarpW74g-1
Received: by mail-wr1-f69.google.com with SMTP id j7so5886314wro.14
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 11:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=CSjuQyAcrZWe4kAZgtkiUjl7JV2n0L7j/NPynspl3dQ=;
 b=gtqH5eCyLLQdCzDsetTLTx9IsvCbUs15AXP+HpRLjON92EuhCtH2SO9xb9Uos9mwD/
 swmw54gRbQzUHInbFyGoWV744ZFdAFhe1z6SoPYi5Pl5XKt5p6Z04zL+6nPS2+LgzO0W
 n0MOcxHefMUgXOl2Z68cNrJQCDM42874KhqVzzapNjhHuIn5sHXGELU094w3dZh8TpB0
 RZ59Zf8Z8wNNsdGbjg2a2yiMuZ2bOQmk0E4aOf5f/5/Q4EXdq2UB3Ua8CMbIJZl5nZ22
 zy6xOi/9uGMoMhy8stPOk7/y2b3PRRvfsCBE4EuqnKjJpLVo9Rdvtk5xlcAQNHkxVUxc
 2ZHQ==
X-Gm-Message-State: AOAM532noTLUWN/wnbm3CXpw6SwE5dGE50ldEd1CIizSnl6n59gi3/Wq
 p9RsWwSrvwE3Re0Hd+ci/CzMHe1DM8nXlrmYgoHUoPnMx21ZCnN3KtALLblDWltLylZyLMw4B4j
 kWV4fUqPjDSgy1PU=
X-Received: by 2002:adf:fa52:: with SMTP id y18mr12396603wrr.264.1600023533465; 
 Sun, 13 Sep 2020 11:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgyvgYQgRq5GALxgCYrlilAZXJ+mFd9DZlf2Qi0MMrhEMLDrn32LFbD0wAJrca759EST7bBA==
X-Received: by 2002:adf:fa52:: with SMTP id y18mr12396572wrr.264.1600023533173; 
 Sun, 13 Sep 2020 11:58:53 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h4sm13569889wrm.54.2020.09.13.11.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 11:58:52 -0700 (PDT)
Subject: Re: [PATCH v8 02/27] block: Fixes nfs compiling error on msys2/mingw
To: luoyonggang@gmail.com, Peter Lieven <pl@kamp.de>
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-3-luoyonggang@gmail.com>
 <5a805c5b-53d5-322e-1031-ddd68154b9e0@redhat.com>
 <CAE2XoE_HtV_YDEdjh2824G+Csz+yR-2WZg7JYb_DNkX=xPUA6A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <b2218d06-f52f-6c52-a57c-8fa5c5b20deb@redhat.com>
Date: Sun, 13 Sep 2020 20:58:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_HtV_YDEdjh2824G+Csz+yR-2WZg7JYb_DNkX=xPUA6A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 09:40:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/20 6:00 PM, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Sun, Sep 13, 2020 at 11:47 PM Philippe Mathieu-Daudé
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
> 
>     On 9/13/20 12:44 AM, Yonggang Luo wrote:
>     > These compiling errors are fixed:
>     > ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
>     >    27 | #include <poll.h>
>     >       |          ^~~~~~~~
>     > compilation terminated.
>     >
>     > ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
>     >    63 |     blkcnt_t st_blocks;
>     >       |     ^~~~~~~~
>     > ../block/nfs.c: In function 'nfs_client_open':
>     > ../block/nfs.c:550:27: error: 'struct _stat64' has no member named
>     'st_blocks'
>     >   550 |     client->st_blocks = st.st_blocks;
>     >       |                           ^
>     > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
>     > ../block/nfs.c:751:41: error: 'struct _stat64' has no member named
>     'st_blocks'
>     >   751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>     >       |                                         ^
>     > ../block/nfs.c: In function 'nfs_reopen_prepare':
>     > ../block/nfs.c:805:31: error: 'struct _stat64' has no member named
>     'st_blocks'
>     >   805 |         client->st_blocks = st.st_blocks;
>     >       |                               ^
>     > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
>     > ../block/nfs.c:752:1: error: control reaches end of non-void
>     function [-Werror=return-type]
>     >   752 | }
>     >       | ^
>     >
>     > On msys2/mingw, there is no st_blocks in struct _stat64, so we use
>     consistence st_size instead.
>     >
>     > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
>     <mailto:luoyonggang@gmail.com>>
>     > ---
>     >  block/nfs.c | 26 ++++++++++++++++++++++----
>     >  1 file changed, 22 insertions(+), 4 deletions(-)
>     >
>     > diff --git a/block/nfs.c b/block/nfs.c
>     > index 61a249a9fc..98b48f363b 100644
>     > --- a/block/nfs.c
>     > +++ b/block/nfs.c
>     > @@ -24,7 +24,9 @@
>     > 
>     >  #include "qemu/osdep.h"
>     > 
>     > +#if !defined(_WIN32)
>     >  #include <poll.h>
>     > +#endif
>     >  #include "qemu/config-file.h"
>     >  #include "qemu/error-report.h"
>     >  #include "qapi/error.h"
>     > @@ -51,6 +53,12 @@
>     >  #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
>     >  #define QEMU_NFS_MAX_DEBUG_LEVEL 2
>     > 
>     > +#if defined (_WIN32)
>     > +#define nfs_stat __stat64
>     > +#else
>     > +#define nfs_stat stat
>     > +#endif
>     > +
>     >  typedef struct NFSClient {
>     >      struct nfs_context *context;
>     >      struct nfsfh *fh;
>     > @@ -58,7 +66,9 @@ typedef struct NFSClient {
>     >      bool has_zero_init;
>     >      AioContext *aio_context;
>     >      QemuMutex mutex;
>     > +#if !defined (_WIN32)
>     >      blkcnt_t st_blocks;
> 
>     What about adding a "typedef off_t blkcnt_t;" or
>     similar typedef instead? Then no need to #ifdef
>     the st_blocks uses.
> 
> No, I did that before and someone else have objection 

What objection?

Again I had to look at the archives to find a comment from
Peter.

Maybe can be justified with:

"As st_blocks and st_size are not the same (st_blocks is
the number of allocated blocks on disk, while st_size is
the virtual size of a file as it may contain holes), we can
not easily add a typedef for blkcnt_t.
Anyhow as the get_allocated_file_size() block drive handler
is not mandatory, we can avoid implementing it on WIN32 by
using some #ifdef'ry."

These comments are useful for future developers. Because else
someone might want to improve your patch, add the typedef and
if Peter is not reviewing this, we might miss that again.

> 
> 
>     > +#endif
>     >      bool cache_used;
>     >      NFSServer *server;
>     >      char *path;
>     > @@ -70,7 +80,7 @@ typedef struct NFSRPC {
>     >      int ret;
>     >      int complete;
>     >      QEMUIOVector *iov;
>     > -    struct stat *st;
>     > +    struct nfs_stat *st;
>     >      Coroutine *co;
>     >      NFSClient *client;
>     >  } NFSRPC;
>     > @@ -419,7 +429,7 @@ static int64_t nfs_client_open(NFSClient
>     *client, BlockdevOptionsNfs *opts,
>     >                                 int flags, int open_flags, Error
>     **errp)
>     >  {
>     >      int64_t ret = -EINVAL;
>     > -    struct stat st;
>     > +    struct nfs_stat st;
>     >      char *file = NULL, *strp = NULL;
>     > 
>     >      qemu_mutex_init(&client->mutex);
>     > @@ -545,7 +555,9 @@ static int64_t nfs_client_open(NFSClient
>     *client, BlockdevOptionsNfs *opts,
>     >      }
>     > 
>     >      ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
>     > +#if !defined (_WIN32)
>     >      client->st_blocks = st.st_blocks;
>     > +#endif
>     >      client->has_zero_init = S_ISREG(st.st_mode);
>     >      *strp = '/';
>     >      goto out;
>     > @@ -706,6 +718,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
>     >      return client->has_zero_init;
>     >  }
>     > 
>     > +#if !defined (_WIN32)
>     >  /* Called (via nfs_service) with QemuMutex held.  */
>     >  static void
>     >  nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs,
>     void *data,
>     > @@ -729,7 +742,7 @@ static int64_t
>     nfs_get_allocated_file_size(BlockDriverState *bs)
>     >  {
>     >      NFSClient *client = bs->opaque;
>     >      NFSRPC task = {0};
>     > -    struct stat st;
>     > +    struct nfs_stat st;
>     > 
>     >      if (bdrv_is_read_only(bs) &&
>     >          !(bs->open_flags & BDRV_O_NOCACHE)) {
>     > @@ -748,6 +761,7 @@ static int64_t
>     nfs_get_allocated_file_size(BlockDriverState *bs)
>     > 
>     >      return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>     >  }
>     > +#endif
>     > 
>     >  static int coroutine_fn
>     >  nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool
>     exact,
>     > @@ -778,7 +792,7 @@ static int nfs_reopen_prepare(BDRVReopenState
>     *state,
>     >                                BlockReopenQueue *queue, Error **errp)
>     >  {
>     >      NFSClient *client = state->bs->opaque;
>     > -    struct stat st;
>     > +    struct nfs_stat st;
>     >      int ret = 0;
>     > 
>     >      if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
>     > @@ -800,7 +814,9 @@ static int nfs_reopen_prepare(BDRVReopenState
>     *state,
>     >                         nfs_get_error(client->context));
>     >              return ret;
>     >          }
>     > +#if !defined (_WIN32)
>     >          client->st_blocks = st.st_blocks;
>     > +#endif
>     >      }
>     > 
>     >      return 0;
>     > @@ -869,7 +885,9 @@ static BlockDriver bdrv_nfs = {
>     >      .create_opts                    = &nfs_create_opts,
>     > 
>     >      .bdrv_has_zero_init             = nfs_has_zero_init,
>     > +#if !defined (_WIN32)
>     >      .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
>     > +#endif
>     >      .bdrv_co_truncate               = nfs_file_co_truncate,
>     > 
>     >      .bdrv_file_open                 = nfs_file_open,
>     >
> 
> 
> 
> -- 
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo


