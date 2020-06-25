Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6E8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DCE2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwVHeczk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DCE2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joQBa-00035D-MU
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joQB0-0002X4-0e
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:36:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59992
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joQAy-0000IT-HR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593084975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gMbg6QjGMJQh9Eo4L4nIycm4Z/qOj9Hh4s3OEgsZNbo=;
 b=LwVHeczkcJMD5JkZeVh+5vv12W1so2GOxFct97IVImqZg/d6Ma3YrtIjpaM+yn2xc+AlxT
 hz2NXvVhMWEbmsbMfDeMU2o0Rdbfoy7+qNH+WZDTxaxnogYJMk+/YIXF2JRb9ab4ZXAhNy
 9itUJPSKTb8Brx0suXCPELV2gYy5JOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-_Sjy00BlPo6dmB5u0j3rfQ-1; Thu, 25 Jun 2020 07:36:12 -0400
X-MC-Unique: _Sjy00BlPo6dmB5u0j3rfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C8FFEC1A2;
 Thu, 25 Jun 2020 11:36:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B3F4579A3;
 Thu, 25 Jun 2020 11:36:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BBAD11384D4; Thu, 25 Jun 2020 13:36:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 03/46] qdev: Smooth error checking of qdev_realize() &
 friends
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-4-armbru@redhat.com>
 <c503f65b-9d1e-6a1b-502a-fdcc4bfa4bcf@redhat.com>
Date: Thu, 25 Jun 2020 13:36:09 +0200
In-Reply-To: <c503f65b-9d1e-6a1b-502a-fdcc4bfa4bcf@redhat.com> (Eric Blake's
 message of "Wed, 24 Jun 2020 13:03:12 -0500")
Message-ID: <87lfkb2x92.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 6/24/20 11:43 AM, Markus Armbruster wrote:
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
> Automated patching is so much easier than manual :)

Except when Coccinelle dies with some weird error, or refuses to play
ball without any explanation at all :)

Coccinelle is both awesome and terrible!

>> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
>> ARMSSE being used both as typedef and function-like macro there.
>> Convert manually.
>>
>> Eliminate error_propagate() that are now unnecessary.  Delete @err
>> that are now unused.  Clean up whitespace.
>
> Well, so there's still some manual stuff.  But that's okay; hopefully
> we don't have too many stragglers reintroduced via pending patches.

The first sentence is a leftover from an earlier, more manual version.
I'll delete it.

The manual stuff is really just deleting unused variables to make the
compiler happy, tidying up whitespace and breaking long lines to make
checkpatch happy, and tweak line breaks a bit more to make my reviewers
happy.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>>   65 files changed, 248 insertions(+), 768 deletions(-)
>
> Quite a big trim.  But I didn't spot any obvious problems.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


