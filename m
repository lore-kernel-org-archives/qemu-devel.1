Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3770C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 21:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95DB20719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 21:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcU/MWpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95DB20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK7Sa-0004xx-QA
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 17:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jK7Ru-0004NM-W3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jK7Rs-000426-Hs
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:32:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58778
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jK7Rr-0003zH-1W
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585863144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtrpPLr1A1jEpwwqjO0SKN7jze8jqDOIueFvYdzOWbU=;
 b=hcU/MWpKTkhUL0xsAsi0dwzB8soXSi792oDhxyI6fDLChLsVpo3Sm1hDBmhLERbmie5aDy
 rQn2T3+6wKluu2VS1HCRh2xrvGVzuhQ4nEsmpXcM3DdTuERxYfWIr+9cAJOkEDnE2rBmTg
 yYJh7rWxOa5igxZIlX6f8Y+41f75KXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-bXXye-HBOmy8ajeuE_hyVg-1; Thu, 02 Apr 2020 17:32:20 -0400
X-MC-Unique: bXXye-HBOmy8ajeuE_hyVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C629107ACC4;
 Thu,  2 Apr 2020 21:32:19 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D40025D9CD;
 Thu,  2 Apr 2020 21:32:15 +0000 (UTC)
Subject: Re: [PATCH for-5.0? v4 0/7] Tighten qemu-img rules on missing backing
 format
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
References: <20200312192822.3739399-1-eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <339cc67c-0214-6520-922a-564f8944d2ae@redhat.com>
Date: Thu, 2 Apr 2020 16:32:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200312192822.3739399-1-eblake@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 2:28 PM, Eric Blake wrote:
> v3 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg01730.html
> In v4:
> - old patch 1 was reworked into new patch 1-3, with stricter rules
> on which backing formats are accepted [Kevin]
> - patch 4 is new: amend is handled differently from rebase [Kashyap]
> - rebase to master
> 
> Eric Blake (7):
>    sheepdog: Add trivial backing_fmt support
>    vmdk: Add trivial backing_fmt support
>    qcow: Tolerate backing_fmt=, but warn on backing_fmt=raw
>    qcow2: Deprecate use of qemu-img amend to change backing file
>    iotests: Specify explicit backing format where sensible
>    block: Add support to warn on backing file change without format
>    qemu-img: Deprecate use of -b without -F

Is this still worth trying to get in 5.0?  There were not many comments 
on v4, other than a compile fix I need to squash in and Kashyap asking a 
question on qemu-img convert behavior that I still need to double-check, 
or at a bare minimum add iotest coverage for.  But depending on the 
urgency to get this in now, vs. delaying the deprecation clock for 4 
more months by starting it in 5.1, determines how much effort I need to 
put in getting a v5 out right now.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


