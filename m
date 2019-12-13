Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFBFC2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB6324125
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv59/ycA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB6324125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmNj-0002Vn-7y
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifmMh-0001sl-B2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifmMg-0003ry-9B
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:56:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifmMg-0003rD-5u
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576248981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ui0OHbnHcOZh0wXwOElKgzMgDmGCKMqLxERfqRsgeNQ=;
 b=dv59/ycAuMvfpD/y1T5GkQtY3lQg+rLXRpQ6TcHZoasuVO5pmrIB1shpHZUchsslqTZK69
 VX83aE50SgpItIDLHATwIrNiVxUlRV7RESoWjnoswASSD7s0QVnI1HzJCOmcbc+H0PoHqm
 UBwY55a1X2TZgR87k5uEZNg6IC18Xbk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-OSTpRT2TP1a93oESPjXiDQ-1; Fri, 13 Dec 2019 09:56:17 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so2653793wrm.18
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ui0OHbnHcOZh0wXwOElKgzMgDmGCKMqLxERfqRsgeNQ=;
 b=BM/PemlR3B4eBBkX/RKJwT25gT+hIpOOK49jp868RsEEcyKLoFG0mXe0zZv0VCdnyl
 bWMQpFRmQdgTkLeAQNDQUVSbQkqYeAQq+hau5z+dSiBm+nJchoIu3Po/6X4k4Q9Gre0J
 mI7OVoGKmLT9ZDBW5icjVb3/sgT+YjekIIK0DjuY49eKl1BIN0rVIeS7qqR85tic4jrv
 KRTd0z9AWDEC9ZQyko4tLfqtgST71h88fHr2qJlT41YkHtUf0bbvAuakytRaCCqGvpM4
 OrARc29ZfBBwNr0tFOMD/Wi+fm7JXsGvgh7I1NKLgTz/148RTq3S+Oz7PMTOAkodfPBp
 mSGA==
X-Gm-Message-State: APjAAAVsSAxtTe+qXzI/MxpqgAyB0cMRV+q0uRZPzkZQSQPct3np2o2W
 +RbxVg68pWWli12DRfGGtypOLqHIKpshJSP3hpoutvwio61XCmYj/5W/X1zRcTjCq1D4iJP2irS
 mSpegCDgJSlPen7U=
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr11170991wrv.316.1576248976433; 
 Fri, 13 Dec 2019 06:56:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqynJ1o+JTv7Rzb+8iq8wJNVnN2nBfCyz/hjVnoi9YVR7WsHgoRv3eiEPN+jdZsAufhN+qj0rA==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr11170967wrv.316.1576248976109; 
 Fri, 13 Dec 2019 06:56:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id a186sm10934044wmd.41.2019.12.13.06.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 06:56:15 -0800 (PST)
Subject: Re: [PATCH] virtio-blk: deprecate SCSI passthrough
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191213144626.1208237-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a14facd1-731e-f1cd-2476-1bd676da1e7d@redhat.com>
Date: Fri, 13 Dec 2019 15:56:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191213144626.1208237-1-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: OSTpRT2TP1a93oESPjXiDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Christoph Hellwig <hch@lst.de>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 15:46, Stefan Hajnoczi wrote:
> The Linux virtio_blk.ko guest driver is removing legacy SCSI passthrough
> support.  Deprecate this feature in QEMU too.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-deprecated.texi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 4b4b7425ac..ef94d497da 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -285,6 +285,17 @@ spec you can use the ``-cpu rv64gcsu,priv_spec=v1.9.1`` command line argument.
>  
>  @section Device options
>  
> +@subsection Emulated device options
> +
> +@subsubsection -device virtio-blk,scsi=on|off (since 5.0.0)
> +
> +The virtio-blk SCSI passthrough feature is a legacy VIRTIO feature.  VIRTIO 1.0
> +and later do not support it because the virtio-scsi device was introduced for
> +full SCSI support.  Use virtio-scsi instead when SCSI passthrough is required.
> +
> +Note this also applies to ``-device virtio-blk-pci,scsi=on|off'', which is an
> +alias.
> +
>  @subsection Block device options
>  
>  @subsubsection "backing": "" (since 2.12.0)
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


