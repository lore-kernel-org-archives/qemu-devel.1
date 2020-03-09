Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63658C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF8E20727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="OGqOnNzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF8E20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJ6x-0005xl-8J
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jBJ5y-0005GE-RC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jBJ5w-0000MP-Cc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:09:26 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:39423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jBJ5v-0000LN-VE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=vFHDAWnHNjEOiBnYg/8boE8TwzKlfidXyu/gSNlwqq0=; b=OGqOnNzPPMQjyld19V52e78r5B
 +sQBPD7ZzEZvS/KTAxgegAxbUkPdKSwzNLyH9YqZT9Tr1gCUR1yhxqPXoscX9CkuiAb+NdALEjTDI
 QybzZ6hbjvP1dlbOcHO7vGnFqwK9xVKMoNx7Lk38/aoSBvDZZZ1fyEkzBTBWfAD1/OAPrngfkIK6f
 w0Va+Lzb4CkjDtoHHFyx/3uFrYSxs9Wf5WDJJroUbZXCG8SiPoVQtEQOa4iAt5s8RMze6HH7jO9GF
 kEs910asebVSx9S7k0jnn7W/+nnJz7Hd2ggPm7y9TBYtskWlbYdk4U/iBRInr3zA8PrealJOZq7lv
 IzjVBLCztNDyhJLw0FGCL0mZ2GWRSjNR7H1JcEfaQ9/mn90zxUR+Tu/3AnOos3Xw7HZX42ixTXfhY
 6ETVytRknxpfJrbZ4JuvgDMF5HM1TZcu0gRNOqh3tIvNWxEqSQlUAeQwZcXkgCVaBQJsGKuh/PFSM
 0FegyzwXgPwMo2BqiKN18aEBbwJVWVm7PssSK2BYh0m8VvoQ2sNrnqFMbEyi+bmu6VaJlFOrytwse
 iIxcfI5vDGuxpY4nFUgZOIFcXuTKsRnrCj49KGtvlwQJX803pIF6bAAHFWZ7f9BES3x4RGN4SAU05
 +e9Vud5RfmxYvZ/OpA8vAXsi5j/yPonUFMzT/HeqU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 10/11] 9pfs: T_readdir latency optimization
Date: Mon, 09 Mar 2020 15:09:21 +0100
Message-ID: <1706149.tZr2OiJYdg@silver>
In-Reply-To: <cbd48794ab09613589719b37b147589cda5af6dd.1579567020.git.qemu_oss@crudebyte.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <cbd48794ab09613589719b37b147589cda5af6dd.1579567020.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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

On Dienstag, 21. Januar 2020 01:30:10 CET Christian Schoenebeck wrote:
> Make top half really top half and bottom half really bottom half:
> 
> Each T_readdir request handling is hopping between threads (main
> I/O thread and background I/O driver threads) several times for
> every individual directory entry, which sums up to huge latencies
> for handling just a single T_readdir request.
> 
> Instead of doing that, collect now all required directory entries
> (including all potentially required stat buffers for each entry) in
> one rush on a background I/O thread from fs driver, then assemble
> the entire resulting network response message for the readdir
> request on main I/O thread. The fs driver is still aborting the
> directory entry retrieval loop (on the background I/O thread) as
> soon as it would exceed the client's requested maximum R_readdir
> response size. So we should not have any performance penalty by
> doing this.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

PING! Idle for 7 weeks.

Could anybody help out reviewing this particular patch 10?

Complete thread:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg04418.html

Patches 1..5 are already on master. Subsequent patches already have been 
reviewed, this patch 10 is the only one not being reviewed at all yet.

Test cases and benchmark patches are provided by thread, instructions to run 
them as well.

>  hw/9pfs/9p.c    | 124 +++++++++++++++-----------------
>  hw/9pfs/9p.h    |  23 ++++++
>  hw/9pfs/codir.c | 183 +++++++++++++++++++++++++++++++++++++++++++++---
>  hw/9pfs/coth.h  |   3 +
>  4 files changed, 254 insertions(+), 79 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 18370183c4..e0ca45d46b 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -971,30 +971,6 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu,
> V9fsFidState *fidp, return 0;
>  }
> 
> -static int coroutine_fn dirent_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
> -                                      struct dirent *dent, V9fsQID *qidp)
> -{
> -    struct stat stbuf;
> -    V9fsPath path;
> -    int err;
> -
> -    v9fs_path_init(&path);
> -
> -    err = v9fs_co_name_to_path(pdu, &fidp->path, dent->d_name, &path);
> -    if (err < 0) {
> -        goto out;
> -    }
> -    err = v9fs_co_lstat(pdu, &path, &stbuf);
> -    if (err < 0) {
> -        goto out;
> -    }
> -    err = stat_to_qid(pdu, &stbuf, qidp);
> -
> -out:
> -    v9fs_path_free(&path);
> -    return err;
> -}
> -
>  V9fsPDU *pdu_alloc(V9fsState *s)
>  {
>      V9fsPDU *pdu = NULL;
> @@ -2314,7 +2290,7 @@ out_nofid:
>      pdu_complete(pdu, err);
>  }
> 
> -static size_t v9fs_readdir_data_size(V9fsString *name)
> +size_t v9fs_readdir_response_size(V9fsString *name)
>  {
>      /*
>       * Size of each dirent on the wire: size of qid (13) + size of offset
> (8) @@ -2323,6 +2299,18 @@ static size_t v9fs_readdir_data_size(V9fsString
> *name) return 24 + v9fs_string_size(name);
>  }
> 
> +static void v9fs_free_dirents(struct V9fsDirEnt *e)
> +{
> +    struct V9fsDirEnt *next = NULL;
> +
> +    for (; e; e = next) {
> +        next = e->next;
> +        g_free(e->dent);
> +        g_free(e->st);
> +        g_free(e);
> +    }
> +}
> +
>  static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>                                          int32_t max_count)
>  {
> @@ -2331,54 +2319,53 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU
> *pdu, V9fsFidState *fidp, V9fsString name;
>      int len, err = 0;
>      int32_t count = 0;
> -    off_t saved_dir_pos;
>      struct dirent *dent;
> +    struct stat *st;
> +    struct V9fsDirEnt *entries = NULL;
> 
> -    /* save the directory position */
> -    saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> -    if (saved_dir_pos < 0) {
> -        return saved_dir_pos;
> -    }
> -
> -    while (1) {
> -        v9fs_readdir_lock(&fidp->fs.dir);
> +    /*
> +     * inode remapping requires the device id, which in turn might be
> +     * different for different directory entries, so if inode remapping is
> +     * enabled we have to make a full stat for each directory entry
> +     */
> +    const bool dostat = pdu->s->ctx.export_flags & V9FS_REMAP_INODES;
> 
> -        err = v9fs_co_readdir(pdu, fidp, &dent);
> -        if (err || !dent) {
> -            break;
> -        }
> -        v9fs_string_init(&name);
> -        v9fs_string_sprintf(&name, "%s", dent->d_name);
> -        if ((count + v9fs_readdir_data_size(&name)) > max_count) {
> -            v9fs_readdir_unlock(&fidp->fs.dir);
> +    /*
> +     * Fetch all required directory entries altogether on a background IO
> +     * thread from fs driver. We don't want to do that for each entry
> +     * individually, because hopping between threads (this main IO thread
> +     * and background IO driver thread) would sum up to huge latencies.
> +     */
> +    count = v9fs_co_readdir_lowlat(pdu, fidp, &entries, max_count, dostat);
> +    if (count < 0) {
> +        err = count;
> +        count = 0;
> +        goto out;
> +    }
> +    count = 0;
> 
> -            /* Ran out of buffer. Set dir back to old position and return
> */ -            v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> -            v9fs_string_free(&name);
> -            return count;
> -        }
> +    for (struct V9fsDirEnt *e = entries; e; e = e->next) {
> +        dent = e->dent;
> 
>          if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
> -            /*
> -             * dirent_to_qid() implies expensive stat call for each entry,
> -             * we must do that here though since inode remapping requires
> -             * the device id, which in turn might be different for
> -             * different entries; we cannot make any assumption to avoid
> -             * that here.
> -             */
> -            err = dirent_to_qid(pdu, fidp, dent, &qid);
> +            st = e->st;
> +            /* e->st should never be NULL, but just to be sure */
> +            if (!st) {
> +                err = -1;
> +                break;
> +            }
> +
> +            /* remap inode */
> +            err = stat_to_qid(pdu, st, &qid);
>              if (err < 0) {
> -                v9fs_readdir_unlock(&fidp->fs.dir);
> -                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> -                v9fs_string_free(&name);
> -                return err;
> +                break;
>              }
>          } else {
>              /*
>               * Fill up just the path field of qid because the client uses
>               * only that. To fill the entire qid structure we will have
>               * to stat each dirent found, which is expensive. For the
> -             * latter reason we don't call dirent_to_qid() here. Only
> drawback +             * latter reason we don't call stat_to_qid() here.
> Only drawback * is that no multi-device export detection of stat_to_qid() *
> would be done and provided as error to the user here. But * user would get
> that error anyway when accessing those @@ -2391,25 +2378,26 @@ static int
> coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp, qid.version
> = 0;
>          }
> 
> +        v9fs_string_init(&name);
> +        v9fs_string_sprintf(&name, "%s", dent->d_name);
> +
>          /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
>          len = pdu_marshal(pdu, 11 + count, "Qqbs",
>                            &qid, dent->d_off,
>                            dent->d_type, &name);
> 
> -        v9fs_readdir_unlock(&fidp->fs.dir);
> +        v9fs_string_free(&name);
> 
>          if (len < 0) {
> -            v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> -            v9fs_string_free(&name);
> -            return len;
> +            err = len;
> +            break;
>          }
> +
>          count += len;
> -        v9fs_string_free(&name);
> -        saved_dir_pos = dent->d_off;
>      }
> 
> -    v9fs_readdir_unlock(&fidp->fs.dir);
> -
> +out:
> +    v9fs_free_dirents(entries);
>      if (err < 0) {
>          return err;
>      }
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 6fffe44f5a..1dbb0ad189 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -215,6 +215,28 @@ static inline void v9fs_readdir_init(V9fsDir *dir)
>      qemu_mutex_init(&dir->readdir_mutex);
>  }
> 
> +/*
> + * Type for 9p fs drivers' (a.k.a. 9p backends) result of readdir requests,
> + * which is a chained list of directory entries.
> + */
> +typedef struct V9fsDirEnt {
> +    /* mandatory (must not be NULL) information for all readdir requests */
> +    struct dirent *dent;
> +    /*
> +     * optional (may be NULL): A full stat of each directory entry is just
> +     * done if explicitly told to fs driver.
> +     */
> +    struct stat *st;
> +    /*
> +     * instead of an array, directory entries are always returned as
> +     * chained list, that's because the amount of entries retrieved by fs
> +     * drivers is dependent on the individual entries' name (since response
> +     * messages are size limited), so the final amount cannot be estimated
> +     * before hand
> +     */
> +    struct V9fsDirEnt *next;
> +} V9fsDirEnt;
> +
>  /*
>   * Filled by fs driver on open and other
>   * calls.
> @@ -419,6 +441,7 @@ void v9fs_path_init(V9fsPath *path);
>  void v9fs_path_free(V9fsPath *path);
>  void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...);
>  void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src);
> +size_t v9fs_readdir_response_size(V9fsString *name);
>  int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
>                        const char *name, V9fsPath *path);
>  int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
> diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> index 73f9a751e1..6ce7dc8cde 100644
> --- a/hw/9pfs/codir.c
> +++ b/hw/9pfs/codir.c
> @@ -18,28 +18,189 @@
>  #include "qemu/main-loop.h"
>  #include "coth.h"
> 
> +/*
> + * This is solely executed on a background IO thread.
> + */
> +static int do_readdir(V9fsPDU *pdu, V9fsFidState *fidp, struct dirent
> **dent) +{
> +    int err = 0;
> +    V9fsState *s = pdu->s;
> +    struct dirent *entry;
> +
> +    errno = 0;
> +    entry = s->ops->readdir(&s->ctx, &fidp->fs);
> +    if (!entry && errno) {
> +        *dent = NULL;
> +        err = -errno;
> +    } else {
> +        *dent = entry;
> +    }
> +    return err;
> +}
> +
> +/*
> + * TODO: This will be removed for performance reasons.
> + * Use v9fs_co_readdir_lowlat() instead.
> + */
>  int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>                                   struct dirent **dent)
>  {
>      int err;
> -    V9fsState *s = pdu->s;
> 
>      if (v9fs_request_cancelled(pdu)) {
>          return -EINTR;
>      }
> -    v9fs_co_run_in_worker(
> -        {
> -            struct dirent *entry;
> +    v9fs_co_run_in_worker({
> +        err = do_readdir(pdu, fidp, dent);
> +    });
> +    return err;
> +}
> +
> +/*
> + * This is solely executed on a background IO thread.
> + *
> + * See v9fs_co_readdir_lowlat() (as its only user) below for details.
> + */
> +static int do_readdir_lowlat(V9fsPDU *pdu, V9fsFidState *fidp,
> +                             struct V9fsDirEnt **entries,
> +                             int32_t maxsize, bool dostat)
> +{
> +    V9fsState *s = pdu->s;
> +    V9fsString name;
> +    int len, err = 0;
> +    int32_t size = 0;
> +    off_t saved_dir_pos;
> +    struct dirent *dent;
> +    struct V9fsDirEnt *e = NULL;
> +    V9fsPath path;
> +    struct stat stbuf;
> +
> +    *entries = NULL;
> +    v9fs_path_init(&path);
> +
> +    /*
> +     * TODO: Here should be a warn_report_once() if lock failed.
> +     *
> +     * With a good 9p client we should not get into concurrency here,
> +     * because a good client would not use the same fid for concurrent
> +     * requests. We do the lock here for safety reasons though. However
> +     * the client would then suffer performance issues, so better log that
> +     * issue here.
> +     */
> +    v9fs_readdir_lock(&fidp->fs.dir);
> +
> +    /* save the directory position */
> +    saved_dir_pos = s->ops->telldir(&s->ctx, &fidp->fs);
> +    if (saved_dir_pos < 0) {
> +        err = saved_dir_pos;
> +        goto out;
> +    }
> +
> +    while (true) {
> +        /* get directory entry from fs driver */
> +        err = do_readdir(pdu, fidp, &dent);
> +        if (err || !dent) {
> +            break;
> +        }
> +
> +        /*
> +         * stop this loop as soon as it would exceed the allowed maximum
> +         * response message size for the directory entries collected so
> far, +         * because anything beyond that size would need to be
> discarded by +         * 9p controller (main thread / top half) anyway
> +         */
> +        v9fs_string_init(&name);
> +        v9fs_string_sprintf(&name, "%s", dent->d_name);
> +        len = v9fs_readdir_response_size(&name);
> +        v9fs_string_free(&name);
> +        if (size + len > maxsize) {
> +            /* this is not an error case actually */
> +            break;
> +        }
> +
> +        /* append next node to result chain */
> +        if (!e) {
> +            *entries = e = g_malloc0(sizeof(V9fsDirEnt));
> +        } else {
> +            e = e->next = g_malloc0(sizeof(V9fsDirEnt));
> +        }
> +        e->dent = g_malloc0(sizeof(struct dirent));
> +        memcpy(e->dent, dent, sizeof(struct dirent));
> 
> -            errno = 0;
> -            entry = s->ops->readdir(&s->ctx, &fidp->fs);
> -            if (!entry && errno) {
> +        /* perform a full stat() for directory entry if requested by caller
> */ +        if (dostat) {
> +            err = s->ops->name_to_path(
> +                &s->ctx, &fidp->path, dent->d_name, &path
> +            );
> +            if (err < 0) {
>                  err = -errno;
> -            } else {
> -                *dent = entry;
> -                err = 0;
> +                break;
>              }
> -        });
> +
> +            err = s->ops->lstat(&s->ctx, &path, &stbuf);
> +            if (err < 0) {
> +                err = -errno;
> +                break;
> +            }
> +
> +            e->st = g_malloc0(sizeof(struct stat));
> +            memcpy(e->st, &stbuf, sizeof(struct stat));
> +        }
> +
> +        size += len;
> +        saved_dir_pos = dent->d_off;
> +    }
> +
> +    /* restore (last) saved position */
> +    s->ops->seekdir(&s->ctx, &fidp->fs, saved_dir_pos);
> +
> +out:
> +    v9fs_readdir_unlock(&fidp->fs.dir);
> +    v9fs_path_free(&path);
> +    if (err < 0) {
> +        return err;
> +    }
> +    return size;
> +}
> +
> +/**
> + * @brief Low latency variant of fs driver readdir handling.
> + *
> + * Retrieves the requested (max. amount of) directory entries from the fs
> + * driver. This function must only be called by the main IO thread (top
> half). + * Internally this function call will be dispatched to a background
> IO thread + * (bottom half) where it is eventually executed by the fs
> driver. + *
> + * The old readdir implementation above just retrieves always one dir entry
> + * per call. The problem of that implementation above is that latency is +
> * added for (retrieval of) each directory entry, which in practice lead to
> + * latencies of several hundred ms for readdir of only one directory. + *
> + * This is avoided in this function by letting the fs driver retrieve all
> + * required directory entries with only call of this function and hence
> with + * only a single fs driver request.
> + *
> + * @param pdu - the causing 9p (T_readdir) client request
> + * @param fidp - already opened directory where readdir shall be performed
> on + * @param entries - output for directory entries (must not be NULL) + *
> @param maxsize - maximum result message body size (in bytes)
> + * @param dostat - whether a stat() should be performed and returned for
> + *                 each directory entry
> + * @returns resulting response message body size (in bytes) on success,
> + *          negative error code otherwise
> + */
> +int coroutine_fn v9fs_co_readdir_lowlat(V9fsPDU *pdu, V9fsFidState *fidp,
> +                                        struct V9fsDirEnt **entries,
> +                                        int32_t maxsize, bool dostat)
> +{
> +    int err = 0;
> +
> +    if (v9fs_request_cancelled(pdu)) {
> +        return -EINTR;
> +    }
> +    v9fs_co_run_in_worker({
> +        err = do_readdir_lowlat(pdu, fidp, entries, maxsize, dostat);
> +    });
>      return err;
>  }
> 
> diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
> index c2cdc7a9ea..1249dbe6df 100644
> --- a/hw/9pfs/coth.h
> +++ b/hw/9pfs/coth.h
> @@ -49,6 +49,9 @@
>  void co_run_in_worker_bh(void *);
>  int coroutine_fn v9fs_co_readlink(V9fsPDU *, V9fsPath *, V9fsString *);
>  int coroutine_fn v9fs_co_readdir(V9fsPDU *, V9fsFidState *, struct dirent
> **); +int coroutine_fn v9fs_co_readdir_lowlat(V9fsPDU *, V9fsFidState *, + 
>                                       struct V9fsDirEnt **,
> +                                        int32_t, bool);
>  off_t coroutine_fn v9fs_co_telldir(V9fsPDU *, V9fsFidState *);
>  void coroutine_fn v9fs_co_seekdir(V9fsPDU *, V9fsFidState *, off_t);
>  void coroutine_fn v9fs_co_rewinddir(V9fsPDU *, V9fsFidState *);



