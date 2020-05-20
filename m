Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787AFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA7720709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd77BNom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA7720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRX5-0008Ah-Be
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbRVp-0007Jx-K4
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:24:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27423
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbRVo-0000Ir-LC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589991847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6RdMckO3vDPsPce9ugNs5u7JmGr0DYqgGL+C5tv+u4=;
 b=Wd77BNomX6z1LGT2/dkmZP/yQPgF2g04068aIW3KAO9i5ll/7Z4gD8eYnqlY5rX0ZBxm7w
 6cfefDEt4EUlPicl2yO1rCDrdNZgh2gO0FRtKowtYm1acI38KuZdLKbQ2dVjeBQIYVCjnr
 uhDYBnqYfsSBRTjiHJUsgKNHvZ4Iqy0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-uS1DiypNPOCa0TOVnKhwpQ-1; Wed, 20 May 2020 12:24:04 -0400
X-MC-Unique: uS1DiypNPOCa0TOVnKhwpQ-1
Received: by mail-wr1-f72.google.com with SMTP id p8so1615669wrj.5
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 09:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y6RdMckO3vDPsPce9ugNs5u7JmGr0DYqgGL+C5tv+u4=;
 b=iyu4ff/dhe/05MdX3CMHfJ5wIDJB+bu7eUHtbk29YzBdW/m6vlTw8XL4+vOh87T/in
 w03PZjpLUsa6+ihvjpDQdbCcNWGX8dljuCJM+JaWYJ6hATqeZDKKUEcClsi4wlvJ/0Su
 n+xi6wHF75L/QBCZ2+D/IZmd4QJNi+XPmVIxgn27Rb+63SKTfk9oNQvbaLBlauczYEFS
 hahWdgItV0vF+CwoEOTLb/H/5f9/f1KXS6S8WDe6lv9C7KQgoeFdWwjTxaRdAckuCboZ
 /JBADdXEbHr1vj+Nsvsv5ppjUtDdBMSs/SF9gDAIfKju65zPXQnojJ/NlTzXbF/YPXlm
 Lsdw==
X-Gm-Message-State: AOAM532gZvVGGT3FOHSK4wO8W2bvCviLPF/0v1M1m1zBjpYZZAhfUdR+
 xAkZpv6478MjaJQwHaoQVVW9ANaYgqTn/znl1msRUsHUjl+SvXlhJKA3+5blvPfeEtmFXuvYzNE
 HEvQqYXzTgSYA880=
X-Received: by 2002:a1c:bb0a:: with SMTP id l10mr5293922wmf.186.1589991842877; 
 Wed, 20 May 2020 09:24:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIyx5T1bjFoTVF7X3Kr0BBSc73ftQZB4qGTJ53Zr+dkHMsujMbr4hwMtEkxvcM/DnDqpPqcA==
X-Received: by 2002:a1c:bb0a:: with SMTP id l10mr5293911wmf.186.1589991842642; 
 Wed, 20 May 2020 09:24:02 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id l19sm3752148wmj.14.2020.05.20.09.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 09:24:02 -0700 (PDT)
Subject: Re: [PATCH 51/55] qdev: Make qdev_realize() support bus-less devices
To: Markus Armbruster <armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-52-armbru@redhat.com>
 <b0188311-e138-cf55-c0e9-52313b5aa906@redhat.com>
 <87lflmps2w.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b43c6cb-ac47-1fcb-72b4-e96ae00141b1@redhat.com>
Date: Wed, 20 May 2020 18:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87lflmps2w.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/20 17:02, Markus Armbruster wrote:
>>>
>>> qdev_realize_and_unref() remains restricted, because its reference
>>> counting would become rather confusing for bus-less devices.
>> I think it would be fine, you would just rely on the reference held by
>> the QOM parent (via the child property).
> I took one look at the contract I wrote for it, and balked :)
> 
> qdev_realize()'s contract before this patch:
> 
>     /*
>      * Realize @dev.
>      * @dev must not be plugged into a bus.
>      * Plug @dev into @bus.  This takes a reference to @dev.
>      * If @dev has no QOM parent, make one up, taking another reference.
>      * On success, return true.
>      * On failure, store an error through @errp and return false.
>      */
>     bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
> 
> Simple enough.
> 
> This patch merely adds "If @bus, " before "plug".  Still simple enough.
> 
> qdev_realize_and_unref()'s contract:
> 
>     /*
>      * Realize @dev and drop a reference.
>      * This is like qdev_realize(), except it steals a reference rather
>      * than take one to plug @dev into @bus.  On failure, it drops that
>      * reference instead.  @bus must not be null.  Intended use:
>      *     dev = qdev_new();
>      *     [...]
>      *     qdev_realize_and_unref(dev, bus, errp);
>      * Now @dev can go away without further ado.
>      */
>     bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
> 
> If @bus is null, who gets to hold the stolen reference?
> 
> You seem to suggest the QOM parent.  What if @dev already has a parent?

The caller would still hold the stolen reference, and it would be
dropped.  You cannot have a device that goes away at the end of
qdev_realize_and_unref, as long as dev has a QOM parent that clings onto
dev.  Since dev will have /machine/unattached as the parent if it didn't
already have one before, the function is safe even without a bus.

Or alternatively, ignore all the stolen references stuff, and merely see
qdev_realize_and_unref as a shortcut for qdev_realize+object_unref,
because it's a common idiom.

Paolo


