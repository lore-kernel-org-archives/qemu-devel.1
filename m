Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B788FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 22:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD0620724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 22:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZb7BBhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD0620724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnr9W-0002s4-OF
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 18:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnr8m-00025b-0l
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 18:11:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40215
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnr8j-0005Uj-Rq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 18:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592950296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=we0XtmznPjaX5lmaWubAQg5QxkG+T6wju11fIzy8hOc=;
 b=IZb7BBhQnF7lQnRmAFKyG2hAwzhDaVgQZs0Zbo/1XBskHh+buBhawI1RroO8GTR6E10xao
 TqB/AXklpAm+ZdgbRLiuMBplZPClfeiAwhJXsbDGMVmjSyMUCkDFBD3JxbNjYVSj6+u7K8
 lQLHD2Ie2Q3xYeaRsC8e4O9A42NqtO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-bgIhBtXBNtqZcqiR6oQZGw-1; Tue, 23 Jun 2020 18:11:17 -0400
X-MC-Unique: bgIhBtXBNtqZcqiR6oQZGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08FD4184D157;
 Tue, 23 Jun 2020 22:11:15 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C47E37166A;
 Tue, 23 Jun 2020 22:11:06 +0000 (UTC)
Subject: Re: [PATCH v3 12/17] block/block-backend: convert blk io path to use
 int64_t parameters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-13-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <06a4ac27-f9ca-27be-afce-baaf848bdee3@redhat.com>
Date: Tue, 23 Jun 2020 17:11:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200430111033.29980-13-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:54:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 6:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths.
> 
> Main motivation is realization of 64-bit write_zeroes operation for
> fast zeroing large disk chunks, up to the whole disk.
> 
> We chose signed type, to be consistent with off_t (which is signed) and
> with possibility for signed return type (where negative value means
> error).
> 
> Now bdrv layer is converted, convert blk layer too.

In fact, I just discovered thanks to 
https://bugs.launchpad.net/qemu/+bug/1884831 that NBD is a case of a 
client that can currently pass values larger than 2G into 
blk_co_pdiscard() which in turn appears as a negative value and instant 
EIO failure.  So this is a bug fix visible to NBD clients.

$ gdb --args ./qemu-nbd --trace=nbd_\* -f raw f --port 10810
...
(gdb) b blk_co_pdiscard
(gdb) r
...
$ nbdsh -u nbd://localhost:10810 -c 'h.trim(3*1024*1024*1024,0)'
...
Thread 1 "qemu-nbd" hit Breakpoint 3, blk_co_pdiscard (blk=0x555555832dc0,
     offset=0, bytes=-1073741824)

Looks like I now have even more reason to accelerate my review of the 
remainder of this series, and to take some (if not all) of it through 
the NBD tree.


> +++ b/include/sysemu/block-backend.h
> @@ -119,14 +119,14 @@ BlockBackend *blk_by_dev(void *dev);
>   BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
>   void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
>   int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
> -                               unsigned int bytes, QEMUIOVector *qiov,
> +                               int64_t bytes, QEMUIOVector *qiov,
>                                  BdrvRequestFlags flags);
>   int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
> -                                     unsigned int bytes,
> +                                     int64_t bytes,
>                                        QEMUIOVector *qiov, size_t qiov_offset,
>                                        BdrvRequestFlags flags);
>   int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
> -                               unsigned int bytes, QEMUIOVector *qiov,
> +                               int64_t bytes, QEMUIOVector *qiov,
>                                  BdrvRequestFlags flags);

pread and pwrite weren't necessarily problems for NBD (since our NBD 
implementation caps things to 32M per packet).

>   
>   static inline int coroutine_fn blk_co_pread(BlockBackend *blk, int64_t offset,
> @@ -148,13 +148,13 @@ static inline int coroutine_fn blk_co_pwrite(BlockBackend *blk, int64_t offset,
>   }
>   
>   int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
> -                      int bytes, BdrvRequestFlags flags);
> +                      int64_t bytes, BdrvRequestFlags flags);
>   BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
> -                                  int bytes, BdrvRequestFlags flags,
> +                                  int64_t bytes, BdrvRequestFlags flags,
>                                     BlockCompletionFunc *cb, void *opaque);

But this change to writing zeroes,

>   int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
> -int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int bytes);
> -int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int bytes,
> +int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int64_t bytes);
> +int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int64_t bytes,
>                  BdrvRequestFlags flags);
>   int64_t blk_getlength(BlockBackend *blk);
>   void blk_get_geometry(BlockBackend *blk, uint64_t *nb_sectors_ptr);
> @@ -167,14 +167,14 @@ BlockAIOCB *blk_aio_pwritev(BlockBackend *blk, int64_t offset,
>                               BlockCompletionFunc *cb, void *opaque);
>   BlockAIOCB *blk_aio_flush(BlockBackend *blk,
>                             BlockCompletionFunc *cb, void *opaque);
> -BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int bytes,
> +BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes,
>                                BlockCompletionFunc *cb, void *opaque);

and this change to discard are definitely both bug fixes for NBD 
clients, especially now that we have a real-world case of a client 
(namely the blkdiscard app triggering ioctl(BLKDISCARD) handling through 
nbd.ko as client) that actually triggers a >2G trim request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


