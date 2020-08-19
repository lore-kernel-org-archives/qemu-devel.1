Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919F5C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C26207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0r6seC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C26207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Tqs-0004X1-Lj
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 15:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8TqC-0003m3-Jn
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:33:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8Tq9-0001Z2-3D
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597865619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8gYDUhf1ZlJOPVEZPjAfjw1s+gDKRXRueaC6mAZQLo=;
 b=V0r6seC041b3oAUXhdMjz6rwfJvmThLkttDzO1XDkOfgPHH/OSHiD9ABpShbFQMGWexysi
 vjQDfqllCQNgN/d+oxYtsESCJoANpqeg6LZ//ziQ3xfCR5nUKo4WVMCynOJY3Ahtpnn22a
 ReH1sq0kwsrpliuXTbnd5f8vVwxcalo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-9OP0q50hPbOMG8RT3N94pw-1; Wed, 19 Aug 2020 15:33:38 -0400
X-MC-Unique: 9OP0q50hPbOMG8RT3N94pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 392B964080;
 Wed, 19 Aug 2020 19:33:37 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAA0526DD4;
 Wed, 19 Aug 2020 19:33:36 +0000 (UTC)
Subject: Re: [RFC PATCH 06/22] qemu-nbd: Use raw block driver for --offset
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-7-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4f9e0b0e-3f70-6237-86b3-c43c29847a0d@redhat.com>
Date: Wed, 19 Aug 2020 14:33:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-7-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 11:29 AM, Kevin Wolf wrote:
> Instead of implementing qemu-nbd --offset in the NBD code, just put a
> raw block node with the requested offset on top of the user image and
> rely on that doing the job.
> 
> This does not only simplify the nbd_export_new() interface and bring it
> closer to the set of options that the nbd-server-add QMP command offers,
> but in fact it also eliminates a potential source for bugs in the NBD
> code which previously had to add the offset manually in all relevant
> places.

Yay!  This patch alone is worth having, regardless of the fate of the 
rest of the series: no change in end-user functionality, but by making 
qemu-nbd turn it into proper syntactic sugar, we've reduced the 
maintenance burden of duplicated code.

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/block/nbd.h |  4 ++--
>   blockdev-nbd.c      |  9 +--------
>   nbd/server.c        | 34 +++++++++++++++++-----------------
>   qemu-nbd.c          | 27 ++++++++++++---------------
>   4 files changed, 32 insertions(+), 42 deletions(-)
> 

> +++ b/nbd/server.c
> @@ -89,7 +89,6 @@ struct NBDExport {
>       BlockBackend *blk;
>       char *name;
>       char *description;
> -    uint64_t dev_offset;
>       uint64_t size;

I'm trying to figure out if we can also drop 'size' here.  If we do, the 
consequence would be that an NBD client could ask for beyond-EOF I/O, 
and presumably the block layer would reject that gracefully (although 
not necessarily with the same errno as NBD currently reports).  I'm fine 
leaving it alone in this patch, though.

> @@ -1569,7 +1574,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
>           exp->nbdflags |= (NBD_FLAG_SEND_TRIM | NBD_FLAG_SEND_WRITE_ZEROES |
>                             NBD_FLAG_SEND_FAST_ZERO);
>       }
> -    assert(size <= INT64_MAX - dev_offset);
> +    assert(size <= INT64_MAX);

As Max caught, this is now dead code.

> @@ -2386,8 +2388,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>           if (request->flags & NBD_CMD_FLAG_FAST_ZERO) {
>               flags |= BDRV_REQ_NO_FALLBACK;
>           }
> -        ret = blk_pwrite_zeroes(exp->blk, request->from + exp->dev_offset,
> -                                request->len, flags);
> +        ret = blk_pwrite_zeroes(exp->blk, request->from, request->len, flags);
>           return nbd_send_generic_reply(client, request->handle, ret,
>                                         "writing to file failed", errp);
>   
> @@ -2401,8 +2402,7 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                                         "flush failed", errp);
>   
>       case NBD_CMD_TRIM:
> -        ret = blk_co_pdiscard(exp->blk, request->from + exp->dev_offset,
> -                              request->len);
> +        ret = blk_co_pdiscard(exp->blk, request->from, request->len);

Merge conflicts with 890cbccb08; should be obvious enough to resolve, 
though.

> +++ b/qemu-nbd.c
> @@ -523,7 +523,6 @@ int main(int argc, char **argv)
>       const char *port = NULL;
>       char *sockpath = NULL;
>       char *device = NULL;
> -    int64_t fd_size;
>       QemuOpts *sn_opts = NULL;
>       const char *sn_id_or_name = NULL;
>       const char *sopt = "hVb:o:p:rsnc:dvk:e:f:tl:x:T:D:B:L";
> @@ -1028,6 +1027,17 @@ int main(int argc, char **argv)
>       }
>       bs = blk_bs(blk);
>   
> +    if (dev_offset) {
> +        QDict *raw_opts = qdict_new();
> +        qdict_put_str(raw_opts, "driver", "raw");
> +        qdict_put_str(raw_opts, "file", bs->node_name);
> +        qdict_put_int(raw_opts, "offset", dev_offset);

Huh.  When 0bc16997f5 got rid of the --partition option, it also got rid 
of the only way that the NBD driver could clamp down requests to a range 
smaller than the end of the file.  Now that you are adding a raw driver 
in the mix, that ability to clamp the end of the range (aka a --size 
option, in addition to an --offset option) may be worth reinstating. 
But that can be done as a separate patch, if at all (and whether 
qemu-nbd should do it, or qemu-storage-daemon, or whether we just point 
people at 'nbdkit --filter=partition', is part of that discussion).  But 
for this patch, it looks like you are making a straight-across conversion.

> +        bs = bdrv_open(NULL, NULL, raw_opts, flags, &error_fatal);
> +        blk_remove_bs(blk);
> +        blk_insert_bs(blk, bs, &error_fatal);
> +        bdrv_unref(bs);
> +    }
> +

Slick.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


