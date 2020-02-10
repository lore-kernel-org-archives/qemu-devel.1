Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E9C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA8520838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 16:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7HGYSmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA8520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1CC4-0006Rm-4h
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 11:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j1CB5-0005ck-Tg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j1CB4-0000Nf-MO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:44:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j1CB4-0000Md-If
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 11:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581353094;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vV4eGTWFc+JudZUEnauQlSTCA8p35uJtX0Dklx+ttrk=;
 b=O7HGYSmmprHl91yQBX0L/OB41C3HbKsRcCyj6rnbNnZvNlJVi7J7zmAzvidPc7SghrEhxO
 doZB2W0o88yx41cEXC05mUL2gfKNpDDbxa1JbGljPx+l/gCcgdIE2gxEBIceobQ7F2L/2x
 WG66ZACAr3IXsJZoMpTeWRmhJYQ0Ang=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-TPZjxvRtNGCfDg9wDmtWZA-1; Mon, 10 Feb 2020 11:44:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92567107ACCD;
 Mon, 10 Feb 2020 16:44:50 +0000 (UTC)
Received: from redhat.com (ovpn-117-6.ams2.redhat.com [10.36.117.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4959B60BF3;
 Mon, 10 Feb 2020 16:44:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v12 12/13] virtio-iommu: Support migration
In-Reply-To: <6a276f9d-18a3-300b-c55f-00665d30b34f@redhat.com> (Auger Eric's
 message of "Mon, 10 Feb 2020 14:36:56 +0100")
References: <20200109144319.15912-1-eric.auger@redhat.com>
 <20200109144319.15912-13-eric.auger@redhat.com>
 <87eev27hby.fsf@secure.laptop>
 <c8df42d0-c913-94e3-39a0-1e09fa459622@redhat.com>
 <6a276f9d-18a3-300b-c55f-00665d30b34f@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 10 Feb 2020 17:44:40 +0100
Message-ID: <8736bi75on.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TPZjxvRtNGCfDg9wDmtWZA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Reply-To: quintela@redhat.com
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, tnowicki@marvell.com,
 mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, jean-philippe@linaro.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Auger Eric <eric.auger@redhat.com> wrote:
> Hi Juan,
>
> On 2/10/20 2:09 PM, Auger Eric wrote:
>> Hi Juan,
>>=20
>> On 2/10/20 1:33 PM, Juan Quintela wrote:
>>> Eric Auger <eric.auger@redhat.com> wrote:
>>>> Add Migration support. We rely on recently added gtree and qlist
>>>> migration. We only migrate the domain gtree. The endpoint gtree
>>>> is re-constructed in a post-load operation.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>>
>>> And yes, this is as confusing as it can be:
>>>  a tree of mappings (i.e. key,value)
>>>  a list of endpoints
>>>
>>> I will propose this as most complex structure migrated ever.
>> :-) Thank you Juan, Dave, and Peter for your support
>
> I did not notice this at the first glimpse but could you send the R-b on
> the v15. I have been running like a hamster on my wheel during last week.
>
> Code has not changed though :-).

Sure.

Later, Juan.


