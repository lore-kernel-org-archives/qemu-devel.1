Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33033C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDAD2083B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 12:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PT79sR2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDAD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc6dO-0000ZE-DJ
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 07:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc6cf-0008MZ-Ke
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 07:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc6cc-0008KB-Ee
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 07:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604926208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X85Heu0DjKvCPbKlWQBf8i++TCWZFz0FhN0m9dVu4Bc=;
 b=PT79sR2sYIP2LPw9bjITZX8K7gYFpDTPWdN0VCoHdIwzVcIjD+uZLP7ZSwrfJPc/wVN0YJ
 V6Q1t4e6e8GbYvf1WaRS9X5KkYecHK1QrThF4frtd/U5NKk8Wb+xrqlPG+r+EpRdUtnVzT
 eBIRmwDzQnZPguoPVqNYllH7Q/zAbq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-xorZ4snaNkuzY4r-8tRA1w-1; Mon, 09 Nov 2020 07:50:07 -0500
X-MC-Unique: xorZ4snaNkuzY4r-8tRA1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4717F59;
 Mon,  9 Nov 2020 12:50:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B021002C15;
 Mon,  9 Nov 2020 12:50:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F251D1132BD6; Mon,  9 Nov 2020 13:50:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alex Chen <alex.chen@huawei.com>
Subject: Re: [PATCH] qtest: Fix bad printf format specifiers
References: <5FA28117.3020802@huawei.com>
 <67eca43e-99ea-f2ce-5d9e-a9cb5c7a3a83@redhat.com>
 <5FA38A32.2020008@huawei.com>
 <18690aa2-3de9-70ad-477f-934724b284a0@redhat.com>
 <87wnyzouy4.fsf@dusky.pond.sub.org>
 <1fd5965d-cf5e-b41b-2029-bd3e52c3e498@redhat.com>
 <8f5ef0b8-4c43-034f-f609-e7e5ca013970@redhat.com>
 <87d00narns.fsf@dusky.pond.sub.org> <5FA91234.1010708@huawei.com>
Date: Mon, 09 Nov 2020 13:50:03 +0100
In-Reply-To: <5FA91234.1010708@huawei.com> (Alex Chen's message of "Mon, 9 Nov
 2020 17:56:04 +0800")
Message-ID: <877dqupudg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Chen <alex.chen@huawei.com> writes:

> On 2020/11/9 15:57, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 06/11/2020 15.18, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 11/6/20 7:33 AM, Markus Armbruster wrote:
>>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>>
>>>>>> On 05/11/2020 06.14, AlexChen wrote:
>>>>>>> On 2020/11/4 18:44, Thomas Huth wrote:
>>>>>>>> On 04/11/2020 11.23, AlexChen wrote:
>>>>>>>>> We should use printf format specifier "%u" instead of "%d" for
>>>>>>>>> argument of type "unsigned int".
>>>>>>>>>
>>>>>>>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>>>>>>>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>>>>>>>>> ---
>>>>>>>>>  tests/qtest/arm-cpu-features.c | 8 ++++----
>>>>>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>>>>
> [...]
>>>>>>>>>
>>>>>>>>
>>>>>>>> max_vq and vq are both "uint32_t" and not "unsigned int" ... so if=
 you want
>>>>>>>> to fix this really really correctly, please use PRIu32 from inttyp=
es.h instead.
>>>>>>>>
>>>>>>>
>>>>>>> Hi Thomas,
>>>>>>> Thanks for your review.
>>>>>>> According to the definition of the macro PRIu32(# define PRIu32    =
     "u"),
>>>>>>> using PRIu32 works the same as using %u to print, and using PRIu32 =
to print
>>>>>>> is relatively rare in QEMU(%u 720, PRIu32 only 120). Can we continu=
e to use %u to
>>>>>>> print max_vq and vq in this patch.
>>>>>>> Of course, this is just my small small suggestion. If you think it =
is better to use
>>>>>>> PRIu32 for printing, I will send patch V2.
>>>>>>
>>>>>> Well, %u happens to work since "int" is 32-bit with all current comp=
ilers
>>>>>> that we support.
>>>>>
>>>>> Yes, it works.
>>>>>
>>>>>>                  But if there is ever a compiler where the size of i=
nt is
>>>>>> different, you'll get a compiler warning here again.
>>>>>
>>>>> No, we won't.
>>>>>
>>>>> If we ever use a compiler where int is narrower than 32 bits, then th=
e
>>>>> type of the argument is actually uint32_t[1].  We can forget about th=
is
>>>>> case, because "int narrower than 32 bits" is not going to fly with ou=
r
>>>>> code base.
>>>
>>> Agreed.
>>>
>>>>> If we ever use a compiler where int is wider than 32 bits, then the t=
ype
>>>>> of the argument is *not* uint32_t[2].  PRIu32 will work anyway, becau=
se
>>>>> it will actually retrieve an unsigned int argument, *not* an uint32_t
>>>>> argument[3].
>>>
>>> I can hardly believe that this can be true. Sure, it's true for such ca=
ses
>>> like this one here, where you multiply with an "int". But if you just t=
ry to
>>> print a plain uint32_t variable?
>>=20
>> Default argument promotions (=C2=A76.5.2.2 Function calls) still apply: =
"the
>> integer promotions are performed on each argument, and arguments that
>> have type float are promoted to double."
>>=20
>>> I've seen compiler warning in cases one tries to print a 16-bit (i.e. s=
hort)
>>> variable in the past if you use %d instead of the proper PRId16 (or %hd=
)
>>> format specifier - maybe not on x86, but certainly on other architectur=
es.
>>> If you're statement was right, that should not have happened, should it=
?
>>=20
>> =C2=A77.19.6.1 "The fprintf function" on length modifier 'h':
>>=20
>>     Specifies that a following d, i, o, u, x, or X conversion specifier
>>     applies to a short int or unsigned short int argument (the argument
>>     will have been promoted according to the integer promotions, but its
>>     value shall be converted to short int or unsigned short int before
>>     printing)
>>=20
>> Integer promotions preserve value including sign.  So, printing a short
>> value with %hd first promotes it to int, then converts it back to short.
>> Neither conversion has an effect.
>>=20
>> However, printing an int with %hd has: it converts int to short.
>> Implementation-defined behavior when the value doesn't fit.
>>=20
>> Length modifier 'h' is pretty pointless with printf().  So would be a
>> warning to nudge people towards its use.
>>=20
>> In fact, GNU libc's PRIu32 does not use it.  inttypes.h:
>>=20
>>     /* Unsigned integers.  */
>>     # define PRIu8=09=09"u"
>>     # define PRIu16=09=09"u"
>>     # define PRIu32=09=09"u"
>>     # define PRIu64=09=09__PRI64_PREFIX "u"
>>=20
>> where __PRI64_PREFIX is "l" or "ll" depending on system-dependent
>> __WORDSIZE.
>>=20
>> In short:
>>=20
>>>>> In other words "%" PRIu32 is just a less legible alias for "%u" in al=
l
>>>>> cases that matter.
>>=20
>
> Hi Markus,
>
> Thanks for your reply, I have learned a lot.
> May I understand it as follows:
> %u is used when there are parameters obtained by arithmetic operation;
> otherwise, PRIu32 is used to print uint32_t type parameters?

No.  Use "%u" unless you need portability to machines where unsigned is
narrower than 32 bits (we don't).

On machines where unsigned int is at least 32 bit wide, "%" PRIu32
is the same as "%u".  It's not wrong, just illegible.


