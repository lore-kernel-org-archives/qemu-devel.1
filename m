Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165E8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45E8206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioyZOd/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45E8206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwE1-0001CA-5R
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtwDU-0000lj-11
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:49:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtwDS-0001t7-Fp
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594399777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWQVFvxzHaI3cpGgJR2RIec5xz3c/DX2/Rl3zeUvHvs=;
 b=ioyZOd/2zRxfhrCq66NPVidazHeDQt91oqT7FLMIEX/uNe1iD4bRkblz2JdyxsJA5/ou8V
 UHBg/afQQ6BmthxYx77mU5ozaNcO8M4jTD7n4Bc3e8OUUGjw+3HyJWJKKMnORr4JoeUYod
 pgT9SydeZO9OFQKz8IPYfVhx4oFD1qo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-qAUljdPLO6yxpXG7iux-iw-1; Fri, 10 Jul 2020 12:49:35 -0400
X-MC-Unique: qAUljdPLO6yxpXG7iux-iw-1
Received: by mail-wr1-f69.google.com with SMTP id y13so6558266wrp.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RWQVFvxzHaI3cpGgJR2RIec5xz3c/DX2/Rl3zeUvHvs=;
 b=TQgBh9Msy7FVdOALaQiNhMQT5NEQs8hGPMOrSrx1PVpPck5LHu8d0Fv+sUuCHvbttZ
 BtIMHRYMoUWoSHEunxUG1pcKp7i1/vaeXErZmZ1lbwwJYRcmVskT8m4023mGLy6Sc9C8
 0lCmPU7+Lq7VUA3AVL1H3aJ8fV/Hr9IXGZBDD6MqxU0AFs17jvaU1oRk8HGWJZfugBRT
 ETo/5Cc26wCUDYAbvQJYkqw8WEEfMAZ0aj/wZ2PMMarFPCGSBvT+UyzwX8rcxtlprJeK
 699KNw7gNQgf829yUkG/a7h2JAQhZJgHAiczg/cPtrCRdmlkm1JIC19R7kbviWDDXtiJ
 Tnsw==
X-Gm-Message-State: AOAM530OpKarQ5F6qZQKm2Tb1pzZMFTIspUVdJp61RME5dUpVkJMvwi9
 lzxqN16jzPmS467l6RSI8e7huucAgB+RuuJnWuqQ+VDJKHUS6bTlq0PanIAQMOUdLjYbPpRfX55
 3jXdX8aripBGbINo=
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr5804736wme.187.1594399774646; 
 Fri, 10 Jul 2020 09:49:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjo6cziBz4llXoygguBXC0MmjK/n5HwnK7mOi14NIUnh3IbVLS5JnI830gbTxvPqvRGFQvhw==
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr5804708wme.187.1594399774384; 
 Fri, 10 Jul 2020 09:49:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id d28sm10364646wrc.50.2020.07.10.09.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:49:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] x86/cpu: Handle GUEST_MAXPHYADDR < HOST_MAXPHYADDR
 for hosts that don't support it
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200619155344.79579-1-mgamal@redhat.com>
 <20200619155344.79579-3-mgamal@redhat.com>
 <20200708171621.GA780932@habkost.net> <20200708172653.GL3229307@redhat.com>
 <20200709094415.yvdh6hsfukqqeadp@sirius.home.kraxel.org>
 <CALMp9eQnrdu-9sZhW3aXpK4pizOW=8G=bj1wkumSgHVNfG=CbQ@mail.gmail.com>
 <20200709191307.GH780932@habkost.net>
 <79aa7955-6bc1-d8b2-fed0-48a0990d9dea@redhat.com>
 <20200710160219.GQ780932@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <654ac020-5f6b-9d71-a84f-9c435f5aa0cf@redhat.com>
Date: Fri, 10 Jul 2020 18:49:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710160219.GQ780932@habkost.net>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Guilherme Piccoli <gpiccoli@canonical.com>,
 Pedro Principeza <pedro.principeza@canonical.com>,
 kvm list <kvm@vger.kernel.org>, libvir-list@redhat.com,
 Dann Frazier <dann.frazier@canonical.com>, rth@twiddle.net,
 mtosatti@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Mohammed Gamal <mgamal@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 fw@gpiccoli.net, Jim Mattson <jmattson@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/20 18:02, Eduardo Habkost wrote:
> On Fri, Jul 10, 2020 at 09:22:42AM +0200, Paolo Bonzini wrote:
>> On 09/07/20 21:13, Eduardo Habkost wrote:
>>>> Doesn't this require intercepting MOV-to-CR3 when the guest is in PAE
>>>> mode, so that the hypervisor can validate the high bits in the PDPTEs?
>>> If the fix has additional overhead, is the additional overhead
>>> bad enough to warrant making it optional?  Most existing
>>> GUEST_MAXPHYADDR < HOST_MAXPHYADDR guests already work today
>>> without the fix.
>>
>> The problematic case is when host maxphyaddr is 52.  That case wouldn't
>> work at all without the fix.
> 
> What can QEMU do to do differentiate "can't work at all without
> the fix" from "not the best idea, but will probably work"?

Blocking guest_maxphyaddr < host_maxphyaddr if maxphyaddr==52 would be a
good start.  However it would block the default configuration on IceLake
processors (which is why Mohammed looked at this thing in the first place).

Paolo


