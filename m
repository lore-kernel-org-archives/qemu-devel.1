Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED2CC2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C24E206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flx4744y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C24E206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFMt-0004TP-8b
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJFLu-0003ZD-OR
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJFLt-0006O6-KA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:46:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51836
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJFLt-0006N1-Gw
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585655200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jzy0sS8VSapouDnrDGubOhVXn072gzn3z6qI/Z3/T2Q=;
 b=flx4744ysjnOlm39y1FSfAmqZgQj8dQJsgnKjBoK7/YD16A+H+kT4h5yyUtw5N0ZynHrXX
 OVzqF+F5fek8TRYS1SJVzHbIgQ6JrIlbW84sPwMeFlAXFSeiT/1fXEKD69JpAV8LuDWUU6
 /VfyfrkD+BjYAW8CA/TwxWkZ9+7gOH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-rxQvmtDeO4CAHlAzLHyfDA-1; Tue, 31 Mar 2020 07:46:39 -0400
X-MC-Unique: rxQvmtDeO4CAHlAzLHyfDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B49E5100726B;
 Tue, 31 Mar 2020 11:46:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1F2F60BE1;
 Tue, 31 Mar 2020 11:46:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1A5211385E2; Tue, 31 Mar 2020 13:46:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 6/6] qga/commands-posix: fix use after free of local_err
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-7-vsementsov@virtuozzo.com>
 <012d4cf0-e168-a9ea-273a-a683e50ef7a0@redhat.com>
 <3e28eab6-a7c8-a9b3-84bf-b98e241139cc@virtuozzo.com>
Date: Tue, 31 Mar 2020 13:46:30 +0200
In-Reply-To: <3e28eab6-a7c8-a9b3-84bf-b98e241139cc@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 25 Mar 2020 07:28:02 +0300")
Message-ID: <87tv24ycfd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 quintela@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, den@openvz.org, marcandre.lureau@redhat.com,
 mreitz@redhat.com, mdroth@linux.vnet.ibm.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

[...]
> I agree that this is a strange function and its logic is weird. But I
> don't know what the logic should be. My patch is still valid to just
> fix obvious use-after-free and possible leak. It doesn't fix the
> logic.

I sketched improved logic elsewhere in this thread, and I can turn that
into a patch.

I can either make it replace Vladimir's patch, or make it go on top.  If
the latter, we can apply just Vladimir's patch for 5.0, and punt mine to
5.1

Got a preference?


