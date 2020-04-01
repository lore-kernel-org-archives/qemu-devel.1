Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5957C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF19220B1F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUa0jKYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF19220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJfbe-0002vl-RF
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJfYQ-0008Gd-8L
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJfYM-00042H-FA
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:45:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJfYK-0003zi-74
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585755913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpK27Uk3DCWMsHFVPmHAapf2CLyJNYmb6GHTFo93/sk=;
 b=eUa0jKYpuBtYAIuNNQZVIGMnOuvrkYQbYkFL/UdKEb2vFAOGMTvCWK1NMrdxGj3n2FSlOd
 Kw8R86vhXqsj/2aZmvNh3w1Nv3jNsRXlRPHgclJSCYFbdWHjrPl2yYy/qsUVLMRCX4w1aQ
 AbIcO55vvgPe2T86N8BOqmDMvc6RT88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-SwbNc7e5PqiyDUFwc_RGeg-1; Wed, 01 Apr 2020 11:45:09 -0400
X-MC-Unique: SwbNc7e5PqiyDUFwc_RGeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FBFF107ACCD;
 Wed,  1 Apr 2020 15:45:07 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F4A35D9CA;
 Wed,  1 Apr 2020 15:45:02 +0000 (UTC)
Subject: Re: [PATCH] Compress lines for immediate return
To: Simran Singhal <singhalsimran0@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200401121101.GA26994@simran-Inspiron-5558>
 <d93af7ef-59d3-ceda-6847-1f5c92eaea2b@redhat.com>
 <CALrZqyNpvKeH6E2KCLQoCt1H1qphktWuX8i-cwoMOH6_g0Qu4g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <33d40ebc-00d1-28d2-f278-2419ab636b45@redhat.com>
Date: Wed, 1 Apr 2020 10:45:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALrZqyNpvKeH6E2KCLQoCt1H1qphktWuX8i-cwoMOH6_g0Qu4g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/1/20 9:49 AM, Simran Singhal wrote:
> Hello Philippe
>=20
> On Wed, Apr 1, 2020 at 7:26 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
> wrote:
>=20
>> Hi Simran,
>>
>> On 4/1/20 2:11 PM, Simran Singhal wrote:
>>> Compress two lines into a single line if immediate return statement is
>> found.
>>
>> How did you find these changes? Manual audit, some tool?
>>
>=20
> I wrote coccinelle script to do these changes.
>=20

Then is it worth checking in your script to scripts/coccinelle/ to let=20
it be something we can repeatedly rerun in the future to catch more=20
instances?  Even if you don't go that far, mentioning the exact rune you=20
used makes it easier to reproduce the patch, or even backport its=20
effects to a different branch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


