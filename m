Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6339DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26108206F0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHoi8jEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26108206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibjpt-0001L5-Ak
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 06:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1ibjok-0000cR-8W
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:24:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1ibjoj-0007Hx-9G
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:24:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1ibjoj-0007HX-5I
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 06:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575285876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GS+23DaqC3qG/4/nQ76tpqB0JqbHQ+rqtKp1zwW49yA=;
 b=QHoi8jEeJEj7QcbB/wP4prWtU8PLO89ygZdbYYh97hyzceQDXsLY81UZ5MJfQJFW3SFNG3
 8X9QLg4QSe7wOltwe9hqzIqeqlpgr0UzZs7jOwNf7SLqiMMQ/w7jOIv8m4MxUkpM3KxCEg
 H/uta/vlNZ56Sc92Z1yRxDDyuaq9Uqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-ba1fABGxNuif4wxiIkf9ZA-1; Mon, 02 Dec 2019 06:24:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB314800D53;
 Mon,  2 Dec 2019 11:24:31 +0000 (UTC)
Received: from localhost (dhcp-192-223.str.redhat.com [10.33.192.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A947A4B86;
 Mon,  2 Dec 2019 11:24:22 +0000 (UTC)
Date: Mon, 2 Dec 2019 12:24:21 +0100
From: Jens Freimann <jfreimann@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 00/21] Error handling fixes, may contain 4.2 material
Message-ID: <20191202112421.nqwj4bycswnqjdym@jenstp.localdomain>
References: <20191130194240.10517-1-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191130194240.10517-1-armbru@redhat.com>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ba1fABGxNuif4wxiIkf9ZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 vsementsov@virtuozzo.com,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Nishanth Aravamudan <naravamudan@digitalocean.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 30, 2019 at 08:42:19PM +0100, Markus Armbruster wrote:
>PATCH 2-4 fix crash bugs.  Including them would be a no-brainer at
>-rc0.  But we're post -rc3, and even for crash bugs we require a
>certain likelihood of users getting bitten.
>
>Jens, please assess impact of PATCH 2's crash bug.

Guest can't use it to trigger a qemu crash because the hotplug_handler
called after the pre-plug doesn't do anything with errp.

qemu_opt_set_bool() is also unlikely to trigger the bug because both
reasons for why it would set errp are not true in this path.

I would prefer for this fix to go into 4.2 but if it is the only one
and triggers a large amount of work then don't do it.

regards
Jens


