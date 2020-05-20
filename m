Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3637C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA702065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Su+h6lLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA702065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJvZ-0007qU-SM
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbJux-0007Qt-OK
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:17:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbJux-0001ys-13
 for qemu-devel@nongnu.org; Wed, 20 May 2020 04:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589962653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWiUdBfvnxMbEYh/pkGKmvvgVggmo7ESA+YK4mCP3OQ=;
 b=Su+h6lLVadmlcX+HOW5FpNvU1t0rwUrQroY6ttqN86/B8Jeokkad7JLNdhFDCQvI4haDlj
 IzR4S/iV6a5tglLMO1CvgLuSKg2Am+/b370GsvbGXYF/uGaznciqzae7V/sgc4zE9zYIFS
 zmyE947OZhF2MardhLyVLPjV51UIreg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-5GiKvu2PM5C4XQWYgK0shQ-1; Wed, 20 May 2020 04:17:30 -0400
X-MC-Unique: 5GiKvu2PM5C4XQWYgK0shQ-1
Received: by mail-wr1-f70.google.com with SMTP id y7so1069306wrd.12
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 01:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BWiUdBfvnxMbEYh/pkGKmvvgVggmo7ESA+YK4mCP3OQ=;
 b=JqueFUSzRTPzQ2KUb125TKYHo/FcSfSikIItrQi1/0iYqgD6ULU+mu+xF97yuimMBE
 t/WIBgIbLjMCeqYjJef4sE6OydOTx93+LPnA5yxxpUqStg9QfW5ATmr5+w4xW8oIDHNs
 EluzCPfwH3BQrvWVoz1jau5wop/kBoCBymHOqyvRtrQy7BdRg2iAQgtBXNYWEl9Psp3d
 aIiRnkW6lVGVQQQlM98XD12ybJ02u6DBuj9tOoX0JfWhi0WhRuN2L+XmTMq7u2kfXpIf
 llPqIV4xdRaHs3mBNf4O+H/ItZbJ2oBSdnltpo+HuWAS+j+4+1M8ndFaYXxMVzdRbDKs
 mB/A==
X-Gm-Message-State: AOAM532vCB9S8uLiW6k38uZN2z6nftGGvKf5cKrzjt1aW7wZIqr7TOgK
 Fqdi+uzntou7xfy3P8wx+QfYOC7sPoWt/FS4SOfQM/CBIIW9cB7J6hBaco7Nh5bUpdPjZYHnVDz
 K6ItKoTuiJZ62+9E=
X-Received: by 2002:a5d:5404:: with SMTP id g4mr3013933wrv.310.1589962648819; 
 Wed, 20 May 2020 01:17:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+xU+5cUr8voPDRq4j/MqbHYE7QZ0UGzqBhWQcwXFrGUu2c9UxnZmq2A9w7mZzKwqsIcR4GQ==
X-Received: by 2002:a5d:5404:: with SMTP id g4mr3013910wrv.310.1589962648600; 
 Wed, 20 May 2020 01:17:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:60b0:79b4:e56:bfb5?
 ([2001:b07:6468:f312:60b0:79b4:e56:bfb5])
 by smtp.gmail.com with ESMTPSA id r11sm227480wre.25.2020.05.20.01.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 01:17:28 -0700 (PDT)
Subject: Re: [PATCH 03/55] qdev: New qdev_new(), qdev_realize(), etc.
To: Markus Armbruster <armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-4-armbru@redhat.com>
 <9b329adc-8110-c108-996a-3b7d8463d042@redhat.com>
 <871rnft498.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3c59472-9f2a-f30a-deed-36192840a892@redhat.com>
Date: Wed, 20 May 2020 10:17:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <871rnft498.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/20 10:11, Markus Armbruster wrote:
>> On 19/05/20 16:54, Markus Armbruster wrote:
>>> +
>>> +    object_ref(OBJECT(dev));
>>> +    object_property_set_bool(OBJECT(dev), true, "realized", &err);
>>> +    if (err) {
>>> +        error_propagate_prepend(errp, err,
>>> +                                "Initialization of device %s failed: ",
>>> +                                object_get_typename(OBJECT(dev)));
>>> +    }
>>> +    object_unref(OBJECT(dev));
>> Why is the ref/unref pair needed?  Should it be done in the realized
>> setter instead?
> Copied from qdev_init_nofail(), where it is necessary (I figured out why
> the hard way).  It doesn't seem to be necessary here, though.  Thanks!

Why is it necessary there?  It seems a bit iffy.

Paolo


