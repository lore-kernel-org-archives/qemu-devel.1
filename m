Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF8C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810C02072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eihb1Ptq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810C02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieF20-0001F3-OW
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ieF1O-0000n5-8I
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ieF1N-0007yY-9B
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:08:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50581
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ieF1N-0007x5-4p
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575882480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hdq5V5plUYcf38+uVBSj73KNazScHJ/N/dNaJzrWL9c=;
 b=eihb1PtqiFfDXar71kABvt7qeySiMIx/AQZLoz+8+vGolHe2gZN8z75+db8hZQ5TruY0Aj
 nzupjsqqXHme0joCqPl/s9O5Yk5F+sTVN+yKdNiARgfFM6QZD3u3ec74dRNLUkqtjk46PU
 tlGCl+fNMmbdBEYmnNqNIfxxEjSc42Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-3yhAo_LGMzeMVor3Sm3BAw-1; Mon, 09 Dec 2019 04:07:59 -0500
Received: by mail-wr1-f70.google.com with SMTP id c6so7178178wrm.18
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 01:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hdq5V5plUYcf38+uVBSj73KNazScHJ/N/dNaJzrWL9c=;
 b=OYLmksSJ+NU5eEJYCH/9r2aC3xkA2jmA5TXAmMHZ7BULu1KqT235zwEZjOudpc2sJr
 Pd56ctAFDJivTtADh4ou1Ly0T1CGXmjzAj83wN6sFzGsi63BRGYw5STVzFGyE3sekvda
 xRtXHxWEzQxZQWXNy0t4NS9355Ykl3ZQA1Nx8zPAIJBKP0rhdS64tOYVPd6vMU81ZWAw
 E2Tf0VQL7l+EwpFidIy0q7/z/Iybn1Fr6s1w/V6/pApg+VdfftG1naxZ7cGwiRi2tetO
 1+FYgddWUkHQqZZyNM1zYE3q5uPj6B9F3Yi5umoRDonxoYmaXiNA3fKG7sTx+q6fbd0H
 ZY6w==
X-Gm-Message-State: APjAAAVw1guUCbi8vYzMevQTjoVDFKZy9hfPQ/CZ9RSVddge9xEWhZ3K
 DqC1WMkMqYGXKyGjzQVWwad60qoAd/wWJ72Ho5S82j2/HDf4AQJOGUfDArHzo9/PbONS3d8y1Ki
 pDLtIHnO2khAMkoo=
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr22459797wma.25.1575882478197; 
 Mon, 09 Dec 2019 01:07:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKfU0hg6m2ojICTumRsdQ/lxceoP+z/vRvlTpdhGAI4jhdct7GBzcSHi0TjSKJ/TJgn9mi9w==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr22459767wma.25.1575882477910; 
 Mon, 09 Dec 2019 01:07:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id a20sm13289655wmd.19.2019.12.09.01.07.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2019 01:07:57 -0800 (PST)
Subject: Re: [PATCH V3 0/4] Introduce Advanced Watch Dog module
To: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
References: <20191119123016.13740-1-chen.zhang@intel.com>
 <7efe2315-87c3-2b64-2240-087aba389016@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0667556-3228-76cc-8e4d-1adf671f4a9e@redhat.com>
Date: Mon, 9 Dec 2019 10:08:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7efe2315-87c3-2b64-2240-087aba389016@intel.com>
Content-Language: en-US
X-MC-Unique: 3yhAo_LGMzeMVor3Sm3BAw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/12/19 18:52, Zhang, Chen wrote:
> Hi All~
> 
> No news for a long time.
> 
> Please give me more comments about this series.

Sorry, people were probably busy with the QEMU release candidates.

Even before looking at the code, the series is completely missing
documentation on how to use it and on the chardev protocol.  The
documentation should go in docs/ and should be written as restructuredText.

The qemu-options.hx patches also lack documentation about the properties
accepted by the new object.

In particular:

>> -chardev socket,id=h1,host=3.3.3.3,port=9009,server,nowait
>> -chardev socket,id=heartbeat0,host=3.3.3.3,port=4445
>> -object iothread,id=iothread2
>> -object
>> advanced-watchdog,id=heart1,server=on,awd_node=h1,notification_node=heartbeat0,opt_script=colo_opt_script_path,iothread=iothread1,pulse_interval=1000,timeout=5000

What are the two sockets for, and what should be in colo_opt_script_path?

>>
>> In secondary node:
>>
>> -monitor tcp::4445,server,nowait
>> -chardev socket,id=h1,host=3.3.3.3,port=9009,reconnect=1
>> -chardev socket,id=heart1,host=3.3.3.8,port=4445
>> -object iothread,id=iothread1
>> -object
>> advanced-watchdog,id=heart1,server=off,awd_node=h1,notification_node=heart1,opt_script=colo_secondary_opt_script,iothread=iothread1,timeout=10000

Same here.

Paolo


