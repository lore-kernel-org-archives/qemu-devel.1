Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21DFC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE6F20748
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 10:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1YEoQh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE6F20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVZ60-0004bQ-Fx
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 05:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1iVZ5I-00049N-7H
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1iVZ5G-0007ek-Re
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:44:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1iVZ5G-0007eY-M2
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 05:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573814650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=67mQNAHiL+vZmOGjwhLig6+s2f+hybFhtX2PSzDn4gg=;
 b=I1YEoQh5d8gt/RdcM4BidMxM02/m7fBbdELJADL4W5ZfOryjxc2hw8j5kc/0oZ0Qi0k/fr
 +ZCepWOsD/RbYRLaoiT+eIcNoMAU9Zhzgj6lED+qaez9Iehbc2grbyomKA8LGA46K/kcuU
 IoChWCMnM3KW/xX2B9qGrqYfuVj43cI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-LJYrnRPAP5SC_xJLdAF8dQ-1; Fri, 15 Nov 2019 05:43:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E43981802CE3;
 Fri, 15 Nov 2019 10:42:58 +0000 (UTC)
Received: from [10.36.116.194] (ovpn-116-194.ams2.redhat.com [10.36.116.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E7225C1B0;
 Fri, 15 Nov 2019 10:42:53 +0000 (UTC)
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
 <20191113144344.GA4204@orkuz.int.mamuti.net>
 <20191113160900.5f9f5415@bahia.lan>
 <CAFEAcA9+VzDC9N5vGcA9COUaPsSue9VWmtoaPneCqY7drtbVzA@mail.gmail.com>
 <20191113170040.7c62fcaf@bahia.lan> <20191115092003.GC2134@umbus.fritz.box>
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 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
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <f69212b5-7e12-3009-c812-39176c4e6cde@redhat.com>
Date: Fri, 15 Nov 2019 11:42:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191115092003.GC2134@umbus.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: LJYrnRPAP5SC_xJLdAF8dQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/11/2019 10:20, David Gibson wrote:
> On Wed, Nov 13, 2019 at 05:00:40PM +0100, Greg Kurz wrote:
>> On Wed, 13 Nov 2019 15:31:58 +0000
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>>> On Wed, 13 Nov 2019 at 15:10, Greg Kurz <groug@kaod.org> wrote:
>>>> David is away until the 19th of November, which is the release date
>>>> of rc2 according to the planning [*]. Then we have rc3 the 26th, and
>>>> final release (or rc4) the 3rd of December, so it should be ok.
>>>
>>> Please don't actively plan to delay putting changes in
>>> until later release candidates. The release process
>>> involves steadily winding up the bar of whether it's
>>> worth putting in and hopefully reducing the volume
>>> of changes between rcs. In an ideal world rc3 would
>>> have very few changes, and then there would be no
>>> changes at all between rc3 and the final release.
>>>
>>
>> Right. I could discuss with Laurent: David should be back on Monday
>> actually. Hopefully he can a send a PR before rc2.
>=20
> I'm back home now, back to work on Monday.  It'll probably take me a
> full day of catching up on email and whatnot, so the earliest I'd be
> likely to do the PR is Tuesday.  If you can get it ready before that,
> please go ahead.
>=20
I'm going to take your ppc-for-4.2 branch to build and test, and then I
will do the PR, probably today.

Thanks,
Laurent


