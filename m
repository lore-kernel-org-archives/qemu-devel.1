Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E95C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 06:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6CA207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 06:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4ak1+4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6CA207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeYNw-0005yE-A3
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 02:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeYNE-0005MK-N7
 for qemu-devel@nongnu.org; Fri, 29 May 2020 02:20:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41609
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeYND-0005jW-6V
 for qemu-devel@nongnu.org; Fri, 29 May 2020 02:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590733205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R678ZV1dCvt8bLqv0zvR63j+GY1+4JSVVKY/4f0a1lk=;
 b=I4ak1+4l1PWWL3MIi7g2sQg/p819Rmjp5QOsVFcpXNCWwSjAs7WKW0jxdkhp0URTFhOz0V
 GcHjA826WmjqSgjrUcVIIa2zw5/GK/cqtzudF6vqfgiNo+XSlA2JpJcCL/7qjV+7rx8nKX
 ELYnFK4fUETCIx2wE3jnRXc+69Jz+Pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-fo-5_RdIOd2PtONp0LvmEw-1; Fri, 29 May 2020 02:20:03 -0400
X-MC-Unique: fo-5_RdIOd2PtONp0LvmEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47A88A0BE6;
 Fri, 29 May 2020 06:20:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8050060E1C;
 Fri, 29 May 2020 06:20:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 14E3E113864A; Fri, 29 May 2020 08:20:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/2] hmp: Simplify qom_set
References: <20200520151108.160598-1-dgilbert@redhat.com>
 <20200520151108.160598-3-dgilbert@redhat.com>
 <1f627a6b-9c5f-09b3-8f75-64e95a4f5d02@redhat.com>
 <20200520190344.GG2820@work-vm> <87y2pge6nv.fsf@dusky.pond.sub.org>
 <20200528140644.GG3069@work-vm>
Date: Fri, 29 May 2020 08:20:00 +0200
In-Reply-To: <20200528140644.GG3069@work-vm> (David Alan Gilbert's message of
 "Thu, 28 May 2020 15:06:44 +0100")
Message-ID: <871rn3p8j3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, afaerber@suse.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>>=20
>> > * Philippe Mathieu-Daud=C3=83=C6=92=C3=82=C2=A9 (philmd@redhat.com) wr=
ote:
>> >> On 5/20/20 5:11 PM, Dr. David Alan Gilbert (git) wrote:
>> >> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> >> >=20
>> >> > Simplify qom_set by making it use qmp_qom_set and the JSON parser.
>> >> >=20
>> >> > Note that qom-set likes JSON strings quoted with ' not ", e.g.:
>> >> >=20
>> >> > (qemu) qom-get /machine smm
>> >> > "auto"
>> >> > (qemu) qom-set /machine smm 'auto'
>> >>=20
>> >> Will I get this output using "?
>> >>=20
>> >> (qemu) qom-set /machine smm "auto"
>> >> Error: Expecting a JSON value
>> >
>> > The error you get is:
>> >
>> > (qemu) qom-set /machine smm "auto"
>> > Error: JSON parse error, invalid keyword 'auto'
>> >
>> > I think, having seen alphanumerics, it's expecting a keyword;
>> > i.e. a true/false making a bool, or a null.
>>=20
>> The command parses its argument as JSON.
>>=20
>> Before we get there, the HMP core extracts the argument from the line of
>> input.  The extraction is guided by the command's .args_type, in this
>> case the 's' in "value:s" in
>>=20
>>     {
>>         .name       =3D "qom-set",
>>         .args_type  =3D "path:s,property:s,value:s",
>>         [...]
>>     },
>>=20
>> monitor/monitor-internal.h documents type code 's' as
>>=20
>>  * 's'          string (accept optional quote)
>>=20
>> The implementation boils down to:
>>=20
>> 1. Skip whitespace.
>>=20
>> 2. If looking at '"', get the string enclosed in '"', with C-like escape
>>    sequences \n, \r, \\, \', \".
>>=20
>> 3. Else, get the string up to the next whitespace.
>>=20
>> See get_str().
>>=20
>> Therefore, argument "auto" is the same as auto.  Parsing auto as JSON
>> duly fails.
>>=20
>> Argument 'auto' works, but only because qobject_from_json() recognizes
>> single-quoted strings.  This is as extension over RFC 8259.
>>=20
>> Using single quotes falls apart when you want to pass something
>> containing whitespace.  Then you'd have to use
>>=20
>>     "\"ugly and unintuitive\""
>>=20
>> or, again relying on the extension
>>=20
>>     "'ugly and unintuitive'"
>>=20
>> There's a better way, and Paolo pointed it out in
>>=20
>>     Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
>>     Date: Thu, 21 May 2020 16:24:12 +0200
>>     Message-ID: <2c148331-78ae-31f7-8702-d65c37a090b0@redhat.com>
>>=20
>> Use argument type 'S'.  Documented as
>>=20
>>  * 'S'          it just appends the rest of the string (accept optional =
quote)
>>=20
>> but the parenthesis is confusing.  It really just skips whitespace, then
>> extracts the remainder of the line.  Can't do string with leading
>> whitespace, but that's just fine for us.
>
> Yep, thanks - I spotted Paolo's response but thanks for the deeper
> explanation.
> With that would you give me a Review-by?

Also fix the typo in the title "hmp: Simplify qom_set": it's qom-set.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


