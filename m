Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA84FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90F4C20706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJxQWTdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90F4C20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPyx-0003AR-Ta
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joPyJ-0002eB-MN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:23:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26168
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1joPyH-0000xq-7x
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593084187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ms9xMXyJ/p3SIvZBXwWCr9FOYTVVX0kI6djFCTSlxFs=;
 b=BJxQWTdX1PkL768joDilZ392cB8xRbboqm8J4s2DOnVSHM94rxTBbraM6n7Z2UjKbg7sHn
 ZNrqO1y2cdeLjHH9VnzAhgV2OFehg5kmGeiM2/5wFpdwSRx5rKrZqWRGW7Tool8tc/T2Nk
 vm8wdrVCzlQPf6i78c3ct5Xdd13/8oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-kNpc7pMOP7qMbPJJ3w8Z0w-1; Thu, 25 Jun 2020 07:23:05 -0400
X-MC-Unique: kNpc7pMOP7qMbPJJ3w8Z0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E68380400B;
 Thu, 25 Jun 2020 11:23:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5593C5D9E7;
 Thu, 25 Jun 2020 11:23:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D692211384D4; Thu, 25 Jun 2020 13:23:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 02/46] error: Document Error API usage rules
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-3-armbru@redhat.com>
 <db1af786-075d-b656-b280-d25ad34bbbe6@virtuozzo.com>
Date: Thu, 25 Jun 2020 13:23:00 +0200
In-Reply-To: <db1af786-075d-b656-b280-d25ad34bbbe6@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 25 Jun 2020 10:16:06 +0300")
Message-ID: <87v9jf2xuz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 24.06.2020 19:43, Markus Armbruster wrote:
>> This merely codifies existing practice, with one exception: the rule
>> advising against returning void, where existing practice is mixed.
>>
>> When the Error API was created, we adopted the (unwritten) rule to
>> return void when the function returns no useful value on success,
>> unlike GError, which recommends to return true on success and false on
>> error then.
>>
>> When a function returns a distinct error value, say false, a checked
>> call that passes the error up looks like
>>
>>      if (!frobnicate(..., errp)) {
>>          handle the error...
>>      }
>>
>> When it returns void, we need
>>
>>      Error *err =3D NULL;
>>
>>      frobnicate(..., &err);
>>      if (err) {
>>          handle the error...
>>          error_propagate(errp, err);
>>      }
>>
>> Not only is this more verbose, it also creates an Error object even
>> when @errp is null, &error_abort or &error_fatal.
>>
>> People got tired of the additional boilerplate, and started to ignore
>> the unwritten rule.  The result is confusion among developers about
>> the preferred usage.
>>
>> The written rule will hopefully reduce the confusion.
>>
>> The remainder of this series will update a substantial amount of code
>> to honor the rule.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qapi/error.h | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index 1a5ea25e12..c3d84d610a 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -15,6 +15,32 @@
>>   /*
>>    * Error reporting system loosely patterned after Glib's GError.
>>    *
>> + * Rules:
>> + *
>> + * - Functions that use Error to report errors have an Error **errp
>> + *   parameter.  It should be the last parameter, except for functions
>> + *   taking variable arguments.
>> + *
>> + * - You may pass NULL to not receive the error, &error_abort to abort
>> + *   on error, &error_fatal to exit(1) on error, or a pointer to a
>> + *   variable containing NULL to receive the error.
>> + *
>> + * - The value of @errp should not affect control flow.
>
> What do you mean? Incoming state of errp, or *errp after some call of ano=
ther
> function? Should we then update this paragraph, when introduce
> ERRP_AUTO_PROPAGATE?

The argument value passed for parameter @errp.

What I'm trying to express is that the function should remain oblivious
of how the caller handles errors.  Do not check whether the argument is
NULL, &error_abort, &error_fatal, or any other value.  It's best to
treat @errp as write-only.

I'm trying to strike a balance between clarity and brevity, without
overspecifying what the function may do.  I tend to err on the side of
brevity in function contracts.  I always hope reviewers will flag my
errors :)  In short, I'm open to better ideas.

GLib documentation, for comparison:

    If NULL is passed for the GError** argument, then errors should not
    be returned to the caller, but your function should still abort and
    return if an error occurs. That is, control flow should not be
    affected by whether the caller wants to get a GError.

>
>> + *
>> + * - On success, the function should not use @errp.  On failure, it
>> + *   should set a new error, e.g. with error_setg(errp, ...), or
>> + *   propagate an existing one, e.g. with error_propagate(errp, ...).
>> + *
>> + * - Whenever practical, also return a value that indicates success /
>> + *   failure.  This can make the error checking more concise, and can
>> + *   avoid useless error object creation and destruction.  Note that
>> + *   we still have many functions returning void.  We recommend
>> + *   =E2=80=A2 bool-valued functions return true on success / false on =
failure,
>> + *   =E2=80=A2 pointer-valued functions return non-null / null pointer,=
 and
>> + *   =E2=80=A2 integer-valued functions return non-negative / negative.
>> + *
>> + * How to:
>> + *
>>    * Create an error:
>>    *     error_setg(errp, "situation normal, all fouled up");
>>    *
>>


