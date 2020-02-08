Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F6DC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC1E20726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 07:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRpPaBRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC1E20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Kdx-0005d8-DB
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 02:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j0KdQ-0005E3-7m
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j0KdO-0005Wp-Rt
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:34:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34683
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j0KdO-0005VA-OF
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 02:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581147273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0VxEi74i4v7xRNVfFzvRUDfImTv7nzWb3vTa9c7gTU=;
 b=fRpPaBREIKh2Kl5N7Ae1rHMNYRTo7gLndd35wW/FfehfBQ3FZgnTc5DQtoV66r30ZwXc03
 ZJU/iNV8Id+3O6MVcbRDjQVa/LTtGTm4Q1LhlvItNeddd+X4Z7qjLQv/uxtSUqELfbI2tK
 ugg4Mwm3+rNvWNKTKmwH/pkPDGZ6qXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-sBMV4A-hOpmbTY-AQjcDzw-1; Sat, 08 Feb 2020 02:34:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1353F106C00E;
 Sat,  8 Feb 2020 07:34:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D321A5C21A;
 Sat,  8 Feb 2020 07:34:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69B7B11386A7; Sat,  8 Feb 2020 08:34:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy?
References: <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
 <20200206181836.GK3655@work-vm>
 <3035d327-51e2-bc2b-ff62-4eabd617334b@redhat.com>
Date: Sat, 08 Feb 2020 08:34:19 +0100
In-Reply-To: <3035d327-51e2-bc2b-ff62-4eabd617334b@redhat.com> (Eric Blake's
 message of "Fri, 7 Feb 2020 15:31:23 -0600")
Message-ID: <87sgjlleh0.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: sBMV4A-hOpmbTY-AQjcDzw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 2/6/20 12:18 PM, Dr. David Alan Gilbert wrote:
>
>>>
>>> Pain points of JSON include having to count parenthesises and having to
>>> quote so bloody much.  Additional QMP pain points include long names an=
d
>>> excessive nesting.
>>
>> Some other pet hates:
>>    a) Number formats are awful for our uses
>>    b) Lack of room for comments
>
> Both permitted in JSON5.  Converting valid JSON5 into the stricter
> JSON is lossy when it comes to comments, but as comments don't affect
> machine meaning, maybe all the more it requires is an argument to
> qmp_capabilities stating whether the rest of the session will stick to
> strict JSON or prefer JSON5.
>
>>> We could make quoting optional for certain string literals.
>
> Hmm - JSON5 makes quoting optional for keys in { key:value }, but not
> values.
>
> And one of the reasons why my QAPIfication of netdev was NOT committed
> was that the original code allowed both "item":1 and "item":"1" in the
> QemuOpts world, and we were torn on whether letting QMP accept both
> integer and string-that-parses-as-integer was acceptable.

I think we were in perfect agreement that netdev_add accepting strings
that happen to contain integers as integers is a flaw, we just couldn't
muster the nerve to correct it.

We've since become less dogmatic about maintaining bug compatibility.

>>>  Simple
>>> enough for literals that can only be a string, like abc.  For literals
>>> that could be something else like 123 or true, omitting quotes creates
>>> ambiguity.  When the schema accepts only one of the possible types, the
>>> ambiguity goes away.  Complexity stays, however.
>
> Do we even allow an alternate that permits both a string and a number
> at once? I thought you tightened qapi to reject that because of the
> potential for ambiguity.

Correct.

The complexity enters through the 'any' backdoor.


