Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1DDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DC320723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqWW6TPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DC320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJ9P-0006mp-8R
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrJ8Q-0005WY-Qn
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:41:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48011
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrJ8P-0005bR-2d
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593772892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8xtmXhQAiabIvarEOyRHLrNGfyHqcQ6L2MdvIA3INM=;
 b=LqWW6TPaC86HO1t8ee5Iouvw3S+lMuzY7NaUGpdHQ00dR9JMYQHP5XUBTlUk61uFhuDH+g
 WYKVRh3drmkZg5yyfKSs1Qo63b/73/eM5E2Mxj6bVX/Tjz4XtNW7PX1wdJhUIVjqWUpLks
 lBzJNwpuVhy2uM2U47xWwYjEF2Na2wY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-nSfU31F4OtOfX8gdK4evEQ-1; Fri, 03 Jul 2020 06:41:30 -0400
X-MC-Unique: nSfU31F4OtOfX8gdK4evEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C7DF107ACCA;
 Fri,  3 Jul 2020 10:41:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4965273FD3;
 Fri,  3 Jul 2020 10:41:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C67261138648; Fri,  3 Jul 2020 12:41:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 03/46] qdev: Smooth error checking of qdev_realize() &
 friends
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-4-armbru@redhat.com>
 <f75c7f3b-477f-f662-5239-87a14c996aa8@virtuozzo.com>
Date: Fri, 03 Jul 2020 12:41:27 +0200
In-Reply-To: <f75c7f3b-477f-f662-5239-87a14c996aa8@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 25 Jun 2020 22:00:36 +0300")
Message-ID: <87d05cq3s8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 24.06.2020 19:43, Markus Armbruster wrote:
>> Convert
>>
>>      foo(..., &err);
>>      if (err) {
>>          ...
>>      }
>>
>> to
>>
>>      if (!foo(..., &err)) {
>>          ...
>>      }
>>
>> for qdev_realize(), qdev_realize_and_unref(), qbus_realize() and their
>> wrappers isa_realize_and_unref(), pci_realize_and_unref(),
>> sysbus_realize(), sysbus_realize_and_unref(), usb_realize_and_unref().
>> Coccinelle script:
>
> Please, also mention a command to run the script
>
>>
>>      @@
>>      identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
>>      expression list args, args2;
>>      typedef Error;
>>      Error *err;
>>      identifier errp;
>>      @@
>>      -      fun(args, &err, args2);
>>      -      if (err) {
>>      +      if (!fun(args, errp, args2)) {
>> 	       ... when != err
>>      -	   error_propagate(errp, err);
>> 	       ...
>> 	   }
>>
>>      @@
>>      identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
>>      expression list args, args2;
>>      typedef Error;
>>      Error *err;
>>      @@
>>      -      fun(args, &err, args2);
>>      -      if (err) {
>>      +      if (!fun(args, &err, args2)) {
>> 	       ...
>> 	   }
>>
>> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
>> ARMSSE being used both as typedef and function-like macro there.
>> Convert manually.
>>
>> Eliminate error_propagate() that are now unnecessary.  Delete @err
>> that are now unused.  Clean up whitespace.
>>
>> Signed-off-by: Markus Armbruster<armbru@redhat.com>
>> ---
[...]
>>  65 files changed, 248 insertions(+), 768 deletions(-)
>
> Almost all of this diff-stat may be generated by more obvious script:
>
> @rule1@
> identifier fun = {qdev_realize, qdev_realize_and_unref, sysbus_realize};
> expression list args;
> typedef Error;
> Error *err;
> identifier errp;
> @@
>
> -      fun(args, &err);
> -      if (err)
> +      if (!fun(args, errp))
>        {

Funny: the placement of { makes a difference.

When I use

  -      if (err) {
  +      if (!fun(args, errp)) {

out of QEMU coding style habit, I get an extra line containing only
spaces in the output.  Easy enough to clean up with sed, but putting the
brace in the place where Coccinelle doesn't produce such litter is
better.

> -              error_propagate(errp, err);
>            return;
>        }
>
[...]


