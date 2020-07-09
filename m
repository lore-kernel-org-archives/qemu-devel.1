Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D2AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13A9206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 12:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLF+K82x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13A9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtVH1-0002Yq-5a
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 08:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtVFo-0001cK-Na
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:02:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtVFj-0007eN-85
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 08:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594296130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YX1sDgoP22ScqeHNk+xTLoG0T3XazrUr5HicImrn7tw=;
 b=LLF+K82xQHMk2Dy0a0SO0Dx/cwwasdvhcUEbJlC6dfLLUEZesfquOc+ed4xXjFBpYZKP1K
 JiB7jUfNcMdGN5PLIffcMOoKijaVGY94puJwu+xdaKKP+WJP3OYB4C1uneFbQM3fuEkI3S
 s7BsTsd9X6JrQKuoTyNztarWhxH2wyw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-FuJHJKAHNgGmUkPAphn3Og-1; Thu, 09 Jul 2020 08:02:08 -0400
X-MC-Unique: FuJHJKAHNgGmUkPAphn3Og-1
Received: by mail-wr1-f72.google.com with SMTP id y18so1741618wrq.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 05:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YX1sDgoP22ScqeHNk+xTLoG0T3XazrUr5HicImrn7tw=;
 b=lfKZTfmB+46hle/+W+AaSDpS0x1uqDmT4p3Q4FbqNp8jsirsjkRWdUVDte8G+z+IOG
 R2lVmtj8cfvT6QPZVvtobSyyJQ0x0AQ2VyVoir+B9cCcHWuI1kS52wM4XHz5UXgjC67R
 iUXZbAxKLRSsIyx6dQaIur7xsS1uzGnHUH4sAOKDCckFSEWf8yeL6dnj+m+ifKaZq7qB
 t5nr484RHY3G2FfWnTBUcQZS/Y3y60tiajRnLsw0uylyKXXWo6tfbjLDxEt/wq/lVCEX
 vJ0zwy/rpIMO+sPYTBDCCSXDUfUrfm1wblHryKqWsbnlDDBppRGVg/fq9WKm6SaVeB46
 KGtg==
X-Gm-Message-State: AOAM533CEJGxZxrL77P1teCdhY6w7m+uhUjc6KbCPX2dtn/wggiNlPnq
 s/+k0xq1RkB/b34lwxDnZwUJGFDE3vG2r5AED8RmZgj702StG7QYnW8tw1KUTBLZqzGz/Opa4I9
 9QyKfRDkagWUfbxM=
X-Received: by 2002:adf:f452:: with SMTP id f18mr62181669wrp.389.1594296127460; 
 Thu, 09 Jul 2020 05:02:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxj7l8wMoTdJtphiP4UaoyDkBXTrBbnSnXUlUG7PSPJfU9nq6ITwgIYhVDuM9fedlboXKCdNQ==
X-Received: by 2002:adf:f452:: with SMTP id f18mr62181642wrp.389.1594296127168; 
 Thu, 09 Jul 2020 05:02:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id e23sm4225122wme.35.2020.07.09.05.02.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 05:02:06 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] Implement drain_call_rcu and use it in
 hmp_device_del
To: Maxim Levitsky <mlevitsk@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
 <20200511160951.8733-3-mlevitsk@redhat.com>
 <87wo3csyn4.fsf@dusky.pond.sub.org>
 <36fae287a2b5e06c35facf22e5d9c16fbbf9908e.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75bd7143-450f-08a1-1195-7e3df730aafb@redhat.com>
Date: Thu, 9 Jul 2020 14:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <36fae287a2b5e06c35facf22e5d9c16fbbf9908e.camel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2eBerrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 13:56, Maxim Levitsky wrote:
> On Thu, 2020-07-09 at 13:42 +0200, Markus Armbruster wrote:
>> Maxim Levitsky <mlevitsk@redhat.com> writes:
>>
>>> This allows to preserve the semantics of hmp_device_del,
>>> that the device is deleted immediatly which was changed by previos
>>> patch that delayed this to RCU callback
>>>
>>> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>> ---
>>>  include/qemu/rcu.h |  1 +
>>>  qdev-monitor.c     |  3 +++
>>>  util/rcu.c         | 33 +++++++++++++++++++++++++++++++++
>>>  3 files changed, 37 insertions(+)
>>>
>>> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
>>> index 570aa603eb..0e375ebe13 100644
>>> --- a/include/qemu/rcu.h
>>> +++ b/include/qemu/rcu.h
>>> @@ -133,6 +133,7 @@ struct rcu_head {
>>>  };
>>>  
>>>  extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
>>> +extern void drain_call_rcu(void);
>>>  
>>>  /* The operands of the minus operator must have the same type,
>>>   * which must be the one that we specify in the cast.
>>> diff --git a/qdev-monitor.c b/qdev-monitor.c
>>> index 56cee1483f..70877840a2 100644
>>> --- a/qdev-monitor.c
>>> +++ b/qdev-monitor.c
>>> @@ -812,6 +812,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>>>          return;
>>>      }
>>>      dev = qdev_device_add(opts, &local_err);
>>> +    drain_call_rcu();
>>> +
>>>      if (!dev) {
>>>          error_propagate(errp, local_err);
>>>          qemu_opts_del(opts);
>>> @@ -904,6 +906,7 @@ void qmp_device_del(const char *id, Error **errp)
>>>          }
>>>  
>>>          qdev_unplug(dev, errp);
>>> +        drain_call_rcu();
>>>      }
>>>  }
>>>  
>>
>> Subject claims "in hmp_device_del", code has it in qmp_device_add() and
>> qmp_device_del().  Please advise.
> 
> I added it in both, because addition of a device can fail and trigger removal,
> which can also be now delayed due to RCU.
> Since both device_add and device_del aren't used often, the overhead won't
> be a problem IMHO.

Ok, just mention this in the commit message.  It may also be a good idea
to move it from qmp_device_add to the error-propagation section of
qdev_device_add.

Paolo


