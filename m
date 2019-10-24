Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64586CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D7620856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cy+SAWbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D7620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYHf-0001le-C9
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iNYGs-0001Gn-Lh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iNYGp-000244-Mp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:15:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iNYGn-00022Y-3p
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571904894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jziDkiLBQ9fOC5h1WDvDikwF/Y+E02EBVpxpOpCkMS0=;
 b=cy+SAWbkHMYY2hDEjJKJoLhmDJ7fhqsFv50UIoad9hzv54KBfICvLXf+tdw7uc4QuuugkO
 1ZwkvUjxlmHugfNR/WoYhbuMwtTvW6p+J6tEVKEa2mf5yRRuDZcsQMiYxGEMRqZX3OQWtI
 wOjCcrGyd5JhQgRl4W6pnLj0IAFCFBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-qq3dEZ6SOeaOfkAwb93YAg-1; Thu, 24 Oct 2019 04:14:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E96247B;
 Thu, 24 Oct 2019 08:14:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC46D60C80;
 Thu, 24 Oct 2019 08:14:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A7DB59DB6; Thu, 24 Oct 2019 10:14:48 +0200 (CEST)
Date: Thu, 24 Oct 2019 10:14:48 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jidong Xia <xiajidong@cmss.chinamobile.com>
Subject: Re: [PATCH] hw/audio: fix a memory leak in OPLCreate()
Message-ID: <20191024081448.asnqqljxb6zxstzp@sirius.home.kraxel.org>
References: <1571824420-24893-1-git-send-email-xiajidong@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <1571824420-24893-1-git-send-email-xiajidong@cmss.chinamobile.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qq3dEZ6SOeaOfkAwb93YAg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 05:53:40PM +0800, Jidong Xia wrote:
> There is a memory leak in OPLCreate(),

No, it's released properly in OPLDestroy().

cheers,
  Gerd


