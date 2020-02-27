Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3676EC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F4124650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkQbNN/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F4124650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7KWz-0008Nl-89
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j7KWI-0007Zm-PR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j7KWH-0005cS-8t
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:52:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34923
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j7KWH-0005by-4K
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582815127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rfhla9vzlRQ9n/j1c1KIEc2k5z+tmP4JB9criD2Mr5A=;
 b=IkQbNN/KH2MRvS+haF+NTHHCwagGI9RDZSZSHfDf+S5lCGWAXcuH6gjgde0i2KVj9tyqiL
 QhDJDZWI2zoz0ZOiPi4tIU7yaxvLfkEk8i8FvV3mG5nDk/tYbjt9UohWHUaGSjaorubjWq
 F8a93Udotb5kOJIOEp9vI+slNsCamBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-7SWPQ_I5OZyqUE00qAarVQ-1; Thu, 27 Feb 2020 09:52:05 -0500
X-MC-Unique: 7SWPQ_I5OZyqUE00qAarVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2407E1B2C984
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 14:52:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1E245DA2C;
 Thu, 27 Feb 2020 14:52:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3BC0711386A6; Thu, 27 Feb 2020 15:52:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] qapi/machine: Place the 'Notes' tag after the 'Since'
 tag
References: <20200227134019.6218-1-philmd@redhat.com>
Date: Thu, 27 Feb 2020 15:52:03 +0100
In-Reply-To: <20200227134019.6218-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 27 Feb 2020 14:40:19
 +0100")
Message-ID: <87tv3cozfw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> This fixes when adding a 'Since' tag:
>
>   In file included from qapi/qapi-schema.json:105:
>   qapi/machine.json:25:1: '@arch:' can't follow 'Notes' section

I'm confused.  This error is detected in scripts/qapi/parser.py, and it
is fatal.  Is the build broken for you?  It isn't for me.  Moreover,
where is @arch?  I can't see it anywhere close to the two spots the
patch patches.

>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Fix another occurrence in CpuInstanceProperties (Liam Merwick)
> ---
>  qapi/machine.json | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6c11e3cf3a..3d8b5324f3 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -16,11 +16,11 @@
>  # individual target constants are not documented here, for the time
>  # being.
>  #
> +# Since: 3.0
> +#
>  # Notes: The resulting QMP strings can be appended to the "qemu-system-"
>  #        prefix to produce the corresponding QEMU executable name. This
>  #        is true even for "qemu-system-x86_64".
> -#
> -# Since: 3.0
>  ##
>  { 'enum' : 'SysEmuTarget',
>    'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
> @@ -820,13 +820,13 @@
>  # @die-id: die number within node/board the CPU belongs to (Since 4.1)
>  # @core-id: core number within die the CPU belongs to# @thread-id: threa=
d number within core the CPU belongs to
>  #
> +# Since: 2.7
> +#
>  # Note: currently there are 5 properties that could be present
>  #       but management should be prepared to pass through other
>  #       properties with device_add command to allow for future
>  #       interface extension. This also requires the filed names to be ke=
pt in
>  #       sync with the properties passed to -device/device_add.
> -#
> -# Since: 2.7
>  ##
>  { 'struct': 'CpuInstanceProperties',
>    'data': { '*node-id': 'int',


