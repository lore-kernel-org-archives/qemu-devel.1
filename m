Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F9AC43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459F7205CB
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 15:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zsz8aYEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459F7205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUF2-0001r8-U9
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 11:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHUE2-0000h0-Mj
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:47:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55066
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHUDz-0007ug-L7
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 11:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600012050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J8Ovgx7+rzDczgvSY21yiYPQE4BWryp7+az/9U9nWtE=;
 b=Zsz8aYErDCrZda3B8M+Ay/56HJeWffzfJNIwnVwRb4U5seWjg60wfktWObRNRqjPyB6B5+
 +Oh+xCcFJCDsIqQObuR0x8Wp6vwIwNkv/mfWPYDl3uoSIF2T3XRME3tp6R3vbnOkilMigF
 BzkoTwkiEpbmCZeUzw4KIxHXXq7a/6M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-gmVnWCIwNe-MxaOMeh2aOA-1; Sun, 13 Sep 2020 11:47:28 -0400
X-MC-Unique: gmVnWCIwNe-MxaOMeh2aOA-1
Received: by mail-wr1-f70.google.com with SMTP id j7so5722550wro.14
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 08:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=J8Ovgx7+rzDczgvSY21yiYPQE4BWryp7+az/9U9nWtE=;
 b=sMQZAAIvPQXP6Uq6FptMtB/3YEeKCe2dRxA1JiU2h8bz2ztIVqSj6KV0HeA5DbaqoD
 aLLSuYENFcgYYdXkUqEyftlgDsiliIPHtp2yn3jv9ORefoZCnvJp84JRI5t/4IQjP5c7
 a1Pg3vPP4oefQQccwuZiQ5vVjSaj/cQ6kjRXYYjggKdLtAYmo2PhAFHWmcHekL6r5CiL
 2zA+h5JnmkokeggdymUve771fchtdd34v+Z02It6h/muvSjRp5xbJZY1mpswNVNEJcfc
 e1PCAQozUfockJ7lwobiqszSfDWzSNvUmEIZXC8C/EfoIVslwwt/tQkhXv/4HgYBiJga
 j/YA==
X-Gm-Message-State: AOAM5308uRgzF6t79h/UVWrw3yf3IU4TfVEKgccaIuY8GiRS0GEqEjfl
 /aKRRtI+VE0ki9nM6efu+zZtvVf6nRZylyo2ZuX9n+uL7lsufYF/dCc9870Nx2UrC3zsbxxPwjr
 uSo1F2WF5E/ytTvI=
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr11199996wmi.107.1600012047137; 
 Sun, 13 Sep 2020 08:47:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAcKLi44Brz8LmVEWyoRtd2SSu2WofNVew6RjMo7ruO8HiQKvH5eheCuIhDchAnFq+6k3NnQ==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr11199969wmi.107.1600012046876; 
 Sun, 13 Sep 2020 08:47:26 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q84sm3258839wme.23.2020.09.13.08.47.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 08:47:26 -0700 (PDT)
Subject: Re: [PATCH v8 02/27] block: Fixes nfs compiling error on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-3-luoyonggang@gmail.com>
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
Message-ID: <5a805c5b-53d5-322e-1031-ddd68154b9e0@redhat.com>
Date: Sun, 13 Sep 2020 17:47:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912224431.1428-3-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 11:28:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/20 12:44 AM, Yonggang Luo wrote:
> These compiling errors are fixed:
> ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
>    27 | #include <poll.h>
>       |          ^~~~~~~~
> compilation terminated.
> 
> ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
>    63 |     blkcnt_t st_blocks;
>       |     ^~~~~~~~
> ../block/nfs.c: In function 'nfs_client_open':
> ../block/nfs.c:550:27: error: 'struct _stat64' has no member named 'st_blocks'
>   550 |     client->st_blocks = st.st_blocks;
>       |                           ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:751:41: error: 'struct _stat64' has no member named 'st_blocks'
>   751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>       |                                         ^
> ../block/nfs.c: In function 'nfs_reopen_prepare':
> ../block/nfs.c:805:31: error: 'struct _stat64' has no member named 'st_blocks'
>   805 |         client->st_blocks = st.st_blocks;
>       |                               ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:752:1: error: control reaches end of non-void function [-Werror=return-type]
>   752 | }
>       | ^
> 
> On msys2/mingw, there is no st_blocks in struct _stat64, so we use consistence st_size instead.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  block/nfs.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/block/nfs.c b/block/nfs.c
> index 61a249a9fc..98b48f363b 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -24,7 +24,9 @@
>  
>  #include "qemu/osdep.h"
>  
> +#if !defined(_WIN32)
>  #include <poll.h>
> +#endif
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -51,6 +53,12 @@
>  #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
>  #define QEMU_NFS_MAX_DEBUG_LEVEL 2
>  
> +#if defined (_WIN32)
> +#define nfs_stat __stat64
> +#else
> +#define nfs_stat stat
> +#endif
> +
>  typedef struct NFSClient {
>      struct nfs_context *context;
>      struct nfsfh *fh;
> @@ -58,7 +66,9 @@ typedef struct NFSClient {
>      bool has_zero_init;
>      AioContext *aio_context;
>      QemuMutex mutex;
> +#if !defined (_WIN32)
>      blkcnt_t st_blocks;

What about adding a "typedef off_t blkcnt_t;" or
similar typedef instead? Then no need to #ifdef
the st_blocks uses.

> +#endif
>      bool cache_used;
>      NFSServer *server;
>      char *path;
> @@ -70,7 +80,7 @@ typedef struct NFSRPC {
>      int ret;
>      int complete;
>      QEMUIOVector *iov;
> -    struct stat *st;
> +    struct nfs_stat *st;
>      Coroutine *co;
>      NFSClient *client;
>  } NFSRPC;
> @@ -419,7 +429,7 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
>                                 int flags, int open_flags, Error **errp)
>  {
>      int64_t ret = -EINVAL;
> -    struct stat st;
> +    struct nfs_stat st;
>      char *file = NULL, *strp = NULL;
>  
>      qemu_mutex_init(&client->mutex);
> @@ -545,7 +555,9 @@ static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
>      }
>  
>      ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> +#if !defined (_WIN32)
>      client->st_blocks = st.st_blocks;
> +#endif
>      client->has_zero_init = S_ISREG(st.st_mode);
>      *strp = '/';
>      goto out;
> @@ -706,6 +718,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
>      return client->has_zero_init;
>  }
>  
> +#if !defined (_WIN32)
>  /* Called (via nfs_service) with QemuMutex held.  */
>  static void
>  nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
> @@ -729,7 +742,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
>  {
>      NFSClient *client = bs->opaque;
>      NFSRPC task = {0};
> -    struct stat st;
> +    struct nfs_stat st;
>  
>      if (bdrv_is_read_only(bs) &&
>          !(bs->open_flags & BDRV_O_NOCACHE)) {
> @@ -748,6 +761,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
>  
>      return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>  }
> +#endif
>  
>  static int coroutine_fn
>  nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
> @@ -778,7 +792,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>                                BlockReopenQueue *queue, Error **errp)
>  {
>      NFSClient *client = state->bs->opaque;
> -    struct stat st;
> +    struct nfs_stat st;
>      int ret = 0;
>  
>      if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> @@ -800,7 +814,9 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>                         nfs_get_error(client->context));
>              return ret;
>          }
> +#if !defined (_WIN32)
>          client->st_blocks = st.st_blocks;
> +#endif
>      }
>  
>      return 0;
> @@ -869,7 +885,9 @@ static BlockDriver bdrv_nfs = {
>      .create_opts                    = &nfs_create_opts,
>  
>      .bdrv_has_zero_init             = nfs_has_zero_init,
> +#if !defined (_WIN32)
>      .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
> +#endif
>      .bdrv_co_truncate               = nfs_file_co_truncate,
>  
>      .bdrv_file_open                 = nfs_file_open,
> 


