Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C10C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 06:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC30222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 06:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSI1MOjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC30222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihphD-0004dd-EH
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 01:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ihpgO-00048o-Uy
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 01:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ihpgM-0003pl-HH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 01:53:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ihpgM-0003l6-4o
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 01:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576738386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxzXx+71n4empVY6KRCherhudWNv9rkASvNeiT9MKds=;
 b=dSI1MOjF55gFam0bbfeMLgwirRPnoWajuDH/PSrr88lyBxiXZdbM1uMujp72poYq09dltb
 tmFwIZgAxf/jkIKmT9GZCDaYH2Q36w+hlVRudUKucZ9+7rKFEfqnNQkNV1pTqxruPoARaj
 lIEVBim33SPJfk2Vl+S8Ta2Tqzg+bLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-M1OOxZS7ODWAYahXKaS8VA-1; Thu, 19 Dec 2019 01:53:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EFE7184BEC0;
 Thu, 19 Dec 2019 06:52:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1788D10013A1;
 Thu, 19 Dec 2019 06:52:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EAB111386A7; Thu, 19 Dec 2019 07:52:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 13/14] hw/char/terminal3270: Explicit ignored
 QEMUChrEvent in IOEventHandler
References: <20191217163808.20068-1-philmd@redhat.com>
 <20191217163808.20068-14-philmd@redhat.com>
Date: Thu, 19 Dec 2019 07:52:46 +0100
In-Reply-To: <20191217163808.20068-14-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 17 Dec 2019 17:38:07
 +0100")
Message-ID: <87sglgx0w1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: M1OOxZS7ODWAYahXKaS8VA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Paul Burton <pburton@wavecomp.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alberto Garcia <berto@igalia.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Corey Minyard <minyard@acm.org>,
 Amit Shah <amit@kernel.org>, Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The Chardev events are listed in the QEMUChrEvent enum. To be
> able to use this enum in the IOEventHandler typedef, we need to
> explicit when frontends ignore some events, to silent GCC the
> following warnings:
>
>     CC      s390x-softmmu/hw/char/terminal3270.o
>   hw/char/terminal3270.c: In function =E2=80=98chr_event=E2=80=99:
>   hw/char/terminal3270.c:156:5: error: enumeration value =E2=80=98CHR_EVE=
NT_BREAK=E2=80=99 not handled in switch [-Werror=3Dswitch]
>     156 |     switch (event) {
>         |     ^~~~~~
>   hw/char/terminal3270.c:156:5: error: enumeration value =E2=80=98CHR_EVE=
NT_MUX_IN=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   hw/char/terminal3270.c:156:5: error: enumeration value =E2=80=98CHR_EVE=
NT_MUX_OUT=E2=80=99 not handled in switch [-Werror=3Dswitch]
>   cc1: all warnings being treated as errors
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-s390x@nongnu.org
> ---
>  hw/char/terminal3270.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> index 6859c1bcb2..9e59a2d92b 100644
> --- a/hw/char/terminal3270.c
> +++ b/hw/char/terminal3270.c
> @@ -166,6 +166,9 @@ static void chr_event(void *opaque, int event)
>          sch->curr_status.scsw.dstat =3D SCSW_DSTAT_DEVICE_END;
>          css_conditional_io_interrupt(sch);
>          break;
> +    default:
> +        /* Ignore */
> +        break;
>      }
>  }

I doubt the /* Ignore */ comment is worth its keep.

Splitting PATCH 02-13 feels excessive to me.


