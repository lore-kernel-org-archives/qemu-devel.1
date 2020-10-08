Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE00AC4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15D22184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgnNIFVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15D22184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWiX-0001a2-Um
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQWhb-00012p-Ac
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQWhX-0004RR-60
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602166521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjhr21aSsRJ5tXiLgKrndxaDa4eu0MrzGpsG+lYcc64=;
 b=NgnNIFVJvT7c4lNTLqwnaPaz+vq6Ra1EA5gJ7QhXvTlLxGg9melL1nFdfVZUXwtqlZYvVz
 aVY/HRA787bZz0tSQ790Q5MjJXCuuMBgVHBQoKet5hoSu8MlI7/qSmuyNf+jR9aCA3YRD4
 0Mcu3/4j9TFD3stUKzAFG5DFl0/HzhM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-Fxb5CD1TN62VWp3zn_zDDg-1; Thu, 08 Oct 2020 10:15:20 -0400
X-MC-Unique: Fxb5CD1TN62VWp3zn_zDDg-1
Received: by mail-wm1-f70.google.com with SMTP id y83so3209134wmc.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bjhr21aSsRJ5tXiLgKrndxaDa4eu0MrzGpsG+lYcc64=;
 b=XyTlaRWKcWO/ltDivEqcYKz9k5nl9n+doM5lzJYBmF0OsPIGft3oGlMEyZDfpzHlp9
 XrZDTHJ8coofzwB2OlkcmlbhX6YuKpLNFS03EFgswZqfZMA2zYmByc9hJjt86bafGNzr
 OOWpbQ2zqkyUh0MvIOF2Zhi0wkHhHAtTzqoGWqI1vX11f0LVPU4xD1t+ROKfznq0Bz4c
 kgNyYz/hdMrTJpEO7x2h4nCk1e6i2FzulQz8qfLtQIdgaDVNAQRUGKNyx2Si/VHfGLvF
 h0kYQe2bfNcWMqPrhZqUZoendQTHi4m9ba9RJL5Yh5X+9BNvipyo2s88OW8ulYIrjhZ7
 EVNA==
X-Gm-Message-State: AOAM533eJrwGPJrVIZlj2J6auw46i2GQuOngqyx/ph5Foh+PbNWo+xb9
 idsYE6+ahS7FKPw4hqsmS+7paXqexPbB4HymJ2bMYF0JrPkqjLhVgyAS7/BgvvM+TEteS7HgWLg
 wU639R9o7vpf5ajI=
X-Received: by 2002:adf:fd07:: with SMTP id e7mr9188237wrr.377.1602166518684; 
 Thu, 08 Oct 2020 07:15:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKXhWOWCMYprz5YdVnK8pbDploupp7kZZ7lRm7tvunRvnLArwt+lAHqrYnruBG3qs+SXnt+Q==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr9188213wrr.377.1602166518440; 
 Thu, 08 Oct 2020 07:15:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id f14sm7570622wme.22.2020.10.08.07.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 07:15:17 -0700 (PDT)
Subject: Re: KVM call for agenda for 2020-10-06
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <874kndm1t3.fsf@secure.mitica>
 <20201005144615.GE5029@stefanha-x1.localdomain>
 <CAJSP0QVZcEQueXG1gjwuLszdUtXWi1tgB5muLL6QHJjNTOmyfQ@mail.gmail.com>
 <8fce8f99-56bd-6a87-9789-325d6ffff54d@redhat.com>
 <20201007180429.GI2505881@redhat.com> <87h7r5yn6z.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a35bad26-7ed6-fea8-10ab-ea340f8fc6e2@redhat.com>
Date: Thu, 8 Oct 2020 16:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87h7r5yn6z.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/20 13:25, Markus Armbruster wrote:
> CLI, config file and QMP are differently convenient for different use
> cases. [...]
> 
> If we could afford just one of the three, we'd probably want to pick
> QMP, because it's the most flexible (it's supports queries naturally),
> and because picking something else can't eliminate QMP.  Fortunately, we
> don't have to pick just one if we base on initial configuration on QAPI.

On the other hand, we don't have to pick just one because we already
have a CLI (though one that is full of warts) so the question is not
whether we want to have a CLI, but whether we want to have a *second* CLI.

So my point is essentially that:

* as you said, you cannot get rid of QMP

* we can make the existing CLI a QMP wrapper just like we did with HMP

* any work on QMP-based configuration would apply just as well to both
binaries, so developers could still mix CLI+QMP when (or if) desirable

* once you have a (warty but well-known) CLI and QMP, there are
diminishing returns in going all the way down to QAPI even for the two
hardest commands (device-add and object-add).  That time is better
invested in minimizing the differences between the two binaries, because
we all know that you won't pry the qemu-system-* command line from the
cold dead hands of users and developers.

(not coincidentially, this goes from least to most controversial).

Of course you may say this is "whataboutism", on the other hand time is
limited so I prefer to make the interesting tasks clear from the
beginning and allow better collaboration.

> I'd like to take a serious swing at QAPIfying them, with a loose schema.

What do you mean by "loose schema"?  Is it anything other than
"represent a QDict with a QAPI list of key-value pairs"?

Paolo

> Good enough for QAPI-based initial configuration interfaces.  Not good
> enough for introspection, but a better QOM introspection could fill that
> gap.
> 


