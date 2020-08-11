Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA03C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753BD206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVmKvofb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753BD206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Xu5-00026Z-Nz
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5XtJ-0001gX-RJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:16:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5XtG-0006bX-Md
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597166205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0LEtk4EXEzrNMW0otDfDgjwGl+ZOOaivj7cvR1FXmE=;
 b=RVmKvofbdAO52MWfSk1fAJQfSF8XcEn8k32JlSiVgwq6DPp2Lp/SWHGQLktFCk92fVACgr
 yPL1G90yFyduxry3QJDE4eOPutz+6Rkn2VosV/M13v4bqgG9QDq7uchOKdf5UO98eoRNeQ
 GFFPS7dnMx8GGNCeVgEQ860g4gA1Mf0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-DVrhHLPFNaeJkXtDhAVOOg-1; Tue, 11 Aug 2020 13:16:41 -0400
X-MC-Unique: DVrhHLPFNaeJkXtDhAVOOg-1
Received: by mail-wr1-f69.google.com with SMTP id 89so5815323wrr.15
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 10:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T0LEtk4EXEzrNMW0otDfDgjwGl+ZOOaivj7cvR1FXmE=;
 b=hXnnVaMKLPbE0biFOckR6/lRC/ef9rWbmPp5qzgOx6Jmd4t2h2VbxKPCpwCW/njrDw
 TjS5cQOXjfER5fBiuAhMda7GVHlzTuscc3lbCnlkCqlMlgpTBLVAII4wsL22TSK692x0
 nT+52yYb9oloe7ssgrV1b+h7S6QH9Z3t34hBCVrqHlxVI1mOLCTr8mKPAUU/VI+57ZXl
 iFZ95UjCK+0ItvK3mt0eeHiz0D1ZgyZ7BE8DvJVsi2eD26ZG7rZAQgoThBhmqVigkgWO
 hWfer5CKE9ny2DqOpBme/hE4CxSUBhdYf1kpdIj/oni4If0BTF/02s0LrnGb3eUfPL7M
 Qsgw==
X-Gm-Message-State: AOAM531iFhJeNeXVcxb02BL3+pVjR+T5E7soYTlt/dUC0Uxdj+MykAxC
 2ApcXcoAjGPSvjMtwF9XY6II0vmxdtz/o65JWUgmAmjeNy3lbv8KB2q6rYyhRS7i5kCcS5cfU5s
 O5GV2T8mgt6GDc0c=
X-Received: by 2002:a1c:5459:: with SMTP id p25mr4969625wmi.85.1597166199772; 
 Tue, 11 Aug 2020 10:16:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVW4upJNGTZfigVcufNZDSks5WcXiBS5Y4s0UZtKPVXifOQ7qP56N+iAO4gCwpMTr1zcyHig==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr4969611wmi.85.1597166199475; 
 Tue, 11 Aug 2020 10:16:39 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.12.249])
 by smtp.gmail.com with ESMTPSA id 33sm28567753wri.16.2020.08.11.10.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 10:16:38 -0700 (PDT)
Subject: Re: [PATCH 139/147] meson: replace create-config with meson
 configure_file
To: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-140-git-send-email-pbonzini@redhat.com>
 <21cc800d-c8bf-b737-1059-b83044ad9271@redhat.com>
 <3fa2ac37-b2c1-cc90-28b0-e8361472b331@redhat.com>
 <20200811171202.dx3vxjbxdoj5hcxw@mozz.bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d46d239-cc2f-7d28-3db2-c01c4d42ae58@redhat.com>
Date: Tue, 11 Aug 2020 19:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200811171202.dx3vxjbxdoj5hcxw@mozz.bu.edu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/08/20 19:12, Alexander Bulekov wrote:
> On 200811 1825, Philippe Mathieu-Daudé wrote:
>> On 8/11/20 6:20 PM, Philippe Mathieu-Daudé wrote:
>>> On 8/10/20 7:08 PM, Paolo Bonzini wrote:
>>>> Move the create-config logic to meson.build; create a
>>>> configuration_data object and let meson handle the
>>>> quoting and output.
>>>>
>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> ---
>>>>  Makefile                       |   2 +-
>>>>  block.c                        |   4 +-
>>>>  configure                      |   9 ++-
>>>>  meson.build                    | 100 ++++++++++++++++++++++---------
>>>>  scripts/create_config          | 131 -----------------------------------------
>>>>  tests/qtest/bios-tables-test.c |   2 +-
>>>>  6 files changed, 80 insertions(+), 168 deletions(-)
>>>>  delete mode 100755 scripts/create_config
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index cd4eeb5..1eec727 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -189,7 +189,7 @@ clean: recurse-clean
>>>>  	rm -f fsdev/*.pod scsi/*.pod
>>>>  	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
>>>>  
>>>> -VERSION ?= $(shell cat VERSION)
>>>> +VERSION = $(shell cat $(SRC_PATH)/VERSION)
>>>>  
>>>>  dist: qemu-$(VERSION).tar.bz2
>>>>  
>>>> diff --git a/block.c b/block.c
>>>> index 67c5028..67ca543 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -443,13 +443,13 @@ static int bdrv_format_is_whitelisted(const char *format_name, bool read_only)
>>>>          return 1;               /* no whitelist, anything goes */
>>>>      }
>>>>  
>>>> -    for (p = whitelist_rw; *p; p++) {
>>>> +    for (p = whitelist_rw; p < &whitelist_rw[ARRAY_SIZE(whitelist_rw)]; p++) {
>>>
>>> Alexander reported [*] a problem when ARRAY_SIZE(whitelist_rw) == 0 you
>>> access an undefined address:
>>
>> The question is why CONFIG_BDRV_RW_WHITELIST & CONFIG_BDRV_RO_WHITELIST
>> aren't generated by meson.build...
> 
> Something like this?
> 
> diff --git a/meson.build b/meson.build
> index 300256bf70..d06fa56190 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -378,6 +378,8 @@ foreach k, v: config_host
>    if arrays.contains(k)
>      if v != ''
>        v = '"' + '", "'.join(v.split()) + '", '
> +    else
> +      v = 'NULL'
>      endif
>      config_host_data.set(k, v)
>    elif k == 'ARCH'

This doesn't work, because then you dereference a NULL on the first
iteration.  I'll revert back to without the ARRAY_SIZE.

Paolo

>>
>>>
>>> block.c:442:10: runtime error: index 0 out of bounds for type 'const
>>> char *[0]'
>>>
>>> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02066.html
>>>
>>>>          if (!strcmp(format_name, *p)) {
>>>>              return 1;
>>>>          }
>>>>      }
>>>>      if (read_only) {
>>>> -        for (p = whitelist_ro; *p; p++) {
>>>> +        for (p = whitelist_ro; p < &whitelist_ro[ARRAY_SIZE(whitelist_ro)]; p++) {
>>>
>>> Ditto.
>>>
>>>>              if (!strcmp(format_name, *p)) {
>>>>                  return 1;
>>>>              }
>>> [...]
>>>
>>
> 


