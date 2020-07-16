Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6768CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0D120656
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtIEQ8bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0D120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0K8-0003HK-Fq
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw0Ja-0002pm-Rh
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:36:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jw0JZ-0003aO-1t
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594892188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tpGxZWG7L/pqcdQ2zfyJUay5xdjxjmNolauiLOkIyXs=;
 b=KtIEQ8bjrHtE77ngbW/FZvEe77D2UBlAb3NS8gbWCWraDzmJR15rKMbdsQAz8xFp2nZNYY
 CVpeJvIh0swfO/Ng/0XtcADELzs19409Pc4WzceZGPDBqDLzN10R+EZbTGevcX0534eZJh
 IDsdXLB0/n+cswP3Z6olTEoOGz7IIOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-9yJ7mME9PmOj6H4rw6SqGA-1; Thu, 16 Jul 2020 05:36:26 -0400
X-MC-Unique: 9yJ7mME9PmOj6H4rw6SqGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED6D810059C4
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:36:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57FFB78A59;
 Thu, 16 Jul 2020 09:36:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAF7D11385E0; Thu, 16 Jul 2020 11:36:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 1/5] hw/core/qdev-properties: Simplify
 get_reserved_region()
References: <20200715175835.27744-1-philmd@redhat.com>
 <20200715175835.27744-2-philmd@redhat.com>
 <87o8ofrhgl.fsf@dusky.pond.sub.org>
 <699828e5-83bd-1dfa-904a-8d38a0178e63@redhat.com>
Date: Thu, 16 Jul 2020 11:36:21 +0200
In-Reply-To: <699828e5-83bd-1dfa-904a-8d38a0178e63@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 16 Jul 2020 10:38:12
 +0200")
Message-ID: <87h7u7pzsa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/16/20 10:29 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>=20
>>> Use the safer g_strdup_printf() over snprintf() + abort().
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>  hw/core/qdev-properties.c | 9 +++------
>>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index 098298c78e..d5f5aa150b 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
>>> @@ -581,13 +581,10 @@ static void get_reserved_region(Object *obj, Visi=
tor *v, const char *name,
>>>      DeviceState *dev =3D DEVICE(obj);
>>>      Property *prop =3D opaque;
>>>      ReservedRegion *rr =3D qdev_get_prop_ptr(dev, prop);
>>> -    char buffer[64];
>>> -    char *p =3D buffer;
>>> -    int rc;
>>> +    g_autofree char *p;
>>> =20
>>> -    rc =3D snprintf(buffer, sizeof(buffer), "0x%"PRIx64":0x%"PRIx64":%=
u",
>>> -                  rr->low, rr->high, rr->type);
>>> -    assert(rc < sizeof(buffer));
>>> +    p =3D g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
>>> +                        rr->low, rr->high, rr->type);
>>> =20
>>>      visit_type_str(v, name, &p, errp);
>>>  }
>>=20
>> I don't buy "safer" (the old code is already safe).
>
> I'm suspicious when I find an assert/abort in a code reachable by
> management interface, as IIUC we don't want to crash the process.
> I agree this shouldn't happen and if it happens we are screwed
> anyway.
>
>> I could buy
>> "simpler".
>>=20
>> It's also less efficient, but that shouldn't matter in a property
>> getter.
>
> If we want more efficient code, we should replace all the
> g_strdup_printf() calls by snprintf() + assert() in the places
> where we don't expect failure. This seems counterproductive from
> a maintenance PoV.

Mind, I'm not opposed to your patch.  I just find the commit message's
rationale misleading.  Your patch doesn't make the code safer (it
already is).  It does make it simpler.

>                    At some point we should make a decision and
> not allow more than 3 similar APIs at a time. We have been
> recommended to use GLib instead of snprintf() because it is "safer".
> Can we be consistent with recommendations? Else we should stop
> recommending to use GLib and friends.

We recommend g_strdup_printf() over snprintf() because it's easier to
use correctly, and usually easier to read.

Incorrect use of snprintf() is commonly unsafe.  Correct use of
snprintf() is safe, but commonly less readable than the equivalent
g_strdup_printf().  snprintf()'s efficiency advantage rarely matters.


