Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F03C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CF6206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmuXEzOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CF6206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8tw-0007x8-Oz
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd8sW-0006mV-0o
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:54:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36341
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jd8sU-00086t-UX
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590396873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ykk4Tdh3l+NszSrU+0Udor0+E2C9QqQko3s6y86lVeM=;
 b=hmuXEzOqCpG/URJgVO4uWNAK8lPNKj3qrKv/xZW7u4Y9rF6s3ix8tTCniKhm2VQTmxcpdR
 ylcQGvDQ99JIvmmPzRBQvY1PHNCzvxu9vMhAmHSOj6P+9KHqBxOgGsmHXK4BLpCmvppUup
 x0aNGekxkSsbFtzYT8COTN9hO6cPoNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-AUownmRINNuzmbEgVyfcLA-1; Mon, 25 May 2020 04:54:31 -0400
X-MC-Unique: AUownmRINNuzmbEgVyfcLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36C9A1855A06;
 Mon, 25 May 2020 08:54:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFB4183859;
 Mon, 25 May 2020 08:54:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 591A0113864A; Mon, 25 May 2020 10:54:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hmp: Simplify qom_set
References: <20200520151108.160598-1-dgilbert@redhat.com>
 <20200520151108.160598-3-dgilbert@redhat.com>
 <1f627a6b-9c5f-09b3-8f75-64e95a4f5d02@redhat.com>
 <20200520190344.GG2820@work-vm>
Date: Mon, 25 May 2020 10:54:28 +0200
In-Reply-To: <20200520190344.GG2820@work-vm> (David Alan Gilbert's message of
 "Wed, 20 May 2020 20:03:44 +0100")
Message-ID: <87y2pge6nv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:54:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, afaerber@suse.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Philippe Mathieu-Daud=C3=83=C6=92=C3=82=C2=A9 (philmd@redhat.com) wrote=
:
>> On 5/20/20 5:11 PM, Dr. David Alan Gilbert (git) wrote:
>> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >=20
>> > Simplify qom_set by making it use qmp_qom_set and the JSON parser.
>> >=20
>> > Note that qom-set likes JSON strings quoted with ' not ", e.g.:
>> >=20
>> > (qemu) qom-get /machine smm
>> > "auto"
>> > (qemu) qom-set /machine smm 'auto'
>>=20
>> Will I get this output using "?
>>=20
>> (qemu) qom-set /machine smm "auto"
>> Error: Expecting a JSON value
>
> The error you get is:
>
> (qemu) qom-set /machine smm "auto"
> Error: JSON parse error, invalid keyword 'auto'
>
> I think, having seen alphanumerics, it's expecting a keyword;
> i.e. a true/false making a bool, or a null.

The command parses its argument as JSON.

Before we get there, the HMP core extracts the argument from the line of
input.  The extraction is guided by the command's .args_type, in this
case the 's' in "value:s" in

    {
        .name       =3D "qom-set",
        .args_type  =3D "path:s,property:s,value:s",
        [...]
    },

monitor/monitor-internal.h documents type code 's' as

 * 's'          string (accept optional quote)

The implementation boils down to:

1. Skip whitespace.

2. If looking at '"', get the string enclosed in '"', with C-like escape
   sequences \n, \r, \\, \', \".

3. Else, get the string up to the next whitespace.

See get_str().

Therefore, argument "auto" is the same as auto.  Parsing auto as JSON
duly fails.

Argument 'auto' works, but only because qobject_from_json() recognizes
single-quoted strings.  This is as extension over RFC 8259.

Using single quotes falls apart when you want to pass something
containing whitespace.  Then you'd have to use

    "\"ugly and unintuitive\""

or, again relying on the extension

    "'ugly and unintuitive'"

There's a better way, and Paolo pointed it out in

    Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
    Date: Thu, 21 May 2020 16:24:12 +0200
    Message-ID: <2c148331-78ae-31f7-8702-d65c37a090b0@redhat.com>

Use argument type 'S'.  Documented as

 * 'S'          it just appends the rest of the string (accept optional quo=
te)

but the parenthesis is confusing.  It really just skips whitespace, then
extracts the remainder of the line.  Can't do string with leading
whitespace, but that's just fine for us.

Please squash in:

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 250ddae54d..28256209b5 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1806,7 +1806,7 @@ ERST
=20
     {
         .name       =3D "qom-set",
-        .args_type  =3D "path:s,property:s,value:s",
+        .args_type  =3D "path:s,property:s,value:S",
         .params     =3D "path property value",
         .help       =3D "set QOM property",
         .cmd        =3D hmp_qom_set,


