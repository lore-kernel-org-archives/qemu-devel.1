Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17727C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D410D20780
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ1c5txx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D410D20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmUd-0007km-40
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnmU3-0007Iv-0G
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:13:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45842
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnmU0-0006MA-P9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592932394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFyo9d5brvOdgGyhrupvlcJyRq0Zpqbo+/sNVXNWy9M=;
 b=gZ1c5txxGcK7n7zztAUoE+OVEXwzbj5BNIp6YD8Wdtvd03gQVr3dLJlEb2joy0VAfkQqep
 bF+bOZERr08EgebAtckVrWSfcWsRs/EbbxcU9MJoJt9+gie924aGtuAFCQAOXttqedqs3l
 iYmV0ylyJOASuqLcaJP7BBCxP6KkUUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-vGiGfvw-MWmSnjw8JF7nhQ-1; Tue, 23 Jun 2020 13:13:13 -0400
X-MC-Unique: vGiGfvw-MWmSnjw8JF7nhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 155F185B690
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 17:13:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33C0F7FEBD;
 Tue, 23 Jun 2020 17:12:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 197D045BD; Tue, 23 Jun 2020 19:12:48 +0200 (CEST)
Date: Tue, 23 Jun 2020 19:12:48 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v4 3/7] ccid: build smartcard as module
Message-ID: <20200623171248.pnq6otnwyvl3apky@sirius.home.kraxel.org>
References: <20200622135601.12433-1-kraxel@redhat.com>
 <20200622135601.12433-4-kraxel@redhat.com>
 <434be3b8-8ed0-d27b-99c7-e682b0dc4c02@redhat.com>
MIME-Version: 1.0
In-Reply-To: <434be3b8-8ed0-d27b-99c7-e682b0dc4c02@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
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

  Hi,

> > +    { .type = "ccid-card-passthru",    .mod = "usb-smartcard"         },
> > +    { .type = "ccid-card-emulated",    .mod = "usb-smartcard"         },
> 
> We want to use type definitions here (such TYPE_CCID_PASSTHRU),
> as we don't guaranty them stable.

Hmm?  I'm pretty sure '-device ccid-card-passthru' *is* stable ABI.

> Since there is a relation between QOM type and the module,
> can we store/use the module name in the TypeInfo declaration?
> 
>   static const TypeInfo passthru_card_info = {
>       .name          = TYPE_CCID_PASSTHRU,
>       .parent        = TYPE_CCID_CARD,
>       .instance_size = sizeof(PassthruState),
>       .class_init    = passthru_class_initfn,
>       .module_name   = "usb-smartcard",        <=====
>   };

That doesn't buy us much, the TypeInfo ends up in the module not qemu.
So qemu can't access it without loading the module.

We do *not* want load all modules on startup though.  Which means we
need a such list in qemu.  The struct above is just that.  There
certainly is room for improvement, building that list automatically
somehow for example.

Given that most devices don't depend on external shared libraries I
expect the list of device modules will stay relatively short.  So I've
decided to start with something simple and see how it goes (see also
patch 1/7).

> Actually this modularization is not specific to QDEV
> and can be used to all QOM right? I.e:
> 
>   static const TypeInfo qcrypto_tls_creds_x509_info = {
>       .parent = TYPE_QCRYPTO_TLS_CREDS,
>       .name = TYPE_QCRYPTO_TLS_CREDS_X509,
>       .module_name = "gnu-tls",
>       ...
>   }

Not as-is.  You'll need module load hooks in more places then and some
code tweaks to move it from qdev level (loading hw-* module only) to qom
level.

But, yes, moving the infrastructure to some qom-module.c file might be
useful when modularizing non-device objects.  Do you have any candidates
in mind?

take care,
  Gerd


