Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41570C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 20:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F90A205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 20:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F90A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsBwf-0003Ym-7d
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 16:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42896)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hsBwA-00039q-St
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 16:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hsBwA-0005OM-0g
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 16:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hsBw9-0005Nf-Rt
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 16:08:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7FFD74A6FB;
 Mon, 29 Jul 2019 20:08:00 +0000 (UTC)
Received: from localhost (ovpn-116-75.gru2.redhat.com [10.97.116.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4A3B60872;
 Mon, 29 Jul 2019 20:07:59 +0000 (UTC)
Date: Mon, 29 Jul 2019 17:07:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190729200757.GJ4313@habkost.net>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-23-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726120542.9894-23-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 29 Jul 2019 20:08:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 22/28] Include hw/boards.h a bit less
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

On Fri, Jul 26, 2019 at 02:05:36PM +0200, Markus Armbruster wrote:
> hw/boards.h pulls in almost 60 headers.  The less we include it into
> headers, the better.  As a first step, drop superfluous inclusions,
> and downgrade some more to what's actually needed.  Gets rid of just
> one inclusion into a header.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
[...]
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c58a8e594e..2c9c93983a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -15,7 +15,6 @@
>  #include "qapi/qmp/qerror.h"
>  #include "sysemu/replay.h"
>  #include "qemu/units.h"
> -#include "hw/boards.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "qapi/visitor.h"

This doesn't look right.  hw/core/machine.c contains the
implementation of most functions declared at hw/boards.h, and
surely requires struct MachineClass and struct MachineState to be
defined.

-- 
Eduardo

