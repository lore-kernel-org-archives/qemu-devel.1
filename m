Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E376C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D68D21D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF9uC4d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D68D21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSlBE-0004H9-7m
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSl9b-0002Zg-JZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSl9Z-0000Aq-3M
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602698731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=331qvi+I05STX+RoSiSdzzBsuM674mUglChEtI+juMI=;
 b=QF9uC4d7gDVscMcpzRoL2xX4SJd5756o9i36d/kPhtBOKHNrAogBS/+ROkzZRqiy6+ZeI0
 7JUbhTQf3uDIlKNhI/pptSPGV5QlCtcgJuzaGikmg9pYZhwIHTbl+5H37s+cjnqp1TtVew
 2mLyRVaaITTY3ax1k1EEYEYv542sYxU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-tKHKAcNrMoCKtJp6jrkqug-1; Wed, 14 Oct 2020 14:05:30 -0400
X-MC-Unique: tKHKAcNrMoCKtJp6jrkqug-1
Received: by mail-wr1-f69.google.com with SMTP id b6so1732944wrn.17
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 11:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=331qvi+I05STX+RoSiSdzzBsuM674mUglChEtI+juMI=;
 b=On5fKt6Cf7JeTmDx7JDk1HpZ2/wM1MkvAK/RdBnqLgcd4ihMEzFYmDm2DbT9hCynQ9
 +oXVZzsBGtG7qp94CxH4GYbxzM70mUVO63KBMm3LP6Ur9ewiKu/cacPgLJOAstYlf/Fd
 mArL8cFJOHgQre1YLcdhjqf31jlKy582onN24J3CaD5iWyb4AV560HM5kE06EfyDWH9w
 J9hWoA/FRVQ1Uu7hUMRBY5V1i8cadqQ0QsNPEDsP5TqE3BTG5MmUi/kyKAC7TUmwqaqu
 a2ghqz6FAuOKnPaEkEhhGPtvi6uF/FP9fP4kNGRR8um4ybeWL5+5M388QskP8prIWg3X
 f+iA==
X-Gm-Message-State: AOAM531e+bJZUtV827A8QOXbtxsqwUvf4XbZxmiqcbtOcbht40p2BvMU
 N+SfxzBhmcf94Ftg4Zr2oIEv/lXAEuftHgMzIJsH1Qjxzqwb0E3LAeHOxxxSn89JqVlCS9vmJ39
 5Qcm9KIFCd2TiIeM=
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr67900wme.153.1602698728856; 
 Wed, 14 Oct 2020 11:05:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzREtAoXnuwpdFv/QUh4K/N8hg8FjBMqu27QcslDB2I/Hss50aqvCivnNFiuefZBr3Wt7YNWA==
X-Received: by 2002:a05:600c:2189:: with SMTP id
 e9mr67878wme.153.1602698728688; 
 Wed, 14 Oct 2020 11:05:28 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l3sm297501wmg.32.2020.10.14.11.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 11:05:28 -0700 (PDT)
Subject: Re: [PATCH v2 04/15] python: add directory structure README.rst files
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20201014142957.763624-1-jsnow@redhat.com>
 <20201014142957.763624-5-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7e0232fc-d5e1-f0aa-1701-bbc6d95522d3@redhat.com>
Date: Wed, 14 Oct 2020 20:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014142957.763624-5-jsnow@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 4:29 PM, John Snow wrote:
> Add short readmes to python/, python/qemu/, and python/qemu/core that
> explain the directory hierarchy. These readmes are visible when browsing

Maybe readmes -> READMEs

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> the source on e.g. gitlab/github and are designed to help new
> developers/users quickly make sense of the source tree.
> 
> They are not designed for inclusion in a published manual.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/README.rst           | 27 +++++++++++++++++++++++++++
>   python/qemu/README.rst      |  8 ++++++++
>   python/qemu/core/README.rst |  9 +++++++++
>   3 files changed, 44 insertions(+)
>   create mode 100644 python/README.rst
>   create mode 100644 python/qemu/README.rst
>   create mode 100644 python/qemu/core/README.rst


