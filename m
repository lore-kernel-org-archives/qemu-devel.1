Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D231CC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B865208B8
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 14:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzhSjOBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B865208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPoBe-0006dd-8n
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 10:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPoAL-0005gS-Af
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kPoAI-0007Dv-IL
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 10:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601995324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOQs88IoRx0oWNMi6ig1Y+zg72TOfRpQxMRWIulLBRw=;
 b=gzhSjOBL6MfwQH9Efs8LKekrQmbJGW83pu+GaDEtmmZG3BVjxea1Uxw/ATBlTrEEE7G41j
 3X2LMgNjV4Sw/pvHdJ6IlvkxFs5dJ5lQfgdSWCxm2kgers8OOYgtyEGAxl5zHYaymzbh/0
 Y7UV3iyQNMxRlv3FEIOXY004w1bAUX8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-rTrx3d2iMnOEMN8GnRsAKA-1; Tue, 06 Oct 2020 10:42:02 -0400
X-MC-Unique: rTrx3d2iMnOEMN8GnRsAKA-1
Received: by mail-wr1-f69.google.com with SMTP id c6so4478532wrt.6
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 07:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JOQs88IoRx0oWNMi6ig1Y+zg72TOfRpQxMRWIulLBRw=;
 b=RPBKQymGgXavwhv8W8q4b1A5FWgnz/Z3+z400z2i7Sywi//b4S+ev8fII7J3Y8VO82
 RAN5WxVDE9VQOuAM3LddL/rYU94zn8QZhpiFiblfoGGeDmIOmBhbN4BJPgC3P+VugvWM
 PkrFmid4cOieygX9avhhlRRdGAN1Le1l2IxsbiDPT/mWraGdpWvUThnIH9tsCJ+ukKzL
 k6U9zswc1kV1pRDxqUDZ4DhlmeHQAPYe/5OIT0pbc5oylzobXbrDKmNILd0KfqYW5ui6
 td1k3tmI2ZLgUlVe/9CD3GaS62vQIPrGmVdfQVdPnmEDYUInkH/SNclYTUia5CMXkfl3
 iZ4A==
X-Gm-Message-State: AOAM531bwhRK4ZJNIsD58xp3r6UOZxqqzsWPHt5MgLHT0TrosUZNrERu
 JsTKfZxY8BzGXKS6XGwmVwVvgEK2MaWyHts5gktgwN3yFOQBZvAKjQoRdia59Fb4ObrYQSKZLNq
 zkDuO4Bbs8M3f5Nk=
X-Received: by 2002:a1c:2808:: with SMTP id o8mr2972625wmo.150.1601995320277; 
 Tue, 06 Oct 2020 07:42:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT/4LJWeZMb5yAC1XYQfHzV+Y4gIeaFnzdn2AKMuJMig2/3rFcJa6jYalv6N6ozyXa6+9u1g==
X-Received: by 2002:a1c:2808:: with SMTP id o8mr2972601wmo.150.1601995319973; 
 Tue, 06 Oct 2020 07:41:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e?
 ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id l11sm3934009wrt.54.2020.10.06.07.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 07:41:59 -0700 (PDT)
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20201005211000.710404-1-ehabkost@redhat.com>
 <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
 <20201006143637.GP7303@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <718cd93c-0b95-957d-1ae4-760c76b01cda@redhat.com>
Date: Tue, 6 Oct 2020 16:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006143637.GP7303@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/10/20 16:36, Eduardo Habkost wrote:
> On Tue, Oct 06, 2020 at 03:03:57PM +0100, Peter Maydell wrote:
>> On Mon, 5 Oct 2020 at 22:10, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>
>>> The following changes since commit 36d9c2883e55c863b622b99f0ebb5143f0001401:
>>>
>>>   readthedocs: build with Python 3.6 (2020-10-05 16:30:45 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>>>
>>> for you to fetch changes up to fec5c4b6d3b7f3ffcfcbe1714e0405df6de2a222:
>>>
>>>   kernel-doc: Remove $decl_type='type name' hack (2020-10-05 12:48:11 -0400)
>>>
>>> ----------------------------------------------------------------
>>> machine + QOM queue, 2020-10-05
>>>
>>> * QOM documentation fixes and cleanups (Eduardo Habkost)
>>> * user-mode: Prune build dependencies (Philippe Mathieu-Daudé)
>>> * qom: Improve error message (Philippe Mathieu-Daudé)
>>> * numa: hmat: require parent cache description before the next
>>>   level one (Igor Mammedov)
>>>
>>> ----------------------------------------------------------------
>>
>> Compile failure on OSX:
>>
>> ../../hw/core/numa.c:429:20: error: format specifies type 'unsigned
>> char' but the argument has type 'int' [-Werror,-Wformat]
>>                    node->level - 1);
>>                    ^~~~~~~~~~~~~~~~
>> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:319:35: note:
>> expanded from macro 'error_setg'
>>                         (fmt), ## __VA_ARGS__)
>>                          ~~~      ^~~~~~~~~~~
>> 1 error generated.
> 
> Is there a CI system where this is tested?  I'd like to be able
> to detect this kind of failure before sending pull requests.

Possibly Cirrus CI?  You have to add it to your account
(https://cirrus-ci.org/guide/quick-start/) and then it triggers on any
push to GitHub; there's nothing else you have to do.

Paolo


