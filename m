Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E78C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA912076C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KM+iRtMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA912076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhAM-0002Tw-Ri
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jOh9P-0001Wg-3s
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jOh9O-0005Bh-5g
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:28:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37982
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jOh9O-0005BZ-1f
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586953697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9ZA4PMZgCLLcTtftizUlewIZUpmFU3Zaee+cHcmt5Q=;
 b=KM+iRtMmGw3cyeiF/1+uLTejx1PbmZGl7qIyr7RbJhFHTuvTPvK38sKVCI3KqbK0QIU8S/
 A3fhEEjGnpavJ5aB+MuQw99XI6xLxBqsa592sBApKxrLkUlgai0OFh8jSjEBEzpLGDBeEn
 tN8bUV6fp/KlN0xRmLJ4Wy3cL/cahjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-DOx9EweuNbCLUCf90s6Qhg-1; Wed, 15 Apr 2020 08:28:15 -0400
X-MC-Unique: DOx9EweuNbCLUCf90s6Qhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7F081034B23;
 Wed, 15 Apr 2020 12:28:14 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F7845C1D4;
 Wed, 15 Apr 2020 12:28:14 +0000 (UTC)
Subject: Re: [PATCH for-5.1 2/5] qobject: Factor out helper
 json_pretty_newline()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200415083048.14339-1-armbru@redhat.com>
 <20200415083048.14339-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <344e1038-827a-7dea-7e73-b83b899673ed@redhat.com>
Date: Wed, 15 Apr 2020 07:28:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415083048.14339-3-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 3:30 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/qjson.c | 40 ++++++++++++++++------------------------
>   1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/qobject/qjson.c b/qobject/qjson.c
> index db36101f3b..f3c62711b9 100644
> --- a/qobject/qjson.c
> +++ b/qobject/qjson.c
> @@ -159,21 +159,28 @@ typedef struct ToJsonIterState
>   
>   static void to_json(const QObject *obj, QString *str, int pretty, int indent);
>   
> +static void json_pretty_newline(QString *str, bool pretty, int indent)
> +{
> +    int i;
> +
> +    if (pretty) {
> +        qstring_append(str, "\n");
> +        for (i = 0 ; i < indent ; i++) {

Why are you keeping the spaces before ; ?  Yes, I know they were 
copied-and-pasted from the old code, but as long as you are refactoring, 
fixing the style is worthwhile.

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


