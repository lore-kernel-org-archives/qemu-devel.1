Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D6C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6162469F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 15:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKk39MkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6162469F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7L8X-0007Tw-RB
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 10:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7L7R-0006pr-RC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7L7Q-0004i6-Fs
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:30:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25425
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7L7Q-0004hb-Bq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 10:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582817431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2q17YwiHhRtZjBsC3QieyQjNNAv6MP5vwChtNAYDnaU=;
 b=TKk39MkSnQmbsGmqKqgkkF4QvLzevhP9sUreFv8JEWLW8zPDQBUDNc+wxpM02YZatIdoxl
 Nd8+IFwDJ2o8/ouQraYSywa6QW+6v3L9EDXAXk26VyOby1OIl/BdzRn/0e8TpOUnGxITpn
 06z/jp11TtjU/3IdyQB0xdzMkC38TOs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-Qq9HHIdaNB6D802UpYthWw-1; Thu, 27 Feb 2020 10:30:28 -0500
X-MC-Unique: Qq9HHIdaNB6D802UpYthWw-1
Received: by mail-wr1-f70.google.com with SMTP id p12so601550wrm.13
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 07:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bChU/e2L1PtvRIsJfgXkzjmUKjVp3uJMcvzHG2YLHqc=;
 b=gElVRqtrIuSNYxukEFk/Ovjg5rJVsegCoIrjqaGjZNKGpKTdygVfSh0Q7WX2j8rkxw
 j3DuJoD85LYLTsMpj8IQwcMaKYBUafoY7ljmwdGv4rktL5uqKmATnbROh3Xu2fsrkA6F
 PhwBkavPivB9VxeiCx2Yyty5EkZpUHGdMiOjQuDxB6K8W/YO8Bniwes2LyeYt/SV1KqV
 ru+ntihLjl2HS1CsDLgA9HSBEDKQ0qP6xCHJSc6oLQ8/+gbyU99mAyCENxty6cJcNZ0p
 WkjlAeqQLnjnqdEKygCiIqS2EVaeHCU7b5s5fyWGNo4oY3sZWJiKEJ7hHZ6qsKcYj9pd
 oMxQ==
X-Gm-Message-State: APjAAAVwOx2hjuVEeBhL/K+MygN/an9hxn/MMtu3RaE22Ng101pOejtJ
 PKmvFUtjKBmpoHjHLDU3qE8ZSLoRc2vAeom0cfu+DtvudC3qA72dYY5j3ay/Cox3wDuLJ5RXxi2
 nqPME8CfD6WykhQc=
X-Received: by 2002:a5d:498f:: with SMTP id r15mr5320710wrq.284.1582817426929; 
 Thu, 27 Feb 2020 07:30:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxF0tptfWzms0Xa63f6cSy7cvsvYGXYLhUGVS6VstAs5YPdtVsT/pS0CJAeKJ7XKQB3W6OLWQ==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr5320691wrq.284.1582817426715; 
 Thu, 27 Feb 2020 07:30:26 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id h3sm8980076wrb.23.2020.02.27.07.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 07:30:26 -0800 (PST)
Subject: Re: [PATCH 1/4] qapi: Inheriting from object is pointless with Python
 3, drop
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200227144531.24309-1-armbru@redhat.com>
 <20200227144531.24309-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a6cbbc01-e215-9cfc-ad17-ae7f3e9d9a66@redhat.com>
Date: Thu, 27 Feb 2020 16:30:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227144531.24309-2-armbru@redhat.com>
Content-Language: en-US
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
Cc: crosa@redhat.com, jsnow@redhat.com, mdroth@linux.vnet.ibm.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 3:45 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/gen.py    |  2 +-
>   scripts/qapi/parser.py |  6 +++---
>   scripts/qapi/schema.py | 12 ++++++------
>   scripts/qapi/source.py |  4 ++--
>   4 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 95afae0615..a53a705c73 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -22,7 +22,7 @@ from qapi.common import *
>   from qapi.schema import QAPISchemaVisitor
>  =20
>  =20
> -class QAPIGen(object):
> +class QAPIGen:
>  =20
>       def __init__(self, fname):
>           self.fname =3D fname
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 342792e410..2e3a3c5d76 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -23,7 +23,7 @@ from qapi.error import QAPIParseError, QAPISemError
>   from qapi.source import QAPISourceInfo
>  =20
>  =20
> -class QAPISchemaParser(object):
> +class QAPISchemaParser:
>  =20
>       def __init__(self, fname, previously_included=3DNone, incl_info=3DN=
one):
>           previously_included =3D previously_included or set()
> @@ -293,7 +293,7 @@ class QAPISchemaParser(object):
>           raise QAPIParseError(self, "documentation comment must end with=
 '##'")
>  =20
>  =20
> -class QAPIDoc(object):
> +class QAPIDoc:
>       """
>       A documentation comment block, either definition or free-form
>  =20
> @@ -312,7 +312,7 @@ class QAPIDoc(object):
>       Free-form documentation blocks consist only of a body section.
>       """
>  =20
> -    class Section(object):
> +    class Section:
>           def __init__(self, name=3DNone):
>               # optional section name (argument/member or section name)
>               self.name =3D name
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 5100110fa2..c8bcfe2c49 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -24,7 +24,7 @@ from qapi.expr import check_exprs
>   from qapi.parser import QAPISchemaParser
>  =20
>  =20
> -class QAPISchemaEntity(object):
> +class QAPISchemaEntity:
>       meta =3D None
>  =20
>       def __init__(self, name, info, doc, ifcond=3DNone, features=3DNone)=
:
> @@ -89,7 +89,7 @@ class QAPISchemaEntity(object):
>           return "%s '%s'" % (self.meta, self.name)
>  =20
>  =20
> -class QAPISchemaVisitor(object):
> +class QAPISchemaVisitor:
>       def visit_begin(self, schema):
>           pass
>  =20
> @@ -135,7 +135,7 @@ class QAPISchemaVisitor(object):
>           pass
>  =20
>  =20
> -class QAPISchemaModule(object):
> +class QAPISchemaModule:
>       def __init__(self, name):
>           self.name =3D name
>           self._entity_list =3D []
> @@ -441,7 +441,7 @@ class QAPISchemaObjectType(QAPISchemaType):
>                                          self.features)
>  =20
>  =20
> -class QAPISchemaMember(object):
> +class QAPISchemaMember:
>       """ Represents object members, enum members and features """
>       role =3D 'member'
>  =20
> @@ -519,7 +519,7 @@ class QAPISchemaObjectTypeMember(QAPISchemaMember):
>                                           self.describe)
>  =20
>  =20
> -class QAPISchemaObjectTypeVariants(object):
> +class QAPISchemaObjectTypeVariants:
>       def __init__(self, tag_name, info, tag_member, variants):
>           # Flat unions pass tag_name but not tag_member.
>           # Simple unions and alternates pass tag_member but not tag_name=
.
> @@ -787,7 +787,7 @@ class QAPISchemaEvent(QAPISchemaEntity):
>                               self.arg_type, self.boxed)
>  =20
>  =20
> -class QAPISchema(object):
> +class QAPISchema:
>       def __init__(self, fname):
>           self.fname =3D fname
>           parser =3D QAPISchemaParser(fname)
> diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
> index 8956885033..e97b9a8e15 100644
> --- a/scripts/qapi/source.py
> +++ b/scripts/qapi/source.py
> @@ -13,7 +13,7 @@ import copy
>   import sys
>  =20
>  =20
> -class QAPISchemaPragma(object):
> +class QAPISchemaPragma:
>       def __init__(self):
>           # Are documentation comments required?
>           self.doc_required =3D False
> @@ -23,7 +23,7 @@ class QAPISchemaPragma(object):
>           self.name_case_whitelist =3D []
>  =20
>  =20
> -class QAPISourceInfo(object):
> +class QAPISourceInfo:
>       def __init__(self, fname, line, parent):
>           self.fname =3D fname
>           self.line =3D line
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


