Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D90C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6758820674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il4Eg8Ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6758820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jab0b-0003To-Jy
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaazt-0002si-1Y
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:19:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaazr-0002nE-FR
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589789978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x9BUwSLg8dFMI/q4Vym5aZlnprsw5t6d5rIu2R05XcU=;
 b=Il4Eg8AgdWjyQD5oDNH6otP5C9zFGijmSq/zMynaazcvfx3fmWQ6cbJAr3DHVJ+uCr7EhU
 A/zjcoGU4lzXjvfHF7z46ZEmVTJpw5FsZpGPPkezh9TIQK9w+vJBNfhULwoo7DhbId+Dua
 ZHtHRKfsuTBQmFj0uOq/jDyS94k/KOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-7tWZBNx7PyOrsCrMuPLtwQ-1; Mon, 18 May 2020 04:19:31 -0400
X-MC-Unique: 7tWZBNx7PyOrsCrMuPLtwQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F204A1054F91
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 08:19:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AE83100164D;
 Mon, 18 May 2020 08:19:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B91311358BC; Mon, 18 May 2020 10:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Onboard audio devices and -audiodev none
References: <87pnb5r82b.fsf@dusky.pond.sub.org>
 <20200515083456.vqf4zskk37ycu7te@sirius.home.kraxel.org>
 <87y2ppj0tm.fsf@dusky.pond.sub.org>
 <20200518071429.vz6tpf32bza3rqj3@sirius.home.kraxel.org>
Date: Mon, 18 May 2020 10:19:26 +0200
In-Reply-To: <20200518071429.vz6tpf32bza3rqj3@sirius.home.kraxel.org> (Gerd
 Hoffmann's message of "Mon, 18 May 2020 09:14:29 +0200")
Message-ID: <87r1vheju9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Mon, May 18, 2020 at 06:59:01AM +0200, Markus Armbruster wrote:
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>> 
>> > On Fri, May 15, 2020 at 09:06:20AM +0200, Markus Armbruster wrote:
>> >> Watch this:
>> >> 
>> >>     $ aarch64-softmmu/qemu-system-aarch64 -S -nodefaults -accel qtest -display none -M vexpress-a15 -audiodev none,id=foo
>> >>     audio: Device lm4549: audiodev default parameter is deprecated, please specify audiodev=foo
>> >> 
>> >> I did, didn't I?
>> >
>> > https://patchwork.ozlabs.org/project/qemu-devel/patch/20200429110214.29037-13-kraxel@redhat.com/
>> 
>> I don't immediately understand how that addresses my issue, but I trust
>> it does :)
>
> Well, not the patch itself, it handles pcspk only.  But we could use the
> same naming convention for all other onboard audio devices too:  Have
> them try lookup a "onboard" audio backend and use that if it exists.
> Don't initialize if not.

When an onboard device is an integral part of the physical board we're
emulating, then it should be connected to a suitable null backend when
we don't have a better default.

> Not fully sure this is a good plan, thats why the patch is tagged 'RfC'.
> Better idea are welcome.  In the blockdev world floppy has a similar
> problem, is there any way to link floppy and blockdev without -global
> isa-fdc.driveA=... meanwhile?

Yes, but it won't help with onboard sound: -device floppy just works
now.  The general problem of configuring onboard devices still needs a
solution.  This recent thread has some ideas:

Subject: Configuring onboard devices (was: Failing property setters + hardwired devices + -global = a bad day)
Date: Thu, 30 Apr 2020 12:03:12 +0200 (2 weeks, 3 days, 22 hours ago)
Message-ID: <87tv11e1en.fsf_-_@dusky.pond.sub.org>
https://lists.nongnu.org/archive/html/qemu-devel/2020-04/msg05468.html


