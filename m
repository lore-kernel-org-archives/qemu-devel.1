Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69114C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E1121927
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeWq8uId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E1121927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGs0-0004mw-Fi
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvGrG-0003yb-NJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:04:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvGrE-0005fO-TE
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594717451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9hElE/6P2hreo6ryqv5PdnNZOX6GMy9ITZ9XVw1ELU=;
 b=QeWq8uIdf5dnFmpZ4XTVQj7YDgguD4YhGu+KdBXTsLsrKSi6RGp2omDXwNaAcXNL2pC/hs
 pGIcnb8GwiJhFAO7Ox+2qV6p/B/WFN2DxC/M3V9s48pna31o8NUuqsJPkpDqflEivQBb6J
 xy25QeFRFInt064qc99Kd7jnu4DsoyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-CX8NbzVpO3mucJvJemwqwA-1; Tue, 14 Jul 2020 05:04:10 -0400
X-MC-Unique: CX8NbzVpO3mucJvJemwqwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F052A106B242;
 Tue, 14 Jul 2020 09:04:07 +0000 (UTC)
Received: from [10.72.12.168] (ovpn-12-168.pek2.redhat.com [10.72.12.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74E3C10013C3;
 Tue, 14 Jul 2020 09:04:04 +0000 (UTC)
Subject: Re: [PATCH v2] ftgmac100: fix dblac write test
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Erik Smit <erik.lucas.smit@gmail.com>, Andrew Jeffery <andrew@aj.id.au>
References: <20200628142658.29264-1-erik.lucas.smit@gmail.com>
 <df64d8de-9d7f-474b-8b72-5d2e6c7df1f4@www.fastmail.com>
 <CA+MHfovCuasf4RrfZrJwfHx4VOeRNfQ=MTMaFG4=Df8cELZ=EA@mail.gmail.com>
 <f46d2319-e83f-6d4a-97ba-3f91fe57dd3b@kaod.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f26fe66d-691c-ab4e-a6ea-78306a2b3996@redhat.com>
Date: Tue, 14 Jul 2020 17:04:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f46d2319-e83f-6d4a-97ba-3f91fe57dd3b@kaod.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 Cameron Esfahani via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/13 下午8:06, Cédric Le Goater wrote:
> On 7/7/20 9:42 AM, Erik Smit wrote:
>> Hi Andrew,
>>
>> On Mon, 6 Jul 2020 at 03:59, Andrew Jeffery <andrew@aj.id.au> wrote:
>>> On Sun, 28 Jun 2020, at 23:56, erik-smit wrote:
>>>> The test of the write of the dblac register was testing the old value
>>>> instead of the new value. This would accept the write of an invalid value
>>>> but subsequently refuse any following valid writes.
>>>>
>>>> Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
>>>> ---
>>>> Changes since v1:
>>>>
>>>> Changed %ld to HWADDR_PRIx to fix building on mingw
>>> Bit of a nitpick, but the type of the value argument is uint64_t, so shouldn't
>>> the result of the expression captured by FTGMAC100_DBLAC_TXDES_SIZE() and
>>> FTGMAC100_DBLAC_RXDES_SIZE() be printed with a straight PRIx64 rather than
>>> HWADDR_PRIx?
>> You are correct. I didn't understand the meaning of the PRI macros and
>> just grabbed the other PRI macro I saw getting used in the file.
> With that fixed,
>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>
> Thanks,
>
> C.


Applied by switching to use PRIx64.

Thanks



