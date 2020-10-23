Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D85C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F0A20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUyNtm8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F0A20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0l8-0007GB-MF
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW0kJ-0005xc-49
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW0kH-00084N-AL
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 13:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603473651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69OMIhUVcp9Fhq5x4AhrZCowV7wj/k+vCHsAXln3F3o=;
 b=RUyNtm8NnN8Kw13Z8XISKT0nnreWC20gA4/Bj4mT58RG1uFUJtTQffBirUaXgboildKLhN
 EDlqMoQTuqpJlSVBziNMpRGzHaNgbGtxAR77B5gRr1i12YgKyvzKaiiToDmFnzyYQsR026
 WugCxuscFTWaBZ7Gd+2qoLRi5vL1XWg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-gANZYnfAO666-Jaej0J02Q-1; Fri, 23 Oct 2020 13:20:49 -0400
X-MC-Unique: gANZYnfAO666-Jaej0J02Q-1
Received: by mail-wr1-f69.google.com with SMTP id t3so838346wrq.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 10:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=69OMIhUVcp9Fhq5x4AhrZCowV7wj/k+vCHsAXln3F3o=;
 b=OoXYCKmnN86llLtvMj1PI/i7jKUNHnWWyFS7ysNRUY9h+uL5rRo6cYPivpYl3jQkCs
 +lfK4xTh0vfiHfdSNtSLKeWHdI8D45kB1DoOiqp2/UlK4kX2QZ6V5M3Rrrb1J98RX5uR
 P6iVCTfl5PQZCYMgm1k5IHFNocFk5UV05awIBxMwj3voGdQPBkOf4nBp52QqRnuevsG7
 mmScPbtEarcAqVas1b9ukkPd3eIQWGZGJtxhTpvg0aefIfiUR3E5gvHSMQG9ROGwaOby
 p+EmxB2y18s99zrYZzPsUVHD+T+2eqHy7QM/Ggl7FM+Bnibpor8VgZVybBJUXKF9f6M5
 H6Tw==
X-Gm-Message-State: AOAM531XJqgdfIjAFFHbKeIIRzG9auGkA8MKDmIN0InNe5mn+nKg1G72
 UbIU1JWbzyQM0RTiDu15z7OeRHWlCs3iF0rNVWDtD/DcMscJtMczoIrCm4EU2Gr5FD9KN3gTWIN
 IqWeMLeeMvayznOo=
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr3343366wmf.121.1603473648247; 
 Fri, 23 Oct 2020 10:20:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdhb/w9s96nAbbUlnMpmjTsXH3zjIr1OSw5TCb3niccSUE6cxcNMnUeCpIarNLDQPrMkOf6w==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr3343349wmf.121.1603473648065; 
 Fri, 23 Oct 2020 10:20:48 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m12sm4076581wrs.92.2020.10.23.10.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 10:20:47 -0700 (PDT)
Subject: Re: [PATCH v11 12/19] multi-process: Forward PCI config space acceses
 to the remote process
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org
References: <cover.1602784930.git.jag.raman@oracle.com>
 <1a1490ba03686fe29a0f627bec1556a0051fed18.1602784930.git.jag.raman@oracle.com>
 <47f25366-4cf3-7167-d199-1b82d7fd1ec2@redhat.com>
Message-ID: <e219fd9f-dbc2-2ddd-603a-8340e8e22d53@redhat.com>
Date: Fri, 23 Oct 2020 19:20:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <47f25366-4cf3-7167-d199-1b82d7fd1ec2@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, quintela@redhat.com,
 mst@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 6:59 PM, Philippe Mathieu-Daudé wrote:
> On 10/15/20 8:05 PM, Jagannathan Raman wrote:
>> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>>
>> The Proxy Object sends the PCI config space accesses as messages
>> to the remote process over the communication channel
...

>> +static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
>> +                                MPQemuMsg *msg)
>> +{
>> +    ConfDataMsg *conf = (ConfDataMsg *)&msg->data.conf_data;
>> +    MPQemuMsg ret = { 0 };
>> +    Error *local_err = NULL;
>> +
>> +    if ((conf->addr + sizeof(conf->val)) > pci_config_size(dev)) {
>> +        error_report("Bad address received when reading PCI config, 
>> pid %d",
>> +                     getpid());
>> +        ret.data.u64 = UINT64_MAX;
>> +    } else {
>> +        ret.data.u64 = pci_default_read_config(dev, conf->addr, 
>> conf->l);
> 
> Isn't it endianess issue here? It might makes sense to
> declare ConfDataMsg and PCI_CONFIG_READ/PCI_CONFIG_WRITE
> packets in little endian.

Bah Stefan told me to look at the specs which are included in
the latest patch (docs/multi-process.rst). As I process patches
of this series in order I haven't looked at it yet. Still,
why not put it first in your series?

Regards,

Phil.


