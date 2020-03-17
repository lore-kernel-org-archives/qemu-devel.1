Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54069C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2A920409
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 20:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gk9RPjrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2A920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJ3U-0004Hh-AQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 16:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJ1Q-00024m-UO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJ1P-0007fl-PU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:41:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJ1P-0007e1-Ll
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 16:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584477667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3K7CwCTzobN5Hk3+7i0TSXzKcxTnndVZTZETwtuo4Zs=;
 b=Gk9RPjrNIu6no9fN+aDjW55r2iQ2EdSI4nW76ZrIq6cE0KfCs515/k2f6ZSnJLhrDFL+oa
 /Ixq8pyvwx6YjUfbdaAk5Rpz/h0xzPmxsg1XK5D+N2tFZN3rCU9asqyyP/q3THEzR5Vtdt
 f4Gqq19Da4caA7UoLFWPKfvb4r88m10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-yfHe3B74M4KaDIXNQO0Awg-1; Tue, 17 Mar 2020 16:41:03 -0400
X-MC-Unique: yfHe3B74M4KaDIXNQO0Awg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD3B1107ACCA;
 Tue, 17 Mar 2020 20:41:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86C6019C58;
 Tue, 17 Mar 2020 20:41:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ED1F21138404; Tue, 17 Mar 2020 21:40:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 25/34] qapi: New special feature flag "deprecated"
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200317115459.31821-26-armbru@redhat.com>
 <f26a00be-62a8-ffe9-9f0a-2dfb8e638b8a@redhat.com>
Date: Tue, 17 Mar 2020 21:40:59 +0100
In-Reply-To: <f26a00be-62a8-ffe9-9f0a-2dfb8e638b8a@redhat.com> (Eric Blake's
 message of "Tue, 17 Mar 2020 15:32:30 -0500")
Message-ID: <87tv2miujo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 3/17/20 6:54 AM, Markus Armbruster wrote:
>> Unlike regular feature flags, the new special feature flag
>> "deprecated" is recognized by the QAPI generator.  For now, it's only
>> permitted with commands, events, and struct members.  It will be put
>> to use shortly.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> +++ b/docs/devel/qapi-code-gen.txt
>> @@ -683,6 +683,12 @@ Intended use is to have each feature string signal =
that this build of
>>   QEMU shows a certain behaviour.
>>     +=3D=3D=3D=3D Special features =3D=3D=3D=3D
>> +
>> +Feature "deprecated" makes a command, event, or struct member as
>> +deprecated.  It is not supported elsewhere so far.
>
> Reads awkwardly, but I can't tell if it was a typo or an extra
> word. Either "makes a command, event, or struct member deprecated" or
> "marks a command, event, or struct member as deprecated".

I typoed the latter.  Will fix!

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


