Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B6CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCC020784
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7cgu+Uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCC020784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZtt-000424-HX
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jYZsr-0002Uq-9C
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:44:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47937
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jYZsp-0004OV-PN
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589309042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLsoYb26KX1/As9vNOKU6m110aTWSTde6D0A4DCI8lc=;
 b=i7cgu+UuJv0y2CuxJr67dFPVwd4ZERlxO32MtxBMUg8aARyNE8mG8osIXNNO++vaB3/2wO
 6jVJZ5tgS6v/Ofhi9V4dGCLTBGAVeqaJtsb9N3NNprshBd4q0TtlMk+/T15cgmhuoPuEcd
 UfgHHAAFoOrMtDipU75EukYKKxcBWm0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-yIWRbFEWNcKJhmlNmEDr0Q-1; Tue, 12 May 2020 14:44:00 -0400
X-MC-Unique: yIWRbFEWNcKJhmlNmEDr0Q-1
Received: by mail-wr1-f71.google.com with SMTP id z10so3337972wrs.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iLsoYb26KX1/As9vNOKU6m110aTWSTde6D0A4DCI8lc=;
 b=m+wXmaLhIWi94JjTVUEUyhAxDuYJCMzH7fNf5BgCNHVqT0sThnkiNL29YTlA5uQjHm
 KuHBzr1FBqrkEwG6x3IrNxMmcUo3rBsuw2WUA81XFF6BjkoQ4HDcB8FK4J6QHU/a7t6Q
 dLA8Eju18Pv7HWKeErj1ywGLe+u1HJgUmsrBpfjL+3s9LGDbTeXmBtqMYBf3o31P+blY
 zbGEy2OtjyPsM91FnoyKK2/eg9G+Y2LOkf90b2XGbRiLf6jLjfSOEgpTV+PtylkBqC/x
 fc0tTW7LDIO/9+gLKaRrsazJZckz9syU9jcPJ5hZtEmwEnR75e4903cYPuA+MaxSt6+m
 L/KQ==
X-Gm-Message-State: AGi0Pua/X9plf8XEXN7HF3B/n2+16LYTdf6I1AuAI3aEMFpKdWn62p8T
 oa12HfszW4ACYSjYjJN8io3ZT6sFXFrBGx3vwQqPKYTzfz4FSW7yWaCHMZIftppZn6uDX6W25f4
 pw54UdWxyCIekEcw=
X-Received: by 2002:a5d:684a:: with SMTP id o10mr25872055wrw.311.1589309039865; 
 Tue, 12 May 2020 11:43:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypKloTaXoKHRHPiB0POnsTyy5np/aMiqjF+QgFYkjlz/jeJX0lCw7y0w4hW3oPoFK0imY3UpzQ==
X-Received: by 2002:a5d:684a:: with SMTP id o10mr25870302wrw.311.1589309014232; 
 Tue, 12 May 2020 11:43:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3045:ae65:70cb:daf1?
 ([2001:b07:6468:f312:3045:ae65:70cb:daf1])
 by smtp.gmail.com with ESMTPSA id g25sm31965218wmh.24.2020.05.12.11.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 11:43:33 -0700 (PDT)
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
To: Markus Armbruster <armbru@redhat.com>
References: <87tv0vzrwj.fsf@dusky.pond.sub.org>
 <6fc8633a-6d91-b83a-e6cd-5f714ccaf9ea@redhat.com>
 <875zda8j3m.fsf@dusky.pond.sub.org>
 <a4df3ba3-4759-56ac-68f8-f75eea93e27e@redhat.com>
 <87zhal4lef.fsf@dusky.pond.sub.org> <87o8qttaa9.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bc75209-ff3a-6226-2384-e643e4ab6d77@redhat.com>
Date: Tue, 12 May 2020 20:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87o8qttaa9.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 14:17:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/20 17:58, Markus Armbruster wrote:
> 
> Moving "put on qbus" from qdev_create() (and its wrappers) to
> qdev_init_nofail() means we put on bus by realizing.  No use to
> recursive realization then,

... for qdev_init_nofail; it may still be useful to *replace*
qdev_init_nofail with object_property_add_child+qdev_set_parent_bus, and
do recursive realization.  The bug wouldn't be hit as long as
qdev_set_parent_bus is only called after object_property_add_child.

Certainly not today though!

Paolo


