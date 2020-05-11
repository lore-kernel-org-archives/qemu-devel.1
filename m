Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F94C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F949206CC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 20:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecyeOFu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F949206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYF7M-0005Vf-Hy
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 16:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYF6S-00054Y-Jl
 for qemu-devel@nongnu.org; Mon, 11 May 2020 16:32:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYF6M-0001Db-S7
 for qemu-devel@nongnu.org; Mon, 11 May 2020 16:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589229120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mAH52I8BIhFlxfRVJG5pprEudnuFNcIZXRWXtKuFBBg=;
 b=ecyeOFu8rAIZHHicYfeJCyqO3ScY0NH3gyqx4PwoHwBiMNFQIgfpAKLhJFEupoc0Otjf0d
 Yf4/Tv9at7dbe+4ihhEkicBL6FTXVoB9kKZMsesE8tBdXsHRo480YXRe/5382XE0ifK9hC
 ltz4gxg+3sRnrPTgXB1716GpNA3R8uE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-zRv9cYGMPKuAyLzjwc1dcg-1; Mon, 11 May 2020 16:31:56 -0400
X-MC-Unique: zRv9cYGMPKuAyLzjwc1dcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EB72460;
 Mon, 11 May 2020 20:31:55 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 560BA60CD1;
 Mon, 11 May 2020 20:31:52 +0000 (UTC)
Subject: Re: [PATCH v8] audio/jack: add JACK client audiodev
To: Geoffrey McRae <geoff@hostfission.com>, qemu-devel@nongnu.org
References: <20200511042538.60E863A0386@moya.office.hostfission.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7250e8e8-842e-61cf-9bed-b6263ee92e4e@redhat.com>
Date: Mon, 11 May 2020 15:31:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511042538.60E863A0386@moya.office.hostfission.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 12:53 AM, Geoffrey McRae wrote:
> This commit adds a new audiodev backend to allow QEMU to use JACK as
> both an audio sink and source.
> 
> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> ---

> +++ b/qapi/audio.json
> @@ -152,6 +152,55 @@
>       '*out':     'AudiodevPerDirectionOptions',
>       '*latency': 'uint32' } }
>   
> +##
> +# @AudiodevJackPerDirectionOptions:
> +#
> +# Options of the JACK backend that are used for both playback and
> +# recording.
> +#
> +# @server-name: select from among several possible concurrent server instances
> +# (default: environment variable $JACK_DEFAULT_SERVER if set, else "default")
> +#
> +# @client-name: the client name to use. The server will modify this name to
> +# create a unique variant, if needed unless @exact_name is true (default: the

Minor typos: @exact_name does not match...

> +# guest's name)
> +#
> +# @connect-ports: if set, a regular expression of JACK client port name(s) to
> +# monitor for and automatically connect to
> +#
> +# @start-server: start a jack server process if one is not lready present

already

> +# (default: false)
> +#
> +# @exact-name: use the exact name requested otherwise JACK automatically
> +# generates a unique one, if needed (default: false)

...the actual parameter @exact-name.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


