Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE50C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E412074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQN96TWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E412074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jit14-0005ys-Uu
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisrs-0007rq-Nk
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:01:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisrr-0006JJ-8F
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591765294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v2iir23r4lN4FNrToW1bee8KuY4+wfUm4/X3E1v3uAo=;
 b=JQN96TWaGHbfEwV+7leYbOr8qY3HPYh3KKUFCEQy9syr0f9JN5+rzE4jjcQ4kavKH4IkbI
 WeczzM5XFptF74ixQOx28q0D1w0tWwtuug8IuqTWVgn8mzHa4QJ86IqNniSeop6GDZA3E+
 a25xID1zJc5LegBBtBX4eONuyeKPd08=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-quygeQbXP_GK5TdYfdXHxA-1; Wed, 10 Jun 2020 01:01:32 -0400
X-MC-Unique: quygeQbXP_GK5TdYfdXHxA-1
Received: by mail-wm1-f71.google.com with SMTP id b63so1461654wme.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 22:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v2iir23r4lN4FNrToW1bee8KuY4+wfUm4/X3E1v3uAo=;
 b=EdX/Tadbz0JuMIXMU23rm9Y6YVN64fvmXNyOVdW3cYXrxd1HbApucP0T5AJ+/Hj7CA
 SqtOJrMYWnqVCUnXb4nq4eVxqlU+AdprOUSXpOvBbhCtnIB+E0cJV85OyQnvsxlkdrQg
 UAtPXUL67ubYWP9muDw4oFHqrqKgWORcrQIOf/2gh4TfatL4PddrLbhc8SLTCORoAlet
 XedH1zb+yKtH5RvF+tzvEQEs6+fVPunLIskDnziLGCaxWYY/G5k1mXtPuGyZ5GlDHcbs
 xrDQ2c4Wp618qB2sO8rIjoG09qdygWBU18ZAI9KDBc/71PajWqbHljQ2DAqyKNZaaVLX
 aOsQ==
X-Gm-Message-State: AOAM531Fu1Jj5RXsY5AKEE4voHq5qcE6rZOxnv892IE19ALIs3mQYEu5
 mez37MgE3e6UWDSotgk3fDbHkO7vXOFST/yL9vPE4hIfmKtsOrLsJIOUdNH/qWqWm6JglVeDjMZ
 wLWIHuRPhibUd+oQ=
X-Received: by 2002:adf:d851:: with SMTP id k17mr1451908wrl.30.1591765290860; 
 Tue, 09 Jun 2020 22:01:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlWA5BpNOnAdVApfVfH7s2hGKWU3tHEFYVlwLXVMWnXBdZhkaqQSOZobxUwEj/wS4HjcF4lQ==
X-Received: by 2002:adf:d851:: with SMTP id k17mr1451860wrl.30.1591765290490; 
 Tue, 09 Jun 2020 22:01:30 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id u12sm6331970wrq.90.2020.06.09.22.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 22:01:29 -0700 (PDT)
Date: Wed, 10 Jun 2020 01:01:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 3/7] docs: document non-net VHOST_USER_GET_FEATURES
 behavior
Message-ID: <20200610005129-mutt-send-email-mst@kernel.org>
References: <20200609170218.246468-1-stefanha@redhat.com>
 <20200609170218.246468-4-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200609170218.246468-4-stefanha@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ben Walker <benjamin.walker@intel.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 06:02:14PM +0100, Stefan Hajnoczi wrote:
> QEMU enabled several feature bits for non-net devices without allowing
> the device backend to control them. This only works when the device
> backend implements support for those features. It won't work for new
> features like the packed virtqueue layout, where proper feature
> negotiation will be needed.
> 
> Document the legacy behavior and specify that device backends must
> report features so that we can avoid problems in the future.
> 
> Cc: Ben Walker <benjamin.walker@intel.com>
> Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> CCing SPDK and cloud-hypervisor folks in case they are affected. DPDK
> isn't affected since vhost-user-net performs full feature negotiation.
> ---
>  docs/interop/vhost-user.rst | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 3b1b6602c7..dfadee411d 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -290,6 +290,27 @@ bit was dedicated for this purpose::
>  
>    #define VHOST_USER_F_PROTOCOL_FEATURES 30
>  
> +Feature negotiation
> +-------------------
> +The master fetches features from the backend using the
> +``VHOST_USER_GET_FEATURES`` message. The feature bits correspond to those from
> +the virtio specification, VHOST_F_LOG_ALL (26), and
> +``VHOST_USER_F_PROTOCOL_FEATURES`` (30).

Seems to partially duplicate the description of the message
VHOST_USER_GET_FEATURES, except that is missing
description of VHOST_F_LOG_ALL. How about tweaking that
instead of adding more text? BTW description of VHOST_USER_GET_FEATURES
has some typos worth fixing ...




> +Backends must report all supported feature bits. If a feature bit is set then
> +the master may set it in the ``VHOST_USER_SET_FEATURES`` message. If a feature
> +bit is cleared then the master must not set it in the
> +``VHOST_USER_SET_FEATURES`` message.

Again let's extend description of VHOST_USER_SET_FEATURES if that's
unclear. BTW description of VHOST_USER_SET_FEATURES has
some typos worth fixing ...

> +
> +For devices other than the networking device, masters may assume the following
> +feature bits are always set in ``VHOST_USER_GET_FEATURES`` for compatibility
> +with legacy backend implementations that do not report them correctly:
> +* ``VIRTIO_F_RING_INDIRECT_DESC``
> +* ``VIRTIO_F_RING_EVENT_IDX``
> +* ``VIRTIO_F_VERSION_1``
> +* ``VIRTIO_F_NOTIFY_ON_EMPTY``
> +* ``VIRTIO_F_ANY_LAYOUT``
> +
>  Starting and stopping rings
>  ---------------------------

How common are these backends? Anything shipped for a while?  IIUC we
are not talking about years of history here, so I really think we should
just enforce what spec always said, rather than work around some broken
clients.

> -- 
> 2.26.2
> 


