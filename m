Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72586C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77D721D41
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF4QruYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77D721D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoiH-0005Mo-W4
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIoeC-0007tL-K6
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIoe7-0004o3-K3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600328878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DRSHwJ3siqpaLQ6jSS4qx4AZhN6S17Y/r2VTF3z9bew=;
 b=QF4QruYV3tCEuBuGXYMhKHSfsQ1YJN7DNDn1MRfrHY9BsVid4AYMU1k5uilCLC9vwCPtxX
 HQnXUMUrlrDccq24YG9VLX1jtGwOVOQLJsOerJPThpKqD+jXGBh93CecARjEyLBTSak0OB
 qKTv/LjiYTe1jnS0oV9siw15m3uwxRM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-mRQ1GwmTM4mR--qqYaO2Iw-1; Thu, 17 Sep 2020 03:47:57 -0400
X-MC-Unique: mRQ1GwmTM4mR--qqYaO2Iw-1
Received: by mail-wm1-f70.google.com with SMTP id m125so433364wmm.7
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DRSHwJ3siqpaLQ6jSS4qx4AZhN6S17Y/r2VTF3z9bew=;
 b=HD4pQaTu678MVpbcRnkkALX3NAytsW77HAP+P898L7L03hcnDB0XmEzMN28O0F4J+h
 rOervUQ5HZ0GwK46zfxqcnqNxzTySo2569WldPUhS4ag5AWN4rU47vStDTo2MOrkbDYc
 M+FZavc9F6zlhtiHcjz6PMh+Vr8IsYFJGS+MR6R+JwiAJhg+1VIJUtDMKOhg3P+9Zxk0
 dcgFItPc8sqXQr+xL9yEwJWWVODIwS5lpNT7Mc23B2tkQVVDiqqAdc7PVrBS2DkeUsF7
 LbvStGSrimJDxoWYIHt1XBAODSEGiW6Brmcp9G6njnlGIfWDoYoslmyXrJK28yYy/BD2
 58pw==
X-Gm-Message-State: AOAM530Uar5ow0khSdj/dazhH+8RMRnPJstGGFLDn1ub1MxL4ehCK8TG
 pjjn1QdWcvxhFLEQh9QB0QQl0wkhxlhzPfO+813Uw/l78l1US5eAuQHR9adzjXx5pNE6CX3m4gZ
 el/eVO1XwZ7nPR18=
X-Received: by 2002:a1c:6487:: with SMTP id y129mr9044881wmb.90.1600328875906; 
 Thu, 17 Sep 2020 00:47:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmXK9P0U/5g8yLEimePmsEcostcTmDRBJQtMchgH6LXa2BmZNCoCnRmiq+mBBjGIU2FPHuaQ==
X-Received: by 2002:a1c:6487:: with SMTP id y129mr9044865wmb.90.1600328875698; 
 Thu, 17 Sep 2020 00:47:55 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 11sm9645754wmi.14.2020.09.17.00.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 00:47:54 -0700 (PDT)
Subject: Re: [PATCH 2/5] qom: Remove ParentClassType argument from
 OBJECT_DECLARE_SIMPLE_TYPE
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200916182519.415636-1-ehabkost@redhat.com>
 <20200916182519.415636-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <1d10aff6-b9e8-4d2b-b4a6-6ad5f28a817b@redhat.com>
Date: Thu, 17 Sep 2020 09:47:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916182519.415636-3-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 8:25 PM, Eduardo Habkost wrote:
> The requirement to specify the parent class type makes the macro
> harder to use and easy to misuse (silent bugs can be introduced
> if the wrong struct type is specified).
> 
> Simplify the macro by just not declaring any class struct,
> allowing us to remove the class_size field from the TypeInfo
> variables for those types.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/authz/list.h                |  2 +-
>  include/authz/listfile.h            |  2 +-
>  include/authz/pamacct.h             |  2 +-
>  include/authz/simple.h              |  2 +-
>  include/crypto/secret_keyring.h     |  2 +-
>  include/io/dns-resolver.h           |  2 +-
>  include/io/net-listener.h           |  2 +-
>  include/qom/object.h                | 16 ++++++++--------
>  include/sysemu/vhost-user-backend.h |  2 +-
>  authz/list.c                        |  1 -
>  authz/listfile.c                    |  1 -
>  authz/pamacct.c                     |  1 -
>  authz/simple.c                      |  1 -
>  backends/dbus-vmstate.c             |  3 +--
>  backends/vhost-user.c               |  1 -
>  crypto/secret_keyring.c             |  1 -
>  io/dns-resolver.c                   |  1 -
>  io/net-listener.c                   |  1 -
>  ui/input-barrier.c                  |  3 +--
>  ui/input-linux.c                    |  3 +--
>  20 files changed, 19 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


