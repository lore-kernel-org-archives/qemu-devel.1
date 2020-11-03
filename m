Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34CEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE91B206F1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STXfROuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE91B206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuvS-0000ic-Rs
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZuuX-000050-Dx
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:55:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZuuU-00086s-K7
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604404530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ytEHdZdOz3332Wg4700sB32IrDic/XkvBt0e0imP0s=;
 b=STXfROuflU+C3MwyLpI7BhyYV7WMjqBZ3Chu6kxN5X1NmwJNHI2Km6IIAJEVZ5Q72yvOKf
 62JUMhhug1oGQcyPpU4y7aNm/QIQiEPyx+YLk53WQLjnrVIwSRcRARUec7pXOp+1N7Ipxz
 emh+xbHOhMcs2TDoqxXg/tspSmmTJuA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-DDhTepkVPymQJSVasVSkMQ-1; Tue, 03 Nov 2020 06:55:28 -0500
X-MC-Unique: DDhTepkVPymQJSVasVSkMQ-1
Received: by mail-ed1-f72.google.com with SMTP id h6so7365804edt.12
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/ytEHdZdOz3332Wg4700sB32IrDic/XkvBt0e0imP0s=;
 b=a3QL6y5SGi6rOVppBigmuilz59IRbwgcsyPbEzQxK+S8mvDmu3xurxSM0nM2lstnRz
 Ryf8C/tu0nY6SF9K9a+gqlQCJOlSWmqtvsFjS1/A3/k3n2vMLTE1GTdTRIZQLeT7CVZU
 92shaMNf0BGAD5F9q18C7244QG71BGOFJ/8cwG6VckM0/Kcg403gdUWN441KHP8dCSCP
 nPIdRv5/BTX3pWDsJskv8+HGb/09ZcZBYwjlfE4YsTS5Rxn2KDhBweqfLYMZjnkwV4WM
 M8JYr/wSulhz8EnOXb+LM8+LEoTj8cqkJm/xv3ikuFiqJCiMwHS6j79BYY43qAU2wzf3
 Z1QQ==
X-Gm-Message-State: AOAM533d1ATOSshyQrYkOToKI3WrVNobCPYSR66iQE7Idstqb88+RwFi
 QoG2nVPfMMrA+6OcSef//BsWSjHTrariBzLUMMdhXt1j/fpw7vOS/jODKNaU1mpKXfvBKH33Cmw
 LXOAOAEPfyvIKWFs=
X-Received: by 2002:a17:906:2490:: with SMTP id
 e16mr19337430ejb.17.1604404527178; 
 Tue, 03 Nov 2020 03:55:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwP+JMVOdQQHd7OEFueSgggG55cJg862FWyXlFpvEqHsnc4ugfy6MWhdbp4vxNF8k72n+5IQQ==
X-Received: by 2002:a17:906:2490:: with SMTP id
 e16mr19337416ejb.17.1604404526920; 
 Tue, 03 Nov 2020 03:55:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id og19sm10099926ejb.7.2020.11.03.03.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 03:55:25 -0800 (PST)
Subject: Re: [PATCH] meson: vhost-user-gpu/virtiofsd: use absolute path
To: Marc Hartmayer <mhartmay@linux.ibm.com>, qemu-devel@nongnu.org
References: <20201103112333.24734-1-mhartmay@linux.ibm.com>
 <877dr28ysh.fsf@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4798e23a-da0b-22f6-05bd-2373768a241c@redhat.com>
Date: Tue, 3 Nov 2020 12:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <877dr28ysh.fsf@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 12:28, Marc Hartmayer wrote:
> On Tue, Nov 03, 2020 at 12:23 PM +0100, Marc Hartmayer <mhartmay@linux.ibm.com> wrote:
>> The option `libexecdir` is relative to `prefix` (see
>> https://mesonbuild.com/Builtin-options.html), so we have to be aware
>> of this when creating 50-qemu-gpu.json and
>> 50-qemu-virtiofsd.json. Otherwise, tools like libvirt will not be able
>> to find the executable.
>>
>> Fixes: 16bf7a3326d8 ("configure: move directory options from config-host.mak to meson")
>> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
>> ---
>>  contrib/vhost-user-gpu/meson.build | 2 +-
>>  tools/virtiofsd/meson.build        | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
>> index 37ecca13cafb..c487ca72c1ff 100644
>> --- a/contrib/vhost-user-gpu/meson.build
>> +++ b/contrib/vhost-user-gpu/meson.build
>> @@ -9,6 +9,6 @@ if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
>>
>>    configure_file(input: '50-qemu-gpu.json.in',
>>                   output: '50-qemu-gpu.json',
>> -                 configuration: { 'libexecdir' : get_option('libexecdir') },
>> +                 configuration: { 'libexecdir' : get_option('prefix') / get_option('libexecdir') },
>>                   install_dir: qemu_datadir / 'vhost-user')
>>  endif
>> diff --git a/tools/virtiofsd/meson.build b/tools/virtiofsd/meson.build
>> index e1a4dc98d9ec..17edecf55c0a 100644
>> --- a/tools/virtiofsd/meson.build
>> +++ b/tools/virtiofsd/meson.build
>> @@ -15,5 +15,5 @@ executable('virtiofsd', files(
>>
>>  configure_file(input: '50-qemu-virtiofsd.json.in',
>>                 output: '50-qemu-virtiofsd.json',
>> -               configuration: { 'libexecdir' : get_option('libexecdir') },
>> +               configuration: { 'libexecdir' : get_option('prefix') / get_option('libexecdir') },
>>                 install_dir: qemu_datadir / 'vhost-user')
>> -- 
>> 2.25.4
>>
>>
> 
> It’s probably not the best way to fix it, but at least a good hint
> what’s wrong :)

No, it's okay.  I queued it.

Paolo


