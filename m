Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A7DC3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100CB2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 06:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haCcZ+f0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100CB2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iys1w-0001C9-7N
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 01:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iys0W-00005l-Pi
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iys0U-0005ff-Ej
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:48:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iys0U-0005bK-6z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 01:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580798900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ci32bZ6SY0qK/mb1H6b9S3QjNI2G5Jse0u5fyJOWQyQ=;
 b=haCcZ+f0+vBx1Bxtn3ryckT9Uv6TwK6DG62em5qK36S8/45Xh5tvGglTp1zSZ2fIaEjBk+
 M5C0OhbnPaMTmO5uaUfGOp/l5ZdHFWXwTORZ/rfxKH+zrsQ56vfSYu1HPd7nylzbjQuubK
 WWqHcNCQ2SotoHJ+hefJVD20/9t4rA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Dontyme2NqqWUCjx88OObA-1; Tue, 04 Feb 2020 01:48:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B8BF107BA9C;
 Tue,  4 Feb 2020 06:48:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4CEF87B1D;
 Tue,  4 Feb 2020 06:48:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 470EA11386A7; Tue,  4 Feb 2020 07:48:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH] audio: proper support for float samples in mixeng
References: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
 <87h8086vi7.fsf@dusky.pond.sub.org>
 <d91dcd9f-4f6a-f2b1-bb3a-3be9966b247c@redhat.com>
Date: Tue, 04 Feb 2020 07:48:12 +0100
In-Reply-To: <d91dcd9f-4f6a-f2b1-bb3a-3be9966b247c@redhat.com> (Eric Blake's
 message of "Mon, 3 Feb 2020 09:34:07 -0600")
Message-ID: <8736bqdf0z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Dontyme2NqqWUCjx88OObA-1
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 2/3/20 12:21 AM, Markus Armbruster wrote:
>> "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:
>>
>>> This adds proper support for float samples in mixeng by adding a new
>>> audio format for it.
>>>
>>> Limitations: only native endianness is supported.
>>>
>>> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
>>> ---
>>>
>>> This patch is meant to be applied on top of "[PATCH] coreaudio: fix cor=
eaudio
>>> playback" by Volker R=C3=BCmelin, available at:
>>> https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00114.html
>>>
>>> For more information, please refer to that thread.
>>>
>>> ---
>
>>> +++ b/qapi/audio.json
>>> @@ -276,7 +276,7 @@
>>>   # Since: 4.0
>>>   ##
>>>   { 'enum': 'AudioFormat',
>>> -  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
>>> +  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
>>>     ##
>>>   # @AudiodevDriver:
>>
>> For QAPI:
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>
> Is it worth a comment update mentioning that 'f32' is '(since 5.0)'?

Good point; we routinely do that.

Should look like this:

##
# @AudioFormat:
#
# An enumeration of possible audio formats.
#
# @u8: lorem
# @s8: ipsum
# @u16: dolor
# @s16: sit
# @u32: amet
# @s32: consectetur
# @f32: adipisici (since 5.0)
#
# Since: 4.0
##

The generator does not enforce documentation of enum values.


