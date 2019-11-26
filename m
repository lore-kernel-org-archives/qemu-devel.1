Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5595C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715FC20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2Nd0vKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715FC20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZcef-0002r9-DC
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 10:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iZcci-0001jh-7t
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZccf-0008JE-KG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:19:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZccf-0008IU-C4
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574781564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NHNJAVN9gonW/+bFFXvR2+G9iCC5GVxKmU5ltc5RpM0=;
 b=Y2Nd0vKghrp7oBJU7cQNwH6ZlN09D4KhkSyQohyOOnQk1GPyP2m8H+fa/tosJfsdW465Mz
 kuojVMVbI02P7JlkXCapjuV7YTNOCgSEgav0ZoajsMGeP/uyeAikRdUz2wuWI9hPTHJyxb
 RavOlcHtqGXLNyBrVLJf4zAjx7B0970=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-6Qp6slnpNgGbqNEwfT5S2w-1; Tue, 26 Nov 2019 10:19:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C62C01380BD;
 Tue, 26 Nov 2019 15:19:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7922B5D6BE;
 Tue, 26 Nov 2019 15:19:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03F791138606; Tue, 26 Nov 2019 16:19:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] error: Fix -msg timestamp default
References: <20191010081508.8978-1-armbru@redhat.com>
Date: Tue, 26 Nov 2019 16:19:19 +0100
In-Reply-To: <20191010081508.8978-1-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 10 Oct 2019 10:15:08 +0200")
Message-ID: <875zj6psw8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 6Qp6slnpNgGbqNEwfT5S2w-1
X-Mimecast-Spam-Score: 0
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
Cc: pbonzini@redhat.com, msmarduch@digitalocean.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> -msg parameter "timestamp" defaults to "off" if you don't specify msg,
> and to "on" if you do.  Messed up right in commit 5e2ac51917 "add
> timestamp to error_report()".  Mostly harmless, because "timestamp" is
> the only parameter, so "if you do" is "-msg ''", which nobody does.
>
> Change the default to "off" no matter what.
>
> While there, rename enable_timestamp_msg to error_with_timestamp, and
> polish documentation.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Queued for 5.0.


