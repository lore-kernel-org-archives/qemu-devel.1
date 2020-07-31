Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65222C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325EA2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnuKwkWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325EA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YfH-0004QM-Fl
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1YeW-0003rY-Uz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:17:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1YeV-0006RN-FN
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596215822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kiqETnZBgwF8ZXt1oN3YbOE0gdSwFqJGoixzTRdVNU4=;
 b=PnuKwkWBf07tGxHbV0xuJ2byPzdbn8A1PpfdI8g/8ZoH36FliklPuCMXuwrNeMLI3KOBwT
 dCYUHkJWkxrXJnLI7qA3OOxMAmH+SdgeDLad1cskNHO4xD4sneC7Y23GaaCNDoySh76kdB
 BdklwpMh7O3LYALhnvSHU8EWuopor8o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-ODSo1Tv9Mlmq_6_y9XLD3Q-1; Fri, 31 Jul 2020 13:17:00 -0400
X-MC-Unique: ODSo1Tv9Mlmq_6_y9XLD3Q-1
Received: by mail-wm1-f70.google.com with SMTP id z1so1613770wmf.9
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kiqETnZBgwF8ZXt1oN3YbOE0gdSwFqJGoixzTRdVNU4=;
 b=MiKT2mDJfvlFikRHnh0JgSgMPar29IC4QtB4rjvYePXi3jDIfRbXH1nmiUOVVyVP2Y
 wgtBTZG6cwD14ihiPxdcnihTOpIY580ICPMmiAlwesV+2Rg0tI/TE3iLuu82mBZ3d4Cp
 XGVyO4b+ptAnZfeEFRugM/yKeWZdZyZSnA1zjkoFTyBfXXfFT37smk4hwG+TTrjRqv20
 Ex8lLFtFS4rg8MkTbBerwqNLRboMF4+u9mP5Tb4L8mUQQUNNU9/4Utvl89Orw0NIQPpc
 xnQPRcsNX9I0e1S8yf2O63HWiEZq7roqTl3lzidR0FMerOtMh5N2B3lJuipoEVLzNm4u
 qf5w==
X-Gm-Message-State: AOAM531vlckNu5m4mn8sSZOYYJKEnOz2QkImPehMbvlzr9cpq8oxXJAh
 vam/ibpH2GCsQNJsWqUHgfJmZ9Yr8+/jrTO6lwflufIaS0JaoQdQjcMqxOsDM+AujfKI9JNH15w
 Pyir97MPLGPSWwlo=
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr4801183wmi.34.1596215816276; 
 Fri, 31 Jul 2020 10:16:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8VW1HlRKI55lwvsrgndBoNgHhz+4avXeKmUS/JvN7nzZWCDAE6cCYA+hDd4PhNcXLoKx4OQ==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr4801154wmi.34.1596215815963; 
 Fri, 31 Jul 2020 10:16:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445?
 ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
 by smtp.gmail.com with ESMTPSA id h10sm12873207wro.57.2020.07.31.10.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:16:55 -0700 (PDT)
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <20200731170500.GF3660103@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2ad1dd6-d53e-b4fa-79e2-0006ddf2f5b2@redhat.com>
Date: Fri, 31 Jul 2020 19:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200731170500.GF3660103@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 08:55:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/20 19:05, Daniel P. Berrangé wrote:
> NB our files are not JSON documents, they are a concatenation of a list
> of JSON documents. 

This is not something that editors generally have problems with.

> If you use javascript mode, then emacs will highlight all the javascript
> language keywords in the comments because it doesn't recognise "#" as a
> comment - you need // or /* .. */ for comments in JavaScript

Oops, good point.  So yeah, using // comments and double quotes would
fix editor problems and be much more kind to downstreams.

> I'd also suggest replacing  fprintf/printf/sprintf with the g*printf*
> equivalents. The benefit here is that GLib guarantees that its variants
> work the same way on Windows as on Linux. They pulled in the GNULIB
> printf impl to replace Microsoft's broken impl.

That should not be an issue to replace.  Most of our printf uses anyway
are wrapped within error_report, or they are g_strdup_printf which we're
already preferring to the messy libc asprintf for obvious reasons.

> There's various silly little things like ARRAY_SIZE vs G_N_ELEMENTS,
> and __attribute__ macros - QEMU_NORETURN vs G_GNUC_NORETURN.
> QEMU_BUILD_BUG_ON vs G_STATIC_ASSERT
> There's util/buffer.{c.h} that can be replaced by GString or GArray.

Some of these are no brainers too.  QEMU_BUILD_BUG_ON reverses the
logic; I'm not sure if Coccinelle can do De Morgan laws.

>>> Another example would be adopting a standard code style and using a
>>> tool like clang-format to enforce this for entire of existing code
>>> base and future contributions and throwing away our checkpatch.pl
>>> which nearly everyone is scared of touching as it is Perl code.
>> Checkpatch does much more than that, though the scary part is indeed the 
>> one that enfoces coding style.  I wouldn't have a problem with using
>> clang-format and calling it a day.
> If there are things missing that we consider important, a long term
> better strategy would be to use the Python binding to libclang to
> detect the problem, instead of trying to parse C code with Perl and
> regexes.

Most of it is simply "use this function instead of this one" or "place a
comment to explain why you're using this".  The main feature of
checkpatch.pl however is that it works on patches, not just files, but
still there would be a substantial advantage in employing clang-format.

Paolo


