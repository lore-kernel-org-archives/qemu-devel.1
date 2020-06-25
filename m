Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7781BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39016207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmgtQk9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39016207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSFC-0004Hp-HB
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joSDz-0003Qa-RM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:47:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60059
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joSDy-0003ke-0l
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593092848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/VtBwskcANejUgifJiqNoxSc0B1ul23RZQ2iVt7kayw=;
 b=QmgtQk9CndF+IwhT+j0F2IOlCIZY19r9xbHYfAUOLFs4TnvX/gqauE0I8zXfLmluk0As9I
 HvNrXIXrv22j91ZnU49gkQL7cNSM7dby7bNFaIvKkZhY4kHKzVsKjYssS4xBwJ8rxyyUQ3
 AiBZAyKV4dZsZtFfsfS3BqcL7C0//mM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-8Xe4NMlJOZOR77zWETOBtg-1; Thu, 25 Jun 2020 09:47:23 -0400
X-MC-Unique: 8Xe4NMlJOZOR77zWETOBtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A05FBFC7;
 Thu, 25 Jun 2020 13:47:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44D6B100EBA4;
 Thu, 25 Jun 2020 13:47:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C818711384D4; Thu, 25 Jun 2020 15:47:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 20/46] block: Avoid error accumulation in bdrv_img_create()
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-21-armbru@redhat.com>
 <77f15d66-ba25-0cb8-2896-457aea313fc3@redhat.com>
Date: Thu, 25 Jun 2020 15:47:20 +0200
In-Reply-To: <77f15d66-ba25-0cb8-2896-457aea313fc3@redhat.com> (Eric Blake's
 message of "Wed, 24 Jun 2020 15:14:21 -0500")
Message-ID: <877dvvz28n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
>> When creating an image fails because the format doesn't support option
>> "backing_file" or "backing_fmt", bdrv_img_create() first has
>> qemu_opt_set() put a generic error into @local_err, then puts the real
>> error into @errp with error_setg(), and then propagates the former to
>> the latter, which throws away the generic error.  A bit complicated,
>> but works.
>
> Hmm - may interact with my series to deprecate -b without -F.  We'll
> deal with the fallout based on whatever lands first.
>
>>
>> Not that qemu_opt_set() returns a useful value, we can simply ignore
>
> s/Not/Now/

Will fix.

>> the generic error instead.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   block.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Aha - you fixed 2 of the 4 cases that I noticed in 17/46.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


