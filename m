Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90721C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5280120708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmb9Q72+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5280120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6Ar-0006ce-IU
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iY6AB-0005mb-9Y
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iY6AA-0002qk-CF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:27:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38239
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iY6AA-0002pq-6l
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574418459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlwSh/DOeOTjhh84KPTwk9BE6XZ5NYIGOR7PpjePGP0=;
 b=dmb9Q72+013OYModg+3wCc4841Z9kxeTQZnF2b4KQWz76vDGxJhraHqcTQ00seRR0/mHaG
 +ZOw33rzYtOr2FFFl1d4zS18U9+iQJ6cNLN4egmLKuj3kvVt7ZVa3lvw2ki6otU/TtfqMo
 2WwEh9L+Gy7PMlIF/OAooEb9rSxuQMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-zaOMXvwTO_GmPnwyHAq4TA-1; Fri, 22 Nov 2019 05:27:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 219C610054E3;
 Fri, 22 Nov 2019 10:27:34 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-252.ams2.redhat.com [10.36.117.252])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA4B76E71D;
 Fri, 22 Nov 2019 10:27:32 +0000 (UTC)
Date: Fri, 22 Nov 2019 11:27:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/9] RFC: [for 5.0]: HMP monitor handlers cleanups
Message-ID: <20191122102731.GC4433@linux.fritz.box>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191122101528.GB2785@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191122101528.GB2785@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zaOMXvwTO_GmPnwyHAq4TA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.11.2019 um 11:15 hat Dr. David Alan Gilbert geschrieben:
> * Maxim Levitsky (mlevitsk@redhat.com) wrote:
> > This patch series is bunch of cleanups
> > to the hmp monitor code.
> >=20
> > This series only touched blockdev related hmp handlers.
>=20
> Hi Maxim,
>   This looks mostly OK to me from the HMP side - with one change;
> can you please move the blockdev-hmp-cmds.c into either monitor/ or
> block/; with that

Let's create a block/monitor/hmp.c then. There is more stuff that could
move into that directory later.

Kevin


