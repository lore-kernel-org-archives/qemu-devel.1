Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ABAC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19E2206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtOIj8kG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19E2206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuXn-0006JR-4j
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVuX9-0005q9-GX
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:10:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jVuX8-0001vE-E8
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588673437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPfmZyFKAsiBDybdnzXwf2PCSi/x69ikq150mG0nDgU=;
 b=JtOIj8kG0pTCDF05wOmtHH3VGB4uZPm/fuFiiUSVGFVge+6VkJGj5yy+eYlRcV6hDOS69Y
 q4+79jw/JUdH863bPSreoSHIBlPGWsUChRn5L95GZOBNyHI1SYYhTQGam9OP6iFHuWgns4
 2kM7T1cJ7XHGuZOy1oM2kezvfbHJqds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-ptFzm4_SOJODxWfrPKk7Iw-1; Tue, 05 May 2020 06:10:35 -0400
X-MC-Unique: ptFzm4_SOJODxWfrPKk7Iw-1
Received: by mail-wr1-f70.google.com with SMTP id g10so976972wrr.10
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=klk+WPmzEH2Guopiw/wocH/h2D5fe1l++84CJnbrd14=;
 b=Ah3YzK9HXKwe6FzyKWK/Ijkw1E62ruoO0O0oS1L2xpggp2LdcNWjGppF3mKMQDw0Ju
 IolXhVCeHgL2Pfv5iAAAO0VxR6UhP5SVVkwzCKj+5i8X6r/4K9ejWSLF9WjGBSRw6h41
 mo9U6X0w0Jee7ZKfVMXUzAo4OqgQgMX2KORiEdB9R2qo9fr6uel88oCRgCFkwuR2jbj+
 vHCjYQkMEbzgIcI4M8BWpIZ9y0EiC70xGo8qJtBU92+C+/4eMGbh2d7Omqzd5xQ0nt3g
 vaskjk932LcZf2r8POek3ws4sjVReeT4gXT9uFjrS8zCa8uzj8UhWjAgPPZLbdMm5A+E
 VKvw==
X-Gm-Message-State: AGi0Pub1cGTDaUmQVhpsr69/FXgyUT5QoFgNnOcNz/yQp56lxwO6amnX
 QYMGIvvxusT8oFwdEUkYxf52jM4GVZdgl0Tov7KCDIwvCh0lbjGTtpuVY0DqbmIVZBllPk98UbW
 4i54Otc/l3itBlgA=
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr2656194wma.66.1588673434479; 
 Tue, 05 May 2020 03:10:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypLViQN4o7cHcbqs4513AXldJMMqn8+Vd4nJqKrub7HrFmiZaKMq+0ZHPA626P2cQnmVkBXTNA==
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr2656179wma.66.1588673434308; 
 Tue, 05 May 2020 03:10:34 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
 by smtp.gmail.com with ESMTPSA id h1sm3098045wme.42.2020.05.05.03.10.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 03:10:33 -0700 (PDT)
Subject: Re: [PATCH] hw/audio/gus: Use AUDIO_HOST_ENDIANNESS definition from
 'audio/audio.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200505100750.27332-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc9f6295-9c1a-9617-ecd9-f38ea0ad5d79@redhat.com>
Date: Tue, 5 May 2020 12:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505100750.27332-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/20 12:07, Philippe Mathieu-Daud=C3=A9 wrote:
> Use the generic AUDIO_HOST_ENDIANNESS definition instead
> of a custom one.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Who/what machine is using this device anyway?

PC, like all old ISA audio cards.

Paolo


