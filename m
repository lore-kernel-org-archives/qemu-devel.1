Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D1C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AE721D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEEIndql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AE721D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKyP2-0003fh-UY
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 02:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKyNx-0003Ev-W5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKyNv-0007uI-Ul
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600842970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7c4tWx9wXUnvmHhQXm5dLsewzfiAd7BFG4MOE8nPyw=;
 b=AEEIndqlCsuwR/ZN4CDBiSF6uyRLACpEgpdRe9oNEam7A0lAP7WuAkfiThT3S6SlxzPAuq
 MOoMF9zAodlTF8Yzhsd59ND6ANxnrWlF5DypFpNoRYpuEmuhw1UCJ9+ICjPsnW1mn9tPvN
 qLDQ4P6nyV/eUdDgd9yeLGvRYtNmykk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-uTkUwxhYO22WTyNPgAJVtw-1; Wed, 23 Sep 2020 02:36:07 -0400
X-MC-Unique: uTkUwxhYO22WTyNPgAJVtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F403802B46;
 Wed, 23 Sep 2020 06:36:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDB7960BF1;
 Wed, 23 Sep 2020 06:36:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 17D8416E16; Wed, 23 Sep 2020 08:36:05 +0200 (CEST)
Date: Wed, 23 Sep 2020 08:36:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH 8/9] audio: restore mixing-engine playback buffer size
Message-ID: <20200923063605.hatwdgbnvaxcgmn7@sirius.home.kraxel.org>
References: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
 <20200920171729.15861-8-vr_qemu@t-online.de>
MIME-Version: 1.0
In-Reply-To: <20200920171729.15861-8-vr_qemu@t-online.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index 21b7a0484b..cb931d0fda 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -253,6 +253,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
>          return ret;                                                     \
>      }
>  
> +SDL_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
>  SDL_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
>                   (hw, size), *size = 0, sdl_unlock)
>  SDL_WRAPPER_FUNC(put_buffer_out, size_t,

Compiling C object libcommon.fa.p/audio_sdlaudio.c.o
../../audio/sdlaudio.c:256:65: error: macro "SDL_WRAPPER_FUNC" requires 6 arguments, but only 4 given
  256 | SDL_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
      |                                                                 ^
../../audio/sdlaudio.c:243: note: macro "SDL_WRAPPER_FUNC" defined here
  243 | #define SDL_WRAPPER_FUNC(name, ret_type, args_decl, args, fail, unlock) \
      | 
../../audio/sdlaudio.c:256:17: error: expected ‘;’ before ‘static’
  256 | SDL_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
      |                 ^
      |                 ;
../../audio/sdlaudio.c:355:24: error: ‘sdl_buffer_get_free’ undeclared here (not in a function)
  355 |     .buffer_get_free = sdl_buffer_get_free,
      |                        ^~~~~~~~~~~~~~~~~~~
make: *** [Makefile.ninja:1113: libcommon.fa.p/audio_sdlaudio.c.o] Error 1

(I think coreaudio has the same problem ...).

take care,
  Gerd


