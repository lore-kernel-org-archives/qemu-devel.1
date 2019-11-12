Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E89C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08D721783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fnu0oc/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08D721783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUSgw-0000Jg-4J
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 04:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iUSgE-0008Gc-VC
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iUSgD-0000Tl-ON
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:41:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iUSgD-0000Tc-LC
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573551705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UXxo8FrUQvRaOHwGklG7BVo4Yld+bP5q25dZ424V5g=;
 b=Fnu0oc/5XBSMcoZAuuPHTjD6dcGMYnc1tD+8mmzFm78Ryc108TX98anfJC5XESWgZEGKVi
 9BQD5S3yCmnKAiq/3PRvPuL9hcivSzr41NmgSIpsSnoTf64Gew0n/9Si74o2S9Rx1SeGvo
 OwEYL6BA38MS1Va+HKKcmjicHamo5Ps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-mqykLXTOOrax-dsw6KB9YQ-1; Tue, 12 Nov 2019 04:41:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5251485EE92;
 Tue, 12 Nov 2019 09:41:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9B9460872;
 Tue, 12 Nov 2019 09:41:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 76B891138648; Tue, 12 Nov 2019 10:41:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH 16/18] qapi: Create 'pragma' module
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-17-kwolf@redhat.com>
Date: Tue, 12 Nov 2019 10:41:39 +0100
In-Reply-To: <20191017130204.16131-17-kwolf@redhat.com> (Kevin Wolf's message
 of "Thu, 17 Oct 2019 15:02:02 +0200")
Message-ID: <87mud1juss.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: mqykLXTOOrax-dsw6KB9YQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> We want to share the whitelists between the system emulator schema and
> the storage daemon schema, so move all the pragmas from the main schema
> file into a separate file that can be included from both.

Confusing because the storage daemon schema doesn't exist at this point.
PATCH 13's commit message has the same issue.

I'll revisit this when I review PATCH 18.

>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/pragma.json      | 24 ++++++++++++++++++++++++
>  qapi/qapi-schema.json | 25 +------------------------
>  qapi/Makefile.objs    |  2 +-
>  3 files changed, 26 insertions(+), 25 deletions(-)
>  create mode 100644 qapi/pragma.json
>
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> new file mode 100644
> index 0000000000..cffae27666
> --- /dev/null
> +++ b/qapi/pragma.json
> @@ -0,0 +1,24 @@
> +{ 'pragma': { 'doc-required': true } }
> +
> +# Whitelists to permit QAPI rule violations; think twice before you
> +# add to them!
> +{ 'pragma': {
> +    # Commands allowed to return a non-dictionary:
> +    'returns-whitelist': [
> +        'human-monitor-command',
> +        'qom-get',
> +        'query-migrate-cache-size',
> +        'query-tpm-models',
> +        'query-tpm-types',
> +        'ringbuf-read' ],
> +    'name-case-whitelist': [
> +        'ACPISlotType',             # DIMM, visible through query-acpi-o=
spm-status
> +        'CpuInfoMIPS',              # PC, visible through query-cpu
> +        'CpuInfoTricore',           # PC, visible through query-cpu
> +        'BlockdevVmdkSubformat',    # all members, to match VMDK spec sp=
ellings
> +        'BlockdevVmdkAdapterType',  # legacyESX, to match VMDK spec spel=
lings
> +        'QapiErrorClass',           # all members, visible through error=
s
> +        'UuidInfo',                 # UUID, visible through query-uuid
> +        'X86CPURegister32',         # all members, visible indirectly th=
rough qom-get
> +        'CpuInfo'                   # CPU, visible through query-cpu
> +    ] } }
> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index be90422ffe..85b4048535 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -49,30 +49,7 @@
>  #
>  ##
> =20
> -{ 'pragma': { 'doc-required': true } }
> -
> -# Whitelists to permit QAPI rule violations; think twice before you
> -# add to them!
> -{ 'pragma': {
> -    # Commands allowed to return a non-dictionary:
> -    'returns-whitelist': [
> -        'human-monitor-command',
> -        'qom-get',
> -        'query-migrate-cache-size',
> -        'query-tpm-models',
> -        'query-tpm-types',
> -        'ringbuf-read' ],
> -    'name-case-whitelist': [
> -        'ACPISlotType',             # DIMM, visible through query-acpi-o=
spm-status
> -        'CpuInfoMIPS',              # PC, visible through query-cpu
> -        'CpuInfoTricore',           # PC, visible through query-cpu
> -        'BlockdevVmdkSubformat',    # all members, to match VMDK spec sp=
ellings
> -        'BlockdevVmdkAdapterType',  # legacyESX, to match VMDK spec spel=
lings
> -        'QapiErrorClass',           # all members, visible through error=
s
> -        'UuidInfo',                 # UUID, visible through query-uuid
> -        'X86CPURegister32',         # all members, visible indirectly th=
rough qom-get
> -        'CpuInfo'                   # CPU, visible through query-cpu
> -    ] } }
> +{ 'include': 'pragma.json' }
> =20
>  # Documentation generated with qapi-gen.py is in source order, with
>  # included sub-schemas inserted at the first include directive
> diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> index 519b6f1a8e..3e04e299ed 100644
> --- a/qapi/Makefile.objs
> +++ b/qapi/Makefile.objs
> @@ -7,7 +7,7 @@ util-obj-y +=3D qapi-util.o
> =20
>  QAPI_COMMON_MODULES =3D audio authz block-core block char common crypto
>  QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c monitor
> -QAPI_COMMON_MODULES +=3D net qdev qom rdma rocker run-state sockets tpm
> +QAPI_COMMON_MODULES +=3D net pragma qdev qom rdma rocker run-state socke=
ts tpm
>  QAPI_COMMON_MODULES +=3D trace transaction ui
>  QAPI_TARGET_MODULES =3D machine-target misc-target
>  QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)

Only works because we accept and ignore names in these whitelists that
don't exist in the schema.

Which parts of the whitelists are actually needed in the storage daemon?


