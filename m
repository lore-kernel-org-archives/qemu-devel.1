Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8517DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49059207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGj3krM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49059207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlHuW-0000XF-Iq
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 16:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlHtt-0008SS-Gv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:09:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlHtr-00040h-R3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592338178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qN0bYzVNMxPstzIJVKAf5YT8QXyeNSHCEOpkWOO1oNw=;
 b=AGj3krM6MfBohksflXNGvq3ihlUpX+evmzPfBIBhllSNGFzhuMhBfG9otLE5UTXWggwd4h
 GTX2ffZLqebbdVE6QFXYMC7Z/WAK/vQGYpbszA8/jv90LjkPCdvHD3/7NxToK5RwReGnJB
 VW8wp4vzWnzJxwCs+eGvHs2xSCv2Bfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Fs2psZicMRaYPpgcwEgPQg-1; Tue, 16 Jun 2020 16:09:34 -0400
X-MC-Unique: Fs2psZicMRaYPpgcwEgPQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35D31109133E;
 Tue, 16 Jun 2020 20:09:33 +0000 (UTC)
Received: from [10.3.112.27] (ovpn-112-27.phx2.redhat.com [10.3.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 777A05D9D7;
 Tue, 16 Jun 2020 20:09:32 +0000 (UTC)
Subject: Re: [PATCH] block: file-posix: Fail unmap with NO_FALLBACK on block
 device
To: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>
References: <20200613170826.354270-1-nsoffer@redhat.com>
 <CAMRbyyswkaedF0dN2nPb3H8fj5+pmhLWh9GHGor4wUk_Su=b8A@mail.gmail.com>
 <20200616153241.GF4305@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3fbf14f4-1bb9-7e30-3e7c-6207fa3f15c1@redhat.com>
Date: Tue, 16 Jun 2020 15:09:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616153241.GF4305@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-block <qemu-block@nongnu.org>, pl@kamp.de,
 QEMU Developers <qemu-devel@nongnu.org>, nirsof <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 10:32 AM, Kevin Wolf wrote:
> Am 15.06.2020 um 21:32 hat Nir Soffer geschrieben:
>> We can zero 2.3 g/s:
>>
>> # time blkdiscard -z test-lv
>>
>> real 0m43.902s
>> user 0m0.002s
>> sys 0m0.130s
> 
>> We can write 445m/s:
>>
>> # dd if=/dev/zero bs=2M count=51200 of=test-lv oflag=direct conv=fsync
>> 107374182400 bytes (107 GB, 100 GiB) copied, 241.257 s, 445 MB/s
> 
> So using FALLOC_FL_PUNCH_HOLE _is_ faster after all. What might not be
> faster is zeroing out the whole device and then overwriting a
> considerable part of it again.

Yeah, there can indeed be a difference between a pre-zeroing which can 
be super-fast (on a posix file, truncate to 0 and back to the desired 
size, for example), and where it is faster than writes but still slower 
than a single pass.

> 
> I think this means that we shouldn't fail write_zeroes at the file-posix
> level even if BDRV_REQ_NO_FALLBACK is given. Instead, qemu-img convert
> is where I see a fix.

Is the kernel able to tell us reliably when we can perform a fast 
pre-zero pass?  If it can't, it's that much harder to define when 
BDRV_REQ_NO_FALLBACK makes a difference.

> 
> Certainly qemu-img could be cleverer and zero out more selectively. The
> idea of doing a blk_make_zero() first seems to have caused some
> problems, though of course its introduction was also justified with
> performance, so improving one case might hurt another if we're not
> careful.
> 
> However, when Peter Lieven introduced this (commit 5a37b60a61c), we
> didn't use write_zeroes yet during the regular copy loop (we do since
> commit 690c7301600). So chances are that blk_make_zero() doesn't
> actually help any more now.
> 
> Can you run another test with the patch below? I think it should perform
> the same as yours. Eric, Peter, do you think this would have a negative
> effect for NBD and/or iscsi?

I'm still hoping to revive my work on making bdrv_make_zero a per-driver 
callback with smarts for the fastest possible pre-zeroing that driver is 
capable of, or fast failure when BDRV_REQ_NO_FALLBACK is set and it is 
no faster to pre-zero than it is to just write zeroes when needed.  I 
can certainly construct NBD scenarios in either direction (where a 
pre-zeroing pass is faster because of less network traffic, or where a 
pre-zeroing pass is slower because of increased I/O - in fact, that was 
part of my KVM Forum 2019 demo on why the NBD protocol added a FAST_ZERO 
flag mirroring the idea of qemu's BDRV_REQ_NO_FALLBACK).

> 
> The other option would be providing an option and making it Someone
> Else's Problem.

Matching what we recently did with --target-is-zero.

> 
> Kevin
> 
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index d7e846e607..bdb9f6aa46 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -2084,15 +2084,6 @@ static int convert_do_copy(ImgConvertState *s)
>           s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
>       }
> 
> -    if (!s->has_zero_init && !s->target_has_backing &&
> -        bdrv_can_write_zeroes_with_unmap(blk_bs(s->target)))
> -    {
> -        ret = blk_make_zero(s->target, BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK);
> -        if (ret == 0) {
> -            s->has_zero_init = true;
> -        }
> -    }
> -
>       /* Allocate buffer for copied data. For compressed images, only one cluster
>        * can be copied at a time. */
>       if (s->compressed) {
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


