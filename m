Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0485C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74BA2236F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqPFYNHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74BA2236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaH6r-0005yP-M1
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaH5p-0005TC-M0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:36:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kaH5n-0002ri-SC
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604489802;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=m9rsHkguAl0d8tEBljB689OGXY0IGX7Sk+Z3Mg5SxJU=;
 b=YqPFYNHBA+Pq/4qe5mdj3PFoeORk7poBF1440PeYDFLMVXWtgwwK+x/onnJ3DunQXDWNNp
 0sCxbPEflX0ye0fY+sFehGqcivsPejONAGHKculb/prslzQ3rOIqUYKaMDBwZwppfWazYL
 kWfkWwDkrgDiFRpQluhvBT5wzSBpIts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-djZBb3nqP5SgPEHPN7aSdQ-1; Wed, 04 Nov 2020 06:36:38 -0500
X-MC-Unique: djZBb3nqP5SgPEHPN7aSdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EAFE1868420
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 11:36:37 +0000 (UTC)
Received: from redhat.com (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4163C6EF55;
 Wed,  4 Nov 2020 11:36:36 +0000 (UTC)
Date: Wed, 4 Nov 2020 11:36:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] qapi, qemu-options: make all parsing visitors parse
 boolean options the same
Message-ID: <20201104113633.GG565323@redhat.com>
References: <20201103161339.447118-1-pbonzini@redhat.com>
 <20201103162551.GQ205187@redhat.com>
 <e950af86-c45d-4165-a9f2-85ee6e845b01@redhat.com>
 <871rh91q4d.fsf@dusky.pond.sub.org>
 <81b2bc92-2b87-d4ac-4ee2-b93b90a35726@redhat.com>
MIME-Version: 1.0
In-Reply-To: <81b2bc92-2b87-d4ac-4ee2-b93b90a35726@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 04, 2020 at 12:31:40PM +0100, Paolo Bonzini wrote:
> On 04/11/20 09:29, Markus Armbruster wrote:
> > >   It only hurts in the odd case of a boolean option becoming on/off/auto
> > > or on/off/split.
> > Another argument for deprecating values other than "on" and "off".
> 
> Unfortunately I'm fairly sure that I've seen yes/no in use.  I can buy
> insta-removal (not deprecation) of case-insensitivity.

Seems a couple of example usages are my fault as I documented them :-(

docs/system/vnc-security.rst:     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes \
docs/system/vnc-security.rst:     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes \
docs/system/vnc-security.rst:     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes \
include/authz/listfile.h: *           filename=/etc/qemu/myvm-vnc.acl,refresh=yes
qemu-options.hx:    ``-object authz-listfile,id=id,filename=path,refresh=yes|no``
qemu-options.hx:                 -object authz-simple,id=auth0,filename=/etc/qemu/vnc-sasl.acl,refresh=yes \\

We should fix thos docs in QEMU at least, and unfortunately it seems I
missed that libvirt did use  verify-peer=yes


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


