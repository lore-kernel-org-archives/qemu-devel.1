Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F359EC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 14:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3316D206A4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 14:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxYOQJla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3316D206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kblKl-0000oM-2R
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 09:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kblJd-0008S4-Hj
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 09:05:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kblJa-0005vk-Vp
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 09:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604844305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3tc0dZPokXF+04RHYPNBEJt0GpVK3C0ucYU4ln5Kjs=;
 b=FxYOQJlat3KB9OVRlxmINT8mGU8YSQ1VE7aLZ8Mpcf0/VPopeKESTRa5/WsGUNylDBnb9c
 cAXLMMVK79/+iREsZVr0A5vCsC7TcyENpNNhAduMzUTVXqrX1U1htTXIazZ9SEKKldXbhV
 RogT5ts6jBdjCpKBp59EGuQZjdxLmDY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-QvWiUgDbNIq3G6Bbq5m_bw-1; Sun, 08 Nov 2020 09:05:03 -0500
X-MC-Unique: QvWiUgDbNIq3G6Bbq5m_bw-1
Received: by mail-wm1-f70.google.com with SMTP id 3so1484909wms.9
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 06:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y3tc0dZPokXF+04RHYPNBEJt0GpVK3C0ucYU4ln5Kjs=;
 b=ub0jQDsbfXk7aNzdx7cBMiV0cnTHd9bymQDotVLNz7+Mwtj/7MNPeBsHMhekNVgMF3
 WRj2szZsC6zeOLu60bSQ2pnT1OVknzofQE/9XznnhUy4CFAx2UbkWzx7RIIAaW0xG5ia
 Ejy7YVBCHtqZsrJOOniB8NH1fIxeVXlc0ahiJ3LTyTdijSuV42l29pil2ojGPOTIhV0r
 ymkSgwsKox0EgXtiG9SCux99UUb5UutDsMQqmFgmFXEgoxjUgUUI6ShA7XPl2npHrj1q
 UkiQzeGfmEdlM/o/2VR9HGsbpvPFUqhMvYZBWyMmvH6KxujDV3h6e+hAkeLYx9Zjk30T
 u+Lg==
X-Gm-Message-State: AOAM533aYEFdsUnY553C2YQDhfJwhO7WNGs0pXI7GCGU/Yt54V+zH8h7
 Broj1YN6WZDu0PPRwYR9bceD9rPlFkn4bG6hubShQsxBbCUu8DX/NI5UA6eWR6VDv3gGpxDe6ss
 xrOD6mWvjYfQatzU=
X-Received: by 2002:a1c:b0ca:: with SMTP id z193mr9533787wme.82.1604844302101; 
 Sun, 08 Nov 2020 06:05:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpUs88ZPBJSjAFiFym5VfcrTNlFtPfWa0ZlZNz41aVOx0M2MOo46Xk7SdSrz/OeY/T0wam+Q==
X-Received: by 2002:a1c:b0ca:: with SMTP id z193mr9533757wme.82.1604844301846; 
 Sun, 08 Nov 2020 06:05:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:73b1:3acc:3ebd:4fd4?
 ([2001:b07:6468:f312:73b1:3acc:3ebd:4fd4])
 by smtp.gmail.com with ESMTPSA id 89sm10771270wrp.58.2020.11.08.06.05.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 06:05:01 -0800 (PST)
To: Eduardo Habkost <ehabkost@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201106094511.GA23864@merkur.fritz.box> <20201106155013.GX5733@habkost.net>
 <20201106211034.GY5733@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
Date: Sun, 8 Nov 2020 15:05:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106211034.GY5733@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:02:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/11/20 22:10, Eduardo Habkost wrote:
> This was implemented at:
> https://gitlab.com/ehabkost/qemu/-/commits/work/qdev-make-generic
> 
> This is the interface I'd like to submit as v3:
> 
> static Property machine_props[] = {
>      DEFINE_PROP_STRING("kernel", MachineState, kernel_filename,
>                         .description = "Linux kernel image file"),
>      DEFINE_PROP_STRING("initrd", MachineState, initrd_filename,
>                         .description = "Linux initial ramdisk file"),
>      DEFINE_PROP_STRING("append", MachineState, kernel_cmdline,
>                         .description = "Linux kernel command line"),
>      DEFINE_PROP_STRING("dtb", MachineState, dtb,
>                         .description = "Linux kernel device tree file"),
>      DEFINE_PROP_STRING("dumpdtb", MachineState, dumpdtb,
>                         .description = "Dump current dtb to a file and quit"),
>      DEFINE_PROP_STRING("dt-compatible", MachineState, dt_compatible,
>                         .description = "Overrides the \"compatible\" "
>                                        "property of the dt root node"),
>      DEFINE_PROP_STRING("firmware", MachineState, firmware,
>                         .description = "Firmware image"),
>      DEFINE_PROP_STRING("memory-backend", MachineState, ram_memdev_id,
>                         .description = "ID of memory backend object"),
>      DEFINE_PROP_BOOL("dump-guest-core", MachineState, dump_guest_core, true,
>                       .description = "Include guest memory in a core dump"),
>      DEFINE_PROP_BOOL("mem-merge", MachineState, mem_merge, true,
>                       .description = "Enable/disable memory merge support"),
>      DEFINE_PROP_BOOL("graphics", MachineState, enable_graphics, true,
>                       .description = "Set on/off to enable/disable graphics emulation"),
>      DEFINE_PROP_BOOL("suppress-vmdesc", MachineState, suppress_vmdesc, false,
>                       .description = "Set on to disable self-describing migration"),
>      DEFINE_PROP_UINT32("phandle-start", MachineState, phandle_start, 0,
>                         .description = "The first phandle ID we may generate dynamically"),
>      DEFINE_PROP_END_OF_LIST(),
> };
> 
> static void machine_class_init(ObjectClass *oc, void *data)
> {
>      ...
>      object_class_add_field_properties(oc, machine_props, prop_allow_set_always);
>      ...
> }

If all properties were like this, it would be okay.  But the API in v2 
is the one that is most consistent with QOM in general. Here is how this 
change would be a loss in term of consistency:

- you have the field properties split in two (with the property itself 
in one place and the allow-set function in a different place), and also 
you'd have some properties listed as array and some as function calls.

- we would have different ways to handle device field properties (with 
dc->props) compared to object properties.

- while it's true that the QEMU code base has ~500 matches for 
"object*_property_add*" calls, and ~2100 for "DEFINE_PROP*", the new 
field properties would pretty much be used only in places that use 
object_class_property_add*.  (And converting DEFINE_PROP* to PROP* would 
be relatively easy to script, unlike having an array-based definition 
for all uses of object_class_property*).

The choice to describe class properties as function calls was made in 
2016 (commit 16bf7f522a, "qom: Allow properties to be registered against 
classes", 2016-01-18); so far I don't see that it has been misused.

Also, I don't think it's any easier to write an introspection code 
generator with DEFINE_PROP_*.  You would still have to parse the class 
init function to find the reference to the array (and likewise the 
TypeInfo struct to find the class init function).

Paolo


