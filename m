Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82CEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A55207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 23:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AesIedLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A55207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgzVe-00086R-Ra
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 19:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgzUl-0007Yv-8S
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 19:41:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgzUk-0006Ag-6X
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 19:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591314117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vpa3rdEl1kUDdltKQcUehXACewT1llC22lmT+PzPyCI=;
 b=AesIedLSLcfxB0SJMBGVKUdk6GAfOzrNw0QirI3EH2zrbtiRa4I/fsHvY1arg6R2rrTl5N
 nODxNVuMIiEfVYDadsJFNKWRHFrA7LfAUJpSBubTyfVBuHrguQ2qIbaei8vc86Xj9LuPDz
 2Y44P7e/lbZY3HMeJCBg+GOZhmeBOtU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-_ypzsa7pMyGJujLDDE2OoA-1; Thu, 04 Jun 2020 19:41:55 -0400
X-MC-Unique: _ypzsa7pMyGJujLDDE2OoA-1
Received: by mail-wm1-f69.google.com with SMTP id t145so2455829wmt.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 16:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Vpa3rdEl1kUDdltKQcUehXACewT1llC22lmT+PzPyCI=;
 b=nJQFkQShAcd4ynV7TlZA6ECMBRW6eDQpvJNbKNF2wLFrUaoNhUK83C07X+LVKlvtWh
 NzOe4WNR1KSKBaFX/dlzwtIUYJq3SzuCKHFDhfOEkmxSAtDoLprXpfhppdXwJTeD7/St
 YYqbUp9PGjRzZQyw17yH+CKv3oOXkpJaBqqYfdBuznH05AsxTKeID271NdM7GfHP/nIy
 6sK6FEMj90HgOC0Czc8NA/9tGJl5qzxjhX5rxt0tVq0O/zWrIYrq9S4IabEUhdfmPKMC
 Zl/MCgDhzAmzTMwieffHsbbqtZK8rTMfxtakvWQZJbpWCRKFEQTgGtIszjAtjwjAQl1j
 1Usg==
X-Gm-Message-State: AOAM533tF6k1XysHS1d2BXPPmhsXk3SstqpWPb+Zbc45qAZk+lLlf2YO
 7rcnaUotfaKgpgjBWyltgoquJgqzWEL+SY5S4fF3WyJTJ0w5PWjoVQZ5g0mZLSJFZhK+rW/srYN
 KiOqc7TKTYhvg/O4=
X-Received: by 2002:a05:600c:1008:: with SMTP id
 c8mr6222961wmc.95.1591314114251; 
 Thu, 04 Jun 2020 16:41:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLrJvH75jnQuFHmpOkg3OVlW3wojHKXC9xIcNeA3IoZAQHKOlH224rVHBykXMwxm4dw1PI2A==
X-Received: by 2002:a05:600c:1008:: with SMTP id
 c8mr6222927wmc.95.1591314113925; 
 Thu, 04 Jun 2020 16:41:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id k16sm9745196wrp.66.2020.06.04.16.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 16:41:53 -0700 (PDT)
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <87tuzr5ts5.fsf@morokweng.localdomain>
 <20200604062124.GG228651@umbus.fritz.box>
 <87r1uu1opr.fsf@morokweng.localdomain>
 <dc56f533-f095-c0c0-0fc6-d4c5af5e51a7@redhat.com>
 <87pnae1k99.fsf@morokweng.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec71a816-b9e6-6f06-def6-73eb5164b0cc@redhat.com>
Date: Fri, 5 Jun 2020 01:41:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87pnae1k99.fsf@morokweng.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:58:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 dgilbert@redhat.com, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/20 01:30, Thiago Jung Bauermann wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>> On 04/06/20 23:54, Thiago Jung Bauermann wrote:
>>> QEMU could always create a PEF object, and if the command line defines
>>> one, it will correspond to it. And if the command line doesn't define one,
>>> then it would also work because the PEF object is already there.
>>
>> How would you start a non-protected VM?
>> Currently it's the "-machine"
>> property that decides that, and the argument requires an id
>> corresponding to "-object".
> 
> If there's only one object, there's no need to specify its id.

This answers my question.  However, the property is defined for all
machines (it's in the "machine" class), so if it takes the id for one
machine it does so for all of them.

Paolo


