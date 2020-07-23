Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E39C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0F820737
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJi+F5+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0F820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyb6j-0004Pp-IO
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyb5v-0003ms-5w
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:17:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57482
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyb5t-0003lf-Iu
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 09:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595510224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2PdgvvFMwg32jzr68DVC+U8WdYPKGLd6RaNZhvOzvWo=;
 b=OJi+F5+iEiW+BHeYq3fVtd2moM6FDGCt+B4dQ2yqq3QTq9G0QxNHxedxU3pRlEQK6NA1NG
 jcL/9wsjbCosCW0fWKyqcWPtGY5QW9LWuTRz0IRgVpvkrqJ7kkymcbSXq+soQq54W1sTBQ
 nNHLevSA8+IWGWbYuyN9IDlKu0p3fUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-jVKs7PUbNYSdWbc2X0fy5g-1; Thu, 23 Jul 2020 09:17:02 -0400
X-MC-Unique: jVKs7PUbNYSdWbc2X0fy5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FC63100CCCB;
 Thu, 23 Jul 2020 13:17:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ADBF71D34;
 Thu, 23 Jul 2020 13:17:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACD0D111CA26; Thu, 23 Jul 2020 15:16:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1?] qapi/error: Check format string argument in
 error_propagate_prepend()
References: <20200723091309.18690-1-philmd@redhat.com>
 <c8068bb8-cff1-a2a6-3eff-f709822917b7@weilnetz.de>
 <0b9f2a2e-0d54-08eb-60fa-237d29c2529e@redhat.com>
Date: Thu, 23 Jul 2020 15:16:59 +0200
In-Reply-To: <0b9f2a2e-0d54-08eb-60fa-237d29c2529e@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 23 Jul 2020 12:04:19
 +0200")
Message-ID: <87imeefk1g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/23/20 11:44 AM, Stefan Weil wrote:
>> Am 23.07.20 um 11:13 schrieb Philippe Mathieu-Daud=C3=A9:
>>=20
>>> error_propagate_prepend() "behaves like error_prepend()", and
>>> error_prepend() uses "formatting @fmt, ... like printf()".
>>> error_prepend() checks its format string argument, but
>>> error_propagate_prepend() does not. Fix that.
>>>
>>> This would have catched the invalid format introduced in commit
>>> b98e8d1230f:
>>>
>>>     CC      hw/sd/milkymist-memcard.o
>>>   hw/sd/milkymist-memcard.c: In function =E2=80=98milkymist_memcard_rea=
lize=E2=80=99:
>>>   hw/sd/milkymist-memcard.c:284:70: error: format =E2=80=98%s=E2=80=99 =
expects a matching =E2=80=98char *=E2=80=99 argument [-Werror=3Dformat=3D]
>>>     284 |         error_propagate_prepend(errp, err, "failed to init SD=
 card: %s");
>>>         |                                                              =
       ~^
>>>         |                                                              =
        |
>>>         |                                                              =
        char *
>>>
>>> Fixes: 4b5766488f ("Fix use of error_prepend() with &error_fatal, &erro=
r_abort")
>>> Inspired-by: Stefan Weil <sw@weilnetz.de>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>  include/qapi/error.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>> index 7932594dce..eeeef1a34d 100644
>>> --- a/include/qapi/error.h
>>> +++ b/include/qapi/error.h
>>> @@ -381,6 +381,7 @@ void error_propagate(Error **dst_errp, Error *local=
_err);
>>>   *     error_propagate(dst_errp, local_err);
>>>   * Please use ERRP_GUARD() and error_prepend() instead when possible.
>>>   */
>>> +GCC_FMT_ATTR(3, 4)
>>>  void error_propagate_prepend(Error **dst_errp, Error *local_err,
>>>                               const char *fmt, ...);

Wait!  You put the attribute in an unusual place.  We have it at the end
of the declaration elsewhere in this file.  Let's remain locally
consistent.

>> Reviewed-by: Stefan Weil <sw@weilnetz.de>
>>=20
>> error_vprepend is one more candidate for GCC_FMT_ATTR. Maybe you can add
>> that, too.
>
> This one is different as it uses a va_list. Now I realize it is
> only called in util/error.c, and all its callers are guarded with
> GCC_FMT_ATTR. Maybe we can make it static to simplify... Markus?

Could use GCC_FMT_ATTR(2, 0).  Much less useful, but why not.

Perhaps a respin would be cleaner than me applying multiple tweaks.


