Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20636C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DA72088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsuxcAdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DA72088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0sK-00073m-0C
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0rH-00061e-QU
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:34:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23209
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0rF-000805-3D
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592987651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onD2F+VlFmLsM+j8BU+AiV1q5udFfVtc993ViDW7dGQ=;
 b=OsuxcAdVCgIAS/Y3Ag57V6PJVhUb6j0zJ+Hc7rW61WHWODcdIU3qiYB9UsWKevtnUsY+1G
 DFuBeQC+2cYnoQQS5+hDAyHI7XAm/NDJvMORNCLl3z+lMaztBNjgBbNeYVw9BtVJz0ngSe
 kL31Q8dIqXrkPx3Bo30O9Y18pbIzfPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-8-0xNiEROVSbnyBA_ST1cQ-1; Wed, 24 Jun 2020 04:34:09 -0400
X-MC-Unique: 8-0xNiEROVSbnyBA_ST1cQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEA201883604
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 08:34:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC98B10013D9;
 Wed, 24 Jun 2020 08:34:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BCE7113846D; Wed, 24 Jun 2020 10:34:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: -enablefips
References: <7816f22f-2872-06ef-f7ef-40add5a34040@redhat.com>
 <20200624064954.jmkqonjbqfhso5dr@sirius.home.kraxel.org>
Date: Wed, 24 Jun 2020 10:34:03 +0200
In-Reply-To: <20200624064954.jmkqonjbqfhso5dr@sirius.home.kraxel.org> (Gerd
 Hoffmann's message of "Wed, 24 Jun 2020 08:49:54 +0200")
Message-ID: <878sgcdfr8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Tue, Jun 23, 2020 at 11:51:09PM -0400, John Snow wrote:
>> I never knew what this option did, but the answer is ... strange!
>> 
>> It's only defined for linux, in os-posix.c. When called, it calls
>> fips_set_state(true), located in osdep.c.
>> 
>> This will read /proc/sys/crypto/fips_enabled and set the static global
>> 'fips_enabled' to true if this setting is on.
>
> IIRC the idea is to have a global switch to enable fips compilance for
> the whole distro.  RH specific.  rhel-7 kernel has it.  rhel-8 kernel
> too, so it probably isn't obsolete.  Not present in mainline kernels.
>
> I'm wondering what the point of the -enablefips switch is.  Shouldn't
> qemu check /proc/sys/crypto/fips_enabled unconditionally instead?

The switch feels rather silly to me.  If you take the trouble to put
your host in FIPS mode, requiring -enable-fips to make QEMU to actually
honor it makes no sense.  If you don't, QEMU's -enable-fips has no
effect.

I may well misremember things (it's been years), but I vaguely recall
-enable-fips being a lame compromise between "this ought to be upstream"
and "FIPS is stupid, and I want nothing of it".

>> (Tangent: what does *this* setting actually control? Should QEMU
>> meaningfully change its behavior when it's set?)
>
> fips is a security policy ...
>
>> This static global is exposed via the getter fips_get_state(). This
>> function is called only by vnc.c, and appears to disable the use of the
>> password option for -vnc.
>
> ... yes, "no passwords" is one of the rules.  There are probably more.
>
>> (If we really do want to keep it, it should probably go under -global
>> somewhere instead to help reduce flag clutter, but we'd need to have a
>> chat about what fips compliance means for literally every other spot in
>> QEMU that is capable of using or receiving a cleartext password.)
>
> Yep.  IIRC for spice this is handled in libspice-server.  We need to
> look at blockdev encryption I guess.  Any other places where qemu uses
> passwords directly?  I think we don't have to worry about indirect usage
> (sasl).

I'd expect the SASL libraries to honor FIPS mode by themselves.  But
best ask someone who actually knows how FIPS mode is supposed to work.


