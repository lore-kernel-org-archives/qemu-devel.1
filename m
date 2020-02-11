Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB3BC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84B420842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdwmrlZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84B420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Xed-0001la-Um
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1Xdn-0000vq-9d
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1Xdm-0005q6-CZ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:39:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1Xdm-0005pw-8w
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581435597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ereni4kvdehBygp4FL/74OVPaRQhbfDigxCTDu1fi+4=;
 b=gdwmrlZoYo0wxWz1ZnvCYAzNB1Y68Cj3UrddNjP5bfkNRN0GdQQBbWXKwMJht00JAcMiE1
 RM0m+8QKREWVlDLfOBo43FcHg3u7v3LrUG+jqL9hsv4LVG1Y5kUXU9q2YddKpi4va9ffZP
 3ulDJTIjMM1quggciwm+2KTU8gUPgcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-WPfcbdT9N3iYxUMOpjtsfw-1; Tue, 11 Feb 2020 10:39:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17CD71902EA0;
 Tue, 11 Feb 2020 15:39:52 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C52388836;
 Tue, 11 Feb 2020 15:39:51 +0000 (UTC)
Subject: Re: [PATCH v2 22/33] block: Make backing files child_of_bds children
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-23-mreitz@redhat.com>
 <6869d2fe-197a-3bd8-516a-9ae07756a227@redhat.com>
 <367e84c9-501b-2324-fc7a-575ba10249bd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a7b6b6a3-cfae-f3dc-c9ed-4ec4b53e9c23@redhat.com>
Date: Tue, 11 Feb 2020 09:39:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <367e84c9-501b-2324-fc7a-575ba10249bd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WPfcbdT9N3iYxUMOpjtsfw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 5:33 AM, Max Reitz wrote:
> On 05.02.20 23:45, Eric Blake wrote:
>> On 2/4/20 11:08 AM, Max Reitz wrote:
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>
>> Another sparse commit message (a recurring theme of this series). The
>> subject line says 'what', and the patch appears to be faithful to that,
>> but if a future bisection lands here, even a one-sentence 'why' would be
>> handy; maybe:
>>
>> This is part of a larger series of unifying block device relationships
>> via child_of_bds.
>=20
> Sure, works for me.  Or maybe:
>=20
> Make all parents of backing files pass the appropriate BdrvChildRole.
> By doing so, we can switch their BdrvChildClass over to the generic
> child_of_bds, which will do the right thing when given a correct
> BdrvChildRole.

Sounds good.

>=20
> (Because actually the point of this series is not child_of_bds, but the
> BdrvChildRole, which allows the =E2=80=9CDeal with filters=E2=80=9D serie=
s to implement
> the child access functions in a more obvious way.  I hope.)

And hopefully I finish my review of the rest of the series today, to see=20
if we met that goal.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


