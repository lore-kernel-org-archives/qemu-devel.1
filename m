Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B39C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E65C206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cIi/5o7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E65C206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipX46-0003kd-9F
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1ipX3U-0003GL-Qo
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1ipX3T-00017d-NA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:36:52 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:52129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1ipX3T-0000zg-Cm; Thu, 09 Jan 2020 07:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Gobdt2gwN2OZ2oF/u+M1tlpvTOLjlt6o6s+RMHDe8oo=; 
 b=cIi/5o7zJqXNhFdYkpobc1whD+v5Cm/rWUwPoErAyAUj93Q9cY/oWOw6yPC75qykBjsnqh5DfEdrAnL46PnVVZFo/PFR/dIhhXRN6bnN4pjMjQCnlemyjEuZNsT4prI8GXdD29a5Oa0YM9gFs5JkqOkQZDXhnYvBFyPeOwana/3ag0kFjr01YosDkqwUYbha0PoyDwQ5RcXGbNtLzs6kWvmoU3Bb2xEOhB9e+QARGR0RpZ/M067TwaEc4F5IG+6Sc70NjtvkYVe1PhhDopwBSuLXM7rwD5MS4NVahpVmfWvJ3wzdJgn/0WbxNwG/vtEBw3xApXtvZ6Oaai0sP9Gwnw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1ipX3Q-0007ZA-LS; Thu, 09 Jan 2020 13:36:48 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1ipX3Q-0003Fq-Bd; Thu, 09 Jan 2020 13:36:48 +0100
From: Alberto Garcia <berto@igalia.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH 1/3] qcow2: Require that the virtual size is a multiple of
 the sector size
In-Reply-To: <CAMRbyysKuC8cx7eaCDKwXG6ierQFEZGTQQ6PCtAjR9WQR5TvAQ@mail.gmail.com>
References: <cover.1578505678.git.berto@igalia.com>
 <4a27dc359f8211700662949bdecdd992f8918c12.1578505678.git.berto@igalia.com>
 <CAMRbyysKuC8cx7eaCDKwXG6ierQFEZGTQQ6PCtAjR9WQR5TvAQ@mail.gmail.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 09 Jan 2020 13:36:48 +0100
Message-ID: <w517e20bycf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 08 Jan 2020 08:46:11 PM CET, Nir Soffer wrote:
>> However when an image is opened the virtual size is rounded down,
>> which means that trying to access the last few advertised bytes will
>> result in an error. As seen above QEMU cannot create such images and
>> there's no good use case that would require us to try to handle them
>> so let's just treat them as unsupported.
>
> Making error impossible is best.
>
> Can we require multiple of 4k to avoid unaligned read/write at the end
> of an image aligned to 512 bytes on storage with 4k sector size?

I wouldn't force that on the user. The only reason why I'm not allowing
the non-sector-aligned case is because it's currently broken, but I
wouldn't have a problem with it if it was working fine.

>> +echo
>> +echo "== Image size not a multiple of the sector size =="
>> +_make_test_img 64k
>
> Logging the change here would make the test and the output more clear:
>
>     echo "modifying virtual size to 65535"

Ok

>> +== Image size not a multiple of the sector size ==
>> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
>> +qemu-io: can't open device TEST_DIR/t.qcow2: Virtual size is not a multiple of 512
>
> The output is confusing, looks like we created image with aligned
> size, and on the next line it complains about the size.

Ok, I can also replace the "qemu-io write" with a "qemu-img info" or
something like that to make it a bit less confusing (i.e. the error
happens already when you open the image, not when you write to it).

Berto

