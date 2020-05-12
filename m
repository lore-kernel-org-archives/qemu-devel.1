Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1882C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F72F20675
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAwZZocU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F72F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYT9l-0003B7-Rt
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 07:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYT8O-0001uA-UH
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:31:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54146
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jYT8N-0006Wo-Mf
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589283098;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZvqedTZhNNAKEGXZG7S5y3PLtzRcCQfngA3fpfPJeLA=;
 b=OAwZZocUFBOBt8KP4uhOkk5t1UmN4iFT9AA7foeF0oQWQinQITq5pu1z987cYJjQAinApn
 f552MtH7IJ1Jy/9XnuIss4PBlOEiIOmnlGMutxciIXbXxRBX3jtbeue1zwhEtF536wTQJx
 Y4tLj/keFya4gKiptfAASemLO1u45eI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-ZVc5CzurNfmBKcjRau2pfA-1; Tue, 12 May 2020 07:31:36 -0400
X-MC-Unique: ZVc5CzurNfmBKcjRau2pfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FFB51B18BC2;
 Tue, 12 May 2020 11:31:35 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 787271C9;
 Tue, 12 May 2020 11:31:30 +0000 (UTC)
Date: Tue, 12 May 2020 12:31:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH 10/10] ui/gtk: use native keyboard scancodes on Windows
Message-ID: <20200512113127.GP1191162@redhat.com>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
 <20200510184304.9267-10-vr_qemu@t-online.de>
MIME-Version: 1.0
In-Reply-To: <20200510184304.9267-10-vr_qemu@t-online.de>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 10, 2020 at 08:43:04PM +0200, Volker Rümelin wrote:
> Since GTK 3.22 the function gdk_event_get_scancode() is
> available. On Windows this function returns keyboard scancodes
> and some extended flags. These raw keyboard scancodes are much
> better suited for this use case than the half-cooked win32
> virtual-key codes because scancodes report the key position on
> the keyboard and the positions are independent of national
> language settings.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>  ui/gtk.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index a43fddc57f..242b378bf1 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1016,8 +1016,13 @@ static const guint16 *gd_get_keymap(size_t *maplen)
>  #ifdef GDK_WINDOWING_WIN32
>      if (GDK_IS_WIN32_DISPLAY(dpy)) {
>          trace_gd_keymap_windowing("win32");
> +#if GTK_CHECK_VERSION(3, 22, 0)
> +        *maplen = qemu_input_map_atset1_to_qcode_len;
> +        return qemu_input_map_atset1_to_qcode;
> +#else
>          *maplen = qemu_input_map_win32_to_qcode_len;
>          return qemu_input_map_win32_to_qcode;
> +#endif

Our current min GTK is 3.14, which I picked here:

commit 58296cb61866195297510e946a51acc5f0b9639e
Author: Daniel P. Berrangé <berrange@redhat.com>
Date:   Wed Aug 22 14:15:53 2018 +0100

    ui: increase min required GTK3 version to 3.14.0
    
    Per supported platforms doc[1], the various min GTK3 on relevant distros is:
    
      RHEL-7.0: 3.8.8
      RHEL-7.2: 3.14.13
      RHEL-7.4: 3.22.10
      RHEL-7.5: 3.22.26
      Debian (Stretch): 3.22.11
      Debian (Jessie): 3.14.5
      OpenBSD (Ports): 3.22.30
      FreeBSD (Ports): 3.22.29
      OpenSUSE Leap 15: 3.22.30
      SLE12-SP2: Unknown
      Ubuntu (Xenial): 3.18.9
      macOS (Homebrew): 3.22.30
    
    This suggests that a minimum GTK3 of 3.14.0 is a reasonable target,
    as users are unlikely to be stuck on RHEL-7.0/7.1 still
    


since that time, we no longer support Debian Jessie, since Debian Buster
is now released. We also no longer support Ubuntu Xenial (16.04), since
we now only need Ubuntu Bionic (18.04) and Focal (20.04).

So we can justify moving the minium Gtk in QEMU to 3.22 at this time.

This will avoid you needing to do versioned ifdef for this new functionality.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


