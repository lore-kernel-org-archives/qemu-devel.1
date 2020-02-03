Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB81C33CB2
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31AE20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HW5gv/t1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31AE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVB0-00053Z-3R
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iyV7W-0006Fp-Hp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iyV7T-0006mF-CI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:22:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iyV7T-0006ls-7v
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580710922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VkbQrF2WfUpy8+yqOcKpvTOCPv4IYCyKT4/TcAlEJP8=;
 b=HW5gv/t1dcZFtolKSWTcAXls1xLnoGKC82Ct6RlSdoxH0bjkO+inn5AIHuogFDmb2tn4K6
 TFnwkUSgqhU4Qqxg1J/hKhdOvyObBJ4nc+oDTrbhonx/D5jkqIL6U34o22ejDh2jVCqHOF
 CuQBmJDtMFXQSTK+qzNfTnS/6oqRW9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-bjF-ddPRNkik0WEqMw0v6Q-1; Mon, 03 Feb 2020 01:21:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2065D1800D41;
 Mon,  3 Feb 2020 06:21:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B9B990F47;
 Mon,  3 Feb 2020 06:21:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3F591138404; Mon,  3 Feb 2020 07:21:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Subject: Re: [RFC PATCH] audio: proper support for float samples in mixeng
References: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
Date: Mon, 03 Feb 2020 07:21:52 +0100
In-Reply-To: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
 (=?utf-8?B?IkvFkXbDoWfDsywgWm9sdMOhbiIncw==?= message of "Sun, 2 Feb 2020
 20:38:07 +0100")
Message-ID: <87h8086vi7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: bjF-ddPRNkik0WEqMw0v6Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:

> This adds proper support for float samples in mixeng by adding a new
> audio format for it.
>
> Limitations: only native endianness is supported.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
> ---
>
> This patch is meant to be applied on top of "[PATCH] coreaudio: fix corea=
udio
> playback" by Volker R=C3=BCmelin, available at:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg00114.html
>
> For more information, please refer to that thread.
>
> ---
>  qapi/audio.json        |  2 +-
>  audio/audio_int.h      |  3 +-
>  audio/audio_template.h | 41 ++++++++++++--------
>  audio/mixeng.h         |  8 ++--
>  audio/alsaaudio.c      | 17 ++++++++
>  audio/audio.c          | 56 ++++++++++++++++++---------
>  audio/coreaudio.c      |  7 +---
>  audio/mixeng.c         | 88 ++++++++++++++++++++++++++----------------
>  audio/paaudio.c        |  9 +++++
>  audio/sdlaudio.c       | 28 ++++++++++++++
>  10 files changed, 180 insertions(+), 79 deletions(-)
>
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 83312b2339..d8c507cced 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -276,7 +276,7 @@
>  # Since: 4.0
>  ##
>  { 'enum': 'AudioFormat',
> -  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
> +  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
> =20
>  ##
>  # @AudiodevDriver:

For QAPI:
Acked-by: Markus Armbruster <armbru@redhat.com>


