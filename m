Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05232074F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq+mgfxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05232074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIoR-000382-JB
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqInh-0002JU-1t
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:08:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqInf-0001Mk-I8
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593533279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rvxc5Dz4ETthxrIy4oIdd116ZL70MN6zTtVLzIdLtmA=;
 b=Xq+mgfxESEwsVpY5K+yrTxXh3IT+ePpzbmiRfwz9Jp3fHCRHhI6dJ6NJqOzRqAHdqMluOC
 sefBdqMKdvZXICJ2nWQfYzuI5lryAO0EApPxU9D1NjiM8OeYYdYXEKbwzSQj53sPxu9GFM
 10l5f9neEl01ElN+kzfyn82U0QwDlnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-Thz1_BuNO_SsDStZjjRjZA-1; Tue, 30 Jun 2020 12:07:57 -0400
X-MC-Unique: Thz1_BuNO_SsDStZjjRjZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A500804004
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 16:07:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0840F60C81;
 Tue, 30 Jun 2020 16:07:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B464617444; Tue, 30 Jun 2020 18:07:51 +0200 (CEST)
Date: Tue, 30 Jun 2020 18:07:51 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 3/7] ccid: build smartcard as module
Message-ID: <20200630160751.y52htbwik4ppurlx@sirius.home.kraxel.org>
References: <20200622135601.12433-1-kraxel@redhat.com>
 <20200622135601.12433-4-kraxel@redhat.com>
 <434be3b8-8ed0-d27b-99c7-e682b0dc4c02@redhat.com>
 <20200623171248.pnq6otnwyvl3apky@sirius.home.kraxel.org>
 <50b9426c-f34d-c3e7-8572-82c4c7d155a1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <50b9426c-f34d-c3e7-8572-82c4c7d155a1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: dinechin@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> >>   static const TypeInfo qcrypto_tls_creds_x509_info = {
> >>       .parent = TYPE_QCRYPTO_TLS_CREDS,
> >>       .name = TYPE_QCRYPTO_TLS_CREDS_X509,
> >>       .module_name = "gnu-tls",
> >>       ...
> >>   }
> > 
> > Not as-is.  You'll need module load hooks in more places then and some
> > code tweaks to move it from qdev level (loading hw-* module only) to qom
> > level.

[ note: v5 of the series does this ]

> > But, yes, moving the infrastructure to some qom-module.c file might be
> > useful when modularizing non-device objects.  Do you have any candidates
> > in mind?
> 
> So far I was only thinking of gnutls.

Looks challenging on a quick glance ...

take care,
  Gerd


