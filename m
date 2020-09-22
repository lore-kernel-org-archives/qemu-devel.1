Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C486FC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204E32396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9Jn+azW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204E32396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKi7c-0007F8-UI
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKi6X-0005wx-1p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKi6V-00064f-8q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600780386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krzX1vzdv6z00Kl10xQdk/MIB1ssCErWVzB2JHBBvQI=;
 b=X9Jn+azWol/fYEOJnp2VMCvlNmPiD8q2yggnh5nQbRnyg8r3aGcpPubed40LyQrx4v7JaC
 hEEXftCioWTI9nEDXZeq9JiLHoo5MCdI2Yf7bbpPJ9znaeAKA8gsmUaLigcl+lyxy5chio
 4VY+BS1MOpx+Uw+QGOw7k9GfeJ9OfH4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-oEz00tmOPpK0qBzFRPKEEQ-1; Tue, 22 Sep 2020 09:13:04 -0400
X-MC-Unique: oEz00tmOPpK0qBzFRPKEEQ-1
Received: by mail-wr1-f72.google.com with SMTP id a10so7338943wrw.22
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 06:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=krzX1vzdv6z00Kl10xQdk/MIB1ssCErWVzB2JHBBvQI=;
 b=Kpyza8C3Wj+6/1DhMHrDSSCW2YCCtiL99TXmOTEN9h78MqLITzZbwCTZ7UcCUc/tDQ
 9SADZ8dBPAPyfR+ATjAACVUMD79AbnCLjwFcE6EKfGnDUuzkWEBCCNOJ5/ewMJcqKBR+
 0F2GhVmqWUrocujUfu71tomlY+u8MKFx5pAOdh82j+DRFNQBPFsQPyTqLfWv1pgkj1LU
 uW+0U4ehvi+s+ftRBRJjUtmsNKE7pS97eLjPP5Mb7uhvZH4TUyocOw67yxUx7IEQWgpl
 4fXfUyCttdR/EdTp2JZVBIQfuiAqJzZiyLuwfdEaIGd42srhq4NgSs+lMQWnmCkqYnFq
 OGIA==
X-Gm-Message-State: AOAM530wp/rFCGFsTkeg9LQ0+B1Cwpt16CgQb1VNC49712CMfu7jUVWe
 SIPLB4Erqtu6omHfG5BGFk9jsjuV2wzjryfSzylJT6KuKymIVfuJjAF8bCX7kS6FiFf1LxfyGNC
 v6wMwXPzoOlEb+bc=
X-Received: by 2002:a1c:9ec1:: with SMTP id h184mr1007940wme.180.1600780383160; 
 Tue, 22 Sep 2020 06:13:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoEuVrB+KhgHGXpLpG3XlllggzKILAZDL5V5Q9uFwixkpGBCjB8iEAxB/+1a/9p/PNTBM5Pw==
X-Received: by 2002:a1c:9ec1:: with SMTP id h184mr1007901wme.180.1600780382899; 
 Tue, 22 Sep 2020 06:13:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec2c:90a9:1236:ebc6?
 ([2001:b07:6468:f312:ec2c:90a9:1236:ebc6])
 by smtp.gmail.com with ESMTPSA id n4sm26272527wrp.61.2020.09.22.06.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 06:13:02 -0700 (PDT)
Subject: Re: [PATCH v5 13/15] docs: convert replay.txt to rst
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
 <160077701288.10249.16846150592069982759.stgit@pasha-ThinkPad-X280>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2c0c42c8-8dd7-b208-2430-a241ba5f938e@redhat.com>
Date: Tue, 22 Sep 2020 15:13:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160077701288.10249.16846150592069982759.stgit@pasha-ThinkPad-X280>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 alex.bennee@linaro.org, mtosatti@redhat.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com, philmd@redhat.com,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/20 14:16, Pavel Dovgalyuk wrote:
> +
> +When you need to use snapshots with diskless virtual machine,
> +it must be started with 'orphan' qcow2 image. This image will be used
> +for storing VM snapshots. Here is the example of the command line for this:
> +
> +  qemu-system-i386 -icount shift=3,rr=replay,rrfile=record.bin,rrsnapshot=init \
> +    -net none -drive file=empty.qcow2,if=none,id=rr
> +
> +empty.qcow2 drive does not connected to any virtual block device and used
> +for VM snapshots only.

This is not rST.  Are you sure you included the right patch.

No problem though, I can just skip it.

Paolo


