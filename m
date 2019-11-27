Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F21C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443D320684
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0s3Ua9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443D320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0Jr-00013N-1k
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 11:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ia0Ax-0004z4-Bz
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iZzvZ-0000Mr-Ry
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:12:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50048
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iZzvZ-0000Ma-Oj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574871149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7kSHyNakhpnfN3uIPCCKdBsmup5ZS0T/FitgipkbsLQ=;
 b=a0s3Ua9t2V+RXlkGnZkvEmZQJeeoBJEQgQXMepEvs1gBOUYRXdOyJ9BbvU0OziLHbSA0cL
 3Xyn4bPoAWYFtUOIETFhY/zkH6Tm9J5rDak4qSbAcQaVq6G3I8AAhVAUINeN+vdPE/eDNZ
 qkW1kQDKPK9z1GmwonwOf59cbuI6OEI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-YlPBbR1EPZabdcau0F8fyw-1; Wed, 27 Nov 2019 11:12:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1E72800D53;
 Wed, 27 Nov 2019 16:12:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CF7260BEC;
 Wed, 27 Nov 2019 16:12:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99D4F1138606; Wed, 27 Nov 2019 17:12:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/6] qapi: Generate command registration stuff into
 separate files
References: <20191120182551.23795-1-armbru@redhat.com>
 <20191120182551.23795-4-armbru@redhat.com>
 <d9fc4c2a-61d0-43b9-e792-35f5f5d39798@redhat.com>
Date: Wed, 27 Nov 2019 17:12:23 +0100
In-Reply-To: <d9fc4c2a-61d0-43b9-e792-35f5f5d39798@redhat.com> (Eric Blake's
 message of "Wed, 20 Nov 2019 13:26:10 -0600")
Message-ID: <87sgm9ti1k.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: YlPBbR1EPZabdcau0F8fyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, kwolf@pond.sub.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 11/20/19 12:25 PM, Markus Armbruster wrote:
>> Having to include qapi-commands.h just for qmp_init_marshal() is
>> suboptimal.  Generate it into separate files.  This lets
>> monitor/misc.c, qga/main.c, and the generated qapi-commands-FOO.h
>> include less.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/docs/devel/qapi-code-gen.txt
>> @@ -1493,6 +1493,10 @@ $(prefix)qapi-commands.c: Command marshal/dispatc=
h functions for each
>>   $(prefix)qapi-commands.h: Function prototypes for the QMP commands
>>                             specified in the schema
>>   +$(prefix)qapi-init-commands.h - Command initialization prototype
>> +
>> +$(prefix)qapi-init-commands.h - Command initialization code
>
> Looks like you meant s/h/c/

I did.  Thanks!

>> +    #endif /* EXAMPLE_QAPI_INIT_COMMANDS_H */
>> +    $ cat qapi-generated/example-qapi-init-commands.
>> +[Uninteresting stuff omitted...]
>
> missing a 'c'

Yes.

>> +++ b/Makefile
>
>>   -QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h
>> qga-qapi-visit.h qga-qapi-commands.h)
>> +QGALIB_GEN=3D$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi=
-visit.h qga-qapi-commands.h qga-qapi-init-commands.h)
>
> Worth using \ for line-wrapping?

Hmm, it's used only in the following line, could just as well inline
there and line-wrap that:

    $(qga-obj-y): $(QGALIB_GEN)

Hmm^2, why do we even have that line?  The compiler-generated .d should
take care of dependencies.  Dig, dig, ...

    commit 016c77ad62a8ad607dd4349d8cb8ad1365bab831
    Author: Michael Roth <mdroth@linux.vnet.ibm.com>
    Date:   Tue Jul 26 11:39:24 2011 -0500

        Makefile: add missing deps on $(GENERATED_HEADERS)

        This fixes a build issue with make -j6+ due to qapi-generated files
        being built before $(GENERATED_HEADERS) have been created.

        Tested-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
        Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
        Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

Yes, but the same issue exists for all the other generated headers, and
we solve it differently: put them into $(generated-files-y), have
Makefile depend on them.

I'll clean this up on top.  No need to beautify lines now that will go
away then.

> With those addressed,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


