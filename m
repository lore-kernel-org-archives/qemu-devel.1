Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DCFC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5849E20773
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnAXACsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5849E20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3va-0000sA-C5
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kX3tB-0006Du-2y
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kX3t5-0002vT-2h
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603724057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZHZ0Nb1Z87HLGZB6ibB1EAr7IwF0gi/b2zc52ouJawA=;
 b=XnAXACsWl3ZgslhfnUB2GDMTVme3G61NvsX1dqtmqoJB9+oUcevG/zCQ8i5mzGVixBna10
 RWUQ49O/3GootTTjHZ3GexbwPbv/PShHZf34DuKacFC+Xj90beZ8Rq7T/spdr7GTcEkjZt
 mQDhUi5NQ9HYzaVqbNQJjfgPQfdesQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-Ad29AFCkMuyuT0k8CeblVw-1; Mon, 26 Oct 2020 10:54:13 -0400
X-MC-Unique: Ad29AFCkMuyuT0k8CeblVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 812CC64143;
 Mon, 26 Oct 2020 14:54:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72FB562A14;
 Mon, 26 Oct 2020 14:54:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3D83113865F; Mon, 26 Oct 2020 15:54:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 00/12] Exposing backing-chain allocation over NBD
References: <20201023183652.478921-1-eblake@redhat.com>
 <e3c7c962-93ef-15a0-5fba-ecfcad6241b0@redhat.com>
Date: Mon, 26 Oct 2020 15:54:07 +0100
In-Reply-To: <e3c7c962-93ef-15a0-5fba-ecfcad6241b0@redhat.com> (Eric Blake's
 message of "Fri, 23 Oct 2020 13:44:55 -0500")
Message-ID: <87k0vd3unk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/23/20 1:36 PM, Eric Blake wrote:
>> v4 was here:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02708.html
>> 
>> Since then:
>> - rebase to master
>> - patches 1, 2, and 12 are new based on Vladimir's observation of QAPI_LIST_ADD
>> - patches 10-11 are new based on prior discussion on exposing actual
>> depth in addition to a tri-state encoding
>> - patch 3 has a nasty bug fixed that was causing iotest failures
>> - patch 6 updated to take advantage of patch 2
>> - other minor tweaks based on review comments
>> 
>> 001/12:[down] 'qapi: Move GenericList to qapi/util.h'
>> 002/12:[down] 'qapi: Make QAPI_LIST_ADD() public'
>> 003/12:[0002] [FC] 'nbd: Utilize QAPI_CLONE for type conversion'
>> 004/12:[0010] [FC] 'nbd: Add new qemu:allocation-depth metadata context'
>> 005/12:[----] [--] 'nbd: Add 'qemu-nbd -A' to expose allocation depth'
>> 006/12:[0014] [FC] 'nbd: Update qapi to support exporting multiple bitmaps'
>> 007/12:[----] [--] 'nbd: Simplify qemu bitmap context name'
>> 008/12:[----] [--] 'nbd: Refactor counting of metadata contexts'
>> 009/12:[0017] [FC] 'nbd: Allow export of multiple bitmaps for one device'
>> 010/12:[down] 'block: Return depth level during bdrv_is_allocated_above'
>> 011/12:[down] 'nbd: Expose actual depth in qemu:allocation-depth'
>> 012/12:[down] 'qapi: Use QAPI_LIST_ADD() where possible'
>
> and I meant to add:
>
> Also available at:
> https://repo.or.cz/qemu/ericb.git/shortlog/refs/tags/nbd-alloc-depth-v5
>
> patch 12 is the largest; it may be worth splitting that by maintainer,

I wouldn't split.  The various parts will trickle in separately, and you
may well end up holding leftovers.

> or even pushing it off post-5.2.  Logically, it can go in anywhere after
> patch 2, but by putting it last, I'm hoping to send a pull request for
> soft freeze next week for patches 1-11 for sure, and only include 12 if
> we get enough positive review in time.  I did not try to see if
> Coccinelle could make the work done in patch 12 more automatable.

PATCH 12 serves a useful purpose even if we can't get it in right away:
it convinces me that making QAPI_LIST_ADD() public makes sense.


