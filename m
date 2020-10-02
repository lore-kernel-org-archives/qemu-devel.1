Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298D5C46466
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC78E208A9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2VSKjEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC78E208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOV2-0001lS-Jz
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kOOTx-0001Jw-Aa
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:04:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kOOTs-00082m-CL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601658267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xgj0hpVcffvhbEeRWVxqdaYvCtQRdJemk3XrZAdr0Dg=;
 b=C2VSKjEhIEUbOICaFQk2+RdBHLC6stFA0Xgc9L1mnS2Np8Ksnt483YAwEfS7yp6NDtQCfT
 nFQq9abJuwTdD8ZvLPiz18iqLa4qKekb5xfEmdE0ublgmsk/vUUHsolSfz8f5juSVYRYe9
 q91rqQ3zWlkh1Wvop7NNXOtMYv0Q6I0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-pVeLMFzAOZyKlcgqQOAWmg-1; Fri, 02 Oct 2020 13:04:25 -0400
X-MC-Unique: pVeLMFzAOZyKlcgqQOAWmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE963801AC2;
 Fri,  2 Oct 2020 17:04:23 +0000 (UTC)
Received: from work-vm (ovpn-114-192.ams2.redhat.com [10.36.114.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D311E73669;
 Fri,  2 Oct 2020 17:04:14 +0000 (UTC)
Date: Fri, 2 Oct 2020 18:04:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 5/5] qapi: Restrict Xen migration commands to
 migration.json
Message-ID: <20201002170412.GJ3286@work-vm>
References: <20201002133923.1716645-1-philmd@redhat.com>
 <20201002133923.1716645-6-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201002133923.1716645-6-philmd@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> Restricting xen-set-global-dirty-log and xen-load-devices-state
> commands migration.json pulls slightly less QAPI-generated code
> into user-mode and tools.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Looks OK; for migration


Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  qapi/migration.json    | 41 +++++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json         | 41 -----------------------------------------
>  accel/stubs/xen-stub.c |  2 +-
>  hw/i386/xen/xen-hvm.c  |  2 +-
>  migration/savevm.c     |  1 -
>  5 files changed, 43 insertions(+), 44 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7f5e6fd681..cb30f4c729 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1551,6 +1551,47 @@
>  { 'command': 'xen-save-devices-state',
>    'data': {'filename': 'str', '*live':'bool' } }
>  
> +##
> +# @xen-set-global-dirty-log:
> +#
> +# Enable or disable the global dirty log mode.
> +#
> +# @enable: true to enable, false to disable.
> +#
> +# Returns: nothing
> +#
> +# Since: 1.3
> +#
> +# Example:
> +#
> +# -> { "execute": "xen-set-global-dirty-log",
> +#      "arguments": { "enable": true } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'xen-set-global-dirty-log', 'data': { 'enable': 'bool' } }
> +
> +##
> +# @xen-load-devices-state:
> +#
> +# Load the state of all devices from file. The RAM and the block devices
> +# of the VM are not loaded by this command.
> +#
> +# @filename: the file to load the state of the devices from as binary
> +#            data. See xen-save-devices-state.txt for a description of the binary
> +#            format.
> +#
> +# Since: 2.7
> +#
> +# Example:
> +#
> +# -> { "execute": "xen-load-devices-state",
> +#      "arguments": { "filename": "/tmp/resume" } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
> +
>  ##
>  # @xen-set-replication:
>  #
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 9813893269..afe936b45b 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -287,26 +287,6 @@
>    'data': {'device': 'str', 'target': 'str', '*arg': 'str'},
>    'features': [ 'deprecated' ] }
>  
> -##
> -# @xen-set-global-dirty-log:
> -#
> -# Enable or disable the global dirty log mode.
> -#
> -# @enable: true to enable, false to disable.
> -#
> -# Returns: nothing
> -#
> -# Since: 1.3
> -#
> -# Example:
> -#
> -# -> { "execute": "xen-set-global-dirty-log",
> -#      "arguments": { "enable": true } }
> -# <- { "return": {} }
> -#
> -##
> -{ 'command': 'xen-set-global-dirty-log', 'data': { 'enable': 'bool' } }
> -
>  ##
>  # @getfd:
>  #
> @@ -606,24 +586,3 @@
>  ##
>  { 'enum': 'ReplayMode',
>    'data': [ 'none', 'record', 'play' ] }
> -
> -##
> -# @xen-load-devices-state:
> -#
> -# Load the state of all devices from file. The RAM and the block devices
> -# of the VM are not loaded by this command.
> -#
> -# @filename: the file to load the state of the devices from as binary
> -#            data. See xen-save-devices-state.txt for a description of the binary
> -#            format.
> -#
> -# Since: 2.7
> -#
> -# Example:
> -#
> -# -> { "execute": "xen-load-devices-state",
> -#      "arguments": { "filename": "/tmp/resume" } }
> -# <- { "return": {} }
> -#
> -##
> -{ 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
> diff --git a/accel/stubs/xen-stub.c b/accel/stubs/xen-stub.c
> index 7ba0b697f4..7054965c48 100644
> --- a/accel/stubs/xen-stub.c
> +++ b/accel/stubs/xen-stub.c
> @@ -7,7 +7,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "sysemu/xen.h"
> -#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-migration.h"
>  
>  bool xen_allowed;
>  
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index f3ababf33b..9519c33c09 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -24,7 +24,7 @@
>  #include "hw/xen/xen-bus.h"
>  #include "hw/xen/xen-x86.h"
>  #include "qapi/error.h"
> -#include "qapi/qapi-commands-misc.h"
> +#include "qapi/qapi-commands-migration.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/range.h"
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 34e4b71052..1fdf3f76c2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -42,7 +42,6 @@
>  #include "postcopy-ram.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-migration.h"
> -#include "qapi/qapi-commands-misc.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/cpus.h"
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


