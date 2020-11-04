Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE3CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9189208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+eGyYLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9189208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHoC-0007c0-Ro
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaHnS-0006kN-PO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:21:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kaHnR-0000Ry-8P
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604492507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8mS/EXTnXJdGhLS3FPJht81xZVYb0CoJGI6hPwEEdg=;
 b=E+eGyYLQfB45ljckF21hFUuYfeQimNaAP9dT9AThOBS2/tvbBKMKR/JsJHO+0lQrBWT5Sk
 8c66Yvd8JyWLA6QzlP+DcxwctkR8AQloa64t0bqDWeJyb7d8t1aTvUISRBNjNySgfaecDV
 wNEvYu4VSxM1uC+W136B2LspOgijVZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-GSQSYqxWNJCfeYNcsngUyQ-1; Wed, 04 Nov 2020 07:21:46 -0500
X-MC-Unique: GSQSYqxWNJCfeYNcsngUyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9111464081
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 12:21:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 605C410074EA;
 Wed,  4 Nov 2020 12:21:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCA971132BD6; Wed,  4 Nov 2020 13:21:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-5.2 2/4] qemu-option: move help handling to
 get_opt_name_value
References: <20201103151452.416784-1-pbonzini@redhat.com>
 <20201103151452.416784-3-pbonzini@redhat.com>
Date: Wed, 04 Nov 2020 13:21:43 +0100
In-Reply-To: <20201103151452.416784-3-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 3 Nov 2020 10:14:50 -0500")
Message-ID: <87blgdz50o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Right now, help options are parsed normally and then checked
> specially in opt_validate---but only if coming from
> qemu_opts_parse or qemu_opts_parse_noisily, not if coming
> from qemu_opt_set.
>
> Instead, move the check from opt_validate to the common workhorses
> of qemu_opts_parse and qemu_opts_parse_noisily, opts_do_parse and
> get_opt_name_value.
>
> This will come in handy in a subsequent patch, which will
> raise a warning for "-object memory-backend-ram,share"
> ("flag" option with no =on/=off part) but not for
> "-object memory-backend-ram,help".
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I'm afraid this fails my smoke test:

    $ o=`sed -n '/HAS_ARG,/s/DEF("\([^"]*\)".*/\1/p' qemu-options.hx`
    $ for i in $o; do echo "= $i"; upstream-qemu -$i help -version; done 2>&1 | egrep -v 'QEMU emulator|Copyright'

Many output differences.  False positives due to help printing lists in
random order.  Arbitrarily picked true positive:

    $ upstream-qemu -msg help
    msg options:
      guest-name=<bool (on/off)> - Prepends guest name for error messages but only if -name guest is set otherwise option is ignored

      timestamp=<bool (on/off)>
    $ echo $?
    1

regresses to silent failure.


