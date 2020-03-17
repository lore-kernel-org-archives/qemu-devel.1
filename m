Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E9EC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B66A2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2DlaLA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B66A2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJJg-000218-B2
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJIc-0001R8-MC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJIb-0004jF-AO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:58:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJIb-0004a5-5K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kWLVj57CUSNpMF3wx/rqYzLNYm+65ZiBlFdSEqgqjk=;
 b=J2DlaLA5C5mt5ZZ8Ul5iM0wwWc3IBb1sAtB5utlz2RV7dUiY0Q4ZyKHtQz765bY+leJXSI
 KRXAaximVbHQYhIX+/x5xycmTsIA9bs/Fd5NZ3gLDnYlHeXabF9rGWPAqj7aj96sRccCHr
 89YbsbbEY9dD5n7BA0yzlmSyvKeYZpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-ZvDVhzY2MNWlph4fh8-P8g-1; Tue, 17 Mar 2020 16:58:49 -0400
X-MC-Unique: ZvDVhzY2MNWlph4fh8-P8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EB7318FE860;
 Tue, 17 Mar 2020 20:58:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEE425D9E2;
 Tue, 17 Mar 2020 20:58:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5F42B1138404; Tue, 17 Mar 2020 21:58:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/34] Configurable policy for handling deprecated
 interfaces
References: <20200317115459.31821-1-armbru@redhat.com>
Date: Tue, 17 Mar 2020 21:58:41 +0100
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com> (Markus Armbruster's
 message of "Tue, 17 Mar 2020 12:54:25 +0100")
Message-ID: <877dziitq6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, libvir-list@redhat.com,
 mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com, libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> This series extends QMP introspection to cover deprecation.
> Additionally, new option -compat lets you configure what to do when
> deprecated interfaces get used.  This is intended for testing users of
> the management interfaces.  It is experimental.
>
> -compat deprecated-input=3D<in-policy> configures what to do when
> deprecated input is received.  Available policies:
>
> * accept: Accept deprecated commands and arguments (default)
> * reject: Reject them
> * crash: Crash
>
> -compat deprecated-output=3D<out-policy> configures what to do when
> deprecated output is sent.  Available output policies:
>
> * accept: Emit deprecated command results and events (default)
> * hide: Suppress them
>
> For now, -compat covers only deprecated syntactic aspects of QMP.  We
> may want to extend it to cover semantic aspects, CLI, and experimental
> features.
>
> PATCH 01-04: Documentation fixes
> PATCH 05-10: Test improvements
> PATCH 11-24: Add feature flags to remaining user-defined types and to
>       =09     struct members
> PATCH 25-26: New special feature 'deprecated', visible in
>       =09     introspection
> PATCH 27-34: New -compat to set policy for handling stuff marked with
>       =09     feature 'deprecated'

Queued PATCH 01-26.  Thanks for the reviews that made this possible!

PATCH 27-34 will have to wait for 5.1.


