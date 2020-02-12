Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12456C35242
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 02:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3567206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 02:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YW192sJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3567206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1iDb-0006qA-44
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 21:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j1iCy-0006Gq-RE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 21:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j1iCw-0005jq-69
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 21:57:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j1iCv-0005ij-VT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 21:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581476217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXU+vtg4GDe6+TH+dXzu/WqdoPYmD7KcRYomgmIVnzo=;
 b=YW192sJjB4X1bzD/WmyAgrtn+yu9qkG5ELpqP+i1+itbc1O0oZpyRmlT8t0vFKmsiy2BYM
 ADvSO2GqC9xzndyEm/5LEF24zr0jPbUGKeeoWJGbchfQZu18cpBdcQOQqPJ5aJQhdLpiSx
 gYhsUoQES3w6S4IVe6XiUMQItxli4mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-ZWJQP4vZObeyTrenhmcJ-g-1; Tue, 11 Feb 2020 21:56:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 155F5800EB2;
 Wed, 12 Feb 2020 02:56:54 +0000 (UTC)
Received: from [10.72.13.111] (ovpn-13-111.pek2.redhat.com [10.72.13.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7E3787B34;
 Wed, 12 Feb 2020 02:56:49 +0000 (UTC)
Subject: Re: [PATCH V4 0/5] Introduce Advanced Watch Dog module
To: "Zhang, Chen" <chen.zhang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
References: <20191217124554.30818-1-chen.zhang@intel.com>
 <fa1ed6cb-63d7-ee83-a5a0-b099b662fef2@intel.com>
 <0502a0db0a17484c9220b3a63c40b397@intel.com>
 <08a1a225-52c1-4e6c-85f7-fcf6612b5383@redhat.com>
 <3049425105b94f6cb9cd846c84c95a84@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <783bac16-0e4d-f027-3e4a-b6fff500c244@redhat.com>
Date: Wed, 12 Feb 2020 10:56:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3049425105b94f6cb9cd846c84c95a84@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ZWJQP4vZObeyTrenhmcJ-g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/11 =E4=B8=8B=E5=8D=884:58, Zhang, Chen wrote:
>> -----Original Message-----
>> From: Jason Wang<jasowang@redhat.com>
>> Sent: Monday, January 20, 2020 10:57 AM
>> To: Zhang, Chen<chen.zhang@intel.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Philippe Mathieu-Daud=C3=A9<philmd@redhat.com>;
>> qemu-dev<qemu-devel@nongnu.org>
>> Cc: Zhang Chen<zhangckid@gmail.com>
>> Subject: Re: [PATCH V4 0/5] Introduce Advanced Watch Dog module
>>
>>
>> On 2020/1/19 =E4=B8=8B=E5=8D=885:10, Zhang, Chen wrote:
>>> Hi~
>>>
>>> Anyone have comments about this module?
>> Hi Chen:
>>
>> I will take a look at this series.
> Sorry for slow reply due to CNY and extend leave.
> OK, waiting your comments~ Thanks~
>
>> Two general questions:
>>
>> - if it can detect more than network stall, it should not belong to /net
> This module use network connection status to detect all the issue(Host to=
 Guest/Host to Host/Host to Admin...).
> The target is more than network but all use network way. So it is looks a=
 tricky problem.


Ok.


>
>> - need to convince libvirt guys for this proposal, since usually it's th=
e duty of
>> upper layer instead of qemu itself
>>
> Yes, It looks a upper layer responsibility, but In the cover latter I hav=
e explained the reason why we need this in Qemu.
>   try to make this module as simple as possible. This module give upper l=
ayer software a new way to connect/monitoring Qemu.
> And due to all the COLO code implement in Qemu side, Many customer want t=
o use this FT solution without other dependencies,
> it is very easy to integrated to real product.
>
> Thanks
> Zhang Chen


I would like to hear from libvirt about such design.

Thanks

>


