Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67469C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1682221FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gn0epm2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1682221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBCY-0005cW-Ha
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVBBt-0005By-0h
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:17:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVBBr-0004i2-4u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603275474;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oTucyhGkO2pOJP+ng8zZcJWUZyfwKzXa49VjGi3WeFo=;
 b=gn0epm2ibzWQ+QY8OjBCeoH/CRVDyXOeRi6abZzAMyzbK4PoB/4Ec10sYw1LkHVhs//a0v
 GZM5ElrQZKSPHjS6niMhGTvjw1hK/MkXnHEjl9WysUzgbx0RjSV75sMqEEs17siZEGN1rc
 sJEf6fuLge8sa/yYDFy3Xf8s6D4s6XE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-9rJAcg5KPX-xWU-9OIIQyA-1; Wed, 21 Oct 2020 06:17:52 -0400
X-MC-Unique: 9rJAcg5KPX-xWU-9OIIQyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62F4A8049E2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:17:51 +0000 (UTC)
Received: from redhat.com (ovpn-114-86.ams2.redhat.com [10.36.114.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9BA55C22D;
 Wed, 21 Oct 2020 10:17:46 +0000 (UTC)
Date: Wed, 21 Oct 2020 11:17:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] os: deprecate the -enable-fips option and QEMU's FIPS
 enforcement
Message-ID: <20201021101743.GI412988@redhat.com>
References: <20201020162211.401204-1-berrange@redhat.com>
 <f97dc04a-0cc4-3ba0-ea5e-b185cd0958a7@redhat.com>
 <20201021083803.GC412988@redhat.com>
 <aae2164f-0973-f7b3-3146-1ea659c00922@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aae2164f-0973-f7b3-3146-1ea659c00922@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: libvir-list@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 21, 2020 at 11:51:10AM +0200, Paolo Bonzini wrote:
> On 21/10/20 10:38, Daniel P. Berrangé wrote:
> > On Tue, Oct 20, 2020 at 07:22:03PM +0200, Paolo Bonzini wrote:
> >> On 20/10/20 18:22, Daniel P. Berrangé wrote:
> >>> @@ -153,6 +153,9 @@ int os_parse_cmd_args(int index, const char *optarg)
> >>>          break;
> >>>  #if defined(CONFIG_LINUX)
> >>>      case QEMU_OPTION_enablefips:
> >>> +        warn_report("-enable-fips is deprecated, please build QEMU with "
> >>> +                    "the `libgcrypt` library as the cryptography provider "
> >>> +                    "to enable FIPS compliance");
> >>>          fips_set_state(true);
> >>>          break;
> >>>  #endif
> >>
> >> Should you also remove fips_set_state(true) and make fips_get_state()
> >> return the contents of /proc/sys/crypto/fips_enabled, so that VNC
> >> password authentication is disabled?
> > 
> > I did think about doing that, but decided that since my intention is
> > to delete all trace of fips_get_state / fips_set_state at the end of
> > the deprecation period, that it'd be saner just to leave the semantics
> > unchanged during the deprecation period.
> 
> But would it be correct?  In order to have the advertised behavior of
> "enable FIPS compliance just with procfs, no need to do anything in
> QEMU" you need to disable VNC password authentication; so while
> fips_set_state is an abomination, fips_get_state should remain.

There's no need for fips_get_state. Once you build QEMU with
libgcrypt, when  VNC requests a DES cipher handle, gcrypt will
return an error as that algorithm is forbidden in FIPS mode.

This is the primary reason for outsourcing all crypto to a
separate library and ignoring the impls in QEMU.

Claiming QEMU is FIPS compliant without using libgcrypt is a
bit of joke since we don't do any self-tests of ciphers, hence
this deprecation notice is warning people that libgcrypt is
going to be mandatory if you care about FIPS.


> > Deprecation notices shouldn't really be associated with changes in
> > functionality at time they are introduced.
> 
> I think you can consider it a bugfix since no one sets fips_enabled
> without knowing what they're doing.

I just would rather not change semantics of something that we are
intending to remove 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


