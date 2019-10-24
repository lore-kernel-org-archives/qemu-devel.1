Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C204CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C222064A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyv0R1oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C222064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNixU-0004R2-JP
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 15:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNitt-000181-2F
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNith-0002Gu-OO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:35:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNith-0002GE-Jz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571945748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZBxxwtJr61xMT6jebBHlktczPXyQWeFtZb0+1TntPI=;
 b=hyv0R1oV/Sw0Xg+B2x6HwK9Vl+l5Hu2Jv2huH9VuK/GGkQIrc/ZzXzeaVLpWRJmrnbLxFy
 ygwFuzQfwLzjXHk9r30wMT4ifKEKw8qn4u0QrQ88FIazCxJUFch8MPKlRN9WeBiOeKN/T8
 cviTarBpcd2E1ZinR5do7UTbevBF2ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-3G7cB8kcPhiIcmZ92dg_tA-1; Thu, 24 Oct 2019 15:35:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21ACB800D49
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 19:35:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BB9B5DA8D;
 Thu, 24 Oct 2019 19:35:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC0AD1138619; Thu, 24 Oct 2019 21:35:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [libvirt] [RFC PATCH 18/19] qapi: Include a warning in the
 response to a deprecated command
References: <20191024123458.13505-1-armbru@redhat.com>
 <20191024123458.13505-19-armbru@redhat.com>
 <20191024140146.GC8381@redhat.com>
Date: Thu, 24 Oct 2019 21:35:33 +0200
In-Reply-To: <20191024140146.GC8381@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9=22's?=
 message of "Thu, 24 Oct 2019 15:01:46 +0100")
Message-ID: <87h83yndh6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3G7cB8kcPhiIcmZ92dg_tA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Oct 24, 2019 at 02:34:57PM +0200, Markus Armbruster wrote:
>> Looks like this
>>=20
>>     ---> {"execute": "query-cpus"}
>>     <--- {"return": [...], "warnings": [{"class": "CommandNotFound", "de=
sc": "command is deprecated"}]}
>>=20
>> Management applications may want to log such warnings.
>>=20
>> This commit is not for merging as is, because
>>=20
>> * docs/interop/qmp-spec.txt needs an update for the new success
>>   response member "warnings".
>>=20
>> * I'd like to see a prospective user before I extend the QMP protocol.
>>   If you have specific plans to put them to use, let me know.
>
> Thinking about libvirt's usage of QMP
>
>  - A public API call may result in many QMP commands being run.
>  - Public APIs don't have any convenient way to report deprecated
>    usage synchronously at runtime.
>  - The set of QMP comamnds used by libvirt is a private impl
>    detail that a mgmt app shouldn't know about
>
> Some (most) deprecations will be things targetted at libvirt
> developers, where libvirt just needs fixing to use some new
> alternative instead.

Based on what we've deprecated so far: most, for a large value of
"most".

> Other deprecations where there's no replacement provided by QEMU
> are things where an application might need to be told to stop
> using the feature. From libvirt's public API POV the feature
> likely won't be deprecated, only the specific usage of that
> feature with the QEMU driver. eg consider QEMU decides to
> stop POSTCOPY migration for some reason. Its deprecated from
> POV of QEMU & QMP commands. If Xen or ESX support POSTCOPY
> though, its not deprecated from libvirt's API POV. In many
> ways this becomes a capabilities reporting problem between
> libvirt & the application. Libvirt needs to tell the app which
> features they can use, given their curent open libvirt connection
> and VM instance(s).

Makes sense.

> So, either way, I don't think the QMP deprecations are something
> we would want to expose to applications 'as is', since they're
> either not something an app dev can fix, or they need rephrasing
> in terms of the libvirt API/config feature the app is using, or
> translating into a way for libvirt to expose capabilities to apps.

Makes sense, too.

> Libvirt could potentially log the deprecation warning in the per
> QEMU VM log file. If end users see such log messages they'll
> probably file support tickets / bug reports against libvirt and/or
> the mgmt app, which will alert their maintainers to the fact. THis
> could be useful if the maintainers missed the QEMU documentation
> update listing the deprecation. It could be annoying if libvirt
> knows it is deprecated though, and intentionally is still using
> it in this particular version, with plans already present to fix
> it in future.   So if libvirt does log the deprecations to the
> VM log file, we'll probably want to /not/ log certain deprecations
> that we're intentionally ignoring (temporarily).

Makes sense, too.

Logging the complete QMP traffic can be invaluable when troubleshooting,
and is unlikely to make users report the warnings to libvirt developers.
But that's a different log / a higher debug level.

> In theory libvirt could see the deprecation reply and take
> different action, but I don't much like that idea. It is too

That way is madness :)

> late becasue we've already run the command, and its providing
> a second way to deal with capabilities. We should be able to
> query/probe the right way to invoke commands upfront, so that
> we avoid using deprecated stuff in the first place.

PATCH 15 makes deprecation visible in introspection.  Like all of this
series, it's limited to commands and events.  Extending to arguments and
return values feels feasible, and I'm willing to do the work.

Argument *values* are a different ballgame.  Schema support for "this
argument is deprecated" is straightforward (tack feature "deprecated" to
it).  Support for "this argument value is deprecated" is not (except for
enumerations, where we can tack feature "deprecated" to the enumeration
value).  Same for return values, combinations of arguments, and so
forth.  Not sure how relevant these are in practice.

I'm not sure how useful the "deprecated" feature will be for guiding
decisions on which interface to use.  I imagine there's typically a list
of interfaces libvirt can use, ordered by "desirability", and the most
desirable interface known to work gets used.  If $new_way is workable,
you use it, else you fall back to $old_way.  Whether $old_way is
deprecated is immaterial.

The "deprecated" feature could be used for dynamic checking, i.e. check
the commands sent to QEMU against the output of query-qmp-schema.  But
that merely duplicates the check QEMU does when it receives it.

Static checking would be more interesting, if we can pull it off.

>> * The same warning should be included in a deprecated event.
>>=20
>> * Emitting the same warning over and over again might be annoying or
>>   slow.  Perhaps warning just once would be better.
>
> If written to a log file, any single deprecation definitely
> needs to be limited to once only per QEMU process lifetime.
> Once a libvirt/qemu pair is deployed on a host it may be a
> long time before an upgrade is done that pulls in the new
> libvirt to avoid the deprecation. So we don't want to be
> spamming logs of an otherwise fully functional VM.
>
> In summary, it is probably reasonable to include this info in the QMP
> command reply, but don't expect much to be done with it beyond possibly
> writing it to a log file.

Understood.

Thanks!


