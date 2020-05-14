Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3068EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD86206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPzzTm6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD86206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEnm-00007A-0z
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZEiw-0000S6-BC
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:20:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26890
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jZEiu-00058G-Qx
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojG+ubwH30+tQj377iUQceXxuhYLTEPDXDGrFOO5g30=;
 b=bPzzTm6P3D8ufJmnblA0r6xCBPYdyuDOD538hhCEBaVxHhUv41n5+VGRmujMBJEijWg3LY
 65u2cOXLk12F1+th5UmVTAUN6Hy/1m5dkLsllPFun1rQoBvOsyDsRUXgPOQsZ2XngE9n1h
 KHoFdv402Zq3dfOI2G+tu4ca3LruCJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Sq2qO54-MeeiQNLqBkzFKA-1; Thu, 14 May 2020 10:20:29 -0400
X-MC-Unique: Sq2qO54-MeeiQNLqBkzFKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CBD2A0BDC;
 Thu, 14 May 2020 14:20:28 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CAF95D714;
 Thu, 14 May 2020 14:20:27 +0000 (UTC)
Subject: Re: [PATCH v4 6/9] qemu-img: Add bitmap sub-command
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200513011648.166876-1-eblake@redhat.com>
 <20200513011648.166876-7-eblake@redhat.com>
 <ef44c5c0-1032-76e3-a3ce-ad0cc43d297c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0542a587-424c-a596-1778-e7aaf494298c@redhat.com>
Date: Thu, 14 May 2020 09:20:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ef44c5c0-1032-76e3-a3ce-ad0cc43d297c@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, nsoffer@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 1:45 AM, Vladimir Sementsov-Ogievskiy wrote:
> 13.05.2020 04:16, Eric Blake wrote:
>> Include actions for --add, --remove, --clear, --enable, --disable, and
>> --merge (note that --clear is a bit of fluff, because the same can be
>> accomplished by removing a bitmap and then adding a new one in its
>> place, but it matches what QMP commands exist).  Listing is omitted,
>> because it does not require a bitmap name and because it was already
>> possible with 'qemu-img info'.  A single command line can play one or
>> more bitmap commands in sequence on the same bitmap name (although all
>> added bitmaps share the same granularity, and and all merged bitmaps
>> come from the same source file).  Merge defaults to other bitmaps in
>> the primary image, but can also be told to merge bitmaps from a
>> distinct image.
>>

> 
> I'm sorry for asking it only now on v4.. But still. Why do we need it? 

Ease of use.

> We can instead run qemu binary (or even new qemu-storage-daemon) and 
> just use existing qmp commands. Is there a real benefit in developing 
> qemu-img, maintaining two interfaces for the same thing?

If it makes someone's life easier, and is not hard to maintain, then 
yes.  A command line interface that calls into QMP is not hard to 
maintain.  And _I_ certainly found it easier to write iotests with this 
patch in place, so it already has at least one client.

> Of-course, just 
> run qmp commands from terminal is a lot less comfortable than just a 
> qemu img command.. But may be we need some wrapper, which make it simple 
> to run one qmp command on an image?
> 
> It's simple to make a python wrapper working like
> 
> qemu-qmp block-dirty-bitmap-add '{node: self, name: bitmap0, persistent: 
> true}' /path/to/x.qcow2

This _IS_ such a wrapper.  The whole point of this patch is that it is 
now simpler to run one (or more) QMP command on an offline image from 
the command line.  Just because I wrote it in C instead of python, and 
attached it to an existing tool instead of writing a new tool, doesn't 
change the fact that it is just a wrapper around the existing QMP commands.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


