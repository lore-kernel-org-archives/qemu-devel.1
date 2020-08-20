Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D074C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B4F207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCtAUn1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B4F207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8fAH-0003X1-3O
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 03:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8f9f-0002qL-TI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 03:38:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24102
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8f9e-0006a6-9S
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 03:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597909113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3JvFu0p367ET1K4a2zkxTkMO4ccO7M8quMLnJpD1to=;
 b=jCtAUn1o2gFCVcDIK0sN4jbUKGh1nj6+hDpLKakxl4kVVyuZ04anTtlt9ej3AIFe/rMUpd
 H6jFkfqqXOG6DHWsLzaYDk9uLjTkrGp+QNfC17Rzs42Til0RlBAiVRomdEX2tQfbgrSOod
 QN7rXAVjc0rC6hM1MAazULxnBRCWJgg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-Wifca8KaOmyXthknEu2OpA-1; Thu, 20 Aug 2020 03:38:30 -0400
X-MC-Unique: Wifca8KaOmyXthknEu2OpA-1
Received: by mail-wr1-f70.google.com with SMTP id m7so334239wrb.20
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 00:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e3JvFu0p367ET1K4a2zkxTkMO4ccO7M8quMLnJpD1to=;
 b=MpHw+2hMkf2mR5RKwkQko6YwgSHbz1nsuC1YOsEvPDvqvwO3myJ8iU/q+92bsQxFj8
 wPqUdps/k5+C+AorZRmXyoDokulX8f3nYBjd7FHl6eWo41+6Llpi4XjC4mUFACeNFqVh
 TPP+TXH1MjcRgAO9zYOhj7kqiKmjRtQKKYNPwPk87Iwu8XGQ2NJ2X+SqgUKyviIwCxw5
 OA6QCDFuUGsUlV3rPowBDpc7Ve+bzu51Zu7hyFYwU6Ah9ka3dqFmrZOX8D7t1CJnLr2p
 zp2yjLs+b1HKPeRAd5onunZ/R0l2EkoCVklnP/iipFPQAQ9OdDfKPlXLdLoqvjCSAvOn
 U2Lg==
X-Gm-Message-State: AOAM532zPGqSxyH+gCkbT96HYRP4Y/8GHP65Dsja1wtD+NmXF3MlqF39
 YvqDUwupwVEPAXYKYMRMAxnEqQvYsi+iTBfwdm5mcQxF+fNvi5AdElu4eZCWB+RfpudyfG9cBLa
 9DEFz7GaivJe1R3I=
X-Received: by 2002:a1c:61d5:: with SMTP id v204mr2262360wmb.102.1597909109033; 
 Thu, 20 Aug 2020 00:38:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfNTIfv7AHV187vDeUaLxKSotQy/UA5HoL1H3Fi0uw0HcZ4lwXxYml7hS89iUGLWzwNguOaA==
X-Received: by 2002:a1c:61d5:: with SMTP id v204mr2262330wmb.102.1597909108830; 
 Thu, 20 Aug 2020 00:38:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745?
 ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
 by smtp.gmail.com with ESMTPSA id j11sm2314372wrq.69.2020.08.20.00.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 00:38:28 -0700 (PDT)
Subject: Re: [PATCH v7 4/7] scripts: add coroutine-wrapper.py
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200610100336.23451-1-vsementsov@virtuozzo.com>
 <20200610100336.23451-5-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f646e5fc-0a7f-4c34-77ff-70ec80be9968@redhat.com>
Date: Thu, 20 Aug 2020 09:38:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610100336.23451-5-vsementsov@virtuozzo.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/20 12:03, Vladimir Sementsov-Ogievskiy wrote:
> +        {struct_name} s = {{
> +            .poll_state.bs = {bs},
> +            .poll_state.in_progress = true,
> +
> +{ func.gen_block('            .{name} = {name},') }
> +        }};
> +
> +        s.poll_state.co = qemu_coroutine_create({name}_entry, &s);
> +
> +        return bdrv_poll_co(&s.poll_state);
> +    }}
> +}}"""
> +
> +
> +def gen_wrappers_file(input_code: str) -> str:
> +    res = gen_header()
> +    for func in func_decl_iter(input_code):
> +        res += '\n\n\n'
> +        res += gen_wrapper(func)
> +
> +    return prettify(res)  # prettify to wrap long lines
> +
> +
> +if __name__ == '__main__':
> +    print(gen_wrappers_file(sys.stdin.read()))
> -- 

For Meson support, you'll have to move the "cat" inside the script.  But
since func_decl_iter can work separately on each file, it's enough to do
something like

    for filename in sys.argv:
        with open(filename, 'r') as f:
           print(gen_wrappers_file(f.read()))

Paolo


