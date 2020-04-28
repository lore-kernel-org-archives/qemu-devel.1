Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17055C83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67C1206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl8vOnzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67C1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQxq-0007I3-Tq
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQvH-0002d6-5d
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQsU-0002TL-7R
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:09:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39727
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTQsT-0002Sr-OM
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588082785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oS87x/C4tkeHKsdJZq3Zu2P7VYqrs3IBlIfEH29BBsI=;
 b=hl8vOnzyie6Chuvwb+8A17zUVylLft8/TohJJpWogE0ala8U2SvhrwVJd4qlN+9EVKG76M
 GRb/Uu/dirIDfZSl5JkTXc/ZuvAeHnF69zX80LPIm4zeHrbO4AEcIZW34H+DWXgh44uLbf
 ugRvEUYkqnnE3DZYhKIfvtfbylvTOes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-JOQ3aNrnMXuGDGUmWVi3TA-1; Tue, 28 Apr 2020 10:05:58 -0400
X-MC-Unique: JOQ3aNrnMXuGDGUmWVi3TA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B28DEA0BF4;
 Tue, 28 Apr 2020 14:05:57 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF452619A7;
 Tue, 28 Apr 2020 14:05:56 +0000 (UTC)
Subject: Re: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200428132629.796753-1-mreitz@redhat.com>
 <c8235407-a2cf-abe3-e5d9-f16170f9b4b4@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <feccd959-3979-5f1c-f3b4-eac81ba62491@redhat.com>
Date: Tue, 28 Apr 2020 09:05:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c8235407-a2cf-abe3-e5d9-f16170f9b4b4@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 8:49 AM, Eric Blake wrote:
> On 4/28/20 8:26 AM, Max Reitz wrote:
>> Branch: https://github.com/XanClic/qemu.git fix-bdrv_make_empty-v1
>> Branch: https://git.xanclic.moe/XanClic/qemu.git fix-bdrv_make_empty-v1
>>
>> Hi,
>>
>> Right now, there is no centralized bdrv_make_empty() function.=C2=A0 Not=
 only
>> is it bad style to call BlockDriver methods directly, it is also wrong,
>> unless the caller has a BdrvChild with BLK_PERM_WRITE taken.
>=20
> I'm also in the middle of writing a patch series that adds a=20
> corresponding .bdrv_make_empty driver callback.=C2=A0 I'll rebase that wo=
rk=20
> on top of this, as part of my efforts at fixing more code to rely on=20
> bdrv_make_empty rather than directly querying=20
> bdrv_has_zero_init[_truncate].

Correction - I'm working on adding .bdrv_make_zero, not .bdrv_make empty=20
(which already exists), although maybe it really only needs to be one=20
callback instead of two if we have decent flags.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


