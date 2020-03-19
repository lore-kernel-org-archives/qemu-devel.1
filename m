Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D547FC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBDA20724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJNwyBr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBDA20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqb9-0002V5-Rl
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEqaR-00020M-F6
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEqaQ-0002jg-0o
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:31:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEqaP-0002e8-PD
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584606688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCeApddrICmk/xsjdPqOtSUl0Pm0uVIHbo4ldlnlaiM=;
 b=dJNwyBr2JTE/MlPNoBAuYSx9AYpKfUsKl466OGYNLrN1ma2OTDEIrEiINLgCTzjF9feg+q
 RBIRrPe3c9Jl71/jnZ14lGv5XR7mXqfafYZ+FjC6UGIpLqrLBW1HSkhgr4PxVUShmJZ9s9
 dSeNTrNNEcVADx4M+LSTO7K+Bao2jaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-Rok3BDfKOuG_a8mww7ooPg-1; Thu, 19 Mar 2020 04:31:27 -0400
X-MC-Unique: Rok3BDfKOuG_a8mww7ooPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2609ADB24;
 Thu, 19 Mar 2020 08:31:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4303860BF7;
 Thu, 19 Mar 2020 08:31:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2D101138404; Thu, 19 Mar 2020 09:31:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
 <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
 <87blozex9v.fsf@dusky.pond.sub.org>
 <3e1e5815-eb5f-7862-e6eb-596991e2842b@virtuozzo.com>
Date: Thu, 19 Mar 2020 09:31:17 +0100
In-Reply-To: <3e1e5815-eb5f-7862-e6eb-596991e2842b@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 17 Mar 2020 16:54:52 +0300")
Message-ID: <87pnd8zqy2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 14.03.2020 0:54, Markus Armbruster wrote:
[...]
>> // Match functions with propagation of local error to errp.
>> // We want to refer these functions in several following rules, but I
>> // don't know a proper way to inherit a function, not just its name
>> // (to not match another functions with same name in following rules).
>> // Not-proper way is as follows: rename errp parameter in functions
>> // header and match it in following rules. Rename it back after all
>> // transformations.
>> //
>> // The simplest case of propagation scheme is single definition of
>> // local_err with at most one error_propagate_prepend or
>> // error_propagate on each control-flow. Still, we want to match more
>> // complex schemes too. We'll warn them with help of further rules.
>> @rule1 disable optional_qualifier exists@
>> identifier fn, local_err;
>> symbol errp;
>> @@
>>
>>   fn(..., Error **
>> -    errp
>> +    ____
>>      , ...)
>>   {
>>       ...
>>       Error *local_err =3D NULL;
>>       ...
>> (
>>       error_propagate_prepend(errp, local_err, ...);
>> |
>>       error_propagate(errp, local_err);
>> )
>>       ...
>>   }
>>
>>
>> // Warn several Error * definitions.
>> @check1 disable optional_qualifier exists@
>> identifier fn, _errp, local_err, local_err2;
>> position p1, p2;
>> @@
>>
>>   fn(..., Error **_errp, ...)
>>   {
>>       ...
>>       Error *local_err =3D NULL;@p1
>>       ... when any
>>       Error *local_err2 =3D NULL;@p2
>>       ... when any
>>   }
>>
>> @ script:python @
>> fn << check1.fn;
>> p1 << check1.p1;
>> p2 << check1.p2;
>> @@
>>
>> print('Warning: function {} has several definitions of '
>>        'Error * local variable: at {}:{} and then at {}:{}'.format(
>>            fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>
>> // Warn several propagations in control flow.
>> @check2 disable optional_qualifier exists@
>> identifier fn, _errp;
>> position p1, p2;
>> @@
>>
>>   fn(..., Error **_errp, ...)
>
> Hmm, for this to work, we should move the rule above rule1, because now p=
aramter
> definition is different from it usage in the function body.

I think you're right.

[...]


