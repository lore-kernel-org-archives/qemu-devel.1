Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F53C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 08:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BF720728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 08:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPByqghX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BF720728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isMym-0001Gb-SM
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 03:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1isMy8-0000qe-8O
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 03:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1isMy3-0002VI-I1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 03:27:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1isMy3-0002Te-Af
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 03:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579249618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=djMiusIi/ALtU4CyAVNLmrIouqtGOhlNCqVgY8aZc+Q=;
 b=EPByqghXGmpndmDJB31GQCXoxHosouYIn2HJSe76jSm9n5UrRkZux5oQYFNTbBFcNWsyHC
 v24uYQjMedADZ02HFCy9l/YCc3DvADl7aMzVdAvDUl24YtjptAWXNfCllnspLjAgLtlg6U
 AFarz7kWL2s3QBkfeIOdpT6SZl1zNYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-C00TOZ_8N0O96jDqfe4uxg-1; Fri, 17 Jan 2020 03:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C1E107B11D;
 Fri, 17 Jan 2020 08:26:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-212.ams2.redhat.com [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2872D89D03;
 Fri, 17 Jan 2020 08:26:50 +0000 (UTC)
Subject: Re: [PATCH v2 85/86] numa: make exit() usage consistent
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-86-git-send-email-imammedo@redhat.com>
 <a4feb8cd-a105-bcfd-b8c3-27ac5bb0f474@redhat.com>
 <1e76bbe6-1dda-818a-49a2-68843a08f989@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3a46563e-f7c0-bbf7-126a-4b7460a6770e@redhat.com>
Date: Fri, 17 Jan 2020 09:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1e76bbe6-1dda-818a-49a2-68843a08f989@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: C00TOZ_8N0O96jDqfe4uxg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 Riku Voipio <riku.voipio@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 David Gibson <dgibson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/01/2020 09.06, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 1/16/20 5:43 PM, Thomas Huth wrote:
>> On 15/01/2020 16.07, Igor Mammedov wrote:
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>> CC: ehabkost@redhat.com
>>> ---
>>> =C2=A0 hw/core/numa.c | 4 ++--
>>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>>> index 3177066..47d5ea1 100644
>>> --- a/hw/core/numa.c
>>> +++ b/hw/core/numa.c
>>> @@ -718,7 +718,7 @@ void numa_complete_configuration(MachineState *ms)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Report large =
node IDs first, to make mistakes easier to
>>> spot */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!numa_info[i=
].present) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_report("numa: Node ID missing: %d", i);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exi=
t(1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exi=
t(EXIT_FAILURE);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 @@ -759,7 +759,7 @@ void numa_complete_configuration(MachineStat=
e *ms)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_report("total memory for NUMA nodes (0x%" PRIx64 ")"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 " should equal RAM size (0x" RAM_ADDR_FMT
>>> ")",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 numa_total, ram_size);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exi=
t(1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exi=
t(EXIT_FAILURE);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!numa=
_uses_legacy_mem()) {
>>
>> Please don't. We've had exit(1) vs. exit(EXIT_FAILURE) discussions in
>> the past already, and IIRC there was no clear conclusion which one we
>> want to use. There are examples of changes to the numeric value in our
>> git history (see d54e4d7659ebecd0e1fa7ffc3e954197e09f8a1f for example),
>> and example of the other way round (see 4d1275c24d5d64d22ec4a30ce1b6a0
>> for example).
>>
>> Your patch series here is already big enough, so I suggest to drop this
>> patch from the series. If you want to change this, please suggest an
>> update to CODING_STYLE.rst first so that we agree upon one style for
>> exit() ... otherwise somebody else might change this back into numeric
>> values in a couple of months just because they have a different taste.
>=20
> TBH I find your suggestion a bit harsh. If you noticed this, it means
> you care about finding a consensus about which style the project should
> use, but then you ask Igor to update to CODING_STYLE to restart the
> discussion until we get an agreement, so he can apply his patch.
>
> If this patch were single, this could be understandable. Now considering
> the series size, as you suggested, as the patch author I'd obviously
> drop my patch and stay away of modifying a 'exit()' line forever.
>=20
> Maybe it is a good opportunity to restart the discussion and settle on a
> position, update CODING_STYLE.rst, do a global cleanup, update
> checkpatch to keep the code clean.
> As I don't remember such discussions, they might predate my involvement
> with the project. Do you mind starting a thread with pointers to the
> previous discussions?

Honestly, I don't care much whether we use exit(EXIT_FAILURE) or
exit(1). But I care about having less code churn, so that "git blame"
stays somewhat usable in the course of time, i.e. I really like to avoid
that we include such ping-pong patches where every author changes such
lines to their current taste.

Thus if someone really cares to change such matter-of-taste code lines,
I think it's fair to ask them to update CODING_STYLE first. Otherwise,
yes, please just leave the exit() lines as they are to avoid unnecessary
code churn.

 Thanks,
  Thomas


