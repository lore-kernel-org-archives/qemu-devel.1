Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9790C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C0A22CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 13:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgTdDMRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C0A22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i19yg-0006nk-QT
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 09:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i19w3-00042c-AO
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i19vz-0001XF-Ma
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:48:58 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54793)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i19vz-0001R6-G7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 09:48:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id p74so8960357wme.4
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S6kbrEanuXFFbwxfhb/v6sGK3ToKmhxw4DL6EDmPb6U=;
 b=OgTdDMRxye10izk6N7J4T2403uD67M+DT315psHEXEMevyZrAhjjEgPoTmx7v7HdMT
 PmTYe0oqdIKdqV7FfBebNu9oOpaVsQ4SYW3hDmYaBwEIUnRWDfVcJk2FPGG/8iY7Ni6k
 gi/uOsp5NEV9RIQi/9l/esFxX4Zi0MtuVM93z/DjRKdjZHfBXzy3bYl8Eh6mDsZa2W99
 ycdabAzpYmAA/JBA4hWYu5nxHGFpLEaeAAYv8zvIfPUMqI7ABRrYRrngPiziXZoeuJvP
 eaB3RGzOLVRFyzaI8Ck99xickOICt6vlJQSQWtWwptLofqSsp0i6AM5oeDIaqfAOMN/U
 3okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S6kbrEanuXFFbwxfhb/v6sGK3ToKmhxw4DL6EDmPb6U=;
 b=VTlm7vkUehC2ep77FJxJibD8SoHSsss967W6jbiyzLOCuawL8nT7fgY0gpm2iPsCay
 IYdZ8TqpgECblO/HFLSlvlh0XbC7cTCMKLSyN1h741FaumrlncVU4Fx6H5ZIU8s0Uybf
 lx97FkFzpZxqhb4jnJVTVXeFc/bQSb/AhQhxzYl/I20uZ9xKMyQDr/ZiCPo4bsbjcyTP
 U3uMWmICiIcxFssu+jeG2vXtrEThB6uKlJVXDmQGvyjB+CyK8IImckEg4vJ2seoaSUII
 L3N2EfCYwxKNjCy0u8kwhTij0QmUxxTHLAAEcSCm1WqOnUOhro5U8pK8Jwv5BYQzFTTc
 WnsA==
X-Gm-Message-State: APjAAAVLn/DbJxlyb+ZtDWhMWbwoJbSzJpKLfOQ2FmTHcEddt4BLLLb/
 cWhY4zlk3YNv4XFecxOFEuYg8Y+l8blxIq7COcM=
X-Google-Smtp-Source: APXvYqxv6zJJ3TzYV2uUOrecuvy+LUFWCDpWVWcbmUzDT/ZIlNOjscWGWwfhrnWQIUTTh9sxgWFysaY7xFmKogDVX5o=
X-Received: by 2002:a05:600c:22c6:: with SMTP id 6mr5427856wmg.5.1566568129730; 
 Fri, 23 Aug 2019 06:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190808150325.21939-1-marcandre.lureau@redhat.com>
 <20190823112053.GE9654@redhat.com>
 <CAMxuvayoLetZkJ_HNKxC8Y0Yk33hn5pHLLn32R-XCuD7z31i=Q@mail.gmail.com>
 <20190823114157.GG9654@redhat.com> <20190823130014.GG2784@work-vm>
In-Reply-To: <20190823130014.GG2784@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Aug 2019 17:48:37 +0400
Message-ID: <CAJ+F1CKTsQC1fULFG-hbUZ=Ao654K-TE6Fm9c1V+eRdAjk9QRA@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Add dbus-vmstate
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Aug 23, 2019 at 5:00 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
>
> <snip>
>
> > This means QEMU still has to iterate over every single client
> > on the bus to identify them. If you're doing that, there's
> > no point in owning a well known service at all. Just iterate
> > over the unique bus names and look for the exported object
> > path /org/qemu/VMState
> >
>
> Not knowing anything about DBus security, I want to ask how do
> we handle security here?

First of all, we are talking about cooperative processes, and having a
specific bus for each qemu instance. So some amount of security/trust
is already assumed.

But if necessary, dbus can enforce policies on who is allowed to own a
name, or to send/receive message from. As far as I know, this is
mostly user/group policies.

But there is also SELinux checks to send_msg and acquire_svc (see
dbus-daemon(1))

>
> I want to know that the external device that's giving me migration data
> is the device I think I'm speaking to, not one of the other devices;

DBus is not the problem nor the solution here.

But what defines that device-service strong relationship? Can you
generalize it? I don't think so.

What DBus can guarantee is that the unique-id you are talking to is
always the same connection (thus the same process).

> I also dont want different devices chatting to each other over dbus
> unless we're very careful.

That's a bus policy job.

>
> Dave
>
> > Regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>


--=20
Marc-Andr=C3=A9 Lureau

