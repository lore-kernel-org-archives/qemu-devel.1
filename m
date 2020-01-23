Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B618EC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8467524683
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0NwpXVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8467524683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaPO-0006mo-LQ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuaOZ-0006LD-QP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iuaOY-0004P2-GS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:11:31 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iuaOY-0004Oc-AP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:11:30 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so2626195wro.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 03:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oGNkE299gTnpziJ0nlH0pLt/Mi+ND0EpzTQ53UR2bj8=;
 b=b0NwpXVgXRygt6xy5ioJhJO+p3158frqy44zitXbDwm0UkrMRXKALP9YILe6ppBp4g
 TX2i/TfOIS7K0wkAuRBnx96wdnrQ7V49oehuxP1R4lbUhtR+swQ9DLN5UO+R2Fm3C1yD
 5XTWqZGLD+ErXIQ9J8kO73bHke+/2kMzaPIWJzRu2NV8w8fQAoSZjdIW2EgzZUV0sR0l
 FnwwDunFlKYmWsKZRDW5XluqqFp+s1lBAxETHLwm8iyFhdu4WC9gVF+/Vp6fyPont5yE
 ZSh5/ysaHFBDdYDYsNgOHIDDmPZZObmu09ZXA893Bzq5FI3TZmfHSM3mFMAvf6BF83uY
 1NAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oGNkE299gTnpziJ0nlH0pLt/Mi+ND0EpzTQ53UR2bj8=;
 b=VZ1X5OSrX/RlFgylLtRmJJ/OVqS7EOIBQ6T6JptKJocEhRgILxJXC8PA+Y7cdwWDdi
 dM3d8Is2j08++v997Phfrb2wTgN7qjKBL6/u62EziY2jyws+1IDTaxULVTfP/9vArpsN
 oYOAfnNUX4Wp+JbRIKVnuOXpDa4AzaH8XiG+eVfhG8/1ibQ/+ZZqrRQDyHXKpapJLEBl
 Vl00NhjaXDR6icqlA7aCCYhe/WAZhXWfKSrhEtEouLMGq+SNMVNQAxHn0Mh27lPj1YBD
 y/ykKkbWVZOnOyaBeFGk+O4jjekSNruTGYK2AbxRQjCJKxMtVLMM/zmvKKjWcLaydRCs
 RBeA==
X-Gm-Message-State: APjAAAULsOFq7oLbB8VzWlPO2cD/ZjIJnQKIruag3dL6Yg1LZFvWVph/
 bTuk5mbCRLt8xM+ALQ9ZxROt6CxRQG4UB5cWpA3xpObtGmI=
X-Google-Smtp-Source: APXvYqzuA3AoiT9s0NJLxDDatxA6Pc2bwPacwZY6ne0xOtkTh6bGOhCbPonB8zDxhQ/NXLnTZrm1CKBdgUzlsFjSoy0=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr16439622wrr.32.1579777889092; 
 Thu, 23 Jan 2020 03:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20200110153039.1379601-1-marcandre.lureau@redhat.com>
 <20200110153039.1379601-20-marcandre.lureau@redhat.com>
 <5974b974-d3a9-dd1f-d226-6912d7d97365@redhat.com>
In-Reply-To: <5974b974-d3a9-dd1f-d226-6912d7d97365@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Jan 2020 15:11:16 +0400
Message-ID: <CAJ+F1C+KQsLmBVtSVANPY=bu=nLN6E1j_tEQauD4-fgEdwAP0A@mail.gmail.com>
Subject: Re: [PATCH 19/26] qdev: set properties with device_class_set_props()
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Jan 23, 2020 at 3:09 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/01/20 16:30, Marc-Andr=C3=A9 Lureau wrote:
> > The following patch will need to handle properties registration during
> > class_init time. Let's use a device_class_set_props() setter.
>
> If you don't mind, I'll also rename "props" to "props_" so that we can
> more easily catch conflicts (which will be syntax errors and not just
> bugs) in the future.

Yes, I wanted to do something like that too.
thanks


--=20
Marc-Andr=C3=A9 Lureau

