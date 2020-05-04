Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3F9C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A8A206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bFx/ZMyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A8A206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeZw-0007FN-A8
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVeZ4-0005xb-Ri; Mon, 04 May 2020 13:07:34 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:50808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jVeZ1-0007Dh-Pq; Mon, 04 May 2020 13:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=h1S6Erhi03+OvLy16KR/926VjU+DuBCd2HtjArEuSRY=; 
 b=bFx/ZMyPGVw2ljDmcvYjqU6FwzkW2dZPXLzPPHIsfFDzvIj7k6K3U+bjOlefNMbXU2li4623ouuLEzO8CFM/TooSFWnwaLxAbr2Lv3GrtPS2Jaznakru/cJvJ/Kw5iUI7tlnfEjx3iSpw3RNXWJOHH1AghdiVQDFyF3zuZ1rgApaEwD0KpmWwtWo+HUABvs2aP5OgWs+hKAuzGSR6A5JcZrz0FVPOnLeA2gYhmexQ9osLKp/s73LboP6rvkJqI5U518TdVHeNlI4sP0WaK+u0LUurOGfV+veQV0dlYTJs5V1QHNADeI9VDyMtF1PCSbC2Q3iP/XyBEe54iO7TEHfzA==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jVeYx-00009U-So; Mon, 04 May 2020 19:07:27 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jVeYx-0001wh-J7; Mon, 04 May 2020 19:07:27 +0200
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3] qcow2: Avoid integer wraparound in qcow2_co_truncate()
In-Reply-To: <6fefd4af-3687-7f38-3933-aa67f2f221e8@redhat.com>
References: <20200504155217.10325-1-berto@igalia.com>
 <6fefd4af-3687-7f38-3933-aa67f2f221e8@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 04 May 2020 19:07:27 +0200
Message-ID: <w51368fiq7k.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 09:47:36
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon 04 May 2020 06:01:19 PM CEST, Eric Blake wrote:
>> +_supported_fmt qcow2
>> +_supported_proto file
>
> Do we have to limit it to qcow2 and file?  Yes, it's testing a bugfix
> for qcow2, but are there other formats that it doesn't hurt to have
> the extra testing?

It doesn't work with any other format at the moment (meaning: reading
the tail of the image after growing it returns the data from the backing
file).

Also, it seems that qemu-img's -F does not work with other formats
either.

> Also, I don't see anything preventing this from working with non-file
> protocol.

Right, that can be updated I guess (whoever commits this, feel free to
do it).

Berto

