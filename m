Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8191C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968F7206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TNTx8Qsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968F7206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtxZ-0007ok-NZ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jHtwz-0007Nh-Ve
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jHtwz-00040H-15
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:43:25 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:60555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jHtwy-0003v6-EP; Fri, 27 Mar 2020 14:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=cyTVFSrvRinTzjh3lIKtyeMV6t6tcf+RahRWNXkr6ic=; 
 b=TNTx8QsjlQId35s76EFl1Up/wSohvlxhPaWXA0OAWaMFi5L2qdVYNydGCdoHEc6Vulequcc7MBsHUxF28bDNpDh22FtThnXn+auL2tydtm4HimICITUaLvPo0HQCCiQFb5sesoSb4K9VatpyBRnMtbjDT+mmgFIUiWDh4hUunIiHczqKh+xXwGo0kiNNgcBaMPZ5Q5TcsRycdo8oRSEf5vbC41ey1bTuhYzLwltTrHPZESOverz6jhURtEdlj108OIJqf0U7cFSAGMOdFAto6K+gM4BYbQ+dkwfXT5vk4f+16JYuEWOBwG4LjUucIwlgMffhOsiI2YoSkoAl5YNW9Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jHtwv-0002uc-MT; Fri, 27 Mar 2020 19:43:21 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1jHtwv-0003kj-DA; Fri, 27 Mar 2020 19:43:21 +0100
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] qcow2: Forbid discard in qcow2 v2 images with backing
 files
In-Reply-To: <abf9a6c8-7b15-b3c1-e26a-f0ffe9523c85@redhat.com>
References: <20200327164857.31415-1-berto@igalia.com>
 <abf9a6c8-7b15-b3c1-e26a-f0ffe9523c85@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 27 Mar 2020 19:43:21 +0100
Message-ID: <w51eetdhc52.fsf@maestria.local.igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri 27 Mar 2020 07:13:04 PM CET, Eric Blake wrote:
>> +for qcow2_compat in 0.10 1.1; do
>> +    echo "# Create an image with compat=$qcow2_compat without a backing file"
>> +    _make_test_img -o "compat=$qcow2_compat" 128k
>> +
>> +    echo "# Fill all clusters with data and then discard them"
>> +    $QEMU_IO -c 'write -P 0x01 0 128k' "$TEST_IMG" | _filter_qemu_io
>> +    $QEMU_IO -c 'discard 0 128k' "$TEST_IMG" | _filter_qemu_io
>> +
>> +    echo "# Read the data from the discarded clusters"
>> +    $QEMU_IO -c 'read -P 0x00 0 128k' "$TEST_IMG" | _filter_qemu_io
>> +done
>
> Should this loop also inspect qemu-img map output?

I guess we can, although here the image is completely unallocated in
both cases.

Berto

