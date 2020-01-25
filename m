Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06239C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 11:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6737206D3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 11:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuWl8ai7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6737206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivK3o-0000Y1-0u
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 06:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ivK2h-00084y-7N
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ivK2g-0004iN-1K
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:55:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25715
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ivK2f-0004gK-Uj
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579953356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcqyU7+A1sLWVk2b4Hl5QARXDSa1Bb4LVoSjiZdzS+M=;
 b=fuWl8ai7sbUuWD8zDnlM1Zho5MuLNhZZgBMw79jxq4MkBmJUVQ54H4MVkcaqTDrCTsGR4x
 /4VNdBF21PaFXGhVR9R0UcHsq2Qob1c1Rt3JUSB5gIT5MsaOwtGZRNWaCclOGXbb/QDpMV
 VkQtyjtQAjXuYv/qDOLQDFeK/168ZVc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131--o2hY0xtOs2jC7fEc9vfNw-1; Sat, 25 Jan 2020 06:55:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id f15so2912115wrr.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 03:55:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B7wOyBscgdBjNnSTpfrOeaaL5oPRAK1sxjRnQTVg9qs=;
 b=H/GXTzkWr5upOKTx5I1uxy9MmuCVNS0eFzlK2h9oKgi/RjcSo7qBFT3+6A583tkdpf
 oHxi9zssNp84cMad/WSz8ncYBTMZszZfZPUJrb0rszgvqC1Gwz0aP/nfWuCHXoqCtqcV
 1vMwZAVvtf9bHxG+3Qn5olWLaOIGOXubjQd3EIUgggdstTTPFqURt1RrU3639qkxwagf
 b45tuXOc7Xk3anuPbnv51rp4uXcHgQ7JWxn4oFuWJAC1NLt/6QS+fbskGQFlsIxsYfsu
 1YxqyZ47kFId7JtN32riO5qGJ4OaboRR5q2i1JhXQiSBEqVWNmw5ourdKRC+Ba4Xhmas
 ZbmQ==
X-Gm-Message-State: APjAAAX3OWAfnEG+3fzKAafPKXCJ3sZxr9veg2BnTipPljMrRIhjs0VJ
 O693nG8JrXFVbZ4pGLI5PI0JxwadvDI+nPLIQ7YPg46JnprE/uSjLuj5VwXIQTcweQXLTrphy7y
 mFMtEFOiU34tG7M4=
X-Received: by 2002:adf:f501:: with SMTP id q1mr10293631wro.263.1579953351269; 
 Sat, 25 Jan 2020 03:55:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0ug7dNfgr6GyXfHjeNFkDVSbijXD7300NZDz25iEXj/LQtfaiim/Y8DRpRorPlIGU0GVALA==
X-Received: by 2002:adf:f501:: with SMTP id q1mr10293619wro.263.1579953350960; 
 Sat, 25 Jan 2020 03:55:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:784d:f09c:63f4:b9cb?
 ([2001:b07:6468:f312:784d:f09c:63f4:b9cb])
 by smtp.gmail.com with ESMTPSA id a184sm10620444wmf.29.2020.01.25.03.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2020 03:55:50 -0800 (PST)
Subject: Re: Making QEMU easier for management tools and applications
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org> <20191224134139.GD2710539@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c5f198f-9be5-8ba4-41bf-29e41b99c9c5@redhat.com>
Date: Sat, 25 Jan 2020 12:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191224134139.GD2710539@redhat.com>
Content-Language: en-US
X-MC-Unique: -o2hY0xtOs2jC7fEc9vfNw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/12/19 14:41, Daniel P. Berrang=C3=A9 wrote:
> I'm wondering if we need to think about a temporary *throwaway* fork of
> QEMU. I wasn't involved in the work, but as an outside observer I think
> it is interesting to see how the NEMU project fork ultimately led to QEMU
> moving forward with a new KConfig approach, and the integration of microv=
m.
> They had the freedom to develop these new approaches with zero regard
> to back compat or broader QEMU needs that might otherwise hold back dev.

Just a quick note: none of these were developed first in NEMU.  KConfig
was completed *for* NEMU (to make their lives easier) but the code
already existed, and microvm is inspired by Firecracker.  NEMU's main
merit in my opinion was to make QEMU's perception issues clearer, and to
cause more thought on those issues and how to approach it.

That said, I agree that a throwaway experiment on command line and
configuration is worthwhile.  The main thing to think about is to make
convenience options syntactic sugar for something else.  For example, a
couple ideas mentioned in the thread or elsewhere in hallway discussions:

- Make default devices expressible as QemuOpts, so that -writeconfig
able to write out the default devices as well and -readconfig would
imply -nodefaults.

- Reduce the scope of -drive by dropping if=3Dnone in favor of -blockdev.
 Leave -drive as a quick way of configuring frontend and backend.

- And somewhat unrelated to configuration files: generate bindings for
QMP clients from the schema.

In the meanwhile, we should deprecate -readconfig/-writeconfig.  Can't
go wrong with that.

Paolo


