Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF4AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D80206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKFI5Y0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D80206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCk2-0002zU-Jp
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqCiQ-00015b-Vy
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:38:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58890
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqCiO-0000LJ-Ri
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593509888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y1B5g62jYcl2eWVnkJSKnP3HvvRTUAof1OANE3HOJ3I=;
 b=WKFI5Y0TuyDZYfcj90pHhPQf3gbI2LfPUcfD2Jm6F7alLQ3XgW74E3ZxR0Q54wIim6F3P4
 0uhfpebP1vdzXYq4HVj/7Q3kkDlOXmQ6ArNmR6gZn3XkapQ/a6H/7ShZesZ7+9/cQAzLt5
 //D6xHsLKVRelGztHzcs1gmmr5oYhTY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-CInM91XnPA-hVQCbmwNTHQ-1; Tue, 30 Jun 2020 05:38:06 -0400
X-MC-Unique: CInM91XnPA-hVQCbmwNTHQ-1
Received: by mail-wm1-f72.google.com with SMTP id h6so20603411wmb.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 02:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y1B5g62jYcl2eWVnkJSKnP3HvvRTUAof1OANE3HOJ3I=;
 b=NoJLKV/vGuQ4nv0xwp0KGrbyoojBl2UnT0moOa0HwnbtD7Q4m/ySJ9SKOXQkr8jbp4
 4btVoGxd+WEdy5x7GHitYFoPwyul8X7t/WG8y19y3s2RE/FxgXfYjE+DunvvhsUBTqmB
 1pwE+4SG2/HNrmEJ+/QJVLRVnUipPJZqfNrjlEvkuCdIJGGVru7+emIxU3CkXWhCONzy
 nKWOwQYMWOZutOQYW/+7i4evdOjKdsrK80UiZnsp5PzOIZEwlAbTyP5Q7X0HggEu56rc
 RyW1KhO4eyOgjjppXFgOXqvtkS3hpo6Gfsz/7SDYTzda1dsZq0oK00QelwRzoUJ5hd/A
 C0cA==
X-Gm-Message-State: AOAM532v4/PF/1Z4Ui3GESf9t8Z9DHlvNEgEBFkOSZ0VlQvHynGQqFnZ
 nBeNvKmtIdJpc/qqlE7yDXHMZiqCLRnA1/2hVYNQPgzlsUeySye5aYkpgu8kPklzJHDoQevpkoj
 AR8U88s9ywjGz/lA=
X-Received: by 2002:a1c:2905:: with SMTP id p5mr7467217wmp.91.1593509885536;
 Tue, 30 Jun 2020 02:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNmnNNae5rQGhonjaryUJrjkLdjRtKA1CLJ6rMXOta4zKnaEmfpkfM82EHnvghaVy/huTURw==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr7467179wmp.91.1593509885297;
 Tue, 30 Jun 2020 02:38:05 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 z2sm3084365wmc.2.2020.06.30.02.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 02:38:04 -0700 (PDT)
Date: Tue, 30 Jun 2020 05:38:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 01/10] modules: Provide macros making it easier to
 identify module exports
Message-ID: <20200630052756-mutt-send-email-mst@kernel.org>
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-2-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626164307.3327380-2-dinechin@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 06:42:58PM +0200, Christophe de Dinechin wrote:
> In order to facilitate the move of large chunks of functionality to
> load modules, it is simpler to create a wrapper with the same name
> that simply relays the implementation. For efficiency, this is
> typically done using inline functions in the header for the
> corresponding functionality. In that case, we rename the actual
> implementation by appending _implementation to its name. This makes it
> easier to select which function you want to put a breakpoint on.
> 
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  include/qemu/module.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 011ae1ae76..1922a0293c 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -39,6 +39,30 @@ static void __attribute__((constructor)) do_qemu_init_ ## function(void)    \
>  }
>  #endif
>  
> +#ifdef CONFIG_MODULES
> +/* Identify which functions are replaced by a callback stub */
> +#ifdef MODULE_STUBS
> +#define MODIFACE(Ret,Name,Args)                                         \
> +    Ret (*Name)Args;                                                    \
> +    extern Ret Name##_implementation Args
> +#else /* !MODULE_STUBS */
> +#define MODIFACE(Ret,Name,Args)                                         \
> +    extern Ret (*Name)Args;                                             \
> +    extern Ret Name##_implementation Args
> +#endif /* MODULE_STUBS */
> +
> +#define MODIMPL(Ret,Name,Args)                                          \
> +    static void __attribute__((constructor)) Name##_register(void)      \
> +    {                                                                   \
> +        Name = Name##_implementation;                                   \
> +    }                                                                   \
> +    Ret Name##_implementation Args
> +#else /* !CONFIG_MODULES */
> +/* When not using a module, such functions are called directly */
> +#define MODIFACE(Ret,Name,Args)         Ret Name Args
> +#define MODIMPL(Ret,Name,Args)          Ret Name Args
> +#endif /* CONFIG_MODULES */
> +
>  typedef enum {
>      MODULE_INIT_MIGRATION,
>      MODULE_INIT_BLOCK,

Hmm that's quite a bit of overhead for each call across modules.
Can't code patching be used somehow?


> -- 
> 2.26.2


