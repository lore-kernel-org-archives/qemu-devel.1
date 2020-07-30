Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E081CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADEEA2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxafCX7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEEA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1CAo-0002Zu-UZ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 13:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1CA0-000262-Mb
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:16:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34170
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k1C9x-0001gY-Oy
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596129359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SgypV2ZFjTrjr0UsmNPcmecq+zkQ/XC98hs+SU6dAXQ=;
 b=VxafCX7PqyogFVrs+B2nGZzyw7N+SN5BIGY8MVQJeNvdmADnw3CDMFthPrX8NFN866htDO
 p5r/RNMoSR9ssHP7CqUo+cHGuKrKiczTz/g0RzkNmqqdNYBgLY6ju9o7A822GkNvHzKDJ1
 rYyJ6urDx95KUFKld76wXKQ+5gNBU+E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-lu1nUpdQOx61xA1QIny29A-1; Thu, 30 Jul 2020 13:15:55 -0400
X-MC-Unique: lu1nUpdQOx61xA1QIny29A-1
Received: by mail-wm1-f69.google.com with SMTP id f74so2433562wmf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 10:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SgypV2ZFjTrjr0UsmNPcmecq+zkQ/XC98hs+SU6dAXQ=;
 b=kf13A0yfFSJNXRfOIqvx1DR16jJa9Oi4f4gV4q6pfjCCN99+tHLBL++pmyJbKbkjtb
 LQrKawqB8okHHTylAYXR8AFPyM895IZ8Hz1zmpFScCW4F0xpu3lSWmCkwOiRH2f3L6B0
 J9F2RDFcO0ofXxSmqkiNACeG/teWuuxLYbjN9FBTFj6kYCO4fxdtlLHRpODpWKjNNdp+
 uetggv9r4mxI7Q3MXragiRTXM+DB0UlBCgAAO7FlcXO4Xwjnvzo7XhmbIrAxL8YXTrh7
 pMkZkoZ9JsCxe+EeZRE8RduRJp5U6/S5BbcBEGW+U25vyDvJVWKY/aLM0apHEgUEMP65
 ZEAQ==
X-Gm-Message-State: AOAM530ZUY/VJ1eFBxclVlW9y8bj9uesq52lCkHC/HSM4Ldnf1iI8L/b
 5gg+XJhZpElxz5cQlc3SFXyRt2kp092b1gUMW6lQC/CMsDXnfw8e/Wg6qVAhFdtrzRlGO2iQiyH
 BQfeq09O9AbUZR/w=
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr3536632wre.45.1596129354068; 
 Thu, 30 Jul 2020 10:15:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBtdjkvjxxKeU7BlPCRcGS7ak49xFMeeuzpU2D/MH6FaO9Xo11UsCrtV89GWNKWrRyIxxbHA==
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr3536607wre.45.1596129353817; 
 Thu, 30 Jul 2020 10:15:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:310b:68e5:c01a:3778?
 ([2001:b07:6468:f312:310b:68e5:c01a:3778])
 by smtp.gmail.com with ESMTPSA id 68sm9965907wmz.40.2020.07.30.10.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 10:15:53 -0700 (PDT)
Subject: Re: [PATCH V1 00/32] Live Update
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37635d27-b63f-f200-fa89-ccb6f7eba7f6@redhat.com>
Date: Thu, 30 Jul 2020 19:15:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:51:24
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/20 17:14, Steve Sistare wrote:
> The first set of patches adds the cprsave and cprload commands to save and
> restore VM state, and allow the host kernel to be updated and rebooted in
> between.  The VM must create guest RAM in a persistent shared memory file,
> such as /dev/dax0.0 or persistant /dev/shm PKRAM as proposed in 
> https://lore.kernel.org/lkml/1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com/
> 
> cprsave stops the VCPUs and saves VM device state in a simple file, and
> thus supports any type of guest image and block device.  The caller must
> not modify the VM's block devices between cprsave and cprload.

Stupid question, what does cpr stand for?  If it is checkpoint/restore,
please spell it out.  Also, how does the functionality compare to
xen-save-devices-state and xen-load-devices-state?

> cprsave and cprload support guests with vfio devices if the caller first
> suspends the guest by issuing guest-suspend-ram to the qemu guest agent.
> The guest drivers suspend methods flush outstanding requests and re-
> initialize the devices, and thus there is no device state to save and
> restore.

This probably should be allowed even for regular migration.  Can you
generalize the code as a separate series?

Thanks,

Paolo


