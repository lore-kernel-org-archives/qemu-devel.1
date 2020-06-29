Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F63C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61362233F6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL4adhVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61362233F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpq0t-0002Aj-Li
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jpq0E-0001dP-Fm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:23:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46176
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jpq0C-0006Is-4p
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593422578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rE1U4xzfw1CuYdULcMej8cq8YhgxIEgP1aaNEJfJXYI=;
 b=iL4adhVcLaUMOVPY+z/HbD3rsfr817VM+vraTyC1I7HWhc8mMH/w3uazfR/yW05uS7xWKY
 DqHTzv/qTHoroEviWcejV8GI5B8r54b2idceXc7uIjxj6P3Nf4pa44wQS4Uthv5jzmRQQK
 qZwQv/+OkkAHLtC0Uj0TC1wGVWE6d5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-AGqRwZOYPUmiAmAiRGUb2g-1; Mon, 29 Jun 2020 05:22:54 -0400
X-MC-Unique: AGqRwZOYPUmiAmAiRGUb2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5DC6107B7CE;
 Mon, 29 Jun 2020 09:22:52 +0000 (UTC)
Received: from titinator (ovpn-114-115.ams2.redhat.com [10.36.114.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 099FB5D9E7;
 Mon, 29 Jun 2020 09:22:41 +0000 (UTC)
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-5-dinechin@redhat.com>
 <20200626172003.GL1028934@redhat.com>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 04/10] spice: Move all the spice-related code in
 spice-app.so
In-reply-to: <20200626172003.GL1028934@redhat.com>
Date: Mon, 29 Jun 2020 11:22:40 +0200
Message-ID: <lywo3qcjkv.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:37:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-06-26 at 19:20 CEST, Daniel P. Berrang=C3=A9 wrote...
> On Fri, Jun 26, 2020 at 06:43:01PM +0200, Christophe de Dinechin wrote:
>> If we want to build spice as a separately loadable module, we need to
>> put all the spice code in one loadable module, because the build
>> system does not know how to deal with dependencies yet.
>>
>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>> ---
>>  audio/Makefile.objs   | 2 +-
>>  chardev/Makefile.objs | 3 +--
>>  ui/Makefile.objs      | 8 ++++----
>>  3 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/audio/Makefile.objs b/audio/Makefile.objs
>> index b4a4c11f31..298c895ff5 100644
>> --- a/audio/Makefile.objs
>> +++ b/audio/Makefile.objs
>> @@ -1,5 +1,5 @@
>>  common-obj-y =3D audio.o audio_legacy.o noaudio.o wavaudio.o mixeng.o
>> -common-obj-$(CONFIG_SPICE) +=3D spiceaudio.o
>> +spice-app.mo-objs +=3D ../audio/spiceaudio.o
>
> Explicitly showing paths in the variables doesn't look right. The
> make recipes are supposed to automatically expand bare file names
> to add the right path. This is usually dealt with by a call to
> the "unnest-vars" function.

I agree. I mentioned this in the cover letter:

> - Adding various non-UI files into spice-app.so, which required a
>   couple of ../pwd/foo.o references in the makefile. Not very nice,
>   but I did not want to spend too much time fixing the makefiles.

I did not find an elegant way to integrate a non-UI file into a .mo that is
declared in the ui section.

I considered various solutions:

a) Having separate load modules for different source directories.
   This exposes details of the build system into the generated libs.

b) Moving the source
   This breaks the logical organization of the sources

c) Manually managing this specific .o one level up
   This seems even harder to read / understand

So I thought I would dedicate a bit more time to add that capability to the
unnest-vars function. I did not want to defer review for that, and vaguely
hoped that there was an existing correct way to do it that someone more
experienced in the build system could point me to.

>
>>  common-obj-$(CONFIG_AUDIO_COREAUDIO) +=3D coreaudio.o
>>  common-obj-$(CONFIG_AUDIO_DSOUND) +=3D dsoundaudio.o
>>  common-obj-$(CONFIG_AUDIO_WIN_INT) +=3D audio_win_int.o
>> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
>> index fc9910d4f2..955fac0cf9 100644
>> --- a/chardev/Makefile.objs
>> +++ b/chardev/Makefile.objs
>> @@ -22,5 +22,4 @@ common-obj-$(CONFIG_BRLAPI) +=3D baum.o
>>  baum.o-cflags :=3D $(SDL_CFLAGS)
>>  baum.o-libs :=3D $(BRLAPI_LIBS)
>>
>> -common-obj-$(CONFIG_SPICE) +=3D spice.mo
>> -spice.mo-objs :=3D spice.o
>> +spice-app.mo-objs +=3D ../chardev/spice.o
>> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
>> index 504b196479..1ab515e23d 100644
>> --- a/ui/Makefile.objs
>> +++ b/ui/Makefile.objs
>> @@ -11,7 +11,6 @@ common-obj-y +=3D keymaps.o console.o cursor.o qemu-pi=
xman.o
>>  common-obj-y +=3D input.o input-keymap.o input-legacy.o kbd-state.o
>>  common-obj-y +=3D input-barrier.o
>>  common-obj-$(CONFIG_LINUX) +=3D input-linux.o
>> -common-obj-$(CONFIG_SPICE) +=3D spice-core.o spice-input.o spice-displa=
y.o
>>  common-obj-$(CONFIG_COCOA) +=3D cocoa.o
>>  common-obj-$(CONFIG_VNC) +=3D $(vnc-obj-y)
>>  common-obj-$(call lnot,$(CONFIG_VNC)) +=3D vnc-stubs.o
>> @@ -53,10 +52,11 @@ curses.mo-objs :=3D curses.o
>>  curses.mo-cflags :=3D $(CURSES_CFLAGS) $(ICONV_CFLAGS)
>>  curses.mo-libs :=3D $(CURSES_LIBS) $(ICONV_LIBS)
>>
>> -ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),yy)
>> -common-obj-$(if $(CONFIG_MODULES),m,y) +=3D spice-app.mo
>> +common-obj-$(CONFIG_SPICE) +=3D spice-app.mo
>> +spice-app.mo-objs +=3D spice-core.o spice-input.o spice-display.o
>> +ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),ym)
>> +spice-app.mo-objs +=3D spice-app.o
>>  endif
>> -spice-app.mo-objs :=3D spice-app.o
>>  spice-app.mo-cflags :=3D $(GIO_CFLAGS)
>>  spice-app.mo-libs :=3D $(GIO_LIBS)
>>
>> --
>> 2.26.2
>>
>>
>
> Regards,
> Daniel


--
Cheers,
Christophe de Dinechin (IRC c3d)


