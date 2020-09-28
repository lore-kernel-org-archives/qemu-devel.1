Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0100C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B526208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+FV5txx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B526208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwCy-0002Yo-Tj
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 12:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMwAF-0001SK-Ro
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMwAD-0000ly-GT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:38:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601311087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ml8vbI92FRArOHvMxYXzd5Z76+Qd1GqFUhSqX8jG3uA=;
 b=e+FV5txxulcnNR/v8zwLWbQWG1L0ajCQ4Oey6clQVp1ZBBSGk9FYFG2HW7wGOAJKWdWzfW
 slYBVxn8sy/kNTGthS6vQz5Htm9FvbXqwKLAaFUisOXKtimLFHtLAThVWQmLYEVN3Z9R1E
 0KgtwxTpKHubXIH8Sp+OxJfu1KTO3Dg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-LcaYqeDIPyiW0BuMUfquwQ-1; Mon, 28 Sep 2020 12:38:04 -0400
X-MC-Unique: LcaYqeDIPyiW0BuMUfquwQ-1
Received: by mail-wr1-f71.google.com with SMTP id a2so624360wrp.8
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 09:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ml8vbI92FRArOHvMxYXzd5Z76+Qd1GqFUhSqX8jG3uA=;
 b=q+J4EThELumCpQ8uhRdlDhvEzY8M1DhXd4AfB2Daj7YKCzWzIwnxbqhCThtNiqZOQ2
 vmejHy95ytYnfhUKtepTD5z8ND8d6QW7snQQI6v6L1X9lYjgqfdmtUUw8SO90DYVD1IZ
 xIRI0sABen0Y/gpzBB/Xl12O8wOZG197OQcI5TLYlvpX1eMB5C3eALuERpLYhPb/lTwk
 cp6VeZSPda7WXPs1BO7yUN9V8THPTALR2JChp82xWXcg9XB1oIshY3zXz3YNl5WewbWf
 r3FCJ7rEOUikJDw2gHzptzWYzT77kd0h/ZOirzGcUiJovFMluJuaDmvKculyY/LuWSqk
 siFg==
X-Gm-Message-State: AOAM530s66Y5trDlLw8mvwn/3MumaIet8uXexq3UfAUcbxoNyaTAQQUD
 yMxE0fEaKDhGuBW0qmEQpSyagvmdiMapYrfMFik7kT+NL9DuyKIcCU+DVWwVKfAkR6YNGWXUzNv
 j9sS2RI+TJxS6S7Y=
X-Received: by 2002:a1c:f009:: with SMTP id a9mr58880wmb.158.1601311083162;
 Mon, 28 Sep 2020 09:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpIWlRBdZbId5iv4CsF98x3F+9y3GOm8ftCMoArlvr8Of4cFqbTqPNZl813WQ4d0mk2NCb4Q==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr58861wmb.158.1601311082925;
 Mon, 28 Sep 2020 09:38:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4f8:dc3e:26e3:38c7?
 ([2001:b07:6468:f312:f4f8:dc3e:26e3:38c7])
 by smtp.gmail.com with ESMTPSA id z67sm338778wme.41.2020.09.28.09.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 09:38:02 -0700 (PDT)
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <3365834.oEZqtqHOuS@silver> <95ef57d0-b35e-f16a-f957-06bc3692cb7c@redhat.com>
 <9648157.mzsJ5Dm3EP@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0cafb215-e49e-902c-4794-bdb696a892d6@redhat.com>
Date: Mon, 28 Sep 2020 18:38:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9648157.mzsJ5Dm3EP@silver>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/09/20 15:35, Christian Schoenebeck wrote:
>> As I said, the first two patches make total sense.  They would be useful
>> for testing both packed and split virtqueues, for example.  However, I
>> think the (useful) feature is being misused here.
> 
> I haven't understood why my suggested mult-device use case imposes a misusage, 
> but okay, unless I hear different opinions, I'll prepare a v2 with that (IMO 
> hackish) CL fiddling instead in couple days or so.

Because in my opinion the backend in use is a property of the test
rather than a property of the device.

> @Greg: If that's the way to go, then I probably change the test names, e.g.
> 
> 	"fs/version/basic" -> "synth/version/basic"
> 	...
> 	"fs/create_dir" -> "local/create_dir"
> 
> to be able to easily distinguish 'synth' driver tests from 'local' driver 
> tests, as they would then popup with the same device name in v2, unlike in 
> this v1 where they have separate device names.

Right.

>> Also, looking at future plans for qgraph, adding a generic "plug/socket"
>> mechanism to QOSGraph was an idea that we couldn't do in time for GSoC.
>> With that model, virtio-9p would provide a "socket" of type fsdev and
>> the tests would have to provide a "plug" of the same type.  Likewise
>> there would be sockets of type disk or network.  QOSGraphEdgeOpts fits
>> better with that plan, compared to duplicating the devices.
> 
> Sounds like that would require huge changes for all existing qtests on initial 
> thought at least.

Not huge, but yeah many tests would require changes.

Paolo


