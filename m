Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F23C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA57620720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlJPKDNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA57620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0452-00061I-6E
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j044T-0005c7-29
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j044R-0003Iz-Od
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:53:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44127
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j044R-00038W-KX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581083602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltG/tgu7nTgq0ZlJP1NTgnWtcz5r7zKZswvDuleFYLg=;
 b=hlJPKDNS728iRcS0iaCtdRZlPyJcUkGdopGN8kQJEY8oh2UCz7MRLD5O5z7i1t8gssAtZ5
 uShDf2oCHrefy/WUJaGLJQmwcVwqQBYPVvT8BDqIdhkxGll8gCvcms/Nnb9zmJSrg3TpVF
 zgX00qKAwKciwgR/R49JegGTB8LvopA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-CEmrWM-4OkuUyizKuVHSNA-1; Fri, 07 Feb 2020 08:53:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4577192296C;
 Fri,  7 Feb 2020 13:53:14 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C13D65C299;
 Fri,  7 Feb 2020 13:53:11 +0000 (UTC)
Subject: Re: [PULL 12/12] audio: proper support for float samples in mixeng
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200207074557.26073-1-kraxel@redhat.com>
 <20200207074557.26073-13-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5171ac59-23fe-e2ef-8300-e921b5d71e29@redhat.com>
Date: Fri, 7 Feb 2020 07:53:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207074557.26073-13-kraxel@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: CEmrWM-4OkuUyizKuVHSNA-1
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 1:45 AM, Gerd Hoffmann wrote:
> From: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
>=20
> This adds proper support for float samples in mixeng by adding a new
> audio format for it.
>=20
> Limitations: only native endianness is supported.  None of the virtual
> sound cards support float samples (it looks like most of them only
> support 8 and 16 bit, only hda supports 32 bit), it is only used for the
> audio backends (i.e. host side).
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com=
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Message-id: 8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY=
.iCE.hu@gmail.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

> +++ b/qapi/audio.json
> @@ -276,7 +276,7 @@
>   # Since: 4.0
>   ##
>   { 'enum': 'AudioFormat',
> -  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32' ] }
> +  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }

Review suggested that this should add documentation including a since=20
tag; that would now need to be a separate patch (unless this pull=20
request is resun for other reasons)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


