Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4FCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C19220878
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqwDGjBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C19220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblt1-00038j-CR
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbls3-0001Vi-2n
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:08:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48197
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbls1-0003sm-Ql
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590070105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKWjrt2gKwqOfzXY53OCn0UTfwTURwpA1+T5hWQRkVw=;
 b=UqwDGjBqIuk+uQ0iBS6nGm0qIQo0Vzddo2jBinv/Yqr1TBY9XnBWvDKLy/BCi+OgUZ6ppr
 5L44pkP6KzxuSXVUHTHzFZ3+HUetwJ+rkylQtxfpzYMubShq7gW3nRVR9vKL8+a0KCUQQA
 hZ3dEeQm3Q+wvbX1w41fUdmQvri+gIk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-kXbPzGSGM7ixzJ-QJ_YmAg-1; Thu, 21 May 2020 10:08:18 -0400
X-MC-Unique: kXbPzGSGM7ixzJ-QJ_YmAg-1
Received: by mail-wm1-f72.google.com with SMTP id f62so2747205wme.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PKWjrt2gKwqOfzXY53OCn0UTfwTURwpA1+T5hWQRkVw=;
 b=LXVo2cXl8NjC68a3wn/uSNtziAWlBo95baTqvR7cxzwegtKKlo1Gc79zBuAG09TXOy
 bjYDEOQ4wPJ9lIV5srAzroySLf2FbnBdWnrJsZ+vHQsysr+d1rXM2SWB2Xp5awgAJ0Ck
 p3f65kag99DLwkK4+Wapk4xeGU8no/KyO9qBmgN6WT5ftbHTlgKn4fACjEeO1dtpWWK6
 l5Z2limLcPTNPOa5FQRD20c+oFjM2L5Ejf9ytIFjFsrS9idfa40L3R6nE2eBUC27pJqQ
 2o7kuYaKiOXapw+3glY6/B7UAer9+6e4KCTtbulNHZyC0seAsUZFz2+ljiVW2kD8NswA
 1yMQ==
X-Gm-Message-State: AOAM531Ue/gQXAo0q4E7H7lupAUvcgsUdggMEY7WwsZRhScWowrrr1kx
 eL1I17NGlfDUtQcNUQXcvySKM8XBoh8UtHA4RKwNmnVC1lf2i7MqWovJzZ3IPE49cegOfh7dZZ4
 lx+V/mIsaBHmyhNQ=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr8986906wrn.96.1590070096757;
 Thu, 21 May 2020 07:08:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ8nkFwFKTQyDLmXZ5tCgKTguZzs182CYtSYp/K972pVOTc+JY7TK7teC5sck97dTut4yj3Q==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr8986890wrn.96.1590070096526;
 Thu, 21 May 2020 07:08:16 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id h74sm6754859wrh.76.2020.05.21.07.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:08:15 -0700 (PDT)
Subject: Re: [PATCH v2 11/13] audio: deprecate -soundhw pcspk
To: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200515143528.13591-1-kraxel@redhat.com>
 <20200515143528.13591-12-kraxel@redhat.com> <20200515150823.GA738369@lpt>
 <20200518101628.3j4d6hwq6pitjfo3@sirius.home.kraxel.org>
 <20200518102650.GG1430944@redhat.com>
 <20200518112448.7lwjol4elj4d76bq@sirius.home.kraxel.org>
 <20200518125935.zwrpaqwh7dwd3p4p@sirius.home.kraxel.org>
 <87mu659ydh.fsf@dusky.pond.sub.org>
 <20200518132745.yo2k67yau2nzhl54@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b0b8808b-9131-7cd0-a541-49ec0e364c2a@redhat.com>
Date: Thu, 21 May 2020 16:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200518132745.yo2k67yau2nzhl54@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: libvir-list@redhat.com, =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/05/20 15:27, Gerd Hoffmann wrote:
> Ah, cool, that shows that I'm on the right path with my idea ;)
> Sneak preview:
> 	https://git.kraxel.org/cgit/qemu/log/?h=sirius/soundhw
> 
> Suggestions for a good name?  I've used "pc.pcspk" for now,
> but maybe "pc.audiodev0" or "pc.sound0" is better?

Something like "-M pc,pcspk-audiodev=..."?

Paolo


