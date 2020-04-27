Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C21C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF372075B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMpjiErV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF372075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzXL-0007at-PM
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jSzW7-0006dc-3n
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jSzW2-0005el-JW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:53:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41093
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jSzW2-0005aS-6z
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587977605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMkfYsfNSdIEjfJI6/O3wGXAzToxnXhgxIbR3NS+zmE=;
 b=fMpjiErVZN9/k5jeh5A/7GbGFHq/5uYATlNnsFQpm6/TDWeKeTRTalTwt1z0mG2b/GDknD
 yrlKEQzf+M0Q2bYjBAfItgVEZAIEGqFCjd047eRcgKhY7N95v+dxT2nimyZNO9y+YVnc1N
 bOAAa2aKcuG2Eqc9Hjq0/HiC4xYZTS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-cDGtRR8aO2eCK0pD24NyLA-1; Mon, 27 Apr 2020 04:53:22 -0400
X-MC-Unique: cDGtRR8aO2eCK0pD24NyLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18436801503
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 08:53:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DD9F61988;
 Mon, 27 Apr 2020 08:53:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0F5B111358BC; Mon, 27 Apr 2020 10:53:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 06/11] error: Use error_reportf_err() where appropriate
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-7-armbru@redhat.com>
 <44cf6721-88fa-acd3-b051-43e81b37506a@redhat.com>
Date: Mon, 27 Apr 2020 10:53:19 +0200
In-Reply-To: <44cf6721-88fa-acd3-b051-43e81b37506a@redhat.com> (Eric Blake's
 message of "Fri, 24 Apr 2020 15:08:29 -0500")
Message-ID: <87o8rdia2o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 4/24/20 2:20 PM, Markus Armbruster wrote:
>> Replace
>>
>>      error_report("...: %s", ..., error_get_pretty(err));
>>
>> by
>>
>>      error_reportf_err(err, "...: ", ...);
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   chardev/char-socket.c | 5 +++--
>>   hw/sd/pxa2xx_mmci.c   | 4 ++--
>>   hw/sd/sd.c            | 4 ++--
>>   hw/usb/dev-mtp.c      | 9 +++++----
>>   qemu-nbd.c            | 7 +++----
>>   scsi/qemu-pr-helper.c | 4 ++--
>>   6 files changed, 17 insertions(+), 16 deletions(-)
>
> Although it touches NBD, I'm happy for this to go through your tree
> with the larger series.
>
>> +++ b/qemu-nbd.c
>> @@ -856,8 +856,7 @@ int main(int argc, char **argv)
>>           }
>>           tlscreds =3D nbd_get_tls_creds(tlscredsid, list, &local_err);
>>           if (local_err) {
>> -            error_report("Failed to get TLS creds %s",
>> -                         error_get_pretty(local_err));
>> +            error_reportf_err(local_err, "Failed to get TLS creds ");
>
> Odd one out for not using ':' in the message, but that's independent
> of this patch.

The patch is short enough to deviate from "purely mechanical" and stick
in ':' here.  Your choice.

Thanks!


