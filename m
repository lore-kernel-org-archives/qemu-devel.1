Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F2C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5802080A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLFtE5rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5802080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1B4-0007kZ-3E
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS17g-0005sI-NV
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS17c-0001DG-MS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602521787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKH2niLz7WpddERKMg0wUwnHCNeWSRXE81+6tD7Q0ZM=;
 b=fLFtE5rsvqbIVbm1jkgEGZ0s+inMi4R5AiVmgsHcuNs7/xTnSS56mtM8GjPuFvCoXz1eXu
 d14whQWoBV2Nu3qHdFa4YQ7KffoDfPygeWkCbNNnLB4hoVEyZeJzDZhgCcigbe58y55ld6
 g0JEfcLQYT6WtnPiY5psVsfikT1QkLQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-FMZf_TSePfa_T43WM-9_NA-1; Mon, 12 Oct 2020 12:56:25 -0400
X-MC-Unique: FMZf_TSePfa_T43WM-9_NA-1
Received: by mail-wr1-f71.google.com with SMTP id l15so9573587wro.10
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 09:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AKH2niLz7WpddERKMg0wUwnHCNeWSRXE81+6tD7Q0ZM=;
 b=OoI8DtHt1TkhiH0kJD/aZHra39u2LBecKlRKqsVU+hmopmn/b6arIQqSkrdm53s70F
 Y2rwYJoVMQPUwC4j2xdoTle5Wg+aTY/ugkxYtA1jYNe4zqgKGIcjgDTkzdKjc9XEV5r4
 mEg524hxitfB3VnJuAVZSPNtmKL4pHMezAEcOhq2rETjlLT9zJjsJoetWLuqXx/j2fNV
 N5wTzbpm5UjvG2PY+ylTC30Jej3mQXegUiJxvzSne/dSejsjQGkYB6/TL9KDVNBLnxTI
 Mu6qphDOKC70it/KCDAth085eAjf25dME2meguouBTttK3EHzUb1eRJCQTppGBXHG4NQ
 bOiQ==
X-Gm-Message-State: AOAM532mRtjb8oY1OLFtjoX+iQNdfmiJrg9qHzOyFqgCK7c7QGnNz/UB
 35ByLx/RTPmWuw96WnMky0tDz3F9NPJn5DmIM79CPhiq3EzMPAtDa0Q23oT4mbTNhi3qkCx9oGs
 p5v3HqmkXQo82Fss=
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr1321239wro.22.1602521784129; 
 Mon, 12 Oct 2020 09:56:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz5gbt3Cng6Me3aB4z9zJRIsfvJztYhUt8Js7eln2jh9EytzWVIawLQ9HmLmi6h+XKY5Sprg==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr1321215wro.22.1602521783866; 
 Mon, 12 Oct 2020 09:56:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7ffb:1107:73ba:dbcf?
 ([2001:b07:6468:f312:7ffb:1107:73ba:dbcf])
 by smtp.gmail.com with ESMTPSA id o6sm25695021wrm.69.2020.10.12.09.56.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 09:56:23 -0700 (PDT)
Subject: Re: [PATCH v7 02/13] qtest: Reintroduce qtest_qmp_receive
To: Thomas Huth <thuth@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org
References: <20201006123904.610658-1-mlevitsk@redhat.com>
 <20201006123904.610658-3-mlevitsk@redhat.com>
 <3dd3b467-6784-470c-cbfb-b7baf611abde@redhat.com>
 <f3098b68-2d6b-6c99-4658-5b3c32227832@redhat.com>
 <a09865ae-40ec-0fc7-0b95-2f039284d546@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c971fcf1-377f-8b4c-3a69-e464745abde5@redhat.com>
Date: Mon, 12 Oct 2020 18:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a09865ae-40ec-0fc7-0b95-2f039284d546@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/20 15:49, Thomas Huth wrote:
>> We chose to use the same name because the new version generally is the
>> one you want and, except for the handling of events, is exactly the same
>> as before.  In other words, I'm treating the new semantics more as a
>> bugfix than a feature.
>>
>> The only trap that backports of later patches could fall into is if they
>> want to look at events, but it would be caught easily because the test
>> would fail.
> Ok, thanks for the explanation! ... but I think it might be good to have
> this information in the patch description, though.

Ok, I'll add a couple words.

Paolo


