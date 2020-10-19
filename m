Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2CC22263
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcvS0hqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2CC22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVlj-0000oh-C8
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 10:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUVi7-0007Wz-CK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kUVi5-0001DA-BD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603116023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOX7N1suFPzknT2wZrnDBZ1rsdZkdETvhdvdTadXT3Q=;
 b=UcvS0hqb1cdyfUBVX69dASpFiedMG95xEXv7i/j/suhB/MM0cPdTFEMkL4RMD0owRW3F5h
 0zhKyzoWTGKWkJg/5PiJI7xrRgZfdU5WcpCyAJXK5REm/mI/hXPZuK7E0n8+aXsfrVG6g/
 N/nFIPcQCyuJzfjIBZYl7mh65tL5w2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-qhEcgtkuOxO0QM111h7mYw-1; Mon, 19 Oct 2020 10:00:21 -0400
X-MC-Unique: qhEcgtkuOxO0QM111h7mYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 555E88030AD;
 Mon, 19 Oct 2020 14:00:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F8226E70C;
 Mon, 19 Oct 2020 14:00:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 931AC1132A08; Mon, 19 Oct 2020 16:00:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan via <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/pci-host/grackle: Verify PIC link is properly set
References: <20201011190332.3189611-1-f4bug@amsat.org>
 <20201011223446.GA4787@yekko.fritz.box>
 <369509c1-2e90-13cf-8845-892e754516d1@amsat.org>
 <20201012065436.GB71119@yekko.fritz.box>
 <9f7e4847-801d-dcd3-b876-bf2d276251@eik.bme.hu>
 <6e587154-4bc5-c44c-0c85-b46e0dddd3aa@amsat.org>
 <87k0vm1wny.fsf@dusky.pond.sub.org>
 <24bcd4-fde2-22a2-d3f4-cd42d9ee13c6@eik.bme.hu>
Date: Mon, 19 Oct 2020 16:00:17 +0200
In-Reply-To: <24bcd4-fde2-22a2-d3f4-cd42d9ee13c6@eik.bme.hu> (BALATON Zoltan
 via's message of "Mon, 19 Oct 2020 13:11:42 +0200 (CEST)")
Message-ID: <87d01e48pa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan via <qemu-devel@nongnu.org> writes:

> On Mon, 19 Oct 2020, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>> On 10/12/20 1:50 PM, BALATON Zoltan via wrote:
>>>> On Mon, 12 Oct 2020, David Gibson wrote:
>>>>> On Mon, Oct 12, 2020 at 08:21:41AM +0200, Philippe
>>>>> Mathieu-Daud=C3=83=C6=92=C3=86=E2=80=99=C3=83=E2=80=9A=C3=82=C2=A9 wr=
ote:
>>>>>> On 10/12/20 12:34 AM, David Gibson wrote:
>>>>>>> On Sun, Oct 11, 2020 at 09:03:32PM +0200, Philippe
>>>>>>> Mathieu-Daud=C3=83=C6=92=C3=86=E2=80=99=C3=83=E2=80=9A=C3=82=C2=A9 =
wrote:
>>>>>>>> The Grackle PCI host model expects the interrupt controller
>>>>>>>> being set, but does not verify it is present. Add a check to
>>>>>>>> help developers using this model.
>>>>>>>
>>>>>>> I don't think thaqt's very likely, but, sure, applied to ppc-for-5.=
2
>>>>>>
>>>>>> Do you want I correct the description as:
>>>>>> "The Grackle PCI host model expects the interrupt controller
>>>>>> being set, but does not verify it is present.
>>>>>> A developer basing its implementation on the Grackle model
>>>>>> might hit this problem. Add a check to help future developers
>>>>>> using this model as reference."?
>>>>>
>>>>> No, it's fine.=C3=82=C2=A0 All I was saying is that the chances of an=
yone using
>>>>> Grackle in future seem very low to me.
>>>> So maybe an assert instead of a user visible error would be enough?
>>>
>>> My understanding is realize() shouldn't abort()
>>> (the caller might choose to by using &error_abort).
>>
>> assert() is for checking invariants.  A violated invariant is a
>> programming error: developers screwed up, safe recovery is impossible.
>>
>> Abusing assert() to catch errors that are not programming errors is
>> wrong.
>>
>> You may check invariants with assert() anywhere in the code.
>>
>> You should not misuse assert() anywhere in the code.
>>
>> Sometimes, an error condition that is *not* a programming error in the
>> function where it is detected *is* a programming error for certain
>> calls.  Having these calls pass &error_abort is a common solution for
>> this problem.
>>
>> Hope this helps.
>
> Helps just a bit but after reading this I'm still confused if this
> particular case should be assert or ser error.
>
> I was suggesting assert and I think it's a programming error to use
> the grackle model without setting PIC link but not sure if users can
> also create this instance via command line (even if it does not make
> much sense) in which case it's probably better to return error.

They can't: "info qdm" shows

    name "grackle-pcihost", bus System, no-user
                                        ~~~~~~~

>                                                                 Having
> all devices user creatable via -device without a way to describe their=20
> dependencies is a nice way to make all sorts of errors possible. But
> maybe aborting with assert during creation of the machine is still
> OK. If people device_add a model later and that crashes then it's
> their problem. Unless we want to avoid that being used as DoS in
> enterprise setting. So maybe we should never abort then if there's a
> way to fail with an error instead.
>
> I can look at this problem from different angles and all seem to be
> plausible resulting in different solutions.

As long as the device is no-user, asserting that properties have sane
values feels reasonable enough to me.

Setting an error instead is not wrong, of course.


