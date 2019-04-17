Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD9DC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307EF2073F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 05:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307EF2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47065 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGcuY-0005S3-By
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 01:15:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGctj-00054f-AX
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGcti-0007U8-C5
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hGcti-0007T7-4G; Wed, 17 Apr 2019 01:14:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4AEEB3084213;
	Wed, 17 Apr 2019 05:14:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC81A5C220;
	Wed, 17 Apr 2019 05:14:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 66F721138648; Wed, 17 Apr 2019 07:14:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1555315185-16414-1-git-send-email-like.xu@linux.intel.com>
	<1555315185-16414-3-git-send-email-like.xu@linux.intel.com>
	<20190416212003.GB2272@habkost.net>
Date: Wed, 17 Apr 2019 07:14:10 +0200
In-Reply-To: <20190416212003.GB2272@habkost.net> (Eduardo Habkost's message of
	"Tue, 16 Apr 2019 18:20:03 -0300")
Message-ID: <87ftqh1ae5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 17 Apr 2019 05:14:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/2] core/qdev: refactor
 qdev_get_machine() with type assertion
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Like Xu <like.xu@linux.intel.com>, qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org, like.xu@intel.com,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417051410.I-ixmo5wuspE2iZ4oTTcy8m2Z1i1ocvTJCCgeYzxSP8@z>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Mon, Apr 15, 2019 at 03:59:45PM +0800, Like Xu wrote:
>> To avoid the misuse of qdev_get_machine() if machine hasn't been created yet,
>> this patch uses qdev_get_machine_uncheck() for obj-common (share with user-only
>> mode) and adds type assertion to qdev_get_machine() in system-emulation mode.
>> 
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
> I'm queueing the series on machine-next, thanks!

Hold your horses, please.

I dislike the name qdev_get_machine_uncheck().  I could live with
qdev_get_machine_unchecked().

However, I doubt this is the right approach.

The issue at hand is undisciplined creation of QOM object /machine.

This patch adds an asseertion "undisciplined creation of /machine didn't
create crap", but only in some places.

I think we should never create /machine as (surprising!) side effect of
qdev_get_machine().  Create it explicitly instead, and have
qdev_get_machine() use object_resolve_path("/machine", NULL) to get it.
Look ma, no side effects.

