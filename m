Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C5DC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43FA208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KE0Xsm8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43FA208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKr2-00033v-0p
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBKl9-000464-57
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBKl8-0008FF-3u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:56:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50351
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBKl7-0008Eh-Va
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583769360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63SRlbouFohdzAoq4x0ekJ0rctE7A77TQ2/DOmmrdzI=;
 b=KE0Xsm8tvI1nqKVmD0bs9znyhhv+EvQcIoULXlvfqP+z+pWon+ccJHtkXdj2Nd/vkvfUYf
 sxrPgfEs3j5u2GxgI2IJQhNKmXaNUB9em+9us9xBV3itR0W3bA8dMLqiZjlmLUP/ogdmCL
 hxearfd543SmuF4scty3B29yBJ1Vr/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-A8n9hKn-ND2VrgQXZ8iyHw-1; Mon, 09 Mar 2020 11:55:58 -0400
X-MC-Unique: A8n9hKn-ND2VrgQXZ8iyHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CBCD107ACC7;
 Mon,  9 Mar 2020 15:55:57 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B1C5D9C5;
 Mon,  9 Mar 2020 15:55:53 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] block: Add trivial backing_fmt support to qcow,
 sheepdog, vmdk
To: Kevin Wolf <kwolf@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-2-eblake@redhat.com>
 <20200309152112.GC6478@linux.fritz.box>
 <7b7f12f8-ca03-12d4-b93d-2edefb51cb42@redhat.com>
 <20200309154841.GD6478@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c6a6ed42-181b-f3ce-9fa3-5ad683c70da9@redhat.com>
Date: Mon, 9 Mar 2020 10:55:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309154841.GD6478@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, pkrempa@redhat.com,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 libvir-list@redhat.com, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Liu Yuan <namei.unix@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 10:48 AM, Kevin Wolf wrote:

>> Still, the point of this patch is that I want to add -F into all the
>> iotests, and without something along the lines of this patch, all of those
>> iotests are broken for these image formats.  Patch 2 is a lot harder to
>> write if we have to make our use of -F conditional on the image format in
>> question.
> 
> Hm... Maybe _make_test_img can insert/filter out -F depending on $IMGFMT?

I was hoping to avoid that, but yes, if that's what we have to do... :(

The complication is that even if I filter out -F from the command line 
based on $IMGFMT, then I have conditional output (whether backing_fmt= 
or the warning message is output), which means doubling the number of 
expected output cases, or else adding a multi-line filter which is also 
smart enough based on $IMGFMT to translate a warning on one line into an 
addition of a faked backing_fmt= on the next line.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


