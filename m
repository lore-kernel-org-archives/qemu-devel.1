Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8448C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733F520674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 12:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFlDHJfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733F520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaf5u-0000gS-Lp
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 08:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaf50-0007tp-1U
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:41:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22816
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jaf4z-0004Lo-9Z
 for qemu-devel@nongnu.org; Mon, 18 May 2020 08:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589805672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QItQqnNZkKCPPRXadAcIC2flq1LrESOA9aatKerOXQE=;
 b=jFlDHJfbux/PRk4CwQ3E+eetGIphDzJkeU0+EDiRkyAOCIShlya+3qQl0ySkr149DKokax
 G4NFZg1NmHjlU3rwgwP58SFeHmj52jeRJ+CNn3urz7db/Eg2yeqVitMrkA21993qbSdAnl
 N+7RoLo+Yebcd3zNGhi4OSvxCD5UXu0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-Oq_ojPHoNaOQvRqTOQvGyw-1; Mon, 18 May 2020 08:41:11 -0400
X-MC-Unique: Oq_ojPHoNaOQvRqTOQvGyw-1
Received: by mail-wm1-f70.google.com with SMTP id a206so3035236wmh.6
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 05:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QItQqnNZkKCPPRXadAcIC2flq1LrESOA9aatKerOXQE=;
 b=AadHxuJcR5RmV46msozqPGXj7hieMa4el5z7fXMN5nEMcZZd6H7zfN1qVLpMSEEGoW
 rnCrIcY02Q5yQO5GgIgM5QKhhE9d1ejMusVyTedo7zvd7UXdciGpWFDvynU6qa/oPwHz
 AxT76FUeWZKNbnPuyFfhzQVZEp+9R7/c922ek310H7VMgRTfkJkUuXPHguGG7uMZBG3K
 2u5BBPt3qhgzR6eM4bmfoWd52y6PWSaiMVUpWQbaVs84lF52FNYWWEa0jcUhCr+ryVHK
 yC8bUuepQqtPZWA4QbNmNV2WXDUgiGOoikfZoqsQoFKeCh6KQP587+/j5nC8A3T8g+a9
 4RGQ==
X-Gm-Message-State: AOAM532UPTHquDUJ9x1qlPT94EaN9my9LZrlzjG9YqExa7lLffGnHJjB
 xzVLZVvGnyL3yKD2BkKutannASJhJ4/AAZrm/UA51t2gRPXuLglYfyRJc5l58qnI6LmTWZG6cgy
 pDeHhPnv5o1akMTs=
X-Received: by 2002:adf:e388:: with SMTP id e8mr19496548wrm.174.1589805670068; 
 Mon, 18 May 2020 05:41:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrAmIKo4pOUBAMX1CJxZaK1BMzPOb7NfZOqg+W5LYFHnS52xsr835gbJMH18TpWet1U6yOOA==
X-Received: by 2002:adf:e388:: with SMTP id e8mr19496532wrm.174.1589805669914; 
 Mon, 18 May 2020 05:41:09 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v20sm19234230wrd.9.2020.05.18.05.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 05:41:09 -0700 (PDT)
Subject: Re: [PATCH RFC 00/32] python/qemu: refactor as installable package
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <706e76ef-1d41-a850-24ac-3155c92f5759@redhat.com>
Date: Mon, 18 May 2020 14:41:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 7:53 AM, John Snow wrote:

>    python//qmp.py: use True/False for non/blocking modes
>    python//qmp.py: Define common types
>    python//qmp.py: re-absorb MonitorResponseError
>    python//qmp.py: Do not return None from cmd_obj
>    python//qmp.py: add casts to JSON deserialization
>    python//qmp.py: add QMPProtocolError
>    python//qmp.py: assert sockfile is not None
>    python//machine.py: remove logging configuration
>    python//machine.py: Fix monitor address typing
>    python//machine.py: reorder __init__
>    python//machine.py: Don't modify state in _base_args()
>    python//machine.py: Handle None events in event_wait
>    python//machine.py: use qmp.command
>    python//machine.py: Add _qmp access shim
>    python//machine.py: fix _popen access
>    python//qtest.py: Check before accessing _qtest

Maybe remove double // in patch subjects :)


