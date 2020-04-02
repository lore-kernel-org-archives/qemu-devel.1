Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E3AC18E5B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D42208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpmhXyvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D42208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvdz-000057-Fx
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jJvdN-00085o-PQ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jJvdM-0003pB-LJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:55:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jJvdM-0003op-H4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585817732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxdEI8IwH8agF7xqrTLB1OHJ32dmiprD83VD70aDNU4=;
 b=TpmhXyvmtYzPfxq21v/79OtbdMDipFPNjO8hYvb9aN2a+WKKwOpzeFvQISj/kdJbarVp2i
 h2nsrikG19mjxxIT5MBXemIEncL0JZ0evz45F51M7dQ64FLC8BcmNVlr+4eHD8BAYXMb5q
 3k/A+6uPByNgMTnE+lkUfhZcz2k8F6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350--9ipTrWzPGuUjqVwsL8rwQ-1; Thu, 02 Apr 2020 04:55:30 -0400
X-MC-Unique: -9ipTrWzPGuUjqVwsL8rwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A6208017F4;
 Thu,  2 Apr 2020 08:55:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B2D25D9CA;
 Thu,  2 Apr 2020 08:55:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E936711385E2; Thu,  2 Apr 2020 10:55:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Questionable aspects of QEMU Error's design
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
 <44b5ff2c-6dce-e516-a9cc-9d80354c5a72@virtuozzo.com>
 <CAFEAcA_cmOkR4YsDmP7mDdKzs0jTu3WDO=d1uvMxHguvZjGW_g@mail.gmail.com>
Date: Thu, 02 Apr 2020 10:55:27 +0200
In-Reply-To: <CAFEAcA_cmOkR4YsDmP7mDdKzs0jTu3WDO=d1uvMxHguvZjGW_g@mail.gmail.com>
 (Peter Maydell's message of "Thu, 2 Apr 2020 08:11:11 +0000")
Message-ID: <877dyy9shs.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 2 Apr 2020 at 07:11, Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
>> Somehow, in general, especially with long function names and long parame=
ter lists I prefer
>>
>> ret =3D func(..);
>> if (ret < 0) {
>>      return ret;
>> }
>
> Personally I prefer the other approach -- this one has an extra line
> in the source and
> needs an extra local variable.

Me too, except when func(...) is so long that

    if (func(...) < 0) {

becomes illegible like

    if (func(... yadda, yadda,
             yadda, ...) < 0) {

Then an extra variable can improve things.

>> Are you sure that adding a lot of boolean functions is a good idea? I so=
mehow feel better with more usual int functions with -errno on failure.
>>
>> Bool is a good return value for functions which are boolean by nature: c=
hecks, is something correspond to some criteria. But for reporting an error=
 I'd prefer -errno.
>
> When would we want to return an errno? I thought the whole point of the
> Error* was that that was where information about the error was returned.
> If all your callsites are just going to do "if (ret < 0) { ... } then hav=
ing
> the functions pick an errno value to return is just extra work.

0/-1 vs. true/false is a matter of convention.  Lacking convention, it's
a matter of taste.

0/-1 vs. 0/-errno depends on the function and its callers.  When -errno
enables callers to distinguish failures in a sane and simple way, use
it.  When -errno feels "natural", I'd say feel free to use it even when
all existing callers only check < 0.

When you return non-null/null or true/false on success/error, neglecting
to document that in a function contract can perhaps be tolerated; you're
using the return type the common, obvious way.  But when you return 0/-1
or 0/-errno, please spell it out.  I've seen too many "Operation not
permitted" that were actually -1 mistaken for -EPERM.  Also too many
functions that return -1 for some failures and -errno for others.


