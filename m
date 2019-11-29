Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902FCC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF5A21721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qbv4GUkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF5A21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabxe-0003JO-Ck
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iabMS-0001US-Pn
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iabMO-0001BN-VK
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:10:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iabMN-00011U-Uk
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575015035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=N0tS99Erwc627c3slu1qUknVMYkA1zzRQbAO5hFI1VM=;
 b=Qbv4GUkb1/FaKSuLgVa3ZxkS0mU01dL3Npz4Lea3zG5YByPZvXGkdDw1PQbTZ17aox6bUm
 upwy1EK0Nc3yM4RzUf476v5jBsIIlZvmA+BZXI9ZB14R8kZEkP1JVf2zLk2eYd45jo7ptf
 vEa2M1jh0z8wmWByaDYvNVlePSOiWZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-ukm2CoiiPniRv7ws7GlCVQ-1; Fri, 29 Nov 2019 03:10:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80578188352C;
 Fri, 29 Nov 2019 08:10:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-159.ams2.redhat.com [10.36.116.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76330600C8;
 Fri, 29 Nov 2019 08:10:25 +0000 (UTC)
Subject: Re: [PATCH v1 1/1] pc-bios/s390-ccw: fix sclp_get_loadparm_ascii
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1574944437-31182-1-git-send-email-imbrenda@linux.ibm.com>
 <52e295af-3b34-6cb7-ba52-a26ae70aebcd@de.ibm.com>
 <20191128134517.7caf3496.cohuck@redhat.com>
 <bbfd3b99-c38f-ccb0-9c16-24bad35f357a@de.ibm.com>
 <CAFEAcA_vJP_nBRCtD=E2Lya1MejNBz0=Me-RcS6G39=VZ2zbAg@mail.gmail.com>
 <887eaf8d-2e39-83e3-acdc-f45f26004638@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5308c96c-6f18-ff40-1965-98b9405b9706@redhat.com>
Date: Fri, 29 Nov 2019 09:10:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <887eaf8d-2e39-83e3-acdc-f45f26004638@de.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ukm2CoiiPniRv7ws7GlCVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 08.38, Christian Borntraeger wrote:
> 
> 
> On 28.11.19 16:05, Peter Maydell wrote:
>> On Thu, 28 Nov 2019 at 12:48, Christian Borntraeger
>> <borntraeger@de.ibm.com> wrote:
>>>
>>>
>>>
>>> On 28.11.19 13:45, Cornelia Huck wrote:
>>>> On Thu, 28 Nov 2019 13:35:29 +0100
>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>
>>>>> Ack.
>>>>>
>>>>> Conny, I think this would be really nice to have for 4.2 (together with a bios rebuild)
>>>>> as this fixes a regression. Opinions?
>>>>
>>>> I fear that this is a bit late for 4.2... but this should get a
>>>> cc:stable.
>>>
>>> So we would rather ship a qemu regression instead of pushing a 1 line fixup?
>>> Peter, what is the current state of 4.2? does it look like we will have an rc4
>>> or is everything else silent.
>>
>> There isn't currently anything else that would need an rc4.
> 
> I would vote for getting this patch still in. And I think we probably do not need an
> rc4 for that, the fix seems pretty straight forward.

Ok, I'm going to build the binaries and send a pull request today.

 Thomas


