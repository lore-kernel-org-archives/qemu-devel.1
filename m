Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FC9C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0FB206FC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQMh6bDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0FB206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJATv-0007bT-Dt
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJASb-00074I-VO
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kJASa-00019R-1E
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600412731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPds/lZOU77VJGN8fRBlsgRvlncbbzb0eCuffqfkX04=;
 b=PQMh6bDYCugcAsorqR5u1Qtyo1wry6cXuAWIRrRVwGJlOC2S44hlHe2JhVFFeW96W9ykb9
 JJPW886RSENX5BjI/RYPrKeJoZHte+Yu8L9EHdPqxUD0aU+/D5sBs5PgwrskT1IL4gjORi
 X9IN+IfH81+pB6hg9SoMpO9sfE/aFRE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-s5Fx3IbROLeUMkeC9mILXw-1; Fri, 18 Sep 2020 03:05:29 -0400
X-MC-Unique: s5Fx3IbROLeUMkeC9mILXw-1
Received: by mail-wr1-f69.google.com with SMTP id 33so1791999wre.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 00:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rRQhREZmj/0SOM2Z4rGOK/GBGAKW8gTKt0cBS5rDWlc=;
 b=OFKrNJjfO8DJxinf7ZM648Axm95fPvW5rNVhqO0cDJ0+YcRXWeAfmTHDOkAxoSPtWe
 8lOjXg80P8efe3yQ5ypwwATz4qCs64/eRjeKsmnae+qPTWcqOu7eYcnDmX5/HImc3bbT
 K3emQIA6SJv09hrLM7xIzTiy/CrFx8XD4guO6jbXYKAvAp3+Eb4sI9JCj8Z8zmbZ9ipC
 ZIXh1LuZ1HX1XNLcg5dCFVLH2POyHJJyMVNfPWcbz9pr4748lf44QGLIfPbGVrj9Vu7L
 LVCm8+UDumq8Jlnfv5KG3Tm+B4eidZvSF5lmnAZcoGJJ69yFF7ranQgJwLIviBKtOCWF
 hnsQ==
X-Gm-Message-State: AOAM532vmkaOr8h7MuAq4/1AWSvnB43gPHwv56uLhIgm3S+9MZJ1DVH7
 0g7vNtso3IoW/ZalUsHVoA94t1hG/JlqUPukY/XAcZBLjRFtPkGw3ggD6wfPwKvtgbGB2vquPF8
 LSUkhAM1NKZRXFBA=
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr12258059wrn.113.1600412727954; 
 Fri, 18 Sep 2020 00:05:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd6MJm6ud1PvA92GjB5IDPaBabuUDKmHWQLAwiCky3LUnFIr2cKVVAditQsne0gJYJ0qK+0Q==
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr12258028wrn.113.1600412727691; 
 Fri, 18 Sep 2020 00:05:27 -0700 (PDT)
Received: from steredhat (host-79-51-197-141.retail.telecomitalia.it.
 [79.51.197.141])
 by smtp.gmail.com with ESMTPSA id t124sm3519427wmg.31.2020.09.18.00.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 00:05:26 -0700 (PDT)
Date: Fri, 18 Sep 2020 09:05:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] checkpatch: avoid error on cover letter files
Message-ID: <20200918070524.kc7y4rbtkuzw2ccl@steredhat>
References: <20200917170212.92672-1-sgarzare@redhat.com>
 <d5a967e3-ab0d-621f-45fc-d2d4a2bc116b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d5a967e3-ab0d-621f-45fc-d2d4a2bc116b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 07:44:21PM +0200, Philippe Mathieu-Daudé wrote:
> On 9/17/20 7:02 PM, Stefano Garzarella wrote:
> > Running checkpatch on a directory that contains a cover letter reports
> > this error:
> > 
> >     Checking /tmp/tmpbnngauy3/0000-cover-letter.patch...
> >     ERROR: Does not appear to be a unified-diff format patch
> > 
> >     total: 1 errors, 0 warnings, 0 lines checked
> > 
> > Let's skip cover letter as it is already done in the Linux kernel.
> 
> .. "commits 06330fc40e3f ("checkpatch: avoid NOT_UNIFIED_DIFF errors
>  on cover-letter.patch files") and a08ffbef4ab7 ("checkpatch: fix
> ignoring cover-letter logic")."
> 
> Maybe complete with that ^^^ ?

Yes, it's better ;-)

Should I send a v2 or can be updated when queueing?

> 
> Regardless:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks!

Stefano


