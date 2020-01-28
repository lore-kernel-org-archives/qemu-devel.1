Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FA8C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585C321739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5TDjJhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585C321739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwTHE-0001ki-I2
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwTGN-0000UC-Mo
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwTGL-00017o-CR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:58:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwTGL-00016Y-8h
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580227128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4GBHGZt1UyiS5qwAQ5oZRX6bQ9pOGYtijQP7j74zqs=;
 b=a5TDjJhGiD/mt9yFAr5QxmxTJne9R5Y8AWM8iL8PqDaTS8S15b2sMJ63zLH4U7ionhd4XP
 istkVmQWCfYHwLJq8kToYw6p+t70xRPWHm2GNBpaqhLtd3oBWEv5dCq8I1RlmDA1g/NTYY
 MLh1UGSOP5Diz5SdcIPmS9ya6A4hKtk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-HxsesUozPum34ufA4Z8BOw-1; Tue, 28 Jan 2020 10:58:46 -0500
Received: by mail-wr1-f71.google.com with SMTP id j13so8225305wrr.20
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 07:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N4GBHGZt1UyiS5qwAQ5oZRX6bQ9pOGYtijQP7j74zqs=;
 b=nmm+fVvFD8V4jU/qzR19eW6zZMRplQkJa2t9skitCate9hg4KM14dqFJr7rK7wrI1Y
 34w+P1xVDiYAUlfTKsGGAFLTy0ANhaEPW0C3Yb6mlLR26u0L9gWJK/v85a5GnhrhzrY5
 O29Q2mmclxj2KSg+0ymB2ZggT4LUsmLFTMKDLCHSn7n7/goWiBRNqwsd3JUpOgpGTWxt
 sMAM8CpGfQro0r/2qwSc6wzvZS8ZqVkyN9YoP2FN6C8vbQN+w31N56xPyena7IOguWIk
 Zaqpe7YK4kLVqo/V81OaIKx+RV/ywxOrJL33X2EGXcRS3gIdsPkaGJIZpnOdPXqF7MrS
 zOAw==
X-Gm-Message-State: APjAAAW5MSYgeF3q5HSXa1IRM+dSicUqMMt1xjk0aZv4yKv3Z2N35i36
 7Lr2nb+BbzlufHfrqCCN/4JhX8oVIcuK2NQ0EYKZ//zbDtTL1/tB6qZVrDruUNIdLnVa5x4OO0Y
 vNJYTf+rV+sl3Ivc=
X-Received: by 2002:adf:f80c:: with SMTP id s12mr29486524wrp.1.1580227125293; 
 Tue, 28 Jan 2020 07:58:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwuvCzzyD9y8vAe24dwctUvL5OMfk6kDvu85az7uMKxNwKgTWw38tiEum2kD3nZEsDyK28vZg==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr29486501wrp.1.1580227125045; 
 Tue, 28 Jan 2020 07:58:45 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w7sm3387525wmi.9.2020.01.28.07.58.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 07:58:44 -0800 (PST)
Subject: Re: python3 script header and rhel8
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <2cb797a9-25ec-8b36-2268-ec9638b14e1e@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cfa26656-8202-bb0c-fc91-e53b2d89976c@redhat.com>
Date: Tue, 28 Jan 2020 16:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2cb797a9-25ec-8b36-2268-ec9638b14e1e@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: HxsesUozPum34ufA4Z8BOw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/28/20 4:44 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Hmm Qemu dropped support for python2, and anyway python2 is not supported now at all.
> 
> Still, we have a lot of "#!/usr/bin/env python" headings in our scripts, which is
> unsupported by rhel8 by default. So, for example, because of such line in
> tests/qemu-iotests/nbd-fault-injector.py, iotest 277 fails.
> 
> Of course, it's simple to set python in rhel8 to be python3... But should we fix
> all the headings to be "#!/usr/bin/env python3"? Or what is the correct heading
> for scripts in a new python3 world?

I'd go for a codebase wide cleanup for once, and use python3. That way 
we are ready for when Python4 goes out, we won't suffer the same pain. 
That also mean we'll have to explicitly support Python4.

Eventually add modify scripts/checkpatch.pl to refuse commits 
introducing unversioned python back.


