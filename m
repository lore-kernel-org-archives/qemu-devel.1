Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE58C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DFE2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1SPEZ17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DFE2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYAWM-00025L-5b
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 12:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYAVA-0001Na-AX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYAV8-0002uM-7x
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603987808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3hxrFAJxMVxsiVbv0lgHrRC1k9+fms5PAciP3sWUcg=;
 b=O1SPEZ17VCzf70vfIPIop/yDGx9thhXLgaDz01KGuXu8GoGb0uW6AB53F6OJ2gyBpdTuZ1
 WvnkHgTN6bqnyfDK8DJqzG41pZbBK13AV65JZ+RXFs3S69L1oK9YT19bZknuzzNJUuoSzP
 6beplw6BHtViBKe6FEkBZfe62xre1zs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-c-bVtXIrPTG8nxKc3WQ3iw-1; Thu, 29 Oct 2020 12:10:07 -0400
X-MC-Unique: c-bVtXIrPTG8nxKc3WQ3iw-1
Received: by mail-wr1-f71.google.com with SMTP id f11so1460533wro.15
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 09:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G3hxrFAJxMVxsiVbv0lgHrRC1k9+fms5PAciP3sWUcg=;
 b=T6pJtrZVp6MnP522fVfehCeMYuDeszZrnAujQUE8kvYKhn19jSnEp3ftuAOEt00xEw
 cDF4pC+an0F8ubZHauBaCGiRwqpx+2wqpDSACzF6Ro2A3qNAImUdLOUtOWj3Z6qK7bIV
 6yPZ/Hhxw+ivOiXGGOU9jGwTNKZBicPHzJEscDFAu2WMCRDlcbd/eXlSHaiclAEXbpqv
 LhwfXmtWpsKAVfi1gD7rElXHCMVEDXjQAsg/mx8XX+R5e3Yutwtqwp/R2s8DUvcgR488
 5MQEKzUmxBbYEEIvUnINtFEgJhLVmeGW+keB6TmPm0vwYcyjLEHMxnFvi1FDu5rBeyqN
 jtfQ==
X-Gm-Message-State: AOAM532wdro0cGz85egtnYYsPTMC59KdREZwpj2ukNAnne9/cp9idLFU
 6p4jsQl6gEJD1nvj+BtYfKugvQ/+MMgfsfDkr6t7yeQ0u2eqEgfYY6HqGSZvRDh4klvlJmklw2+
 dJHC3kGHHUlj9vTo=
X-Received: by 2002:a5d:6a86:: with SMTP id s6mr6598738wru.344.1603987804812; 
 Thu, 29 Oct 2020 09:10:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw71iDEF2pl9gpbu5kEXWSrJ/BPflxqgXUJJ3ZWsU7Ptsb1BFM8+QgoZYf6EutuvACsha0ZPg==
X-Received: by 2002:a5d:6a86:: with SMTP id s6mr6598704wru.344.1603987804554; 
 Thu, 29 Oct 2020 09:10:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id v123sm535420wme.7.2020.10.29.09.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 09:10:03 -0700 (PDT)
To: Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
 <20201029083130.0617a28f@w520.home>
 <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <67e84450-3f42-2766-c1c0-ba17042d69f8@redhat.com>
Date: Thu, 29 Oct 2020 17:10:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029094603.15382476@w520.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/20 16:46, Alex Williamson wrote:
>>> Clearly we're also trying to account for proprietary devices where even
>>> for suspend/resume support, proprietary drivers may be required for
>>> manipulating that internal state.  When we move device emulation
>>> outside of QEMU, whether in kernel or to other userspace processes,
>>> does it still make sense to require code in QEMU to support
>>> interpretation of that device for migration purposes?  
>>
>> Well, we could extend Qemu to support property module (or have we 
>> supported that now?). And then it can talk to property drivers via 
>> either VFIO or vendor specific uAPI.
>
> Yikes, I thought out-of-process devices was exactly the compromise
> being developed to avoid QEMU supporting proprietary modules and ad-hoc
> vendor specific uAPIs.  I think you're actually questioning even the
> premise of developing a standardized API for out-of-process devices
> here.

Strongly agreed!  Some (including me :)) would very much prefer not
having proprietary device emulation at all; at the same time
out-of-process devices make sense for _technical_ reasons (cross-VM
operation, privilege separation, isolation of less secure code) that are
strong enough to accept the reality of allowing proprietary
out-of-process code.  Especially if people could anyway go for an
inferior solution using VFIO, putting the kernel between QEMU and the
proprietary emulation just to get what they want.

Having to choose between opaque migration blobs and proprietary modules,
I would certainly go for the former.

Paolo


