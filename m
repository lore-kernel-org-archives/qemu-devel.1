Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA82C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E3B2078C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezm9YqWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E3B2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je3Dg-0000IZ-NP
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 17:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je3D7-00083K-51
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:03:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je3D5-0006Wu-J5
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590613414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x0JRjjU3dgAIrBxPLDRaH5wHrqMTWl6+2G4BcOeSFds=;
 b=ezm9YqWqQKLZm5eH8Zp/XVnHKkG1iKP3hQn17seGBwuMozjY+bBEqYVVgWCeQ8EtRYdT6J
 LJ9khzr3G7Xt2jMQl0HtQE3klTThgesvVqm6lwr9/0OLhpvpEZYe4+3c2UJkL3OBtEX0l7
 4P4SD//Z5B8VjL1ckoKm6fB44JcoTMY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-tt9gU6FBNfqvTs1VyXa-Jg-1; Wed, 27 May 2020 17:03:27 -0400
X-MC-Unique: tt9gU6FBNfqvTs1VyXa-Jg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AED58005AA;
 Wed, 27 May 2020 21:03:25 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 770ECA1020;
 Wed, 27 May 2020 21:03:14 +0000 (UTC)
Subject: Re: [PATCH v6 4/5] block: make size-related BlockConf properties
 accept size suffixes
To: Roman Kagan <rvkagan@yandex-team.ru>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, xen-devel@lists.xenproject.org,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Paul Durrant <paul@xen.org>, Fam Zheng
 <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200527124511.986099-1-rvkagan@yandex-team.ru>
 <20200527124511.986099-5-rvkagan@yandex-team.ru>
 <d2ac3549-e63d-d737-41fa-21965c551175@redhat.com>
 <20200527205311.GA373697@rvkaganb.lan>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <367c42ad-69cf-0ed6-1bbf-ed5ea1b0a957@redhat.com>
Date: Wed, 27 May 2020 16:03:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527205311.GA373697@rvkaganb.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 17:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 3:53 PM, Roman Kagan wrote:

>>> ---
>>> v5 -> v6:
>>> - add prop_size32 instead of going with 64bit
>>
>> Would it be worth adding prop_size32 as its own patch, before using it here?
> 
> I've no strong opinion on this.  Should I better split it out when
> respinning?

Patch splitting is an art-form.  But in general, a long series of 
smaller patches each easy to review is going to get accepted into the 
tree faster than a single patch that merges multiple changes into one 
big blob, even if the net diff is identical.  It's rare that someone 
will ask you to merge patches because you split too far, so the real 
tradeoff is whether it will cost you more time to split than what you 
will save the next reviewer (including the maintainer that will merge 
your patches, depending on whether the maintainer also reviews it or 
just trusts my review), if you decide to go with a v7.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


