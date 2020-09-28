Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7774AC4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F130920739
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAneCg6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F130920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMspN-0006Q3-Um
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMsUd-00024P-AH
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:42:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kMsUZ-0006OD-1r
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:42:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601296974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hzLYBFyyNMraP7fr3lwKCtCNrSkXv/KH9vRNL1ePOWY=;
 b=eAneCg6HDLCEAedAr/3KnYmccT7AMFRzP4zUfJG44SAumQkS+vtTVLTTFb4z0+QkYqVxXT
 8anwkUi9OxrxQq4Z+JbBfeNEvNLpiCXG+QBuwzY0Sf1vQJgu9R7fDEuorfgbyfG1+fTL7A
 dw1XocjVQAvUmEYQUxNbJfinepd0qYU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-sWfAxP7MP1eKkG67YkfLVg-1; Mon, 28 Sep 2020 08:42:51 -0400
X-MC-Unique: sWfAxP7MP1eKkG67YkfLVg-1
Received: by mail-wr1-f69.google.com with SMTP id l17so358714wrw.11
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 05:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hzLYBFyyNMraP7fr3lwKCtCNrSkXv/KH9vRNL1ePOWY=;
 b=ObTX7OV0YR9P7anCztH6FaiOC/DlwOAEpvVmYzpUyFsjE++7db4zs/nVs52SWP0i5a
 vCYrw/ymXt6rcp5/0P5Kn+U4kOcx+gFjuM3YC9jGRN/WTOpBt/M32UK6OGxgCszcvUJK
 02JP6WqZMQ9o3XCi5FZ6w/D8/PffXxzNk6r9PUQ4Bkkn0O7vW/sfr2oIl4awqvjj/9ON
 3VYGvAXPz8vZ8FhI2U9pMTUY7gGUItrJ4ABX22CeAOnFhDTcrybtFK9ikKOid0jirj9i
 17mjxtqm74H0XykMClvAKSVOhWI7sR/3eYF+BjDVOI+HNmIMhEQU9QPcNxvc4oDt0ZYF
 fDzA==
X-Gm-Message-State: AOAM5329d32Yf6KY26cv2EPvf5Ci6win3tznKxKQIyK2R8ArMbsXdPdL
 4PbBzX1UjZPK9d4z9XYhMrAzjtJRucX6HUldUGreF+TEZDxNc68T3H+kk28eh0C/980r9FFCn3C
 DmGtLEXiB/lPLOgo=
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr1477416wmk.10.1601296970380; 
 Mon, 28 Sep 2020 05:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvTkcXukZxuyk34IN3s4KtVOaqjptgYQr+gwfmUXoGpLLJAvzleBNmzsO/n3I68SPVbXCrYg==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr1477396wmk.10.1601296970141; 
 Mon, 28 Sep 2020 05:42:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4f8:dc3e:26e3:38c7?
 ([2001:b07:6468:f312:f4f8:dc3e:26e3:38c7])
 by smtp.gmail.com with ESMTPSA id q4sm1286887wru.65.2020.09.28.05.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 05:42:49 -0700 (PDT)
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <265f5d9a0fb10ce5e782455839d1baf678dbac48.1601203436.git.qemu_oss@crudebyte.com>
 <7aba6fc7-6d9b-25b5-9dbf-04e15314707c@redhat.com> <3365834.oEZqtqHOuS@silver>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95ef57d0-b35e-f16a-f957-06bc3692cb7c@redhat.com>
Date: Mon, 28 Sep 2020 14:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3365834.oEZqtqHOuS@silver>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/09/20 13:56, Christian Schoenebeck wrote:
>> The implementation in patches 1 and 2 is reasonable, but what is the
>> advantage of this as opposed to specifying the fsdev in the edge options
>> for the test (similar to virtio-net)?  I was expecting both
>> virtio-9p-device-synth and virtio-9p-device-local to produce virtio-9p,
>> so that the existing tests would be reused automatically by the qos
>> graph walk.
>>
>> As things stand, I don't see any reason to have separate devices for
>> different backends.
> 
> I thought to fix the problem at its root, by removing that singular device 
> limitation in qos. That would also allow to cleanly separate tests suites that 
> are not related to each other instead of having to depend on each other, 
> taking care about other one's command line skeleton and more.

As I said, the first two patches make total sense.  They would be useful
for testing both packed and split virtqueues, for example.  However, I
think the (useful) feature is being misused here.

> So your suggested solution is fine for appending extra arguments past the 
> command line. However I would not be able to prepend something (easily) in 
> front of '-device virtio-9p-pci'.
> 
> So I would be forced to parse the existing command line in modifycmdline() 
> callback and then insert the required arguments appropriately. I would not 
> find that very clean.

IIRC -fsdev can be added to the end of the command line and it still
works.  But if you think that is ugly, you can also use g_string_prepend.

Also, looking at future plans for qgraph, adding a generic "plug/socket"
mechanism to QOSGraph was an idea that we couldn't do in time for GSoC.
With that model, virtio-9p would provide a "socket" of type fsdev and
the tests would have to provide a "plug" of the same type.  Likewise
there would be sockets of type disk or network.  QOSGraphEdgeOpts fits
better with that plan, compared to duplicating the devices.

Paolo


