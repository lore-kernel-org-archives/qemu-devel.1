Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6FCC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D6221D95
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOcJONic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D6221D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0KL8-0000X0-2l
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0KJx-0007nw-IJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:46:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47565
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0KJv-0004Jh-Qy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595922403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izcsI4BKHIW+6sl6qugHgw6wvnZ0LvO0RJ8uH9UBtQs=;
 b=bOcJONicFEVaBp6/S7UiaLEV2oFHlAPNLNFIm0mH+Pmg/EEj6P7QGtsKIvPBxCCmJdssRj
 dVaBoOOYJft9vAbG+MzUhk24gC4ZfF+8AeKezkv86HJ7KiJrSqLaBdkZsd5MeAzQE60+Eh
 aw9xx1sFXg/KymxXpdhKRYfwdCC+cxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-W09igTNiPzyN_bM1_UnoGQ-1; Tue, 28 Jul 2020 03:46:38 -0400
X-MC-Unique: W09igTNiPzyN_bM1_UnoGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC7351009600;
 Tue, 28 Jul 2020 07:46:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA20410013C4;
 Tue, 28 Jul 2020 07:46:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74A371132FD2; Tue, 28 Jul 2020 09:46:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] hw/core/qdev: Increase qdev_realize() kindness
References: <20200707033326.19178-1-f4bug@amsat.org>
 <4e472f6a-e6b3-910b-97fe-0526d1f560a1@redhat.com>
 <f8505888-abe4-5f55-0ff0-b167064909a8@amsat.org>
Date: Tue, 28 Jul 2020 09:46:36 +0200
In-Reply-To: <f8505888-abe4-5f55-0ff0-b167064909a8@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 27 Jul 2020 19:55:03
 +0200")
Message-ID: <878sf4f5er.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 7/7/20 11:47 AM, Paolo Bonzini wrote:
>> On 07/07/20 05:33, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Since commit 510ef98dca5, qdev_realize() aborts if bus-less device
>>> is realized on a bus. While commits 514db7710b..007d1dbf72 took
>>> care of converting all mainstream uses, QEMU forks weren't. These
>>> forks are usually maintained by hobbyist with interest in following
>>> mainstream development, but with limited time, so usually rebase
>>> from time to time. To avoid them to spend time on debugging and
>>> reading git-log history, display a kind hint about what is wrong.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> Since v2:
>>> - scratch __func__ (armbru)
>>> - reword to justify this is not an impossible case (armbru)
>>> ---
>>>  hw/core/qdev.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>>> index 2131c7f951..a16f1270f1 100644
>>> --- a/hw/core/qdev.c
>>> +++ b/hw/core/qdev.c
>>> @@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus,=
 Error **errp)
>>> =20
>>>      if (bus) {
>>>          qdev_set_parent_bus(dev, bus);
>>> -    } else {
>>> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>>> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>>> +        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'=
",
>>> +                   DEVICE_GET_CLASS(dev)->bus_type,
>>> +                   object_get_typename(OBJECT(dev)));
>>> +        return false;
>>>      }
>>> =20
>>>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
>>>
>>=20
>> Queued, thanks.
>
> Thanks! I haven't see that and sent a v4 with example included &
> typo fixed, if possible can you take it instead?
> https://patchew.org/QEMU/20200727175112.6820-1-f4bug@amsat.org/

Please also consider my objection in reply to v4.


