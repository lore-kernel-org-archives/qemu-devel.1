Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA535C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D502146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBznuyaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D502146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBxq6-0004N9-Ds
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jBxpM-0003s3-SR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jBxpL-0002Mz-S3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:39:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28577
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jBxpL-0002M7-Nq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583919539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLv6h6+V/o2qyCXkDIjC9ltvx09vIt/SVYH84pvLOZY=;
 b=jBznuyaGQXvPPOGwV2ABut4XGYsR/XPFFl5xvgb3UNliKQMSr1vbLLWTi8yzAIw83tChRv
 ssAv0C+fMm+mlI1SPH2tRez8CpbW3n8ztoDochfHopYT8kkG5n0GBGQqhTDGYrXCqnFeuF
 dOK4Vxn9d6Gu3qYaSLDAwfYBoMtlg2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-UFrvi3bMMvOEcpcwWN0xfQ-1; Wed, 11 Mar 2020 05:38:56 -0400
X-MC-Unique: UFrvi3bMMvOEcpcwWN0xfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D925E107ACC4;
 Wed, 11 Mar 2020 09:38:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 453B460C99;
 Wed, 11 Mar 2020 09:38:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB70511386A6; Wed, 11 Mar 2020 10:38:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 02/10] scripts: add coccinelle script to use auto
 propagated errp
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-3-vsementsov@virtuozzo.com>
 <87lfo997hs.fsf@dusky.pond.sub.org>
 <fda76f8a-bb62-d867-d7b4-7cf8caf0489e@virtuozzo.com>
Date: Wed, 11 Mar 2020 10:38:47 +0100
In-Reply-To: <fda76f8a-bb62-d867-d7b4-7cf8caf0489e@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 11 Mar 2020 11:29:25 +0300")
Message-ID: <87a74ngriw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

> 09.03.2020 12:56, Markus Armbruster wrote:
>> Suggest
>>
>>      scripts: Coccinelle script to use auto-propagated errp
>>
>> or
>>
>>      scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
>>
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
[...]
>>> +// Note, that we update everything related to matched by rule1 functio=
n name
>>> +// and local_err name. We may match something not related to the patte=
rn
>>> +// matched by rule1. For example, local_err may be defined with the sa=
me name
>>> +// in different blocks inside one function, and in one block follow th=
e
>>> +// propagation pattern and in other block doesn't. Or we may have seve=
ral
>>> +// functions with the same name (for different configurations).
>>
>> Context: rule1 matches functions that have all three of
>>
>> * an Error **errp parameter
>>
>> * an Error *local_err =3D NULL variable declaration
>>
>> * an error_propagate(errp, local_err) or error_propagate_prepend(errp,
>>    local_err, ...) expression, where @errp is the parameter and
>>    @local_err is the variable.
>>
>> If I understand you correctly, you're pointing out two potential issues:
>>
>> 1. This rule can match functions rule1 does not match if there is
>> another function with the same name that rule1 does match.
>>
>> 2. This rule matches in the entire function matched by rule1, even when
>> parts of that function use a different @errp or @local_err.
>>
>> I figure these apply to all rules with identifier rule1.fn, not just
>> this one.  Correct?
>>
>> Regarding 1.  There must be a better way to chain rules together, but I
>> don't know it.
>
> Hmm, what about something like this:
>
> @rule1 disable optional_qualifier exists@
> identifier fn, local_err;
> symbol errp;
> @@
>
>  fn(..., Error **
> - errp
> + ___errp_coccinelle_updating___
>     , ...)
>  {
>      ...
>      Error *local_err =3D NULL;
>      ...
> (
>     error_propagate_prepend(errp, local_err, ...);
> |
>     error_propagate(errp, local_err);
> )
>      ...
>  }
>
>
> [..]
>
> match symbol ___errp_coccinelle_updating___ in following rules in functio=
n header
>
> [..]
>
>
> @ disable optional_qualifier@
> identifier fn, local_err;
> symbol errp;
> @@
>
>  fn(..., Error **
> - ___errp_coccinelle_updating___
> + errp
>     , ...)
>  {
>      ...
>  }
>
>
> - hacky, but seems not more hacky than python detection, and should work =
better

As simple, forceful and unsubtle as a sledgehammer.  I like it :)

[...]


