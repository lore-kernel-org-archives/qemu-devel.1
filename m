Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC7C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 08:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8EE9206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 08:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gE9/0CPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EE9206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaExX-0003NT-4L
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 04:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaEwz-0002fc-G1
 for qemu-devel@nongnu.org; Sun, 17 May 2020 04:47:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42312
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jaEwy-0002R2-PY
 for qemu-devel@nongnu.org; Sun, 17 May 2020 04:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589705232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OU9dGBqYSF9voTJcrRBA26MPCmevoLjfYZey4phI3l0=;
 b=gE9/0CPrVBYedUIF9pWtWwwkHle+QW5JuzEAhJlx27m+p6TckvktDbdZNgBe3bSw+gLYMv
 Lcmmj9L4z3Sd5htMOchXRQgacgp8mvB3D8+VUbvPmZVU3gxkEyd9fut2JW6DcAlfghOw6P
 6D+wO4ym5hKcV5OjCnRf0i2pE2z4V3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-5cu9BqWyMbKKrDALv-sAnw-1; Sun, 17 May 2020 04:47:08 -0400
X-MC-Unique: 5cu9BqWyMbKKrDALv-sAnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59A221005510;
 Sun, 17 May 2020 08:47:07 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F12D60BF4;
 Sun, 17 May 2020 08:47:04 +0000 (UTC)
Message-ID: <8c25372ed549c514fb60a6281f4be55ec5494e7a.camel@redhat.com>
Subject: Re: [PATCH v6 04/14] block/amend: separate amend and create options
 for qemu-img
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, 
 qemu-devel@nongnu.org
Date: Sun, 17 May 2020 11:47:03 +0300
In-Reply-To: <3a2238b4-e040-e327-a7dd-831e3f24c808@redhat.com>
References: <20200510134037.18487-1-mlevitsk@redhat.com>
 <20200510134037.18487-5-mlevitsk@redhat.com>
 <5b389390-eadb-e1d6-48f8-be99c2dfad99@redhat.com>
 <52231bba-4ef1-2e96-1e82-9e350a68b106@redhat.com>
 <c93d9e92-94dc-9965-e291-2aef8724385a@redhat.com>
 <3a2238b4-e040-e327-a7dd-831e3f24c808@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 04:47:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-05-15 at 12:24 -0500, Eric Blake wrote:
> On 5/15/20 1:22 AM, Max Reitz wrote:
> 
> > > > 
> > > > > +        QCOW_COMMON_OPTIONS,
> > > > > +        { /* end of list */ }
> > > 
> > > ...the intended usage is to use the macro name followed by a comma, so
> > > including a trailing comma in the macro itself would lead to a syntax
> > > error.
> > 
> > But why is that the indended usage?  Is there something in our coding
> > style that forbids macros that don’t allow a separator to be placed
> > after them?
> 
> If we have more than one such macro, it is easier to write and indent 
> (especially when using your editor's ability to decipher enough syntax 
> to suggest how to indent):
> 
> myarray = {
>    COMMON_ELEMENTS,
>    MORE_ELEMENTS,
>    { /* end of list */ }
> };
> 
> than it is:
> 
> myarray = {
>    COMMON_ELEMENTS
>    MORE_ELEMENTS
>    { /* end of list */ }
> };
> 
> which in turn implies that it is better to NOT stick a trailing comma in 
> the macro itself.  Similarly, for macros intended to replace statements, 
> we tend to avoid the trailing ; in the macro itself, because it is 
> easier to read:
> 
> {
>    code;
>    MACRO();
>    more code;
> }
> 
> than it is:
> 
> {
>    code;
>    MACRO()
>    more code;
> }
> 

100% agree with that.


Here something a bit off-topic, but something that I find a bit amusing and is somewhat related to
hiding punctuation in macros:

I once wasted about hour of my life trying to understand why kernel ABI macro I added for a backport
didn't work as intended.
(This was a macro we are supposed to wrap each new struct field in it to
inform to the ABI checker
that it is OK).

I was almost ready to poke my eyes out as I were comparing what I wrote to what is present in
few more places that use that macro, till I finally understood that the macro expects you to
not stick ';' after it. It does compile fine with an extra ';', since it is just an empty statement,
but this was tripping some regular expression in the ABI checker script or something.
(It didn't give me any meaningful error).

Back to topic, I'll rebase this patch, as I always do prior to sending
a new patch series.


Best regards,
	Maxim Levitsky



