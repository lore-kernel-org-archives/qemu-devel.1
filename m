Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F68DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6E72067B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Gs2uukU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6E72067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jegcP-0000RP-Ew
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jegbb-0007xG-TB; Fri, 29 May 2020 11:07:31 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:39800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jegbZ-0001qK-Oz; Fri, 29 May 2020 11:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=D5v0JU4vXr8o+lwbD9Fyl/TBPbwyvjqmh1IV0XCCeqg=; 
 b=Gs2uukU3OXEFXt6Ky//uaSq4IOulTuujMzK3gL9AdvHWDJGyTrNj7Yc10Ut9ZBlI2xTP8cPG9t6J2U4f1Y02jlbduUiA5ZRLvvxOoNeMtVTNZr9Rzsnmp44McVRKbMQoDrHUsSC2iqjwMSeAsvoGIvSHI/VHIoKSUgRZNE1xmEhAH5Jm7A9Ifp49q8v2QlbUTpLk2hd22NPlnm3K293QuG6J/SVKlaGrxmllqPNpsXkQ3bCbbnjhoAsmGXRWI+NcCTzZbC4vmMLjYghtxrEIvr2E6yEpW/kQhGgTaXDAGMQeRMHnJMAPwtv1szH5Lfiwtexj80DXg2dSMENPy0Qt3g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jegbB-0008MZ-LH; Fri, 29 May 2020 17:07:05 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jegbB-00008m-6F; Fri, 29 May 2020 17:07:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 32/32] iotests: Add tests for qcow2 images with
 extended L2 entries
In-Reply-To: <c2bb44f3-bb7e-7bb0-dbbf-ef1d3273802d@redhat.com>
References: <cover.1590429901.git.berto@igalia.com>
 <117ba99f5a1fbea62cfed60fe74a460cc628948f.1590429902.git.berto@igalia.com>
 <c2bb44f3-bb7e-7bb0-dbbf-ef1d3273802d@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 29 May 2020 17:07:05 +0200
Message-ID: <w51v9kevkyu.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 11:07:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed 27 May 2020 08:30:06 PM CEST, Eric Blake wrote:
>> +    offset=$(($offset + 8))
>> +    bitmap=`peek_file_be "$TEST_IMG" $offset 8`
>> +
>> +    expected_bitmap=0
>> +    for bit in $expected_alloc; do
>> +        expected_bitmap=$(($expected_bitmap | (1 << $bit)))
>> +    done
>> +    for bit in $expected_zero; do
>> +        expected_bitmap=$(($expected_bitmap | (1 << (32 + $bit))))
>> +    done
>> +    expected_bitmap=`printf "%llu" $expected_bitmap`
>
> Dead statement - expected_bitmap is already a 64-bit decimal number
> without reprinting it to itself.

Not quite... it seems that simply expanding the variable treats the
value as signed so echo $((1 << 63)) returns INT64_MIN. The printf call
makes it unsigned, but even though I tried that in a 32-bit system and
it works now I'm actually wondering about the portability of the whole
thing.

Looking at the source it seems that bash uses intmax_t:

   https://git.savannah.gnu.org/cgit/bash.git/tree/variables.h?h=bash-5.0#n68

But if this is a problem then peek_file_* would also be affected, it
also uses printf %llu and a few iotests are already reading 64bit values
(grep 'peek_file_.* 8').

Berto

