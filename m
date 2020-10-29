Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD60C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376E7207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiqM49MQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376E7207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCMK-0003Xu-RL
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYCL0-0002uo-CX
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYCKy-00021P-KM
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603994867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EldzP6MA20E0NkfiPx3Z5jBPQ+1SUR+1/lXTYGBky4=;
 b=KiqM49MQs7CxObedMKki6Jtz2DvOv0gpPXD/O25kxaM1rhxTQhyBl73bCecs/jlFYMtfN/
 7ux6adSw1pZ/4mQoI9Pci1Xk/ilzZt7SULqaSlv+0TjakuNYW4TyHaBMgNKrAo+wGMKuif
 vSluac2ahBPArCLN4SA3MmBeTHEBAtM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-Uh7N336FP5uadAPIr9XMgA-1; Thu, 29 Oct 2020 14:07:37 -0400
X-MC-Unique: Uh7N336FP5uadAPIr9XMgA-1
Received: by mail-wr1-f69.google.com with SMTP id t14so1617675wrs.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2EldzP6MA20E0NkfiPx3Z5jBPQ+1SUR+1/lXTYGBky4=;
 b=sYOHB1DxIcRdsV74vPXJRC8HUqrM7rdZF7Edljz4Nc5Seen+xkRJIWWWPAcS3J1b5r
 axp3sinp8OrEF3TgQMBK9q99nBbvLkduISJpBgByb4dUTkr78fFYQoOAWMZ1mcxkB/7w
 lMnV0KmhFNlrGVcvZ+mgJti8rKLSNN1pDg6NkwYrxSmSCigfzG+7FxBTCdi0pv7cQ7OV
 qXWDDM2rk/qu4dNFczEW0fVd/P2hC0g6+3bmCb2h9iFfcstXu3U09efSk8JNjTNPI6Yt
 HEBsQLSqBqw7TOBHuFJECJNVt+MUitK7kb2tbvYlzMXPL6+Wbj0VwV5kd9QjooQbHei4
 kKTQ==
X-Gm-Message-State: AOAM532BPtfWU9LxTRkCNkK53VfpdFvmRj7aeK+0URCanLKqiDDwO1jB
 6Ojkc4ZcwXyUu3yuqa3/Lh+BEayZ+g0rd4++TsY20sjk4ehrr5ipVti2fAJ3+bK7DEKPD139u06
 O47VoSh0WaF8cnj4=
X-Received: by 2002:adf:a50e:: with SMTP id i14mr7276614wrb.121.1603994856517; 
 Thu, 29 Oct 2020 11:07:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaULE/3JYEUUEQqzw2cyJgkswW/IYuyC50111W8P7X/v4ZqcriRhtjjtBgKT91XyGFj1/egw==
X-Received: by 2002:adf:a50e:: with SMTP id i14mr7276580wrb.121.1603994856266; 
 Thu, 29 Oct 2020 11:07:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id 71sm7028879wrm.20.2020.10.29.11.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 11:07:35 -0700 (PDT)
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
To: Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 David Edmondson <dme@dme.org>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
 <cunr1ph3t5p.fsf@vroomfondel.hh.sledj.net>
 <20201029164205.GH27369@redhat.com>
 <f0e24955-db5a-7e97-b842-029d7adacc84@nvidia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14102232-2121-607f-ae7c-40261be8df8a@redhat.com>
Date: Thu, 29 Oct 2020 19:07:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f0e24955-db5a-7e97-b842-029d7adacc84@nvidia.com>
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
 John G Johnson <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
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
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/20 18:47, Kirti Wankhede wrote:
> 
> On 10/29/2020 10:12 PM, Daniel P. Berrangé wrote:
>> On Thu, Oct 29, 2020 at 04:15:30PM +0000, David Edmondson wrote:
>>> On Thursday, 2020-10-29 at 21:02:05 +08, Jason Wang wrote:
>>>
>>>> 2) Did qemu even try to migrate opaque blobs before? It's probably a
>>>> bad
>>>> design of migration protocol as well.
>>>
>>> The TPM emulator backend migrates blobs that are only understood by
>>> swtpm.
>>
>> The separate slirp-helper net backend does the same too IIUC
> 
> When sys mem pages are marked dirty and content is copied to
> destination, content of sys mem is also opaque to QEMU.

Non-opaque RAM might be a bit too much to expect, though. :)

Paolo


