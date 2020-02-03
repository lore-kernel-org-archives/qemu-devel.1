Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E405CC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A861720838
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba5idgcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A861720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydka-0005Wd-Ri
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iydjz-00052f-FQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:34:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iydjy-0002Yu-6c
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:34:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60906
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iydjy-0002Y5-2W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580744061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DTKN3efbrGp9npn5a25rhPwpBw1BPeJySITK85bv0k0=;
 b=Ba5idgcKr9Pyj/ULawHXPhsudBVpcozh7GvT08cXyx/QwZF07TwNO+7+NqM7tYmkHIZdXt
 fexsCeH7t6u99eo5te6c7qsOfat+OriIAntvO5z9KaAMurQ1HY48vm/pjUhQKPmBjM+9Mw
 rAvfIkh+gyXDp8sx2q4bHQZKKiWayvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-LPYd-fD0NbWPkPSQqS7nsA-1; Mon, 03 Feb 2020 10:34:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E73BB101E63A;
 Mon,  3 Feb 2020 15:34:10 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D7F719C58;
 Mon,  3 Feb 2020 15:34:08 +0000 (UTC)
Subject: Re: [RFC PATCH] audio: proper support for float samples in mixeng
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
References: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
 <87h8086vi7.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d91dcd9f-4f6a-f2b1-bb3a-3be9966b247c@redhat.com>
Date: Mon, 3 Feb 2020 09:34:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87h8086vi7.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LPYd-fD0NbWPkPSQqS7nsA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 12:21 AM, Markus Armbruster wrote:
> "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:
>=20
>> This adds proper support for float samples in mixeng by adding a new
>> audio format for it.
>>
>> Limitations: only native endianness is supported.
>>
>> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.co=
m>
>> ---
>>
>> This patch is meant to be applied on top of "[PATCH] coreaudio: fix core=
audio
>> playback" by Volker R=C3=BCmelin, available at:
>> https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00114.html
>>
>> For more information, please refer to that thread.
>>
>> ---

>> +++ b/qapi/audio.json
>> @@ -276,7 +276,7 @@
>>   # Since: 4.0
>>   ##
>>   { 'enum': 'AudioFormat',
>> -  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
>> +  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
>>  =20
>>   ##
>>   # @AudiodevDriver:
>=20
> For QAPI:
> Acked-by: Markus Armbruster <armbru@redhat.com>

Is it worth a comment update mentioning that 'f32' is '(since 5.0)'?


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


