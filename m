Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE1BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4D5204FD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRvtuZ6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4D5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIrW2-0003QU-T8
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIrUM-0001qW-8E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIrUK-0008Nb-Du
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600339803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYjr+1hVAqR55mBdwPtil7oQai3WMs/M5qjGvHxWJvo=;
 b=QRvtuZ6s3Qp0jjtWEL7CS+NKcPSYhD/lVWGQ+5dPE/s55nDo0nPDm1IxURWZ1H5a1RVm8X
 VjBJmlPpstJH8mN9mBxol0plRErVIfhci9a6G2LVIbyqZ6rl4OyOvUsyw8b+cHaTJ57Yi3
 rPWaO/yynyZX242cqvlniHHtQZPXWE8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-o-QijpvZMEStr1xx_xWHdQ-1; Thu, 17 Sep 2020 06:50:01 -0400
X-MC-Unique: o-QijpvZMEStr1xx_xWHdQ-1
Received: by mail-wr1-f72.google.com with SMTP id n15so714948wrv.23
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fYjr+1hVAqR55mBdwPtil7oQai3WMs/M5qjGvHxWJvo=;
 b=fOg1n8oJBpXJZWJ+KxtgCmzmy5T4goXfd/UWktKhKAs0yoRn4Eyx862zKVY4UgYNSm
 kgbvOH5XEuSj8IMsFtBZFcj1KuLghjDUE6uCNfJmVrRKwbod6p+ksXINUQh/Y+zPnVVk
 d1lJ1/5PqeNc+r8wt1zSebLUeKtbn1Vq5zmQR6ggoagK3Dqr406lJGF05jwzNVgIS8nJ
 WqzYjLkQFPMMJ/h1/rQkpLvt2Byp+IWivpuHx+IwxCXNm0g/DVpXGDFIlAFH6HiclwP/
 Vz0LaPnlqwjEPGMl8lOp4w4uqyuxDHeqwXjsRlEABK0HkxWMDlXS4/1JfyfudM7s+pBz
 gTvw==
X-Gm-Message-State: AOAM532MWSVzzd+fqECYGbKfFx0gLZ35PKhQ2KSQSSptZnUyDDwZcAVk
 nbR+/2ezrbXyK3OsTvZzsMJ+HYcrCnxfAO2dr4jo3nCFN9SXXpKv3/CCSHPbIhIyv+aAkIW7E86
 dxtAO7xT/7Rfe/xY=
X-Received: by 2002:a05:600c:2312:: with SMTP id
 18mr3024870wmo.141.1600339800280; 
 Thu, 17 Sep 2020 03:50:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/bEm3SpZzs2H1eboCuNt4lCHTXDhCsqP3P3eZ4dZ4nJRyxtSi707ySRfy1iOIl1AOvOU3Zw==
X-Received: by 2002:a05:600c:2312:: with SMTP id
 18mr3024855wmo.141.1600339799993; 
 Thu, 17 Sep 2020 03:49:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d003:b94f:6314:4839?
 ([2001:b07:6468:f312:d003:b94f:6314:4839])
 by smtp.gmail.com with ESMTPSA id u186sm10132821wmu.34.2020.09.17.03.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 03:49:59 -0700 (PDT)
Subject: Re: [PATCH] docker.py: always use --rm
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200917104441.31738-1-pbonzini@redhat.com>
 <20200917104817.GE1568038@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <74a587e6-77fc-556b-8d7a-202e8142411b@redhat.com>
Date: Thu, 17 Sep 2020 12:49:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917104817.GE1568038@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/20 12:48, Daniel P. Berrangé wrote:
> On Thu, Sep 17, 2020 at 12:44:41PM +0200, Paolo Bonzini wrote:
>> Avoid that containers pile up.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  tests/docker/Makefile.include | 1 -
>>  tests/docker/docker.py        | 4 ++--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index 3daabaa2fd..75704268ff 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -243,7 +243,6 @@ docker-run: docker-qemu-src
>>  		$(DOCKER_SCRIPT) run 					\
>>  			$(if $(NOUSER),,--run-as-current-user) 		\
>>  			--security-opt seccomp=unconfined		\
>> -			$(if $V,,--rm) 					\
> 
> I guess the intention was that if someone is running verbose they might
> want to get back into the container after a failure. This is certainly
> a pain for CI though, because running verbose is desirable but keeping
> around dead containers is not.
> 
> The DEBUG=1 option is likely a better general purpose debugging approach
> than relying on the dead container being left behind, so
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Peter, can you apply this directly in order to unbreak Patchew?

Paolo

> 
> 
>>  			$(if $(DEBUG),-ti,)				\
>>  			$(if $(NETWORK),$(if $(subst $(NETWORK),,1),--net=$(NETWORK)),--net=none) \
>>  			-e TARGET_LIST=$(subst $(SPACE),$(COMMA),$(TARGET_LIST))	\
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index 356d7618f1..36b7868406 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -377,7 +377,7 @@ class Docker(object):
>>              if self._command[0] == "podman":
>>                  cmd.insert(0, '--userns=keep-id')
>>  
>> -        ret = self._do_check(["run", "--label",
>> +        ret = self._do_check(["run", "--rm", "--label",
>>                               "com.qemu.instance.uuid=" + label] + cmd,
>>                               quiet=quiet)
>>          if not keep:
>> @@ -616,7 +616,7 @@ class CcCommand(SubCommand):
>>          if argv and argv[0] == "--":
>>              argv = argv[1:]
>>          cwd = os.getcwd()
>> -        cmd = ["--rm", "-w", cwd,
>> +        cmd = ["-w", cwd,
>>                 "-v", "%s:%s:rw" % (cwd, cwd)]
>>          if args.paths:
>>              for p in args.paths:
>> -- 
>> 2.26.2
>>
> 
> Regards,
> Daniel
> 


