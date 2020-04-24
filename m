Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D5C55194
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8292E20724
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 09:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt1CsQxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8292E20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRuKz-000824-K6
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 05:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRuKJ-0007SY-Qi
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRuKB-0000iC-F0
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:08:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRuKB-0000bn-0Y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 05:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587719321;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5irJJ3Oa9cVmLijwKaR2pRBlg6NkFZQqaCH9+TIINqw=;
 b=Nt1CsQxzMzeCubF4ahwUui+KhDZbDlUIl2zCgwI1JuAgkObSCAn7YbfL07rI7+LcFGSaCs
 lpia9zH1JNriN2RqVM3e0C8YAO67JeWbzmnow6ypX8V4+UK4LgZna6TPs6NEqmukv8KvZu
 TA0KtLxVLn6c7b8Xqp0bUecbcZtFOcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-l0E5kdaTPCKWng5FZXzbbA-1; Fri, 24 Apr 2020 05:08:26 -0400
X-MC-Unique: l0E5kdaTPCKWng5FZXzbbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E869945F;
 Fri, 24 Apr 2020 09:08:24 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D49336084A;
 Fri, 24 Apr 2020 09:08:22 +0000 (UTC)
Date: Fri, 24 Apr 2020 10:08:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 09/36] tcg: Consolidate 3 bits into enum TCGTempKind
Message-ID: <20200424090819.GC1212635@redhat.com>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-10-richard.henderson@linaro.org>
 <CAHiYmc7eFG5FSa8z1gEv0Cdi+eBvOx-Y4_2qFCM-EYNZBPqd6A@mail.gmail.com>
 <a3133ba4-9146-bd1a-98be-c41077a18eca@amsat.org>
 <574ccd10-74a3-49e9-5301-015c0a93df1e@linaro.org>
 <20200423172400.GK1077680@redhat.com>
 <dfc47f62-d92d-70c5-3bf0-01002fbe96ea@linaro.org>
MIME-Version: 1.0
In-Reply-To: <dfc47f62-d92d-70c5-3bf0-01002fbe96ea@linaro.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 04:11:14PM -0700, Richard Henderson wrote:
> On 4/23/20 10:24 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Apr 23, 2020 at 08:40:10AM -0700, Richard Henderson wrote:
> >> On 4/23/20 2:00 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> @@ -1885,12 +1896,17 @@ static char *tcg_get_arg_str_ptr(TCGContext=
 *s, char *buf, int buf_size,
> >>>>>  {
> >>>>>      int idx =3D temp_idx(ts);
> >>>>>
> >>>>> -    if (ts->temp_global) {
> >>>>> +    switch (ts->kind) {
> >>>>> +    case TEMP_FIXED:
> >>>>> +    case TEMP_GLOBAL:
> >>>>>          pstrcpy(buf, buf_size, ts->name);
> >>>>> -    } else if (ts->temp_local) {
> >>>>> +        break;
> >>>>> +    case TEMP_LOCAL:
> >>>>>          snprintf(buf, buf_size, "loc%d", idx - s->nb_globals);
> >>>>> -    } else {
> >>>>> +        break;
> >>>>> +    case TEMP_NORMAL:
> >>>>>          snprintf(buf, buf_size, "tmp%d", idx - s->nb_globals);
> >>>>> +        break;
> >>>>>      }
> >>>>
> >>>> Hmm, why this switch doesn't have:
> >>>>
> >>>>         default:
> >>>>             g_assert_not_reached();
> >>>>
> >>>> like the other ones?
> >>>
> >>> ... then all switch should have a default case, as noticed Aleksandar=
.
> >>
> >> There's a bit of a conflict between wanting to use -Werror -Wswitch, a=
nd making
> >> sure every switch has a default.
> >>
> >> With the former, you get a compiler error of the form
> >>
> >> error: enumeration value =E2=80=98FOO=E2=80=99 not handled in switch
> >>
> >> which lets you easily find places that need adjustment enumerators are=
 added.
> >=20
> > FYI,  -Wswitch-enum can deal with this. This gives a warning about
> > missing enum cases, even if there is a default statement:
> >=20
> > [quote]
> > '-Wswitch-enum'
> >      Warn whenever a 'switch' statement has an index of enumerated type
> >      and lacks a 'case' for one or more of the named codes of that
> >      enumeration.  'case' labels outside the enumeration range also
> >      provoke warnings when this option is used.  The only difference
> >      between '-Wswitch' and this option is that this option gives a
> >      warning about an omitted enumeration code even if there is a
> >      'default' label.
>=20
> This warning, IMO, is useless.
>=20
> All you need is one enumeration with 100 elements -- e.g. TCGOp -- and yo=
u
> certainly will not want to have to add all enumerators to every switch.

It depends how many of these exceptions you have. If there are only a
small handful of exceptions like this, then you can use Pragmas to
selectively disable the warning in those few cases, while still
benefitting from it across the rest of the code.  If there are alot
of such exceptions though, then I agree it is impractical.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


