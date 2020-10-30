Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4D1C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC9220731
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQH9fuaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC9220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXwH-0004i6-JL
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYXvL-0004Cn-7J
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kYXvI-0006Xj-0w
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604077840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCRD/pXGx6Ifem48vwGxf1ezhfCtyyJ2X2O04rcUeAg=;
 b=bQH9fuaNnZrF0yvrsox1oYWvt1cw9uZWlxJvL293+Kj4H5iTiInK8NPCytZdZQSn5VN4BT
 Gzcm/kVtkOIKA9pkxwOgtTd4RaWcfBuIfhftBT+JLSf26yNrsSB1XO8Wx5PMy53Q72z3bF
 Q8m5TsuLkKzu8pSXqQEWo43Tcv6pCXk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-wUbihc9WMYuwptjY_W5G0Q-1; Fri, 30 Oct 2020 13:10:38 -0400
X-MC-Unique: wUbihc9WMYuwptjY_W5G0Q-1
Received: by mail-ed1-f69.google.com with SMTP id r14so2887222edw.21
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 10:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NCRD/pXGx6Ifem48vwGxf1ezhfCtyyJ2X2O04rcUeAg=;
 b=DH1OcJblVEen4Pi1+QShxFym/z12UB1dxuhwk4JWV/yI35zUn0KccB8s3u936VU5SG
 Gjux1bFhk5+5145fssgBEDlqoqKsirwueKvG7Y9E2RBbMpQqBtuvTtwRojLTKxuuXtVr
 rrC78g+2sR8NgJuYTM8DhLdtXUq3etQKsk4VYiUFOd2t5MFjDAFIfkTMQV2FZxiQDGZH
 pS9up3xGkf4Dk//4lCBVnF6pBy38jb4xhpIA0mPHYYRLZAPKJt3iJXNri0ZSY5wKbc+c
 2qv1NfW7AL+Ddt3AXgE5sZiAFSKASVNQZq3xDcFmlDEexh/JshwgnqaWOfleIunP95bp
 gKiw==
X-Gm-Message-State: AOAM5328iCyAdmWfdC4ofLssXAuCKJn8Vu5ojT/8UrJBFAeRKHEr/kzu
 y0blBit4ZQbyYlxnvQvGeEuQmsUaRUWi4vgtJpCtOld41ShF/Qs4T+Os2O40UzZixDQC4cvBEUq
 IkNRthGp3UMN0rds=
X-Received: by 2002:a17:906:b1c9:: with SMTP id
 bv9mr3536435ejb.495.1604077836807; 
 Fri, 30 Oct 2020 10:10:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhZSKOvMnfahenpHliW+PTb3sce7iZHzZ/KfkI/2aj6LQ1EiRp34vfx3kVD2evJJWqqb7ykw==
X-Received: by 2002:a17:906:b1c9:: with SMTP id
 bv9mr3536412ejb.495.1604077836622; 
 Fri, 30 Oct 2020 10:10:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id v10sm3199901ejk.101.2020.10.30.10.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 10:10:35 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-35-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 34/36] machine: Use DEFINE_PROP_STRING for string
 properties
Message-ID: <ae632c6e-017b-e0e6-0cb2-9ace77a13ff9@redhat.com>
Date: Fri, 30 Oct 2020 18:10:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201029220246.472693-35-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/20 23:02, Eduardo Habkost wrote:
> +static Property machine_props[] = {
> +    DEFINE_PROP_STRING("kernel", MachineState, kernel_filename),
> +    DEFINE_PROP_STRING("initrd", MachineState, initrd_filename),
> +    DEFINE_PROP_STRING("append", MachineState, kernel_cmdline),
> +    DEFINE_PROP_STRING("dtb", MachineState, dtb),
> +    DEFINE_PROP_STRING("dumpdtb", MachineState, dumpdtb),
> +    DEFINE_PROP_STRING("dt-compatible", MachineState, dt_compatible),
> +    DEFINE_PROP_STRING("firmware", MachineState, firmware),
> +    DEFINE_PROP_STRING("memory-backend", MachineState, ram_memdev_id),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +

While I think generalizing the _code_ for static properties is obviously
a good idea, I am not sure about generalizing the interface for adding them.

The reason is that we already have a place for adding properties in
class_init, and having a second makes things "less local", so to speak.

What do you think about adding macros like

    OBJECT_CLASS_PROPERTY_ADD_STR(oc, MachineState, kernel_filename,
                                  "kernel", prop_allow_set_always);

?

Paolo


