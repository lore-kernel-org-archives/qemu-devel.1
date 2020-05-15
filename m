Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A923C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E862065F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhmPULOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E862065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZSx2-0000ye-9w
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 01:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZSwN-0000IR-L4
 for qemu-devel@nongnu.org; Fri, 15 May 2020 01:31:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37270
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZSwL-0003KU-R8
 for qemu-devel@nongnu.org; Fri, 15 May 2020 01:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589520679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YaT+t91ePOSXrOxxf3rmSEHkhfbrrHQ4akiELZpnbBo=;
 b=bhmPULOfEcGL+2zk04eG3wEFIqs4bDbDSTlWERxFlDAJ+N/ryQCYHdSeVVFSJgi+WuQvyh
 j5H2fGi0r/jH9YKFlcCPdM2EzP24+hFUi4pC7f3rFX386KGZqONj/HNdXyYuzteYlAQsYj
 Hpleq41Vabo2FDuATRgcrL1gzYQam90=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-2itrlRyxOS-R1_AMOqbhIg-1; Fri, 15 May 2020 01:31:18 -0400
X-MC-Unique: 2itrlRyxOS-R1_AMOqbhIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A5DC800053;
 Fri, 15 May 2020 05:31:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9FA2E163;
 Fri, 15 May 2020 05:31:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9705411358BC; Fri, 15 May 2020 07:31:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: proposal: deprecate -readconfig/-writeconfig
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
 <20200514085418.hmglfmz5rn7lsqe4@sirius.home.kraxel.org>
Date: Fri, 15 May 2020 07:31:12 +0200
In-Reply-To: <20200514085418.hmglfmz5rn7lsqe4@sirius.home.kraxel.org> (Gerd
 Hoffmann's message of "Thu, 14 May 2020 10:54:18 +0200")
Message-ID: <87k11dsr1b.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Thu, May 14, 2020 at 10:09:21AM +0200, Paolo Bonzini wrote:
>> IMHO configuration files are in general a failed experiment.  In
>> practice, they do not add much value over just a shell script because
>> they don't allow configuring all QEMU options, they are very much fixed
>> (by their nature).  I think it's more or less agreed that they are not
>> solving any problem for higher-level management stacks as well; those
>> would prefer to configure the VM via QMP or another API.
>> 
>> So, any objections to deprecating -readconfig and -writeconfig?
>
> -writeconfig surely can go away, it never reached the point where it
> could write out an configuration which is actually complete.
>
> -readconfig is a bit more tricky, it's actually useful.  I'm using it
> sometimes.

I use it all the time.

>             Also we have docs/config/ with a bunch of files you can
> pass to -readconfig.

True.

> I can see that it'll stand in the way if we want move away from QemuOpts
> to something else (say qom-based yaml/json config files), so I wouldn't
> veto deprecation, but I'd prefer it not being actually dropped until the
> replacement is ready and the stuff in docs/config/ being converted to
> the new scheme.

I want QemuOpts replaced, and I want its replacement to support
configuration files.

The replacement effort needs some license for incompatible change.  The
less license, the harder the job becomes.

The configuration file format is among the things that'll change.

QemuOpts was a reasonable step forward back when you invented it, and it
served us well for some time, but we've outgrown it.  It's basically
two-level: configuration group ("drive", "chardev", "device", ...) and
option parameter (for "chardev": "backend", "path", "host", ...).  We
really need trees now.  I can't see how to grow the current INI-like
configuration file syntax compatibly to trees without making it overly
verbose.

Telling users now not to rely on the configuration file format to remain
compatible makes sense to me.


