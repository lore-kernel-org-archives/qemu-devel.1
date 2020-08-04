Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728B3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C452177B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpRbHoz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C452177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tq5-0001bD-DQ
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2tpB-0000wE-Kh
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:05:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30063
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2tp7-0006SY-A5
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596535531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqitdL8Fb+ftm3mQzQnCw+bGmrzQynpvk4elBNm13IE=;
 b=dpRbHoz3iYlywqIWMZRcAQ0z3eUVsG2kdePqjrH9AUqkW/weL2HgVf9YjrMM/xHjxNBeXN
 9GCmThiYRVVQ5E4mjXGATArNDtE8Lfjhrv9IKaMHUTuJjPal5lvv/X/5GGHuo/e1EZ3irs
 wiAyRLZtmd6twD7qKDvPYBn4TulJ05o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Xlw-TWy8NoSzYWCaXPuw4g-1; Tue, 04 Aug 2020 06:05:27 -0400
X-MC-Unique: Xlw-TWy8NoSzYWCaXPuw4g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37F0D57;
 Tue,  4 Aug 2020 10:05:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CDCB71764;
 Tue,  4 Aug 2020 10:05:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 79FBF16E0A; Tue,  4 Aug 2020 12:05:16 +0200 (CEST)
Date: Tue, 4 Aug 2020 12:05:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 5/7] spice: Move all the spice-related code in spice-app.so
Message-ID: <20200804100516.rtxv2tdzt73lwqyf@sirius.home.kraxel.org>
References: <20200723174615.2370096-1-dinechin@redhat.com>
 <20200723174615.2370096-6-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723174615.2370096-6-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 07:46:13PM +0200, Christophe de Dinechin wrote:
> If we want to build spice as a separately loadable module, we need to
> put all the spice code in one loadable module, because the build
> system does not know how to deal with dependencies yet.

I'd tend to think teaching qemu about module dependencies will work
better.

I've digged around in g_module_open() docs a bit.  There seems to be no
way to set a shared library search path, which makes it tricky to simply
depend on the dynamic linker because features like loading modules from
the build directory when qemu is started from the build directory will
not work as expected then.

So qemu has do deal with it, in the simplest case just a static
dependency list compiled in which is checked on every module load.
Symbols from other modules are available if they are loaded without
G_MODULE_BIND_LOCAL.

That will make module autoloading work better.  Right now it works fine
with -display spice-app.  It doesn't work with a plain -spice.  And
"-audiodev spice,id=test" will not load the spice module either.

I think we should have:

  (1) A audio-spice.so module (autoload will work, by naming
      convention for audio modules).
  (2) A chardev-spice.so module (autoload needs two lines in qom_modules
      in util/module.c, one for each chardev).
  (3) A ui/spice-app.so module (autoload works by naming convention).
  (4) A ui/spice-core.so module which all other spice modules depend on.
      qemu must explicitly load that one in case it finds -spice on the
      command line.

take care,
  Gerd


