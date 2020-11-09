Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9597C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0759C206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnpGnA6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0759C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc27P-0007oD-NI
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 03:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc25n-0006sK-6i
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:00:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc25i-0006EZ-0z
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 02:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604908793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOgYXmQZ7G1J+i7RpKcgCLQCs873HwBPQdZypJyQQro=;
 b=OnpGnA6oxKcU4TfkSFrzGHgp5UXSoypsm2H4dd1LMlNHeL6jyRv2YObXVJsjTN4+ffqLPO
 jHeEE1ygtsPRhFaStqKjU088ghVdW5fMNCAsNZJ6i63KUIBvGlr8eUMDVaMGaE/5pArmmB
 6yXIF/MkAJeTQbyRoOFlzDeMSBqF32w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ixfkHFzYMK256ybpuGenJA-1; Mon, 09 Nov 2020 02:59:51 -0500
X-MC-Unique: ixfkHFzYMK256ybpuGenJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70862100746B
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 07:59:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DAD55C221;
 Mon,  9 Nov 2020 07:59:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B2AC31132BD6; Mon,  9 Nov 2020 08:59:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] qemu-option: warn for short-form boolean options
References: <20201105142731.623428-1-pbonzini@redhat.com>
 <20201105142731.623428-3-pbonzini@redhat.com>
 <87361mfn1d.fsf@dusky.pond.sub.org>
 <3c094f89-11b6-b6cc-690b-df688e425fd9@redhat.com>
Date: Mon, 09 Nov 2020 08:59:48 +0100
In-Reply-To: <3c094f89-11b6-b6cc-690b-df688e425fd9@redhat.com> (Paolo
 Bonzini's message of "Fri, 6 Nov 2020 19:20:33 +0100")
Message-ID: <878sbbarkb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 06/11/20 17:49, Markus Armbruster wrote:
>>> Deprecate all this, except for -chardev and -spice where it is in
>>> wide use.
>> I consider this a misuse of deprecation, to be frank.  If something is
>> known to be unused, we just remove it.  Deprecation is precisely for
>> things that are used.  I'm with Daniel here: let's deprecate this sugar
>> everywhere.
>> Wide use may justify extending the deprecation grace period.
>
> Fair enough.  However now that I think of it I'd have to remove the
> coverage of the "feature" in tests, because they'd warn.

Either that, or do what we do elsewhere when warnings get in the way of
testing: suppress them when testing.  I wouldn't bother here unless it's
easy.


