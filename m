Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D2C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7FB20714
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2AwK1bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7FB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEbp1-0004OD-Qk
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 12:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEboC-0003aE-1a
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEboA-0005WT-VB
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:44:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEboA-0005Vn-Qe
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584549882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhvKkHKLEWLbQDfbleXstrI9phcJJN9pqlwTCsDptPA=;
 b=X2AwK1bpCkr0PEn/H1kbtJ6m1KDCDV3jqw0GBFjDF/GpjKJ1VCOQeJ6EcAvTS86oYw3qTO
 PDb4ySgXfnKqIxbo7koUj+t9Kru7pH4BFTMf6SdIXN2fU5SyUmhaNhfMB3ZvKeCl6RzXyW
 QLPpc8CeahT44WDmnNyWisewID1PgWA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-QICPMYbkNNioUY-F0mG2xg-1; Wed, 18 Mar 2020 12:44:41 -0400
X-MC-Unique: QICPMYbkNNioUY-F0mG2xg-1
Received: by mail-wr1-f70.google.com with SMTP id d17so847074wrw.19
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 09:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JhvKkHKLEWLbQDfbleXstrI9phcJJN9pqlwTCsDptPA=;
 b=hjAju6+FxDl0UI4KdyFIWNR3lx+stNPIGR0BIiWCXC9nN3LqHvbJ3smiIiQ98qAxHY
 hv1S9gMba+imt3GPYSUfzXhvgW/O/zLSmAAS8TxuzZkYfVIbvzzZXOT8R4G73W7dWqLc
 Fj7RNXJPLJ6fAkMx6ERTQ5iQP5K+3THAMt5u3W2tayf/e6ijQJgZnWBVRj8OC2D/8Myn
 u5pIzkKl9Rq036kzTxSy7+oDy7cHfTqdIsP0mQGU73AbqusiRKwy5SMSQ+iRjZnR/+9B
 UlTKyBYSR2qmW/k4dPrV28/Azjcb1PgOGDbnDW5E+wf6WUnLreAPrT+LI6eS+l29bl2Z
 iwBw==
X-Gm-Message-State: ANhLgQ1k+SXnSZs118GmSY7+6aTxNgYCWAd2/k7XY9t85p62llHf07T5
 IjwUNZexzyzG6xy1dxlNbtq4/ZxYWN7pCgMVQEJ7UYWMIQgpQhlsomIRGjmfGNH9w6pwhwLwU3f
 v2Z34DNw6VpJv8Mo=
X-Received: by 2002:adf:ed06:: with SMTP id a6mr6517426wro.346.1584549879887; 
 Wed, 18 Mar 2020 09:44:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsXd7EdfOdVt4MIVndSrv8vg+RGR7JFKsk9HjL4tbmGHK8Uzuskfzg3mCVab9tC3YDMreemoQ==
X-Received: by 2002:adf:ed06:: with SMTP id a6mr6517400wro.346.1584549879626; 
 Wed, 18 Mar 2020 09:44:39 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id v10sm4287294wml.44.2020.03.18.09.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 09:44:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Markus Armbruster <armbru@redhat.com>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
 <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
 <e1ae65dd-f9cd-b0ee-0ea6-f3c2b010fdab@redhat.com>
 <87tv2p8y5j.fsf@dusky.pond.sub.org>
 <3f512e33-5875-eee4-bbe8-61e7b313743d@redhat.com>
 <87mu8g3kgj.fsf@dusky.pond.sub.org>
 <bd83fe53-6541-b04d-04d9-76ddd29e2b99@redhat.com>
 <875zf1ak9e.fsf@dusky.pond.sub.org>
 <d94927af-eb46-f704-6658-e3f321c4d8ed@redhat.com>
 <87d0997lei.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37da8765-267e-948b-a96f-24c43be7573f@redhat.com>
Date: Wed, 18 Mar 2020 17:44:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87d0997lei.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/03/20 16:06, Markus Armbruster wrote:
>> - object initialization should cause no side effects outside the subtree
>> of the object
> 
> object_initialize_child() and its users like sysbus_init_child_obj()
> violate this rule: they add a child property to the subtree's parent.
> Correct?

At least object_initialize_child() adds the property to the object
itself, so it's fine.

sysbus_init_child_obj() adds a link to the object to the sysbus object
(via qdev_set_parent_bus/bus_add_child).  This does violate the rule.
However, currently we have:

- create link on qdev_set_parent_bus, before realizing

- remove link on device_unparent, after unrealizing

which makes the device setup even more complicated than necessary.  In
other words I don't think the bug is in the function, instead it
probably makes sense to do something else:

- create link in device_set_realized, before calling ->pre_plug (undo on
failure)

- remove link in device_set_realized, after calling ->unrealize (if it
succeeds)

and leave sysbus_init_child_obj() as is.

>> - setting properties can cause side effects outside the subtree of the
>> object (e.g. marking an object as "in use"), but they must be undone by
>> finalization.
> 
> Textbook example is the 1:1 connection between device frontend and
> backend: block frontend's property "drive", char frontend's property
> "chardev", NIC frontend property "netdev", ...
> 
> Can we come up with some guardrails for what property setting may do?
> Affecting guest-visible state is off limits.  What else is?

Yes, guest-visible state is off limits until realization.

>> - realization can also cause side effects outside the subtree of the
>> object, but if unrealization is possible, they must be undone by
>> unrealization. if an object is realized and unrealization is not
>> possible, finalization will never run (and in that case, side effects of
>> realization need not be undone at all).
> 
> One possible answer the question what should be done in realize() is
> whatever must not be done earlier.  Is that the best we can do?

That's the lower bound of descriptivity.  The upper bound is anything
that is visible from the guest.  The truth could be in the middle.

Paolo


