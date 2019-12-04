Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DA3C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 06:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10ECF206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 06:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhHN+Kkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10ECF206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icOc9-0003jf-41
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 01:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1icOan-0003Fl-9G
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1icOaj-0004VG-Si
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:56:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50932
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1icOaj-0004Sj-6c
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 01:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575442611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrtfcmh34LkAnNcXhVDOpk/maERIhAM2EKdtWIsX9aY=;
 b=XhHN+KkrwSoUE7lsevjiyw4BhFREnVowO6ZByKr4oNpR+DQQOIEh675VhTXNsLGlSRepuV
 vXPelNONoDoDCNS6rYHSY9Zqk5jpaMGU7EdSQz93RLeVf3DAawY9b08IKUlIi+PYUox6Yr
 LNDk0gs3ii+Q80WQhMUVUITUCrBacVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-yFLDWYSgOm2HYNTaZIlaEw-1; Wed, 04 Dec 2019 01:56:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC65D800EB6;
 Wed,  4 Dec 2019 06:56:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-134.ams2.redhat.com
 [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 795871001901;
 Wed,  4 Dec 2019 06:56:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 02B321138606; Wed,  4 Dec 2019 07:56:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 7/6] Makefile: Make Makefile depend on generated qga files, too
References: <20191120182551.23795-1-armbru@redhat.com>
 <20191129095927.17382-1-armbru@redhat.com>
 <45cff400-7e88-cefe-560e-7642d2ea1d00@redhat.com>
Date: Wed, 04 Dec 2019 07:56:45 +0100
In-Reply-To: <45cff400-7e88-cefe-560e-7642d2ea1d00@redhat.com> (Eric Blake's
 message of "Tue, 3 Dec 2019 16:33:15 -0600")
Message-ID: <8736e0h93m.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yFLDWYSgOm2HYNTaZIlaEw-1
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 11/29/19 3:59 AM, Markus Armbruster wrote:
>> Generated .h need to be generated before compiling any .c using them.
>> To know which .h a .c uses, we need to compile it.
>>
>> Since commit 4115852bb0 "build: do not sprinkle around
>> GENERATED_HEADERS dependencies", we break this circular dependency the
>> simple & stupid way: the generated headers are a prerequisite of
>> Makefile, which causes Make to generate them first, then start over.
>
> which is a pain when using 'make --dry-run' to see what would get
> built (a dependency of Makefile _is_ rebuilt if Makefile itself has to
> be updated), but not the fault of this patch.

Yes.

>> Except for qga we still use the older method of making all its .o
>> summarily depend on all its generated .h (commit 016c77ad62 "Makefile:
>> add missing deps on $(GENERATED_HEADERS)").
>>
>> Add qga's generated files to generated-files-y to get rid of this
>> exception.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   Makefile | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

>> +++ b/Makefile
>> @@ -130,6 +130,15 @@ GENERATED_QAPI_FILES +=3D qapi/qapi-doc.texi
>>     generated-files-y +=3D $(GENERATED_QAPI_FILES)
>>   +GENERATED_QGA_FILES :=3D qga-qapi-types.c qga-qapi-types.h
>> +GENERATED_QGA_FILES +=3D qga-qapi-visit.c qga-qapi-visit.h
>> +GENERATED_QGA_FILES +=3D qga-qapi-commands.h qga-qapi-commands.c
>> +GENERATED_QGA_FILES +=3D qga-qapi-init-commands.h qga-qapi-init-command=
s.c
>> +GENERATED_QGA_FILES +=3D qga-qapi-doc.texi
>> +GENERATED_QGA_FILES :=3D $(addprefix qga/qapi-generated/, $(GENERATED_Q=
GA_FILES))
>
> Would it be worth using two separate variable names (maybe
> GENERATED_QGA_BASEFILES for the first list) rather than exploiting the
> arcane knowledge that consecutive use of :=3D causes GNU make to rewrite
> an existing variable with new contents?

Our rules.mak relies on this already.  It's full of magic, which
admittedly diminishes its suitability to serve as a good example.

Your worry might be rooted in old "=3D" burns.  "=3D" makes the variable
recursively expanded, and

    GENERATED_QGA_FILES =3D $(addprefix qga/qapi-generated/, $(GENERATED_QG=
A_FILES))

would be an infinite loop.  ":=3D" makes it simply expanded; there's not
even a loop, let alone an infinite one.  The GNU Make manual explains
this clearly at
https://www.gnu.org/software/make/manual/html_node/Flavors.html

Aside: there's a reason one of the two flavors is called "simple".  It
could additionally be called "not as slow".  One of my pet makefile
peeves: unthinking use of recursively expanded variables, complicating
semantics and slowing down builds.

Back to this patch.  I had started to write the thing in longhand, but
got tired of repeating qga/qapi-generated/, so I factored that out.
Would longhand be easier to understand?


