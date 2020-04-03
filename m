Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1ECC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5494620737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJv/itoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5494620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQIv-0003zA-Gn
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKQFu-00010n-Ep
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKQFt-0006oh-0p
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:37:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKQFs-0006n6-Sy
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585935440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZjIg7fGEkQnLRToFnma5xJJUMUduC/9Bq/Ewz1YShhE=;
 b=IJv/itoy0ozTng0w4j9sRKfVvU8RWgYyZ/9eNy03SiCQKeiyo5I42hJo5wkiJdw1LoF7fg
 uQH3H4tiedDSYActCspnbcyOpcousIOnzSH3HWFopqbB6OS2TyO0QUJh6JLobPjE0Mviyz
 WCC9TDpSf5+MkFC97j34XlLxxxz2QEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-LkFEHQxdNcauWS_JgJjT4w-1; Fri, 03 Apr 2020 13:37:14 -0400
X-MC-Unique: LkFEHQxdNcauWS_JgJjT4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FEBA801A2F;
 Fri,  3 Apr 2020 17:37:13 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03A49114818;
 Fri,  3 Apr 2020 17:37:12 +0000 (UTC)
Subject: Re: [PATCH-for-5.0?] configure: Do not leave sphinx in-tree artifacts
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200403165422.21714-1-philmd@redhat.com>
 <CAFEAcA-BAvi3HEuvpMyyir9CqAbkg3nF3920zBVF-sPyFz++Rg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7c976a7a-beeb-e3ce-5760-e4239ff7dd1f@redhat.com>
Date: Fri, 3 Apr 2020 12:37:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-BAvi3HEuvpMyyir9CqAbkg3nF3920zBVF-sPyFz++Rg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 11:57 AM, Peter Maydell wrote:
> On Fri, 3 Apr 2020 at 17:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>>
>> When ./configure checks the sphinx version is new enough, it leaves
>> the docs/sphinx/__pycache__/ directory. Avoid this by using the '-B'
>> option (don't write .py[co] files on import) via the
>> PYTHONDONTWRITEBYTECODE environment variable.
>>
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> This only happens for an in-tree build, right? I think in
> that case you're kind of OK with having random stuff
> left in the source tree... It seems easy enough to suppress
> them though, so I guess we might as well.

It happens in VPATH too - and what's more, in VPATH, it is still=20
creating it under srcdir rather than builddir, which feels like=20
unnecessary pollution.  I was trying to prove whether 'make distclean'=20
got us back to a pristine state; this was one of the files that escaped=20
'make distclean', so our choice is to either add it to the clean rules,=20
or to avoid creating it in the first place.  I like the approach of not=20
creating it in the first place :)

Reviewed-by: Eric Blake <eblake@redhat.com>

That said,

> +    PYTHONDONTWRITEBYTECODE=3Dyes "$sphinx_build" -c "$source_path/docs"=
 -b html "$TMPDIR1/sphinx" "$TMPDIR1/sphinx/out" >/dev/null 2>&1

is now even a longer line; is it worth adding \-newline to split it up?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


