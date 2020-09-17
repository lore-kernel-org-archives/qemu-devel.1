Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BC9C2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7FA2072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkyAxgwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7FA2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItoS-0000FM-59
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kItno-0007pe-HX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kItnm-0002bT-DB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600348697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IBU3WsZrgMAf4qZbic4Ben2MB5qRvI1IpgGngTjZxI0=;
 b=LkyAxgwYTD8dpvAuZSaVepAqK/ngpKpbOMKs5bqQRe4WCFXqoNskDXTNzUJ8qwJSbk90Lw
 ghiwTaoX2PxvKTFPJRcCM+o8AChB5ERvjEOlcOFXoysn73qMFbibX3hOtH563dZrQHiesj
 Jx9bMyNqLB18Y6KsLpHavby9EVyGtN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-XEmQJcf6NJOuNcOHTGfunA-1; Thu, 17 Sep 2020 09:18:15 -0400
X-MC-Unique: XEmQJcf6NJOuNcOHTGfunA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F24A13B855;
 Thu, 17 Sep 2020 13:17:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F81F7881C;
 Thu, 17 Sep 2020 13:17:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6AD0E113864A; Thu, 17 Sep 2020 15:17:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 14/15] spapr: Simplify error handling in
 spapr_memory_plug()
References: <20200914123505.612812-1-groug@kaod.org>
 <20200914123505.612812-15-groug@kaod.org>
 <11f0dcb7-7923-0164-df69-4911b3293663@virtuozzo.com>
 <20200915134340.0cc3f9eb@bahia.lan>
 <20200917011525.GI5258@yekko.fritz.box>
 <87lfh8g8dy.fsf@dusky.pond.sub.org>
 <20200917120437.6ab60ca4@bahia.lan>
 <87ft7g1uee.fsf@dusky.pond.sub.org>
 <20200917121851.GA1597829@redhat.com>
Date: Thu, 17 Sep 2020 15:17:13 +0200
In-Reply-To: <20200917121851.GA1597829@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 17 Sep 2020 13:18:51 +0100")
Message-ID: <87y2l835ly.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Sep 17, 2020 at 02:04:41PM +0200, Markus Armbruster wrote:
>> Greg Kurz <groug@kaod.org> writes:
>>=20
>> > $ git grep object_property_get_uint -- :^{include,qom/object.c} | wc -=
l
>> > 60
>> >
>> > Manual inspecting the output of
>> >
>> > $ git grep -W object_property_get_uint -- :^{include,qom/object.c}
>> > ...
>> >
>> > seems to be showing that most users simply ignore errors (ie. pass NUL=
L
>> > as 3rd argument). Then some users pass &error_abort and only a few
>> > pass a &err or errp.
>> >
>> > Assuming that users know what they're doing, I guess my proposal
>> > wouldn't bring much to the code base in the end... I'm not even
>> > sure now that it's worth changing the contract.
>>=20
>> We'd change
>>=20
>>     val =3D object_property_get_uint(obj, name, &error_abort);
>>=20
>> to
>>=20
>>     object_property_get_uint(obj, name, &val, &error_abort);
>>=20
>> which is not an improvement.
>>=20
>> Most of the ones passing NULL should probably pass &error_abort
>> instead.  Doesn't change the argument.
>
> I wonder if we actually need to have an Error  parameter at all for
> the getters. IIUC the only valid runtime error  is probably the case
> where the property has not been set, and even then, I think properties
> usually have a default value that would be returned.  All the other
> errors look like programmer errors.

From the notes I took when I last hacked a trail through this jungle...

Failure modes of

    object_property_get()
        @name not found
        @name permission, i.e. no ->get
        ->get() fails (how?)

    object_property_get_{str,bool,int,uint}()
        object_property_get_qobject()
            object_property_get() with qobject output visitor
                which see
        prop value qobject not a string / bool / int / uint

    object_property_get_enum()
        @name not found
        @typename doesn't match
        object_property_get() with string output visitor
            which see
        qapi_enum_parse()
            prop value not a value of enum @typename

    object_property_get_link()
        object_property_get_str()
            which see
        prop value does not resolve

I think most of these failures are obviously programming errors most of
the time.

Many callers treat failures as programming errors by passing
&error_abort.

Many callers ignore errors by passing NULL.  I believe most of them
should really pass &error_abort instead.  Fixing them is tedious,
because you have to check what would happen on error.  If the answer is
"chaos", fix to pass &error_abort.  But the answer can also be "works as
intended", or "beats me".

> IOW, can we remove the Error parameter and have all the o_p_get*
> method impls use error_abort.

If we fix the callers that should pass &error_abort to do so, we'll see
what remains, and whether we can drop the parameter.

> In the rare case where a caller needs to handle a property not
> being set, they can use object_property_find() as a test before
> invoking the getter.

I dislike "if (X() is going to fail) do something else; else X()".

I guess it could be okay for the narrow case of "property does not
exist".

> Of course requires someone motivated to audit all the case that
> are not using NULL or error_abort and decide whether the attempt
> at passing a local errp was actually justified or not.

We got one!  Thanks, Greg :)


