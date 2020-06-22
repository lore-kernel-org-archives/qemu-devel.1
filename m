Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382192073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHBkiu4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382192073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnROj-00012z-Ct
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnRHN-0005mM-Gi
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:34:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jnRHL-00082t-Md
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 14:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592850886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iBNQ33u515O4I6Zu5fn4mQsWTVS2wJO6XSUJuMcTCo=;
 b=NHBkiu4DqPNCFl2iBWqACUnhI5dHuardefKKCYY3JIgFhXx/5X37Edzce0Z2wrmUQZ7u7N
 UKsskcEnluypXr0g6k1/WPu0nv5EGjpCjaWDMzZSwbcKC8oivOvHnx1McprOSzPhKe3VRc
 5r9xovc4oRXgWap+vddtR8lQU2y0UaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-9vR12TsrPfOWkgXydVyyew-1; Mon, 22 Jun 2020 14:34:42 -0400
X-MC-Unique: 9vR12TsrPfOWkgXydVyyew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A5708005AD;
 Mon, 22 Jun 2020 18:34:41 +0000 (UTC)
Received: from [10.3.114.4] (ovpn-114-4.phx2.redhat.com [10.3.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 645C95D9E2;
 Mon, 22 Jun 2020 18:34:40 +0000 (UTC)
Subject: Re: [PATCH 1/2] qcow2: Force preallocation with data-file-raw
To: Max Reitz <mreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <20200619104012.235977-2-mreitz@redhat.com>
 <w51eeqb9f43.fsf@maestria.local.igalia.com>
 <9c14c622-eb30-4619-d33a-b59395a397be@redhat.com>
 <w51r1u788gg.fsf@maestria.local.igalia.com>
 <2d35fdff-6230-18b9-cf99-ca72be53267f@redhat.com>
 <CAMRbyytkKjdAqH0hFiiAUEv7NeA9beC5CXx9LmBBSJd0r=5qQA@mail.gmail.com>
 <3b4353d4-cbf1-df89-7f5f-1a1454cfe174@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b72cf89a-7894-934d-cf0a-826579aa3089@redhat.com>
Date: Mon, 22 Jun 2020 13:34:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3b4353d4-cbf1-df89-7f5f-1a1454cfe174@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 10:48 AM, Max Reitz wrote:

>>> As I noted in my reply to myself, data-file-raw is an autoclear flag.
>>> That means, an old version of qemu that doesn’t recognize the flag must
>>> read the same data as a new version.  It follows that the the L2 tables
>>> must be a 1:1 mapping.  (Or the flag can’t be an autoclear flag.)

Yes, that argument is the strongest I've seen for why both creation and 
resize with a data-file-raw image should require metadata preallocation. 
  In other words, we never want to expose different guest data merely 
because we opened the file with an older version (the older version must 
either see the same data [an autoclear bit is fine], or must know that 
it cannot reliably open the image [an incompatible bit is needed]).

>>
>> Being able to read sounds like a nice to have feature, but what about writing?
>>
>> I hope that the image is not writable by older versions that do not understand
>> data_file. Otherwise older qemu versions can corrupt the image silently.
> 
> It’s an autoclear flag.  That means such versions of qemu will
> automatically clear the flag.

Well, an older version is only required to clear the flag if it modifies 
the image; if it opens the image read-only, it may leave the autoclear 
flag set.  So you are more realistically guaranteed that the autoclear 
flag is only cleared when writing to the image with a version that did 
not understand the autoclear flag.

Following that line of thought further - reopening the image under a 
qemu that once again understands the data-file-raw flag will now see 
that the file is no longer raw because the flag was cleared.  That is, 
if you are expecting data-file-raw and no longer see the flag, then you 
KNOW that the qcow2 file was modified by an older program that didn't 
necessarily preserve the 1:1 correspondence, and it is up to you what to 
do next (refuse to use the file, do a pass over the qcow2 file to flush 
contents back to the raw file, or any number of other reactions...).

> So autoclear flags are useful for features that are optional, but that
> may be broken when the image is written to by versions of qemu that
> don’t understand them.)

More importantly, autoclear flags are useful for features where older 
software can safely read the image without data loss, but where older 
software modifying the image may lose whatever property the bit was 
guaranteeing when interpreted correctly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


