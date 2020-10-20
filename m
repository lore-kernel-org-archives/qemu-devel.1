Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B84C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716E4206CA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BpeWU7Cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716E4206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuji-0006fF-F6
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUuYz-0001Z6-6e
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUuYv-0000Cf-MZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603211554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBJSIk2O6RXCCa2bdwMEJbUFi81kXeBpz4bx/4z6zs0=;
 b=BpeWU7CliQQ2Q2rCtBgKYpb3zEzs0pA58hZiEd0f2jzXp8mpKhQ0bd8XaAW1818Fh4ZKsA
 Sz3RPO/WjC8frsHVonK5dKyITG9SHjwXKuR/5s804EuRsN65KpaSmagVjkLF9o17jmUtMa
 zagLTQ6Og+jmkVhbFqsSW8MuCj1uSYs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360--NA9w3eiOt-Y8OC0lV5VxQ-1; Tue, 20 Oct 2020 12:32:32 -0400
X-MC-Unique: -NA9w3eiOt-Y8OC0lV5VxQ-1
Received: by mail-wr1-f72.google.com with SMTP id n14so1033244wrp.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JBJSIk2O6RXCCa2bdwMEJbUFi81kXeBpz4bx/4z6zs0=;
 b=DbxdQL9AxrE+bcPk/CU9Hw1X2lOcc7Ujl0J2Cd4T9vCJNB/xHIROyAd0HbBAaT4sBV
 CptJSBEGBk+5py8Tcur151pKAZKrzFYIdfHPSkdl0j4XnQb53Mev+lvQPVhzSgKoZcrd
 +xrd64XqkksHQxsg0WL6+uGWRUl6KFdqhmJrCWL8RXEcosdMVBkaa1hX3gklNTfRJ7KA
 hbhsqeZnJMIXYC50XJ6b45oP8QjP30zqNe+jT40pD61YjaDqToB9A8R/gGN1kiK69MTb
 vcLpbjUMftYNaMrDn/ZjyoeRsC4LZDObaqWlHm0Y5BxxSj/we3RU3OVSvpjXoDQVGRjO
 lv+Q==
X-Gm-Message-State: AOAM532qGM6AD7A2z7gEpw31vPwgr+RcN8AaBt7vLducPXWraNGWzdy+
 gBh8Vcbu5IEnQ4XOUv7FTDFRZtWbmCjLDHoF/SOwXSoCiiZXRr3qZ0p3V+tOzPNdBzzeaV5OdBz
 tfhSsRHigIPqJuCs=
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr4007784wmi.73.1603211551359; 
 Tue, 20 Oct 2020 09:32:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpI3V0EC9WbZ2CAJMbuXHk7vIaB+3rzCNPBJzsXs8wOLMVgC6iJjWpgIwrUg1mh3y213K1lw==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr4007767wmi.73.1603211551122; 
 Tue, 20 Oct 2020 09:32:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id s2sm3703990wmf.45.2020.10.20.09.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 09:32:30 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201020160504.62460-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] Remove deprecated -no-kvm option
Message-ID: <a8f9d6ad-9ce9-485f-754e-64a4fbe18817@redhat.com>
Date: Tue, 20 Oct 2020 18:32:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020160504.62460-1-thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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
Cc: qemu-trivial@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 libvir-list@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/10/20 18:05, Thomas Huth wrote:
> The option has never been mentioned in our documentation, it's been
> deprecated since years, it's marked with QEMU_ARCH_I386 (which does
> not make sense anymore since KVM is available on other architectures,
> too), it does not do anything by default in upstream QEMU (since TCG
> is the default here anyway), and we're spending too much precious time
> each year discussing whether it makes sense to keep this option as a
> nice suger or not... let's finally put an end on this and remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Mention the parameter in the "removed feature" section (thanks Paolo!)
> 
>  docs/system/deprecated.rst | 11 ++++++-----
>  qemu-options.hx            |  3 ---
>  softmmu/vl.c               |  4 ----
>  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 905628f3a0..9bae13bc01 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -27,11 +27,6 @@ System emulator command line arguments
>  The ``enforce-config-section`` parameter is replaced by the
>  ``-global migration.send-configuration={on|off}`` option.
>  
> -``-no-kvm`` (since 1.3.0)
> -'''''''''''''''''''''''''
> -
> -The ``-no-kvm`` argument is now a synonym for setting ``-accel tcg``.
> -
>  ``-usbdevice`` (since 2.10.0)
>  '''''''''''''''''''''''''''''
>  
> @@ -504,6 +499,12 @@ System emulator command line arguments
>  The ``name`` parameter of the ``-net`` option was a synonym
>  for the ``id`` parameter, which should now be used instead.
>  
> +``-no-kvm`` (removed in 5.2)
> +''''''''''''''''''''''''''''
> +
> +The ``-no-kvm`` argument was a synonym for setting ``-accel tcg``.

Changed this to ``-machine accel=tcg`` and queued, thanks.

(In case you're wondering, the difference is that it prevents ``-no-kvm
-accel kvm`` from working).

Paolo


