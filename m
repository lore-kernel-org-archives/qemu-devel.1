Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4086C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5813620737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwrPNVgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5813620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSZU-00037W-ID
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jHSYX-0002Hv-Rg
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jHSYW-0004iD-Po
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:28:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jHSYW-0004hg-Ka
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EGnRWrEP/8gI+a268GMTJe3S8S/fsmwLOqNCUIw5+xs=;
 b=TwrPNVgme23Z2PM3Ec+WyOqofr9fd5epBiRs4uCiB4gXWfydY1GUDF9d0ktrq4Ml6jAiHO
 YEVIAygTipbPv59N7RnQFhSRzacCvuctFTkD5dT2Mp9SnbvFiZp168TA3qH5DXavCa4o74
 8Sun96M2kwuDG7JjxBXOmsMqCH0la7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-C_Z-TasvNnuG40JLrtQaJQ-1; Thu, 26 Mar 2020 09:28:15 -0400
X-MC-Unique: C_Z-TasvNnuG40JLrtQaJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A698E189F762;
 Thu, 26 Mar 2020 13:28:11 +0000 (UTC)
Received: from [10.3.113.103] (ovpn-113-103.phx2.redhat.com [10.3.113.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C440F5DA7B;
 Thu, 26 Mar 2020 13:27:59 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: pass BlockDriver reference to the
 .bdrv_co_create
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
References: <20200326011218.29230-1-mlevitsk@redhat.com>
 <20200326011218.29230-2-mlevitsk@redhat.com>
 <af808169-5dcb-6293-3c8a-00ab0a9cd76e@redhat.com>
 <c5d0b9889dd7644377464838fbcd58fedcdd93dc.camel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c033ca96-6adc-8fdf-9528-8cae6aa271d1@redhat.com>
Date: Thu, 26 Mar 2020 08:27:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c5d0b9889dd7644377464838fbcd58fedcdd93dc.camel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 integration@gluster.org, sheepdog@lists.wpkg.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 8:22 AM, Maxim Levitsky wrote:
> On Thu, 2020-03-26 at 08:18 -0500, Eric Blake wrote:
>> On 3/25/20 8:12 PM, Maxim Levitsky wrote:
>>> This will allow to reuse a single generic .bdrv_co_create
>>
>> "allow to ${verb}" is not idiomatic, better is "allow ${subject} to
>> ${verb}" or "allow ${verb}ing".  In this case, I'd go with:
>>
>> This will allow the reuse of a single...
> I agree! This commit will probably go as is but next time I'll keep it in mind!

Max hasn't sent the pull request yet; there's still time for him to 
amend his staging queue if he wants.  But yeah, it's not a huge deal if 
the patch goes in without spelling/grammar polish.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


