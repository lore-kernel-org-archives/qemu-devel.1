Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88845C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 07:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB4F206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 07:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0BUJX/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB4F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix4Jl-0004y4-ES
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 02:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ix4Ix-0004SS-Ag
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 02:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ix4Iw-0006Cq-Fa
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 02:31:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ix4Iw-0006BO-Cp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 02:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580369516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqpZwgy76lJlajUnOqccq1LF7SPB6GLnk8PV5lVbPFA=;
 b=i0BUJX/AJQQcIyLel5iic/nokYuh0P2tsfjQCnzfnQSaMt/zSrPvTnic6r5gWZLYduMd2z
 Np9Me21r8PyzcwDaQXyMpelsaBaUFEGcm3K8FCyQUatM7qJO2YG6E1bO2R7+BvW+pq1XLI
 fG58jqmvWqfRg2LBKJ0N4xWw/t4Tv8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-TQoHnpoENRajsKTvNJAt9Q-1; Thu, 30 Jan 2020 02:31:52 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD26918B9F54;
 Thu, 30 Jan 2020 07:31:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FD6519488;
 Thu, 30 Jan 2020 07:31:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C3781138404; Thu, 30 Jan 2020 08:31:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 2/4] qapi: Create module 'control'
References: <20200129102239.31435-1-kwolf@redhat.com>
 <20200129102239.31435-3-kwolf@redhat.com>
 <871rri2pb6.fsf@dusky.pond.sub.org>
 <20200129165810.GD5690@linux.fritz.box>
Date: Thu, 30 Jan 2020 08:31:50 +0100
In-Reply-To: <20200129165810.GD5690@linux.fritz.box> (Kevin Wolf's message of
 "Wed, 29 Jan 2020 17:58:10 +0100")
Message-ID: <8736bxz9g9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TQoHnpoENRajsKTvNJAt9Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 29.01.2020 um 17:35 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>=20
>> > misc.json contains definitions that are related to the system emulator=
,
>> > so it can't be used for other tools like the storage daemon. This patc=
h
>> > moves basic functionality that is shared between all tools (and mostly
>> > related to the monitor itself) into a new control.json, which could be
>> > used in tools as well.
>> >
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>=20
>> I'd like to retitle this patch and the next one:
>>=20
>>     qapi: Split control.json off misc.json
>>     monitor: Collect "control" command handlers in qmp-cmds.control.c
>>=20
>> Okay?
>
> Sure, why not.

Queued, thanks!


