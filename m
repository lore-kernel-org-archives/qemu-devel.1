Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11ECC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:58:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDE920643
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Usrx8Pwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDE920643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwyG-0005Ht-0O
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWwxb-0004jC-EY
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:58:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57692
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jWwxZ-00079i-Ae
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588921091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0+09WM5fjIw2UNbdSZdoZXD0l6y4X4GPJy/niqL0ho=;
 b=Usrx8Pwc/GPm27ii5xkaO7LWmqWX9ZHnz40Pw+JK1tWRKsBw3XUPe/4w4g6WiFSP0wM76l
 A/TKCF42MGXjiPaHWnxtG9Pz0FPEdZ7s2HgRm1QCCS2+HdMOZZugONf06aUfVJUNv/dTkN
 MC8P4ptX0iW8DwME9AVILEFfdPc4GqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-lB8LOUroOui2NSsjHVQYjA-1; Fri, 08 May 2020 02:58:08 -0400
X-MC-Unique: lB8LOUroOui2NSsjHVQYjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DC9480183C;
 Fri,  8 May 2020 06:58:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCFD75D9CA;
 Fri,  8 May 2020 06:58:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 66D1511358BC; Fri,  8 May 2020 08:58:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 13/32] cpus: Fix configure_icount() error API violation
References: <20200429072048.29963-1-armbru@redhat.com>
 <20200429072048.29963-14-armbru@redhat.com>
 <CAFEAcA-CH=2zR2=PC4ss8WDQrRoo9Yr62b96+BoVh9uQay5qqg@mail.gmail.com>
Date: Fri, 08 May 2020 08:58:05 +0200
In-Reply-To: <CAFEAcA-CH=2zR2=PC4ss8WDQrRoo9Yr62b96+BoVh9uQay5qqg@mail.gmail.com>
 (Peter Maydell's message of "Thu, 7 May 2020 16:57:26 +0100")
Message-ID: <87d07e29s2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 29 Apr 2020 at 08:34, Markus Armbruster <armbru@redhat.com> wrote=
:
>>
>> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
>> pointer to a variable containing NULL.  Passing an argument of the
>> latter kind twice without clearing it in between is wrong: if the
>> first call sets an error, it no longer points to NULL for the second
>> call.
>>
>> configure_icount() is wrong that way.  Harmless, because its @errp is
>> always &error_abort or &error_fatal.
>>
>> Just as wrong (and just as harmless): when it fails, it can still
>> update global state.
>
> Hi; Coverity complains about this change (CID 1428754):
>>
>>  void configure_icount(QemuOpts *opts, Error **errp)
>>  {
>> -    const char *option;
>> +    const char *option =3D qemu_opt_get(opts, "shift");
>> +    bool sleep =3D qemu_opt_get_bool(opts, "sleep", true);
>> +    bool align =3D qemu_opt_get_bool(opts, "align", false);
>> +    long time_shift =3D -1;
>>      char *rem_str =3D NULL;
>>
>> -    option =3D qemu_opt_get(opts, "shift");
>> -    if (!option) {
>> -        if (qemu_opt_get(opts, "align") !=3D NULL) {
>> -            error_setg(errp, "Please specify shift option when using al=
ign");
>> -        }
>> +    if (!option && qemu_opt_get(opts, "align")) {
>> +        error_setg(errp, "Please specify shift option when using align"=
);
>>          return;
>
> Previously, if option was NULL we would always take this early
> exit. Now we only take the exit if option is NULL and the
> qemu_opt_get() returns true, so in some cases execution
> can continue through the function with a NULL option...
>
>>      }
>>
>> -    icount_sleep =3D qemu_opt_get_bool(opts, "sleep", true);
>> +    if (align && !sleep) {
>> +        error_setg(errp, "align=3Don and sleep=3Doff are incompatible")=
;
>> +        return;
>> +    }
>> +
>> +    if (strcmp(option, "auto") !=3D 0) {
>
> ...but here we pass option to strcmp(), which is wrong if it
> can be NULL.

Right.  I'll post a fix.  Thank you!


