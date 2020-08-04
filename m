Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A29C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A02D206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 06:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVxDxcQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A02D206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2qKQ-0001fN-CY
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 02:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2qJ3-00013c-8I
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:20:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43467
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k2qJ0-0001ZM-NH
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 02:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596522009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/krpMRa546MDexTEFX+jeDeb+Dv6Eo5ped81ZE5UZT0=;
 b=BVxDxcQ/wflii93LGFHzaWzIljuxUNqq833fXHqkZ/9Yl7s+M37Sq1IaKwQqDvzPPn7+pu
 KCXTPgXCS72j8c/tlvnjW4Tqi7GZYQAuQ8Ruaf+rZ6PQ0J8jI0+fTUbl8L08VnJZpPm9Yg
 sRrSj44cv0j+aaZLcU0vHQqTyHARhYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-SvxwMUGMNc2AVugm6WFIJA-1; Tue, 04 Aug 2020 02:19:27 -0400
X-MC-Unique: SvxwMUGMNc2AVugm6WFIJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 667B48017FB;
 Tue,  4 Aug 2020 06:19:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CBD91001B2C;
 Tue,  4 Aug 2020 06:19:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 23BE31750A; Tue,  4 Aug 2020 08:19:16 +0200 (CEST)
Date: Tue, 4 Aug 2020 08:19:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 3/7] minikconf: Pass variables for modules
Message-ID: <20200804061916.ado6z5h5jknh7s7g@sirius.home.kraxel.org>
References: <20200723174615.2370096-1-dinechin@redhat.com>
 <20200723174615.2370096-4-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723174615.2370096-4-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 07:46:11PM +0200, Christophe de Dinechin wrote:
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  scripts/minikconf.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/minikconf.py b/scripts/minikconf.py
> index bcd91015d3..d60add97f6 100755
> --- a/scripts/minikconf.py
> +++ b/scripts/minikconf.py
> @@ -690,10 +690,10 @@ if __name__ == '__main__':
>      parser = KconfigParser(data)
>      external_vars = set()
>      for arg in argv[3:]:
> -        m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
> +        m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([ymn]?)$', arg)
>          if m is not None:
>              name, value = m.groups()
> -            parser.do_assignment(name, value == 'y')
> +            parser.do_assignment(name, value == 'y' or value == 'm')
>              external_vars.add(name[7:])
>          else:
>              fp = open(arg, 'rt', encoding='utf-8')

Hmm, I somehow doubt it is _that_ simple, miniconf supports only bool
(y+n) not tristate (y+n+m) ...

take care,
  Gerd


