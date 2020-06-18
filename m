Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16CEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3BC2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rtWmi0p1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3BC2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltHq-0005RC-Qz
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jltGX-0004kr-7P; Thu, 18 Jun 2020 08:03:34 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jltGU-0007pN-96; Thu, 18 Jun 2020 08:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=8tOHfkRl5yLj+IuWKesOR0ohwtZVwCDO8HkW+CoIN5c=; 
 b=rtWmi0p1Ly6IYUzx8l2BmoBzAIA/7kI+IstsIDVeSa+1j0HINqo22dQ8Kqu7q8sBav250hT94+q0ZpUfcEmSW/nIpniE6Xy1HCl8qzizEu76zgS9/B+mUDupRRfU/xYN7VGoAR2zDQ+NZgRlL3+PsK6lshNqiybPM/T/QZhL49vJnJgNNTXvUTW97nS7ojM9adONUAJxVqX/6QdFetO5HkStV12c9iVhW3qAi+vd4fW3Z8HzX+sjuA+aBg+Q/i620R6X/0zNOvS/d5uV/XNgCUWVPZqZKBvtX2CrBwxU12iNEbgzj0yu6UngJGt7UGvHvem0ZC5lI5v2XWuQiywsXw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jltGP-0007ay-Nc; Thu, 18 Jun 2020 14:03:25 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jltGP-0000nJ-EG; Thu, 18 Jun 2020 14:03:25 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH for-5.1] qcow2: Don't open images with a backing file and
 the data-file-raw bit
In-Reply-To: <b0202150-5a43-18d5-3716-b758ab7e5824@redhat.com>
References: <20200415190207.21118-1-berto@igalia.com>
 <b0202150-5a43-18d5-3716-b758ab7e5824@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 18 Jun 2020 14:03:25 +0200
Message-ID: <w51r1uctwc2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 06:48:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 03 Jun 2020 03:53:03 PM CEST, Max Reitz wrote:
> Sorry for the long delay. :/

And sorry for my long delay as well.

> The patch itself looks good, but I=E2=80=99m not sure whether it is exten=
sive
> enough.  Let me just jump straight to the problem:
>
> $ ./qemu-img create -f qcow2 \
>     -o data_file=3Dfoo.qcow2.raw,data_file_raw=3Don \
>     foo.qcow2 64M
> (Create some file empty foo.qcow2 with external data file that=E2=80=99s =
raw)
>
> $ ./qemu-img create -f qcow2 backing.qcow2 64M
> $ ./qemu-io -c 'write -P 42 0 64M' backing.qcow2
> (Create some file filled with 42s)
>
> $ ./qemu-img compare foo.qcow2 foo.qcow2.raw
> Images are identical.
> (As expected, foo.qcow2 is identical to its raw data file)
>
> $ ./qemu-img compare --image-opts \
>     file.filename=3Dfoo.qcow2,backing.file.filename=3Dbacking.qcow2 \
>     file.filename=3Dfoo.qcow2.raw
> Content mismatch at offset 0!
> (Oops.)

If two images have the same contents but then you compare them changing
the backing file of one of them you can also get a content mismatch. How
is this different?

Regardless of how we should ideally handle bs->backing and data-file-raw
(and yes I agree that it would be nice that QEMU would say "you cannot
have a backing file and an external raw file" in all cases) I think that
if the problem is that the user can override the backing file name and
get different contents, then that's not a problem that we should be
worried about.

Berto

