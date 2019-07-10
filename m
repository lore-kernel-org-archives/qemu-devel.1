Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FC0C73C68
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 04:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C7320645
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 04:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C7320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl3t4-0000L5-GA
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 00:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54377)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hl3ry-0008LG-Qb
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 00:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hl3rw-00048Z-JE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 00:06:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hl3ru-00045j-RS
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 00:06:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B2E3308219E;
 Wed, 10 Jul 2019 04:06:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30B845FCBA;
 Wed, 10 Jul 2019 04:06:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0B501138648; Wed, 10 Jul 2019 06:06:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
 <597ee579c3d14ff6f0892ee9e1905cdb0e0990ad.1562695780.git.DirtY.iCE.hu@gmail.com>
Date: Wed, 10 Jul 2019 06:06:07 +0200
In-Reply-To: <597ee579c3d14ff6f0892ee9e1905cdb0e0990ad.1562695780.git.DirtY.iCE.hu@gmail.com>
 (=?utf-8?B?IkvFkXbDoWfDsywgWm9sdMOhbiIncw==?= message of "Tue, 9 Jul 2019
 20:35:42 +0200")
Message-ID: <87ef2yy1n4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 10 Jul 2019 04:06:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/11] audio: basic support for multi
 backend audio
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:

> Audio functions no longer access glob_audio_state, instead they get an
> AudioState as a parameter.  This is required in order to support
> multiple backends.
>
> glob_audio_state is also gone, and replaced with a tailq so we can store
> more than one states.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com>
> ---
[...]
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index bfa5681dd2..23196da3fe 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -819,16 +819,17 @@ ETEXI
>=20=20
>      {
>          .name       =3D "wavcapture",
> -        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?",
> -        .params     =3D "path [frequency [bits [channels]]]",
> +        .args_type  =3D "path:F,freq:i?,bits:i?,nchannels:i?,audiodev:s?=
",
> +        .params     =3D "path [frequency [bits [channels [audiodev]]]]",
>          .help       =3D "capture audio to a wave file (default frequency=
=3D44100 bits=3D16 channels=3D2)",
>          .cmd        =3D hmp_wavcapture,
>      },
>  STEXI
> -@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{chann=
els}]]]
> +@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{chann=
els} [@var{audiodev}]]]]
>  @findex wavcapture
> -Capture audio into @var{filename}. Using sample rate @var{frequency}
> -bits per sample @var{bits} and number of channels @var{channels}.
> +Capture audio into @var{filename} from @var{audiodev}. Using sample rate
> +@var{frequency} bits per sample @var{bits} and number of channels
> +@var{channels}.
>=20=20
>  Defaults:
>  @itemize @minus
   @item Sample rate =3D 44100 Hz - CD quality
   @item Bits =3D 16
   @item Number of channels =3D 2 - Stereo
   @end itemize
   ETEXI

Defaults for the other optional arguments are listed here.  Why not for
@audiodev?

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9621e934c0..0111055aa4 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1978,6 +1978,11 @@ can help the device and guest to keep up and not l=
ose events in case
>  events are arriving in bulk.  Possible causes for the latter are flaky
>  network connections, or scripts for automated testing.
>=20=20
> +@item audiodev=3D@var{audiodev}
> +
> +Use the specified @var{audiodev} when the VNC client requests audio
> +transmission.
> +

What's the default?

>  @end table
>  ETEXI

