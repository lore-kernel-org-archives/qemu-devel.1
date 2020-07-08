Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04A4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613B820708
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMPt4SPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613B820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJM5-0002K1-DY
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtJLT-0001jb-LG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:19:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtJLR-0000La-R8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594250356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZeSrzCq4Zce4phCOzRZH2iPhewQJmXNvjO7z7ums5M8=;
 b=fMPt4SPihhsjSzplq5Asa1A2WyRztji3U8HB5x3HNLMjt2H8pgQVaEtNxddcisi/W8ar2x
 bgljHlQdbXin9pNZzSli2B2zvYaWm3xnxx0x53a5cGtSAwqDCBvWM6UUWVhS+kCA0mYWfX
 9MxpVNfwIsNIZCBlTy0oTwW+mxbAE9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-z0hxMTV1PQiL6zJN_PSZRw-1; Wed, 08 Jul 2020 03:16:23 -0400
X-MC-Unique: z0hxMTV1PQiL6zJN_PSZRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29C2C800C64;
 Wed,  8 Jul 2020 07:16:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D37B7846C;
 Wed,  8 Jul 2020 07:16:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CECAB1132FD2; Wed,  8 Jul 2020 09:16:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] hw/ppc/ppc4xx: Only accept (combination of) pow2 DDR sizes
References: <20200629200256.2240-1-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006300250390.32453@zero.eik.bme.hu>
Date: Wed, 08 Jul 2020 09:16:18 +0200
In-Reply-To: <alpine.BSF.2.22.395.2006300250390.32453@zero.eik.bme.hu>
 (BALATON Zoltan's message of "Tue, 30 Jun 2020 03:03:38 +0200 (CEST)")
Message-ID: <87mu4a329p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 29 Jun 2020, Philippe Mathieu-Daud=C3=A9 wrote:
>> Use popcount instruction to count the number of bits set in
>> the RAM size. Allow at most 1 bit for each bank. This avoid
>> using invalid hardware configurations.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> hw/ppc/ppc4xx_devs.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>
>> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
>> index f1651e04d9..c2484a5695 100644
>> --- a/hw/ppc/ppc4xx_devs.c
>> +++ b/hw/ppc/ppc4xx_devs.c
>> @@ -687,6 +687,15 @@ void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_b=
anks,
>>     int i;
>>     int j;
>>
>> +    if (ctpop64(size_left) > nr_banks) {
>> +        if (nr_banks) {
>> +            error_report("RAM size must be a power of 2");
>> +        } else {
>> +            error_report("RAM size must be the combination of %d powers=
 of 2",
>> +                         nr_banks);
>> +        }
>> +        exit(1);
>
> What is this supposed to fix?

The commit message doesn't really tell.  It should.

I suspect this new check is redundant.  What am I missing?

The loop that follows it finds a split of @ram's size guided by
@nr_banks and sdram_bank_sizes[].  The conditional after the loop fails
the function when no such split can be found.

In other words, the function fails unless @ram's size is the sum of
@nr_banks elements of sdram_bank_sizes[].

The actual sdram_bank_sizes[] contain only powers of two.  Anything else
would be deeply weird.

ctpop64(size_left) > nr_banks is weaker than that, isn't it?

To prove me wrong, show me a scenario where the new check fails, and the
existing check doesn't.

>                               Is it a good idea to exit() from a
> helper?

Depends on what exactly is being helped.

>         I don't think so because the board code should be in control
> in my opinion to decide what it can work with or what it cannot handle
> and wants to abort. So maybe it's better to return error in some way
> and let board code handle it. (We already exit from this function but
> that was added in commit a0258e4afa1 when the size fix up was removed
> due to memdev.

Complicate your helper when you genuinely need to.  But YAGNI.

>                That exit uses EXIT_FAILURE constant.)

I consider exit(EXIT_FAILURE) a case of portability virtue signalling ;)

But yes, local consistency should be maintained.

>> +    }
>>     for (i =3D 0; i < nr_banks; i++) {
>>         for (j =3D 0; sdram_bank_sizes[j] !=3D 0; j++) {
>>             bank_size =3D sdram_bank_sizes[j];
>>


