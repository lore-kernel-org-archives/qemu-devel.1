Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB15C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82572065D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 05:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQV3BoVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82572065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqVdf-00053I-2U
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 01:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqVcy-0004bx-Vy
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:49:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23058
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqVcw-0004wJ-M7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 01:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593582585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+yBPnjmpehPev1iRxXrLx7KrY/xzdhXJtRLK0rtuPY=;
 b=YQV3BoVRQMt6E94LffF19tmVzS5c3c8nmZlu7OeYAJ18zIOKm3RoQsnBEC8aFJc+JSrEwh
 ZXxIsEHhELtjvCq0QRvq7+tOWlphhf4q7OIbrwUZiDcwusZEWRy9DDG6zvAkh0OwtRtwOx
 d+tRjaXWuAjM6DQC8IvLXi8FRgMaN7U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-_Xjeu5JHMDqGU_YHetXniw-1; Wed, 01 Jul 2020 01:49:43 -0400
X-MC-Unique: _Xjeu5JHMDqGU_YHetXniw-1
Received: by mail-ej1-f71.google.com with SMTP id do21so14067465ejc.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 22:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i+yBPnjmpehPev1iRxXrLx7KrY/xzdhXJtRLK0rtuPY=;
 b=g3bJtN5fy7gndl4dFUpWCPyZ3owQCw0PDe3YTM7LmdHR2rb3P0WY7r7oYsfoGVOxpB
 Lz/AYPU+Fz+R8fnVqGLi405khTqQ3STkKJIL62urHQ2dUqmZ3qQBymQ4+dy7GkARMua1
 NXhZJ6SllGNUt0z7cZVOTBvqizPhjmN2lzxCzk+d6cUJyYGaQXk5WijpnsQahec151UL
 F9c+w/RBROR0K5XUG+0UIyp4hvUom2hBgVMm2KrPioVg+NKkuumYItWc4IEYd8e6W4Y+
 G6M3BVq0A/rO6HFN13GtzMzeOCCms5UuTAZbR43k5B3tWH2V+4MpVk1VTAw4M22+8Rpw
 4HRg==
X-Gm-Message-State: AOAM531ke0WTl06tYfNHFx6f7TERHcVXuFFKRuMdvcEvkbM5aF1nZYCq
 aYOTlbdIur3l+a+taMMnUM/YDlZX/yW6pEOWPGwUlDR4q2zwiDgjALXyfeQkX9amvTtRzWOr7hL
 TZaWHqkwgg5JjdoI=
X-Received: by 2002:a17:906:3787:: with SMTP id
 n7mr20655471ejc.551.1593582582626; 
 Tue, 30 Jun 2020 22:49:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+Wsmn12/QxAwjhf2xZjVtu3GNdc4ClyU9sRuKBmn/U707px56eKOA6xHQvqY+/+V0EpEgiA==
X-Received: by 2002:a17:906:3787:: with SMTP id
 n7mr20655460ejc.551.1593582582410; 
 Tue, 30 Jun 2020 22:49:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1142:70d6:6b9b:3cd1?
 ([2001:b07:6468:f312:1142:70d6:6b9b:3cd1])
 by smtp.gmail.com with ESMTPSA id t25sm3811506ejc.34.2020.06.30.22.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 22:49:41 -0700 (PDT)
Subject: Re: [PATCH] pc: fix leak in pc_system_flash_cleanup_unused
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200701015859.29820-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <edb74f76-57a0-ef4b-17fa-f9f4b5dae8bc@redhat.com>
Date: Wed, 1 Jul 2020 07:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200701015859.29820-1-alxndr@bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 03:58, Alexander Bulekov wrote:
> fix a leak detected when building with --enable-sanitizers:
> ./i386-softmmu/qemu-system-i386
> Upon exit:
> ==13576==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 1216 byte(s) in 1 object(s) allocated from:
>     #0 0x7f9d2ed5c628 in malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5)
>     #1 0x7f9d2e963500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.)
>     #2 0x55fa646d25cc in object_new_with_type /tmp/qemu/qom/object.c:686
>     #3 0x55fa63dbaa88 in qdev_new /tmp/qemu/hw/core/qdev.c:140
>     #4 0x55fa638a533f in pc_pflash_create /tmp/qemu/hw/i386/pc_sysfw.c:88
>     #5 0x55fa638a54c4 in pc_system_flash_create /tmp/qemu/hw/i386/pc_sysfw.c:106
>     #6 0x55fa646caa1d in object_init_with_type /tmp/qemu/qom/object.c:369
>     #7 0x55fa646d20b5 in object_initialize_with_type /tmp/qemu/qom/object.c:511
>     #8 0x55fa646d2606 in object_new_with_type /tmp/qemu/qom/object.c:687
>     #9 0x55fa639431e9 in qemu_init /tmp/qemu/softmmu/vl.c:3878
>     #10 0x55fa6335c1b8 in main /tmp/qemu/softmmu/main.c:48
>     #11 0x7f9d2cf06e0a in __libc_start_main ../csu/libc-start.c:308
>     #12 0x55fa6335f8e9 in _start (/tmp/qemu/build/i386-softmmu/qemu-system-i386)
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
> 
> I am not very familiar with the QOM, so maybe this isn't the right way
> of going about this. With the call to object_property_add_child in
> pc_sysfw.c:pc_pflash_create, object_ref is called on the pflash device.
> In the pc_system_flash_cleanup_unused function, there are calls to
> object_propery_del and object_unparent, but it seems neither of these
> calls object_unref. So do we need to manually decrement the refcount?

Yes; you can also add it in pc_pflash_create, because

    /*
     * Since object_property_add_child added a reference to the child object,
     * we can drop the reference added by object_initialize(), so the child
     * property will own the only reference to the object.
     */

(from object_initialize_childv).

Paolo

>  hw/i386/pc_sysfw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index ec2a3b3e7e..f69a93671a 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -123,6 +123,7 @@ static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>              object_property_del(OBJECT(pcms), prop_name);
>              g_free(prop_name);
>              object_unparent(dev_obj);
> +            object_unref(dev_obj);
>              pcms->flash[i] = NULL;
>          }
>      }
> 


