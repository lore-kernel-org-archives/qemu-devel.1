Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D444C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE7121019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE7121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32996 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTkt0-0004nV-F6
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:23:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTkrp-0004Cs-06
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTkro-0006jU-0L
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:22:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hTkrn-0006iy-SF
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:22:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19914308FEE2;
	Thu, 23 May 2019 10:22:30 +0000 (UTC)
Received: from work-vm (ovpn-117-235.ams2.redhat.com [10.36.117.235])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A880C607D8;
	Thu, 23 May 2019 10:22:28 +0000 (UTC)
Date: Thu, 23 May 2019 11:22:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: rkir@google.com, quintela@redhat.com
Message-ID: <20190523102225.GA2994@work-vm>
References: <20190522222224.244714-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522222224.244714-1-rkir@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 23 May 2019 10:22:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vmstate: Add VMSTATE_OPAQUE to save/load
 complex data structures
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* rkir--- via Qemu-devel (qemu-devel@nongnu.org) wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> VMSTATE_OPAQUE allows passing user defined functions to save
> and load vmstate for cases when data structures do not fit
> into int/struct/array terms.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>

Hi Roman,
  Thanks for the patch.

Can you give me an example of where you would use it?  I've been
trying to get rid as many of the open-coded cases as possible
and try and make sure vmstate can handle it.

Having said that;  would it be easier to pass the get/put functions
rather than the info ?

Dave

> ---
>  include/migration/vmstate.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 9224370ed5..2736daef17 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -737,6 +737,19 @@ extern const VMStateInfo vmstate_info_qtailq;
>      .start        = offsetof(_type, _next),                              \
>  }
>  
> +/* Provides a way to save/load complex data structures that do not
> + * fit into int/struct/array terms.
> + * _info: a user defined instance of VMStateInfo to handle saving and loading.
> + */
> +#define VMSTATE_OPAQUE(_name, _version, _info) {                      \
> +    .name         = _name,                                            \
> +    .version_id   = (_version),                                       \
> +    .size         = 0,                                                \
> +    .info         = &(_info),                                         \
> +    .flags        = VMS_SINGLE,                                       \
> +    .offset       = 0,                                                \
> +}
> +
>  /* _f : field name
>     _f_n : num of elements field_name
>     _n : num of elements
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

