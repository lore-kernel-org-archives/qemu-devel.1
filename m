Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871BBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516C9207D0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 20:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFbhK5yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516C9207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhIzp-0003xJ-Im
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 16:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jhIz9-0003Xg-Rr
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:30:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20028
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jhIz8-0001TO-LE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 16:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591389036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9zQcO0CjlVyZWjSex/VstC2Tbc0TT8NNM/ed2fxsmo=;
 b=ZFbhK5yQ5f0Szl4w/X6fgzDj0+v4UYeffTo3tL7epGaZI296ADZ4YMBiQPykuXhKqGoB0U
 oanggqK/jeP73Ts+MDJI8MF8spH+gY1NbU93vgd1+JhBzlCCKr1/vue/f02YClUI3LXuYb
 NTTYyeRtbLnM8DUq/A50YudATzNwhT0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-oxFYL20ROMysTzpuENx2Lw-1; Fri, 05 Jun 2020 16:30:34 -0400
X-MC-Unique: oxFYL20ROMysTzpuENx2Lw-1
Received: by mail-ej1-f71.google.com with SMTP id w12so4074300ejf.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 13:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C9zQcO0CjlVyZWjSex/VstC2Tbc0TT8NNM/ed2fxsmo=;
 b=CQ8eXjpr+0BZJ9u0T63qXsc+QeXJrkI48TGqhmIlPVHY7wL9xSnsCQYIyqxcNEGto9
 okRqtoGHAzAdBzIWiKz8mny10EYbgWceQcAb4zdmzDWI+fpA19f2JmcOAkklm72RxsaZ
 Kgg3N0wGUxTDNJ1RKE29Nok6TM2n4jIS1wR8/RqRhjnHMp+AXGNLADtfkq87xzLbezXy
 R2vq1mWHSS+xowABgRR6b8BbF4amnuEfhi+0uo5mU7UNAZJ0J4mao4qCPh+z3wSouFx7
 5zXsA3YgpKhyT8JGM3uLQd6dRlPBJ1AVd0RADBaWGJ90nDCopFadl4eeg2Phj8m7WDbi
 RrIw==
X-Gm-Message-State: AOAM533HkZfpEQEV7CxowvzVrE4knmyA3t7F9V0ra7kn+9qdNTFyajGx
 k/8DFn3FxOP04UPDjNkuTft6s2ry4vSa60UNdWBxQOLEC/3c6mVRdoevZQe0YGtoJPNaz8f8Xrn
 je5nLIJX8eFTmvlQ/JqpodDsIqK1GCKs=
X-Received: by 2002:a17:906:b79a:: with SMTP id
 dt26mr10973076ejb.422.1591389033106; 
 Fri, 05 Jun 2020 13:30:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2X36LlzHbc+qtZ1d9R+l4GcJ4q5C/ZZ3XOsH32u70BT86irz1uoVaD4LfEiz8I6QNeCp5E/s22WDp0dxYB/c=
X-Received: by 2002:a17:906:b79a:: with SMTP id
 dt26mr10973044ejb.422.1591389032833; 
 Fri, 05 Jun 2020 13:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200528110444.20456-1-armbru@redhat.com>
 <87a71h36ap.fsf@dusky.pond.sub.org>
In-Reply-To: <87a71h36ap.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 5 Jun 2020 22:30:20 +0200
Message-ID: <CABgObfYW=FmJSjNqM8jLGE9011LAnMzQjthaXb41h1Zr0bOJyQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Fixes around device realization
To: Markus Armbruster <armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000000799a05a75c22bc"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000000799a05a75c22bc
Content-Type: text/plain; charset="UTF-8"

Yes please, my next pull request is already at 120 patches...

Paolo

Il ven 5 giu 2020, 17:01 Markus Armbruster <armbru@redhat.com> ha scritto:

> Needs a rebase now.
>
> Paolo, would you like me to post the pull requests for my recent QOM
> work myself?
>
>

--00000000000000799a05a75c22bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes please, my next pull request is already at 120 patche=
s...<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 5 giu 2=
020, 17:01 Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbr=
u@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Ne=
eds a rebase now.<br>
<br>
Paolo, would you like me to post the pull requests for my recent QOM<br>
work myself?<br>
<br>
</blockquote></div>

--00000000000000799a05a75c22bc--


