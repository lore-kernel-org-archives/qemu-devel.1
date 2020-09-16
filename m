Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B9CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772442080C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf/QV71r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772442080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIThn-00088G-MG
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kITh4-0007GD-K4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:25:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53002
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kITh3-0004zj-3L
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600248336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deJR2OulOdJMzqPuYxgrD8JNJ/Pt6BjCahT4qBzxV1g=;
 b=Nf/QV71ri1ppH8peuj5FyLAhYenJ+Kc9XvjLsPXkJ/C/8Itl9/L2MPXo1fVg6D6XZVPTPt
 7p2TbCT3SIFfW2aNuHvDRHMtrtvLG3jVQSGSKbj0FdnUcMBudCsBQMXse/j+GIOD84lM6M
 7zoDwNep24Cd+T/QhEJUmqvrczmh4X8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-u-3Cp5AnPF6s2vtvZ-sWjA-1; Wed, 16 Sep 2020 05:25:34 -0400
X-MC-Unique: u-3Cp5AnPF6s2vtvZ-sWjA-1
Received: by mail-wr1-f69.google.com with SMTP id f18so2300512wrv.19
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 02:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=deJR2OulOdJMzqPuYxgrD8JNJ/Pt6BjCahT4qBzxV1g=;
 b=d5FrXssvNr/LrXe438QLl+Pj6xdV3hAloPwCmwtOqD5fjvnejGwxUpzHs5bUzg5+N8
 SJnOth7zSjWQK5JyBrHgfV5FAKLMJ3FAvcHN3KbrNIvHeKNP/e1Gfdvw8+q2d+s6HGsD
 FG4dbc5YW6u5J80wyX6dOKjuuIK/AdWvLBINlpqoPB1RPuerhfJ9z/DJoQVg8Lzl3JG3
 s/CgkhEoWxDRRrSwfYpFMH/Dny3YOHUe1Typ4qBF1dxaa50Yjkuy0V10jtK20kWqAJXW
 e/gMshJYnUCjNBXBnBrulokWVsfoP80JZKV35I0iSTZh0suDsPvynZCLuUsxXt/ehoEB
 PNCA==
X-Gm-Message-State: AOAM532h75xnqYC8RtizeT8bG/uo8ZCN2VlzR8PBeCGn0exS6+5CV1yy
 cEraiKsevRUzZ5RdQTPsVtPMeTYvLKEUX1g9lCunrJumfUdHR0ccBH2zGndkX5vL1Swtit8vXCb
 Suk7AWcMvpne0INk=
X-Received: by 2002:a5d:6b84:: with SMTP id n4mr27568545wrx.55.1600248332908; 
 Wed, 16 Sep 2020 02:25:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRTK9NQ5J97ynApqCVUkm9UQqNpdIlEDZHOPvUmlMgm1zNdj+OnOUDQ+vZYDrOOKUYMDRwaw==
X-Received: by 2002:a5d:6b84:: with SMTP id n4mr27568532wrx.55.1600248332705; 
 Wed, 16 Sep 2020 02:25:32 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id v128sm4256521wme.2.2020.09.16.02.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 02:25:32 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] spice: simplify chardev setup
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200916083913.11902-1-kraxel@redhat.com>
 <20200916083913.11902-2-kraxel@redhat.com>
 <20200916090629.GH1535709@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5855bf1c-c705-12f2-47bf-12b76ee665ea@redhat.com>
Date: Wed, 16 Sep 2020 11:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916090629.GH1535709@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/20 11:06, Daniel P. Berrangé wrote:
>> +    /* spice must initialize before chardevs (for spicevmc and spiceport) */
>> +    qemu_spice_init();
>> +
> I don't think we should be putting this before the '-object' processing too.
> We really want -object to be the first thing processed in general.
> 

What about making qemu_spice_init() idempotent (i.e. "static bool false
= true; if (!first) return; first = false;") and calling it from the
spicevmc and spiceport creation function?

Paolo


