Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62194C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB796206C9
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWTn4bKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB796206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvyz-00018L-UN
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFvy9-0000IG-J6
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:00:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFvy7-00021k-MV
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599642042;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwHwEH+hcxtK4GvmgVtbbkjf1tPkPVKwYH01ZUGePiQ=;
 b=hWTn4bKKnwGn7fdX/yUrRCB008Fc6JlQJl9mISy8LFGBF3asuqsvkQ4UMn58KON9TxDpSb
 9Z8sdt9vTMtrsSzAj3TgDDa8pMj2azUL4Dcei0BixrOr3iHXgt95V0/1t2vZPseIUcodDW
 JUYQCI91kVDeztr2UReh//KwPTVHDdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-5SIE_yzgOjWaQ-hOR_WHPA-1; Wed, 09 Sep 2020 05:00:38 -0400
X-MC-Unique: 5SIE_yzgOjWaQ-hOR_WHPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57BEA801AEC;
 Wed,  9 Sep 2020 09:00:37 +0000 (UTC)
Received: from redhat.com (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E9F110013D0;
 Wed,  9 Sep 2020 09:00:31 +0000 (UTC)
Date: Wed, 9 Sep 2020 10:00:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH 1/5] hw/smbios: support loading OEM strings values from a
 file
Message-ID: <20200909090028.GK1011023@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
 <20200908165438.1008942-2-berrange@redhat.com>
 <c7ecee55-64a3-5a46-26d9-6a1cc4c7889c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c7ecee55-64a3-5a46-26d9-6a1cc4c7889c@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 10:18:47AM +0200, Laszlo Ersek wrote:
> On 09/08/20 18:54, Daniel P. Berrangé wrote:
> > Some applications want to pass quite large values for the OEM strings
> > entries. Rather than having huge strings on the command line, it would
> > be better to load them from a file, as supported with -fw_cfg.
> > 
> > This introduces the "valuefile" parameter allowing for:
> > 
> >   $ echo -n "thisthing" > mydata.txt
> >   $ qemu-system-x86_64 \
> >     -smbios type=11,value=something \
> >     -smbios type=11,valuefile=mydata.txt \
> >     -smbios type=11,value=somemore \
> >     ...other args...
> > 
> > Now in the guest
> > 
> > $ dmidecide -t 11
> > Getting SMBIOS data from sysfs.
> > SMBIOS 2.8 present.
> > 
> > Handle 0x0E00, DMI type 11, 5 bytes
> > OEM Strings
> > 	String 1: something
> > 	String 2: thisthing
> > 	String 3: somemore
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  hw/smbios/smbios.c | 72 +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 59 insertions(+), 13 deletions(-)
> 
> (gearing up to test this / look into the edk2 problem, just one question
> in passing: could we / would we simplify this with g_file_get_contents()?)

Yes, but at the cost of loosing the ability to pass in a pre-opened
FD, which qemu_open allows for.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


