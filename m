Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F3C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F34421D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 19:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfQP+84l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F34421D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPhd-0006JW-P2
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 15:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPen-0003ex-S1
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kWPem-00009q-74
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 15:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603569411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMaLDlpZa/2tS3vjhNrhebRqJvzknEmzQdjtLSvrreg=;
 b=IfQP+84lPcPxMQ2ULLtbmVIG1GedFx6AqPT0Stsfr7XsoxC1fajOlZiC5L/lEDHKx8BcJE
 hWW0fOKsivHlzz+azBv+jDug5pNp/j8JDer5cw1QTiaS55cvnSf7sq59WXELN0+Jr1YaR2
 SwnrqS084JBl8U9GrBXg0hyVU/O+UjA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-4iyjos_3OOG5uNnrQ6DhGw-1; Sat, 24 Oct 2020 15:56:49 -0400
X-MC-Unique: 4iyjos_3OOG5uNnrQ6DhGw-1
Received: by mail-wm1-f69.google.com with SMTP id 13so2970038wmf.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 12:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zMaLDlpZa/2tS3vjhNrhebRqJvzknEmzQdjtLSvrreg=;
 b=akRwyFGsoGKzBo35wOBkIljcx/I5rNT5eRpf9FqM4RE7tIOql/3/eREtHDW3i8LIu6
 IBAaRaOPmXLq6Ak5E4XkWWxpZ8P+yXssWYbOiiG2wNA7uoqPsrVChi8AmO9bqGnwSkcJ
 /XLuTcshMt1qQqBGRJSfk6MKJhN8isQbvcqv5Vl2y75uq2ctsld9l16ZaR0WS8qBWgvO
 e06h+t3BEgdCgDXwzjT7DzA6rdetmWc+tFa1UQoqImUVq2A3orS1yJW9PBIqSJ3RYADd
 AP3RDPJY81Ar1irpQCtG26cjI7oKRMVOF8+QuJbcUlz5Jb02y04XddjWSZZIJtzbkiwt
 9cQQ==
X-Gm-Message-State: AOAM531rptGcEt8hO44hbxzaKPIjEi3GOZZrYd+NbmqRgRfCT+Z2y+1v
 wRII3dKcBy8kdVrIkMki0cjljoK5tBS2V8YnyFcykuDohStKjmufCY3txsIfQelxIljcPMOVDFO
 53ndozKp8HnU2hRI=
X-Received: by 2002:a1c:a5c4:: with SMTP id o187mr8339387wme.171.1603569408030; 
 Sat, 24 Oct 2020 12:56:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNgveXW9UNO7LpebBQ+XhVTAfVsc/KbBc4WpC2A5PH94Rcs9UxcY/MQKll944j5OMR42LjIA==
X-Received: by 2002:a1c:a5c4:: with SMTP id o187mr8339381wme.171.1603569407897; 
 Sat, 24 Oct 2020 12:56:47 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id t12sm12962482wrm.25.2020.10.24.12.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 12:56:47 -0700 (PDT)
Subject: Re: [PATCH 14/15] scripts/qom-fuse: add redirection shim to
 python/qemu/qmp/qom-fuse.py
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201021185208.1611145-1-jsnow@redhat.com>
 <20201021185208.1611145-15-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5b4732ff-57bf-25b2-3b28-601972bbe922@redhat.com>
Date: Sat, 24 Oct 2020 21:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021185208.1611145-15-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 15:43:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 8:52 PM, John Snow wrote:
> By leaving the script absent for a commit, git-blame travels to the new
> file instead of staying on the shim.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qmp/qom-fuse | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>   create mode 100755 scripts/qmp/qom-fuse

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


