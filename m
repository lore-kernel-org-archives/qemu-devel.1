Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E99C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EF821D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXGrV7Li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EF821D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUvv-0000op-Lz
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihUug-0007Gf-FE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihUue-0005Q1-0N
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:42:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40427
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihUud-0005Nq-S6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576658550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RcTacBwkJf7SXenM2pZZ9gnf9LM9SJfQqYzNdtporM=;
 b=WXGrV7Li2KaT0aqfqQ0ieo8i93VPLOcAVC6j4PflN71pwLlN7oYgnpgt3hw9uQf3RvjFDH
 F4KOgrEoKYr3gEOfUwDtEvYkBDB1UvA4d+3PjdMtD/Nxx+EscBJys37X0wr5RJyCGxKrsa
 Aywjkt5QTR9kuCizEmhSYYE8lDXNWjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-VyfPrMuyMieHhwMuwTInMQ-1; Wed, 18 Dec 2019 03:42:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B27B800D5A;
 Wed, 18 Dec 2019 08:42:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DA5B5D9E2;
 Wed, 18 Dec 2019 08:42:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B318E11386A7; Wed, 18 Dec 2019 09:42:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/6] QAPI patches for 2019-12-17
References: <20191217081454.8072-1-armbru@redhat.com>
 <CAFEAcA8r-wai+vMa8WiCjUFyRGwTQQs9fZo_ddRmAdr_6GAcTw@mail.gmail.com>
Date: Wed, 18 Dec 2019 09:42:24 +0100
In-Reply-To: <CAFEAcA8r-wai+vMa8WiCjUFyRGwTQQs9fZo_ddRmAdr_6GAcTw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 17 Dec 2019 15:54:58 +0000")
Message-ID: <875zie81ov.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: VyfPrMuyMieHhwMuwTInMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 17 Dec 2019 at 08:16, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e2166=
304:
>>
>>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16=
-2019' into staging (2019-12-16 14:07:56 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-12-17
>>
>> for you to fetch changes up to 328add3012e0b642134afedcd53660c30c758866:
>>
>>   qapi: Simplify QAPISchemaModularCVisitor (2019-12-17 08:09:28 +0100)
>>
>> ----------------------------------------------------------------
>> QAPI patches for 2019-12-17
>>
>> ----------------------------------------------------------------
>> Markus Armbruster (6):
>>       qapi: Tweak "command returns a nice type" check for clarity
>>       tests/Makefile.include: Fix missing test-qapi-emit-events.[ch]
>>       qapi: Generate command registration stuff into separate files
>>       qapi: Proper intermediate representation for modules
>>       qapi: Fix code generation for empty modules
>>       qapi: Simplify QAPISchemaModularCVisitor
>
> Build failures:
>
> OSX:
> In file included from In file included from qapi/qapi-types-block.c:15:
> In file included from
> /Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-block.h:17:
> In file included from
> /Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-block-core.h:1=
8:
> /Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:176:3=
3:
> error: field has incomplete type 'QCryptoBlockOptionsQCow' (aka
> 'struct QCryptoBlockOptionsQCow')
> qapi/qapi-types-block-core.c:15:
> In file included from
> /Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-block-core.h:1=
8:
> /Users/pm215/src/qemu-for-merges/build/all/qapi/qapi-types-crypto.h:176:3=
3:
> error: field has incomplete type 'QCryptoBlockOptionsQCow' (aka
> 'struct QCryptoBlockOptionsQCow')
>         QCryptoBlockOptionsQCow qcow;
>         QCryptoBlockOptionsQCow qcow;                                ^
>
>                                 ^

Perplexing.  None of the files involved gets changed by this pull
request.  My qapi-types-crypto.h has

    typedef struct QCryptoBlockOptionsQCow QCryptoBlockOptionsQCow;
    [...]
    struct QCryptoBlockOptionsQCow {
        bool has_key_secret;
        char *key_secret;
    };
    [...]
    struct QCryptoBlockOpenOptions {
        /* Members inherited from QCryptoBlockOptionsBase: */
        QCryptoBlockFormat format;
        /* Own members: */
        union { /* union tag is @format */
            QCryptoBlockOptionsQCow qcow;
            QCryptoBlockOptionsLUKS luks;
        } u;
    };

before and after.  May I see yours?

[More errors snipped, they're similar]


